Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTGXKJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 06:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTGXKJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 06:09:47 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:34264 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261151AbTGXKJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 06:09:40 -0400
Date: Thu, 24 Jul 2003 12:24:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: weissg@vienna.at, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] OHCI problems with suspend/resume
Message-ID: <20030724102432.GB228@elf.ucw.cz>
References: <20030723220805.GA278@elf.ucw.cz> <3F1F342F.70701@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1F342F.70701@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >In 2.6.0-test1, OHCI is non-functional after first suspend/resume, and
> >kills machine during secon suspend/resume cycle.
> 
> Hmm, last time I tested suspend/resume it worked fine.
> That was 2.5.67, but the OHCI code hasn't had any
> relevant changes since then.

> Evidently your system used different suspend/resume paths
> than mine did ... :)

Can you try echo 4 > /proc/acpi/sleep? echo 3 breaks it, too, but that
is little harder to set up.

> >What happens is that ohci_irq gets ohci->hcca == NULL, and kills
> >machine. Why is ohci->hcca == NULL? ohci_stop was called from
> >hcd_panic() and freed ohci->hcca.
> 
> Then the problem is that an IRQ is still coming in after the
> HCD panicked.

Actually, as PCI interrupts are shared, I do not find that too
surprising. 

> >I believe that we should
> >
> >1) not free ohci->hcca so that system has better chance surviving
> >hcd_panic()
> 
> Not ever????
> 
> It's freed in exactly one place, after everything should be
> shut down.  If it wasn't shut down, that was the problem.
> 
> Could you instead figure out why it wasn't shut down?

In case of hcd_panic(), where is interrupt deallocated?

> >and 
> >
> >2) inform user when hcd panics.
> 
> The OHCI code does that already on the normal panic path
> (controller delivers a Unrecoverable Error interrupt), but
> you're right that this would be better as a generic KERN_CRIT
> diagnostic.  (But one saying which HCD panicked, rather than
> leaving folk to guess which of the N it applied to...)  And
> I'd print that message sooner, not waiting for that task to
> be scheduled.

That would be good. I definitely had another failure path, where it
did not tell me that hcd is no K.O...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
