Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVCHRv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVCHRv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVCHRv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:51:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38621 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261448AbVCHRvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:51:17 -0500
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>,
       Randy Dunlap <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>,
       <fastboot@osdl.org>
Subject: Re: kexec and IRQ sharing
References: <Pine.LNX.4.44L0.0503081125580.978-100000@ida.rowland.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Mar 2005 10:48:17 -0700
In-Reply-To: <Pine.LNX.4.44L0.0503081125580.978-100000@ida.rowland.org>
Message-ID: <m1fyz6m3ku.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> I can implement either a shutdown method or a reboot notifier for
> uhci-hcd.  Note however that the upcoming changes to the PM core include a
> suspend call (PMSG_FREEZE) that does exactly what you want: quiesce the
> device, disable IRQ and DMA, but don't necessarily switch the power level.  
> (See Documentation/power/devices.txt.)  Unfortunately it won't be
> implemented until another few kernel releases have gone by.

Thanks.
 
> The idea of using kexec to recover from a partially-damaged kernel seems 
> unreliable.  Even attempting to quiesce devices prior to rebooting may 
> not work because of locks whose owners have crashed.

There is still a final bit of feeling our way through the weirdness,
in that case.  But in that case no devices will be quiesced before
we start the next kernel.  Basically very little beyond a jump
jump instruction will be executed at that point.  What is loaded must
be a very robust kernel capable of handling the few devices it needs
from an active state.  The irq weirdness you just ran into is
something that really hasn't been looked at.

In that case I suspect we will probably simply want to specify irqpoll
on the command line by default.  We are as safe as possible from DMA
traffic because we run out of a completely reserved area of memory
that the primary kernel never uses.

And the target is not a complete system recover but rather being able
to do something useful in the event of a crash like write a core
dump.

So in the crash dump case with a non-hardened driver that can't cope
the system may lock up, but I don't see it corrupting your data.
Which is the important bit.  And with drivers that have been
sufficiently hardened you will be able to do things like write
to disk etc.

Eric
