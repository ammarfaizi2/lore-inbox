Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271399AbTGXBCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 21:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271401AbTGXBCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 21:02:08 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:40843 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S271399AbTGXBCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 21:02:03 -0400
Message-ID: <3F1F342F.70701@pacbell.net>
Date: Wed, 23 Jul 2003 18:19:43 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: weissg@vienna.at, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] OHCI problems with suspend/resume
References: <20030723220805.GA278@elf.ucw.cz>
In-Reply-To: <20030723220805.GA278@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> In 2.6.0-test1, OHCI is non-functional after first suspend/resume, and
> kills machine during secon suspend/resume cycle.

Hmm, last time I tested suspend/resume it worked fine.
That was 2.5.67, but the OHCI code hasn't had any
relevant changes since then.

Evidently your system used different suspend/resume paths
than mine did ... :)


> What happens is that ohci_irq gets ohci->hcca == NULL, and kills
> machine. Why is ohci->hcca == NULL? ohci_stop was called from
> hcd_panic() and freed ohci->hcca.

Then the problem is that an IRQ is still coming in after the
HCD panicked.


> I believe that we should
> 
> 1) not free ohci->hcca so that system has better chance surviving
> hcd_panic()

Not ever????

It's freed in exactly one place, after everything should be
shut down.  If it wasn't shut down, that was the problem.

Could you instead figure out why it wasn't shut down?


> and 
> 
> 2) inform user when hcd panics.

The OHCI code does that already on the normal panic path
(controller delivers a Unrecoverable Error interrupt), but
you're right that this would be better as a generic KERN_CRIT
diagnostic.  (But one saying which HCD panicked, rather than
leaving folk to guess which of the N it applied to...)  And
I'd print that message sooner, not waiting for that task to
be scheduled.

I'll merge that fix in with one I have in my queue.

- Dave

