Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272131AbTGYOvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272132AbTGYOvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:51:42 -0400
Received: from ida.rowland.org ([192.131.102.52]:15620 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S272131AbTGYOvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:51:40 -0400
Date: Fri, 25 Jul 2003 11:06:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Dominik Brugger <ml.dominik83@gmx.net>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
In-Reply-To: <20030725095222.21a2632e.ml.dominik83@gmx.net>
Message-ID: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003, Dominik Brugger wrote:

> Good morning,
> 
> > Do not unload modules before suspend, they should handle that just
> > fine.
> 
> If I keep them loaded during suspend:
> 
> [...]
> Suspending devices
> uhci-hcd 0000:00:11.2: suspend to state 3
> drivers/usb/host/uhci-hcd.c: dc00: suspend_hc
>  hwsleep-0257 [10] acpi_enter_sleep_state: Entering sleep state [S3]
> Enabling SEP on CPU 0
> Back to C!
> Devices Resumed
> uhci-hcd 0000:00:11.2: resume
> [...]
> drivers/usb/host/uhci-hcd.c: dc00: wakeup_hc
> 
> Mouse doesn't work, unplug:
> 
> hub 1-0:0: port 1, status 300, change 3, 1.5 Mb/s
> usb 1-1: USB disconnect, address 2
> drivers/usb/core/usb.c: nuking urbs assigned to 1-1
> usb 1-1: unregistering interfaces
> drivers/usb/core/usb.c: nuking urbs assigned to 1-1
> usb 1-1: hcd_unlink_urb df7be640 fail -22
> usb 1-1: hcd_unlink_urb df7be540 fail -22
> drivers/usb/core/usb.c: usb_hotplug
> usb 1-1: unregistering device
> drivers/usb/core/usb.c: usb_hotplug
> hub 1-0:0: port 1 enable change, status 300
> drivers/usb/host/uhci-hcd.c: dc00: suspend_hc
> 
> replug:
> 
> hub 1-0:0: port 1, status 301, change 3, 1.5 Mb/s
> hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
> hub 1-0:0: new USB device on port 1, assigned address 3
> drivers/usb/core/message.c: usb_control/bulk_msg: timeout
> 
> Further attempts to un/re-plug the device show no response.
> 
> (Same with Canon Powershot instead of Logitech USB Mouse)
> 
> > With uhci on toshiba satelite I can do both S3 and S4, and USB
> > survives that (at least it is able to power devices and detects
> > plugs/unplugs).
> 
> In my case it is an Epox 8kha+ board, the problem should not be hardware specific since Suspend To RAM works under WinXP.
> 
> I will try S4 lateron.
> 
> -Dominik Brugger

This could very well be related to the problem reported by Paul Mackerras 
about a month or two ago, see:

http://sourceforge.net/mailarchive/message.php?msg_id=5176974

I think the hub driver's power management code may be at fault.  It needs
to cancel the status interrupt URB when suspending and resubmit it when
waking up; right now it probably does neither one.

Or maybe I'm wrong about that.  Perhaps it's okay to leave the URB active.  
If that's the case, then the root hub power management code needs to be 
changed to restart the status URB timer after a wakeup.

I'm not sure how the design is intended to work, but either way something 
needs to be fixed.

Alan Stern


