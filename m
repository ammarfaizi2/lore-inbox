Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313943AbSDUXsx>; Sun, 21 Apr 2002 19:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313962AbSDUXsw>; Sun, 21 Apr 2002 19:48:52 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:21007 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S313943AbSDUXsw>; Sun, 21 Apr 2002 19:48:52 -0400
Message-Id: <200204212348.g3LNmoG10576@enterprise.bidmc.harvard.edu>
Content-Type: text/plain; charset=US-ASCII
From: Kris Karas <ktk@enterprise.bidmc.harvard.edu>
Organization: BI Deaconess Medical Center, Boston
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre2++ USB EHCI-HCD -> auto-reboot
Date: Sun, 21 Apr 2002 19:49:52 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg, et al,

I need some tips on how to debug (or help others debug) a problem I am seeing 
with the EHCI-HCD driver introduced in 2.4.19-pre2.

Problem: When reading roughly 250 or more contiguous sectors from a 
usb-storage device, the system auto-reboots.  The reboot is hard and 
instantaneous enough that it is impossible to capture screen debug output, if 
any; even with verbose debug enabled, there are no lines appended to 
/var/log/* that survive the ext3 journal replay.  (Sorry, no serial-debug 
ability here at home; I doubt the data would be flushed out the line anyway.)

Observations: This behavior does not exhibit itself with the UHCI or OHCI 
drivers, so it does not appear to be a usb-storage driver problem.  The 
hardware is evidently OK, as the Windows drivers have no such problem using 
the full 480 Mbit speed.  Small transfers (of at most a few blocks at a time) 
seem to work OK at high speed.

Kris

What I did, comments in #...
$ # Note: using OHCI at the moment...
$ dd if=/dev/sda of=/dev/null bs=512 count=256
256+0 records in
256+0 records out
$ modprobe ehci-hcd
$ # EHCI now; Plug and unplug USB cable to flush buffers...
$ dd if=/dev/sda of=/dev/null bs=512 count=224
224+0 records in
224+0 records out
$ # Plug and unplug the cable again...
$ dd if=/dev/sda of=/dev/null bs=512 count=256
<Instantaneous Reboot>

System:
MB:	Soltek SL75DRV2, Athlon XP 1700, KT266A, VT8233,
	VIA UHCI USB 1.1, VT82C586B, rev 27
USB:	SIIG USB 2.0 + IEEE1394 PCI card
	Uses HINT corp HB1-SE33 PCI-PCI bridge (rev17).
	NEC OHCI USB 1.1, rev 65,
	NEC EHCI USB 2.0, rev 2,
	VIA IEEE 1394 OHCI, rev 67.

Config:
CONFIG_IEEE1394=y
CONFIG_IEEE1394_OHCI1394=y
CONFIG_IEEE1394_VIDEO1394=y
CONFIG_IEEE1394_SBP2=y
CONFIG_IEEE1394_RAWIO=y
CONFIG_IEEE1394_VERBOSEDEBUG=y
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI=y
CONFIG_USB_OHCI=y
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_PRINTER=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
