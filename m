Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTL3GPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTL3GPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:15:00 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:34221 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264419AbTL3GOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:14:53 -0500
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031229205157.4c631f28.davem@redhat.com>
References: <1072567054.4112.14.camel@gaston>
	 <20031227170755.4990419b.davem@redhat.com> <3FF0FA6A.8000904@pobox.com>
	 <20031229205157.4c631f28.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1072764858.5079.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Dec 2003 17:14:18 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-30 at 15:51, David S. Miller wrote:

> There is one important detail not mentioned.
> 
> If we let the TX free occur in cpu IRQ disabled context, the
> BH to actually do the work will occur as some indeterminate
> time in the future after the top level IRQ spinlock release
> occurs.
> 
> Unlike local_bh_enable(), local_irq_enable() does not run
> softirq work.  Similarly when comparing IRQ handler return
> (which also runs softirq work if pending).

Ok, checked that with Rusty and it seems that scheduling the
softirq will wakeup softirqd when done from non-interrupt level,
so it should just work to call dev_kfree_skb_irq() from this
task context.

inline void raise_softirq_irqoff(unsigned int nr)
{
        __raise_softirq_irqoff(nr);
 
        /*
         * If we're in an interrupt or softirq, we're done
         * (this also catches softirq-disabled code). We will
         * actually run the softirq once we return from
         * the irq or softirq.
         *
         * Otherwise we wake up ksoftirqd to make sure we
         * schedule the softirq soon.
         */
        if (!in_interrupt())
                wakeup_softirqd();
}
 
So that should be ok to just call the _irq version in these
cases. Those aren't performance critical code path anyway,
it's power management when the machine is going to sleep in
this specific case in sungem, and close() codepath in
general.

Ben.



