Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279502AbRKRNaL>; Sun, 18 Nov 2001 08:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRKRNaC>; Sun, 18 Nov 2001 08:30:02 -0500
Received: from N402P014.adsl.highway.telekom.at ([213.33.50.46]:12703 "HELO
	twinny.dyndns.org") by vger.kernel.org with SMTP id <S279502AbRKRN3r>;
	Sun, 18 Nov 2001 08:29:47 -0500
Message-ID: <3BF7B50A.B1AC9FE@webit.com>
Date: Sun, 18 Nov 2001 14:18:02 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: USB-OHCI + USB broken in 2.4.14/15pre2?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In article <3BF735A6.E7E67ABD@webit.com> you write:
> >
> >I tried to "recover" this behavior by temporarily patching
> >ohci_pci_resume() so that it does a brutal hc_restart(ohci) instead of
> >nothing when detecting this "odd PCI resume" situation - without any
> >success. 

> I would suggest trying to do a "pci_enable_device(dev);" at the 
> very top of ohci_pci_resume(). It sounds like your suspend/resume doesn't
> re-enable PCI interrupt routing, and doing the device enable will make
> the kernel re-route the interrupt for you. If that helps, please send me 
> the tested patch, and forward it to the appropriate USB people too.

Kiitos/tack; however, to make it actually work on my particular machine
I needed to 

1) call hc_restart(ohci) in default section of switch statement AND

2) like you said, insert "pci_enable_device(dev);" right after the
declarations in ohci_pci_resume(). (I think this should be done after
the check for concurrent resumes, anyway).

This is what the log says this time:

----
Nov 18 13:40:46 oland cardmgr[189]: executing: './network suspend eth1'
Nov 18 13:40:46 oland kernel: usb-ohci.c: USB suspend: usb-00:01.2
Nov 18 13:40:46 oland kernel: NETDEV WATCHDOG: eth1: transmit timed out
Nov 18 13:40:46 oland kernel: eth1: Transmit timeout.
Nov 18 13:40:46 oland kernel: usb-ohci.c: Bus suspended
Nov 18 13:40:46 oland kernel: usb-ohci.c: USB suspend: usb-00:01.3
Nov 18 13:40:47 oland kernel: usb-ohci.c: Bus suspended
Nov 18 13:40:51 oland logger: Storing ALSA mixer settings...done.
Nov 18 13:40:52 oland logger: Shutting down ALSA sound driver (version
0.9.0beta9): done.
Nov 18 13:40:53 oland apmd[350]: User Suspend
Nov 18 13:40:57 oland kernel: PCI: Found IRQ 11 for device 00:01.2
Nov 18 13:40:57 oland kernel: PCI: Sharing IRQ 11 with 00:01.3
Nov 18 13:40:57 oland kernel: usb-ohci.c: odd PCI resume for usb-00:01.2
Nov 18 13:40:57 oland kernel: usb.c: USB disconnect on device 1
Nov 18 13:40:58 oland kernel: hub.c: USB hub found
Nov 18 13:40:58 oland kernel: hub.c: 3 ports detected
Nov 18 13:40:58 oland kernel: PCI: Found IRQ 11 for device 00:01.3
Nov 18 13:40:58 oland kernel: PCI: Sharing IRQ 11 with 00:01.2
Nov 18 13:40:58 oland kernel: usb-ohci.c: odd PCI resume for usb-00:01.3
Nov 18 13:40:58 oland kernel: usb.c: USB disconnect on device 1
Nov 18 13:40:58 oland kernel: usb.c: USB disconnect on device 2
Nov 18 13:40:58 oland kernel: usb-ohci.c: TD leak, 1
Nov 18 13:40:58 oland kernel: hub.c: USB hub found
Nov 18 13:40:58 oland kernel: hub.c: 3 ports detected
Nov 18 13:40:58 oland kernel: APIC error on CPU0: 00(40)
Nov 18 13:40:59 oland cardmgr[189]: executing: './network resume eth1'
Nov 18 13:41:00 oland kernel: hub.c: USB new device connect on bus2/1,
assigned device number 4
Nov 18 13:41:00 oland kernel: input0: USB HID v1.10 Mouse [Logitech USB
Mouse] on usb2:4.0
Nov 18 13:41:00 oland logger: ALSA driver (version 0.9.0beta9) is
already running.
Nov 18 13:41:01 oland kernel: PCI: Found IRQ 11 for device 00:01.4
Nov 18 13:41:01 oland kernel: PCI: Sharing IRQ 11 with 00:03.0
Nov 18 13:41:03 oland apmd[350]: Normal Resume after 00:00:10 (99%
unknown) AC power
Nov 18 13:41:04 oland logger: ALSA driver (version 0.9.0beta9) is
already running.
Nov 18 13:41:05 oland apmd[350]: Normal Resume after 00:00:12 (99%
unknown) AC power
----

As you can see, the APIC error still shows up in the log, although AFTER
hub.c says that it found a hub a the ports (ie. after
re-initialization).

Wondering what "TD leak, 1" means...?

I think this is more a dirty work-around than an appropriate solution;
or is it ok to assume that the control flags are corrupted (or reset to
OHCI_USB_OPER) after pci_enable_device() leading into "odd PCI
resume"...? (In this case I would be glad to submit a patch...)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:         
mailto:tw@webit.com              *** http://www.webit.com/tw
