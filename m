Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVCGW6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVCGW6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVCGW4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:56:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65499 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261802AbVCGWLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:11:25 -0500
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Randy Dunlap <rddunlap@osdl.org>,
       linux-usb-devel@lists.sourceforge.net, fastboot@osdl.org,
       <linux-kernel@vger.kernel.org>
Subject: Re: kexec and IRQ sharing
References: <Pine.LNX.4.44L0.0503071555530.1789-100000@ida.rowland.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Mar 2005 15:08:17 -0700
In-Reply-To: <Pine.LNX.4.44L0.0503071555530.1789-100000@ida.rowland.org>
Message-ID: <m1k6ojm7n2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On 7 Mar 2005, Eric W. Biederman wrote:
> 
> > Alan Stern <stern@rowland.harvard.edu> writes:
> > 
> > > Shared IRQs will always be a problem.  And the PCI subsystem doesn't
> > > implement shutdown() methods; that seems like a pretty big hole.  I guess 
> > > individual drivers can always create their own, however.
> > 
> > Not having seen this in practice what is the bad effect
> > that happens with shared irqs.  I know there is a warning messages
> > but is there anything beyond this, such as the irq being stuck on?
> 
> The problem comes when two devices share an IRQ line and at least one of 
> them is actively generating interrupt requests.  An ethernet interface or 
> a USB controller would make a good example, if they weren't shut down 
> properly during a kexec reboot.
> 
> Let's say devices A and B share the same IRQ, and B has an interrupt
> request pending.  Initially all the IRQ lines are disabled; they only get
> enabled as drivers request them.  So consider what happens when the driver
> for A is initialized.  It will probe A and will request the IRQ line be
> enabled.  B's outstanding request will immediately interrupt the
> processor.  But since there's no driver loaded for B, nobody will claim
> the interrupt or clear its source.
> 
> Result: The kernel warns about interrupts not owned by a driver, and 
> automatically disables the IRQ line.  Now device A is in trouble.  
> Obviously it can't function correctly without interrupts.  B will be in 
> trouble too, when its driver loads.
> 
> This is exactly what happened to Laurent Riffard in
> 
> http://bugme.osdl.org/show_bug.cgi?id=4294
> 
> Read his full dmesg attachment; you can see where IRQ 5 was triggered as 
> soon as one of the USB controllers enabled it.  Apparently the other USB 
> controller had a pending interrupt.
> 
> Things wouldn't be quite so bad if setup_irq() would re-enable a disabled
> shared IRQ when another driver requests it, but it doesn't.  Is this
> behavior a bug or is it deliberate?

Very good question.  I'm going to bounce this discussion towards
linux-kernel and because it appears that the kernels interrupt
handling behavior could be made more robust.  It looks like
irqpoll command line option is a step in that direction.

/sbin/kexec downs network interfaces before calling sys_reboot()
so for network interfaces this is largely solved.

The ongoing DMA transfers which are companions of the irq generating
events are what really concern me, as we could get all kinds of
interesting memory stomps.  Do you think you could implement
a reboot notifier or a shutdown() method to handle that case?

This appears to be yet another case of kexec transforming theoretical
bugs into actual ones.  Groan.

Eric
