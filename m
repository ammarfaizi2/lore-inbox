Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbTLKU1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTLKU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:27:12 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:17280 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265229AbTLKU1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:27:05 -0500
Date: Thu, 11 Dec 2003 21:26:23 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [USB] hid blacklist addition for the BerkshireProducts USB PC Watchdog
Message-ID: <20031211212623.A5490@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

the hid driver oops'es on the BerkshireProducts USB PC Watchdog card 
when it automatically disconnects itself, just before doing it's 
reboot stuff. (See Oops log at the end of this message)

The (quick) fix in this case is to add this card to the hid blacklist.
(See diff below).

I added the change to the linux-watchdog bitkeeper tree 
(See http://linux-watchdog.bkbits.net:8080/linux-2.5-watchdog
ChangeSet 1.1436).

Some more info:

 drivers/usb/input/hid-core.c |    4 ++++
 1 files changed, 4 insertions(+)

through these ChangeSets:

<wim@iguana.be> (03/12/11 1.1436)
   [USB] hid blacklist addition
   
   Added the Berkshire Products USB PC Watchdog to the hid blacklist.
   This to avoid problems with USB-Disconnects when the card feels it should reboot...

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Thu Dec 11 21:04:40 2003
+++ b/drivers/usb/input/hid-core.c	Thu Dec 11 21:04:40 2003
@@ -1354,6 +1354,9 @@
 #define USB_VENDOR_ID_A4TECH		0x09DA
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 
+#define USB_VENDOR_ID_BERKSHIRE		0x0c98
+#define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1403,6 +1406,7 @@
 	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK },
+	{ USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD, HID_QUIRK_IGNORE },
 	{ 0, 0 }
 };
 
================================================================================
Nov 23 13:38:58 stafke kernel: usb 1-2: USB disconnect, address 2
Nov 23 13:38:58 stafke kernel: Unable to handle kernel paging request at virtual address c8828060
Nov 23 13:38:58 stafke kernel:  printing eip:
Nov 23 13:38:58 stafke kernel: c8822ee4
Nov 23 13:38:58 stafke kernel: *pde = 011a1067
Nov 23 13:38:58 stafke kernel: *pte = 00000000
Nov 23 13:38:58 stafke kernel: Oops: 0002 [#1]
Nov 23 13:38:58 stafke kernel: CPU:    0
Nov 23 13:38:58 stafke kernel: EIP:    0060:[<c8822ee4>]    Not tainted
Nov 23 13:38:58 stafke kernel: EFLAGS: 00010246
Nov 23 13:38:58 stafke kernel: EIP is at hiddev_cleanup+0x24/0x40 [hid]
Nov 23 13:38:58 stafke kernel: eax: 00000060   ebx: c7e8b6e0   ecx: 00000000   edx: 00000000
Nov 23 13:38:58 stafke kernel: esi: c8827ac0   edi: c79e6e00   ebp: c1361e88   esp: c1361e7c
Nov 23 13:38:58 stafke kernel: ds: 007b   es: 007b   ss: 0068
Nov 23 13:38:58 stafke kernel: Process khubd (pid: 67, threadinfo=c1360000 task=c1395300)
Nov 23 13:38:58 stafke kernel: Stack: c7e8b6fc c8827bb8 c12a4000 c1361e9c c8822968 c7e8b6e0 c8827ac0 c7fa2200
Nov 23 13:38:58 stafke kernel:        c1361eb4 c883f136 c7fa2200 c7fa2200 c7fa2214 c8827ae0 c1361ecc c01cf836
Nov 23 13:38:58 stafke kernel:        c7fa2214 c7fa2240 c7fa2214 c79e6ecc c1361ee4 c01cf973 c7fa2214 c7fa2270
Nov 23 13:38:59 stafke kernel: Call Trace:
Nov 23 13:38:59 stafke kernel:  [<c8822968>] hid_disconnect+0xb8/0xe0 [hid]
Nov 23 13:38:59 stafke kernel:  [<c883f136>] usb_unbind_interface+0x76/0x80 [usbcore]
Nov 23 13:38:59 stafke kernel:  [<c01cf836>] device_release_driver+0x66/0x70
Nov 23 13:38:59 stafke kernel:  [<c01cf973>] bus_remove_device+0x53/0xa0
Nov 23 13:38:59 stafke kernel:  [<c01ce83d>] device_del+0x5d/0xa0
Nov 23 13:38:59 stafke kernel:  [<c8845210>] usb_disable_device+0x70/0xb0 [usbcore]
Nov 23 13:38:59 stafke kernel:  [<c883fa16>] usb_disconnect+0xa6/0x100 [usbcore]Nov 23 13:38:59 stafke kernel:  [<c8842161>] hub_port_connect_change+0x321/0x330 [usbcore]
Nov 23 13:38:59 stafke kernel:  [<c8841a58>] hub_port_status+0x38/0xa0 [usbcore]Nov 23 13:38:59 stafke kernel:  [<c8842493>] hub_events+0x323/0x370 [usbcore]
Nov 23 13:38:59 stafke kernel:  [<c8842515>] hub_thread+0x35/0xe0 [usbcore]
Nov 23 13:38:59 stafke kernel:  [<c0118270>] default_wake_function+0x0/0x30
Nov 23 13:38:59 stafke kernel:  [<c88424e0>] hub_thread+0x0/0xe0 [usbcore]
Nov 23 13:38:59 stafke kernel:  [<c01091c9>] kernel_thread_helper+0x5/0xc
Nov 23 13:38:59 stafke kernel:
Nov 23 13:38:59 stafke kernel: Code: 89 0c 85 e0 7e 82 c8 89 5d 08 8b 5d fc 89 ec 5d e9 97 56 91
