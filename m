Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWINVsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWINVsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWINVsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:48:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:25819 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751225AbWINVsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:48:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Date: Thu, 14 Sep 2006 23:47:15 +0200
User-Agent: KMail/1.9.1
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       Mattia Dongili <malattia@linux.it>, Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609141618450.6982-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609141618450.6982-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609142347.16578.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 September 2006 22:55, Alan Stern wrote:
> On Thu, 14 Sep 2006, Rafael J. Wysocki wrote:
> 
> > Well, sorry.  This test has been passed, but after a reboot it refused to
> > suspend just once giving the same messages that I've got from the kernel
> > with USB_SUSPEND set (the relevant dmesg output is attached).
> > 
> > > Then for the next stage, repeat the same tests but with  
> > > USB_SUSPEND set.
> 
> Okay, hang on, let's try to solve this first.
> 
> This actually is a completely different problem from what I've been
> attacking up to now, and we definitely should resolve it.  It's purely a
> question of the ohci-hcd driver, nothing (or very little) to do with
> usbcore or ehci-hcd or uhci-hcd.
> 
> I'm asking David to chime in, because this is his code and his driver.
> 
> Here's an explanation of the problem.  Basically it boils down to the way 
> ohci-hcd rolls its own root-hub autosuspend.  I'm referring to the call to 
> ohci_bus_suspend() near the end of ohci-hub.c:ohci_hub_status_data().
> Things go wrong because that call totally bypasses usbcore.  It's a 
> layering violation.
> 
> The corresponding root-hub autoresume code, i.e., the call to
> usb_hcd_resume_root_hub() in ohci-hcd.c:ohci_irq(), _does_ go through
> usbcore.  It fails for two reasons.  First, resume_root_hub does its job
> by queuing a call to usb_autoresume_device(), and when CONFIG_USB_SUSPEND
> isn't set that routine is a no-op.  Second, since usbcore was never
> notified when the root hub was suspended, the root hub's device state
> isn't USB_STATE_SUSPENED and the interface is still marked as active -- so
> even if usb_autoresume_device() did get called it wouldn't do anything.
> 
> As I see it, there are two ways to resolve the problem.  The easiest is to
> rip out the autosuspend stuff from ohci-hcd entirely.  When my generic
> autosuspend patches are accepted, the HCD-specific stuff won't be needed
> so much.  This has the disadvantage that the root hub will never get
> suspended if CONFIG_USB_SUSPEND isn't set.  On the other hand, this is how 
> ehci_hcd works already.

This isn't a big deal as far as I'm concerned, but I think that dependancy
will have to be reflected by some Kconfig rules (eg. if CONFIG_USB_SUSPEND
gets selected automatically if CONFIG_PM is set).

> The second way is to copy what I did in uhci-hcd.  There is a special
> "root hub is stopped" mode which kicks in only when no ports are
> connected.  It isn't a full-fledged suspend, in the sense that usbcore
> isn't notified -- just like what happens in ohci-hcd.  The difference is,
> since we know no devices are attached, the driver can go back to normal
> operation while in interrupt context.  It doesn't have to sleep because no
> attached devices means no TRSMRCY delay is needed and the controller's
> hardware can be reset directly.  As a result, the corresponding
> "auto-restart" code doesn't need to go through usbcore either and so
> usb_autoresume_device() never enters the picture.
> 
> I don't know if this is feasible with OHCI.  For now, I'll include a patch 
> that takes the first approach and disables the ohci-hcd autosuspend 
> entirely.  I think it will solve your problem above.

Yes it does.

Now I'm able to suspend/resume several times in a row with both
ohci and ehci hcds loaded all the time.  Thanks a lot!

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
