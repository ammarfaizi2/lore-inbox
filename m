Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVK0T5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVK0T5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVK0T5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:57:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751027AbVK0T5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:57:15 -0500
Date: Sun, 27 Nov 2005 11:56:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: ak@suse.de, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, paulmck@us.ibm.com, greg@kroah.com,
       Douglas_Warzecha@dell.com, Abhay_Salunke@dell.com,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-Id: <20051127115640.3073f8e3.akpm@osdl.org>
In-Reply-To: <24158.1133113176@ocs3.ocs.com.au>
References: <20051127172725.GJ20775@brahms.suse.de>
	<24158.1133113176@ocs3.ocs.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
> On Sun, 27 Nov 2005 18:27:25 +0100, 
> Andi Kleen <ak@suse.de> wrote:
> >On Mon, Nov 28, 2005 at 02:59:05AM +1100, Keith Owens wrote:
> >> On Sun, 27 Nov 2005 14:47:36 +0100, 
> >> Andi Kleen <ak@suse.de> wrote:
> >> >akpm wrote
> >> >>   - Introduce a new notifier API which is wholly unlocked
> >> >
> >> >The old notifiers were already wholly unlocked.

The register and unregister functions take a write_lock on notifier_lock. 
notifier_call_chain() runs unlocked.

> So it wouldn't 
> >> >even need any changes. Just additional locks everywhere.
> >> 
> >> Wrong.  
> >
> >Did you actually read what I wrote? 
> 
> Of course I did.

No you didn't!

>  The whole point is that _ALL_ of the existing
> notifier chain callback code is racy[*].

yup.

>  Saying that the code can be
> left without any changes is simply ignoring the existing races.  They
> _ALL_ need to be fixed.

We're saying that kernel/sys.c:notifier_lock should be removed and that all
callers of notifier_chain_register(), notifier_chain_unregister() and
notifier_call_chain() should be changed to define and use their own lock.

So the _callers_ get to decide whether they're going to use down(),
spin_lock(), down_read(), read_lock(), preempt_disable(), local_irq_disable()
or whatever.

Furthermore we should alter notifier_call_chain() so that a callback may
safely perform notifier_chain_unregister() - that's sane and easy enough.
