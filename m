Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWIMUjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWIMUjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIMUjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:39:44 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:44947 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751177AbWIMUjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:39:44 -0400
Date: Wed, 13 Sep 2006 22:38:07 +0200
From: Mattia Dongili <malattia@linux.it>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Message-ID: <20060913203806.GA5580@inferi.kami.home>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	USB development list <linux-usb-devel@lists.sourceforge.net>
References: <200609131442.26784.rjw@sisk.pl> <Pine.LNX.4.44L0.0609131407390.6684-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609131407390.6684-100000@iolanthe.rowland.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc6-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 02:38:35PM -0400, Alan Stern wrote:
> On Wed, 13 Sep 2006, Rafael J. Wysocki wrote:
> 
> > Well, I have reproduced it with gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch
> > reverted too.
> > 
> > Attached is the output of dmesg from the failing case with USB_DEBUG set.
> > It covers two attempts to suspend to disk, the second one being unsuccessful,
> > with reloading the ohci_hcd module in between.  [This kernel also has your
> > other patch to prevent the second suspend from failing applied, but it doesn't
> > help.]
> 
> Okay.  Your problem, and probably Mattia's too, is something other than
> what that recent patch addressed.  I can't tell from the dmesg log exactly
> what went wrong, but I can tell you where to look.
> 
> In drivers/usb/core/driver.c, resume_device() is not succeeding.  That is, 
> the lines near the end which do
> 
> 	if (status == 0)
> 		udev->dev.power.power_state.event = PM_EVENT_ON;
> 
> aren't running during the first resume.  You can see this in the dmesg 
> log; lines 1173-1175 say
> 
> 	usb usb1: resuming
> 	 usbdev1.1_ep00: PM: resume from 0, parent usb1 still 1
> 	hub 1-0:1.0: PM: resume from 0, parent usb1 still 1
> 
> If power_state.event had gotten set to PM_EVENT_ON then the parent state 
> would be 0, not 1.  This is the source of your problem.  During your 
> second suspend attempt, usb1 didn't get handled correctly because its 
> state was set wrong.  (I suspect the mishandling took place in usbcore 
> rather than the PM core, but it doesn't matter.  The state should not have 
> been wrong to begin with.)  Consequently its parent device 0000:00:13.2 
> refused to freeze, which aborted the suspend attempt.
> 
> For the usb1 device, udriver->resume should point to the generic_resume() 
> routine in drivers/usb/core/generic.c.  In fact, this should be true for 
> every device that driver.c:resume_device() sees.  But generic_resume() 
> simply calls usb_port_resume() in hub.c, and the log doesn't contain any 
> of the USB debugging messages that usb_port_resume() would produce.  So I 
> can't tell what happened.
> 
> The patch below will add some extra debugging information.  We need to
> find out why the resume didn't succeed.  Oh -- and of course, you should
> reinstate all those autosuspend patches.  Otherwise this patch won't 
> apply!

ok, with USB_DEBUG=y and this is with your first patch still applied
http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-verbose-usb-try2

this is without it:
http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-verbose-usb-try3

I hope I'm not mixing thing too much with Rafael :)

Thanks
-- 
mattia
:wq!
