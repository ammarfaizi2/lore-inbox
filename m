Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbSKPJoa>; Sat, 16 Nov 2002 04:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbSKPJoa>; Sat, 16 Nov 2002 04:44:30 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:25623
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267253AbSKPJo3>; Sat, 16 Nov 2002 04:44:29 -0500
Date: Sat, 16 Nov 2002 04:54:41 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Greg Kroah-Hartmann <greg@kroah.com>, Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5] USB core/config.c triggers slab bugcheck
Message-ID: <Pine.LNX.4.44.0211160452010.1810-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg does this look ok? My system boots now;

drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.2, Intel Corp. 82371AB/EB/MB PIIX4 USB
drivers/usb/core/hcd-pci.c: irq 10, io base 0000e000
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected

kernel BUG at mm/slab.c:1454!
invalid operand: 0000

CPU:    0
EIP:    0060:[<c01478da>]    Not tainted
EFLAGS: 00010093
EIP is at cache_free_debugcheck+0x8a/0x190
eax: 00000000   ebx: 00000048   ecx: c15c4000   edx: c15c4c40
esi: c15c4bf8   edi: c15c4bfc   ebp: c7fff1d0   esp: c148fe6c
ds: 0068   es: 0068   ss: 0068
Process khubd (pid: 5, threadinfo=c148e000 task=c7f75940)
Stack: c1487c00 c7fff1d0 c15c4bfc 00000296 c0146c81 c7fff1d0 c15c4bfc c7f7e195
       c15c4c20 c15bd428 c15c4bfc c031d442 c15c4bfc c7f7e18e c15c4c44 00000040
       00000000 c7f7e155 00000000 c7f7e155 c031d819 c15c0800 c7f7e155 00000040
Call Trace:
 [<c0146c81>] kfree+0x61/0xe0
 [<c031d442>] usb_parse_interface+0xb2/0x320
 [<c031d819>] usb_parse_configuration+0x169/0x220
 [<c031dc91>] usb_get_configuration+0x181/0x360
 [<c0317920>] usb_new_device+0x1a0/0x3f0
 [<c03199df>] usb_hub_port_connect_change+0x17f/0x280
 [<c0319df0>] usb_hub_events+0x310/0x3d0
 [<c0319ee5>] usb_hub_thread+0x35/0xe0
 [<c011f7c0>] default_wake_function+0x0/0x40
 [<c0319eb0>] usb_hub_thread+0x0/0xe0
 [<c0108e15>] kernel_thread_helper+0x5/0x10

Code: 0f 0b ae 05 c1 8e 45 c0 8b 5d 38 8b 79 0c 89 f0 29 f8 31 d2

Index: linux-2.5.47-zm1/drivers/usb/core/config.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.47/drivers/usb/core/config.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 config.c
--- linux-2.5.47-zm1/drivers/usb/core/config.c	11 Nov 2002 03:57:41 -0000	1.1.1.1
+++ linux-2.5.47-zm1/drivers/usb/core/config.c	16 Nov 2002 09:37:11 -0000
@@ -109,7 +109,8 @@
 	interface->num_altsetting = 0;
 	interface->max_altsetting = USB_ALTSETTINGALLOC;
 
-	interface->altsetting = kmalloc(sizeof(struct usb_interface_descriptor) * interface->max_altsetting, GFP_KERNEL);
+	interface->altsetting = kmalloc(sizeof(*interface->altsetting) * interface->max_altsetting,
+					GFP_KERNEL);
 	
 	if (!interface->altsetting) {
 		err("couldn't kmalloc interface->altsetting");
@@ -118,29 +119,27 @@
 
 	while (size > 0) {
 		struct usb_interface_descriptor	*d;
-
+	
 		if (interface->num_altsetting >= interface->max_altsetting) {
-			void *ptr;
+			struct usb_host_interface *ptr;
 			int oldmas;
 
 			oldmas = interface->max_altsetting;
 			interface->max_altsetting += USB_ALTSETTINGALLOC;
 			if (interface->max_altsetting > USB_MAXALTSETTING) {
-				warn("too many alternate settings (max %d)",
-					USB_MAXALTSETTING);
+				warn("too many alternate settings (incr %d max %d)\n",
+					USB_ALTSETTINGALLOC, USB_MAXALTSETTING);
 				return -1;
 			}
 
-			ptr = interface->altsetting;
-			interface->altsetting = kmalloc(sizeof(struct usb_interface_descriptor) * interface->max_altsetting, GFP_KERNEL);
-			if (!interface->altsetting) {
+			ptr = kmalloc(sizeof(*ptr) * interface->max_altsetting, GFP_KERNEL);
+			if (ptr == NULL) {
 				err("couldn't kmalloc interface->altsetting");
-				interface->altsetting = ptr;
 				return -1;
 			}
-			memcpy(interface->altsetting, ptr, sizeof(struct usb_interface_descriptor) * oldmas);
-
-			kfree(ptr);
+			memcpy(ptr, interface->altsetting, sizeof(*interface->altsetting) * oldmas);
+			kfree(interface->altsetting);
+			interface->altsetting = ptr;
 		}
 
 		ifp = interface->altsetting + interface->num_altsetting;
-- 
function.linuxpower.ca

