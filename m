Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280031AbRKRTUV>; Sun, 18 Nov 2001 14:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRKRTUM>; Sun, 18 Nov 2001 14:20:12 -0500
Received: from N402P014.adsl.highway.telekom.at ([213.33.50.46]:13983 "HELO
	twinny.dyndns.org") by vger.kernel.org with SMTP id <S280031AbRKRTT7>;
	Sun, 18 Nov 2001 14:19:59 -0500
Message-ID: <3BF80863.88128F58@webit.com>
Date: Sun, 18 Nov 2001 20:13:39 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB-OHCI + USB broken in 2.4.14/15pre2?
In-Reply-To: <3BF7B50A.B1AC9FE@webit.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thomas Winischhofer wrote:
> 
> Kiitos/tack; however, to make it actually work on my particular machine
> I needed to
> 
> 1) call hc_restart(ohci) in default section of switch statement AND
> 
> 2) like you said, insert "pci_enable_device(dev);" right after the
> declarations in ohci_pci_resume(). (I think this should be done after
> the check for concurrent resumes, anyway).

WRONG. This does as a matter of fact _not_ work:

When a device is connected to the bus at the time of suspend, using my
somewhat brutal method recovers that device at resume from suspend. So
far so good.

But: When there's _no_ device connected to the usb at the time of
suspend, the bus does NOT recover properly and produces errors after
resume whenever I try to connect a device.

Here's what I did:

----
--- /root/usb-ohci.c	Sun Nov 18 19:26:00 2001
+++ /usr/src/linux/drivers/usb/usb-ohci.c	Sun Nov 18 19:37:27 2001
@@ -2678,16 +2678,16 @@
 	mdelay (500); /* No schedule here ! */
 	switch (readl (&ohci->regs->control) & OHCI_CTRL_HCFS) {
 		case OHCI_USB_RESET: /* dbg statt info!/TW */
-			dbg("Bus in reset phase ???");
+			info("Bus in reset phase ???");
 			break;
 		case OHCI_USB_RESUME:
-			dbg("Bus in resume phase ???");
+			info("Bus in resume phase ???");
 			break;
 		case OHCI_USB_OPER:
-			dbg("Bus in operational phase ???");
+			info("Bus in operational phase ???");
 			break;
 		case OHCI_USB_SUSPEND:
-			dbg("Bus suspended");
+			info("Bus suspended");
 			break;
 	}
 	/* In some rare situations, Apple's OHCI have happily trashed
@@ -2719,6 +2719,8 @@
 	int		temp;
 	unsigned long	flags;
 
+	pci_enable_device(dev);
+	
 	/* guard against multiple resumes */
 	atomic_inc (&ohci->resume_count);
 	if (atomic_read (&ohci->resume_count) != 1) {
@@ -2812,6 +2814,7 @@
 
 	default:
 		warn ("odd PCI resume for usb-%s", dev->slot_name);
+		hc_restart (ohci);
 	}
 
 	/* controller is operational, extra resumes are harmless */

----

The log:

---- suspending:
Nov 18 19:45:00 oland cardmgr[189]: executing: './network suspend eth1'
Nov 18 19:45:00 oland kernel: NETDEV WATCHDOG: eth1: transmit timed out
Nov 18 19:45:00 oland kernel: eth1: Transmit timeout.
Nov 18 19:45:00 oland kernel: usb-ohci.c: USB suspend: usb-00:01.2
Nov 18 19:45:01 oland kernel: usb-ohci.c: Bus suspended
Nov 18 19:45:01 oland kernel: usb-ohci.c: USB suspend: usb-00:01.3
Nov 18 19:45:01 oland kernel: usb-ohci.c: Bus suspended
Nov 18 19:45:06 oland apmd[350]: User Suspend
----

---- resuming:
Nov 18 19:45:13 oland kernel: PCI: Found IRQ 11 for device 00:01.2
Nov 18 19:45:13 oland kernel: PCI: Sharing IRQ 11 with 00:01.3
Nov 18 19:45:13 oland kernel: usb-ohci.c: odd PCI resume for usb-00:01.2
Nov 18 19:45:13 oland kernel: usb.c: USB disconnect on device 1
Nov 18 19:45:14 oland kernel: hub.c: USB hub found
Nov 18 19:45:14 oland kernel: hub.c: 3 ports detected
Nov 18 19:45:14 oland kernel: PCI: Found IRQ 11 for device 00:01.3
Nov 18 19:45:14 oland kernel: PCI: Sharing IRQ 11 with 00:01.2
Nov 18 19:45:14 oland kernel: usb-ohci.c: odd PCI resume for usb-00:01.3
Nov 18 19:45:14 oland kernel: usb.c: USB disconnect on device 1
Nov 18 19:45:14 oland kernel: hub.c: USB hub found
Nov 18 19:45:14 oland kernel: hub.c: 3 ports detected
Nov 18 19:45:14 oland kernel: APIC error on CPU0: 00(40)
Nov 18 19:45:15 oland cardmgr[189]: executing: './network resume eth1'
Nov 18 19:45:16 oland apmd[350]: Normal Resume after 00:00:10 (99%
unknown) AC power
Nov 18 19:45:17 oland apmd[350]: Normal Resume after 00:00:11 (99%
unknown) AC power
----

(Why resume twice?)

---- connecting device (mouse)
Nov 18 19:45:29 oland kernel: hub.c: USB new device connect on bus1/3,
assigned device number 3
Nov 18 19:45:32 oland kernel: usb_control/bulk_msg: timeout
Nov 18 19:45:32 oland kernel: usb.c: USB device not accepting new
address=3 (error=-110)
Nov 18 19:45:33 oland kernel: hub.c: USB new device connect on bus1/3,
assigned device number 4
Nov 18 19:45:36 oland kernel: usb_control/bulk_msg: timeout
Nov 18 19:45:36 oland kernel: usb.c: USB device not accepting new
address=4 (error=-110)
----

There we are again. What do the ohci gurus say?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:         
mailto:tw@webit.com              *** http://www.webit.com/tw
