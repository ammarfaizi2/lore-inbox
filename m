Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbSKPJra>; Sat, 16 Nov 2002 04:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbSKPJra>; Sat, 16 Nov 2002 04:47:30 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:26903
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267254AbSKPJr3>; Sat, 16 Nov 2002 04:47:29 -0500
Date: Sat, 16 Nov 2002 04:57:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Greg Kroah-Hartmann <greg@kroah.com>, Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5] USB core/urb.c triggers slab bugcheck
Message-ID: <Pine.LNX.4.44.0211160455040.1810-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is also required to get my box to boot

kernel BUG at mm/slab.c:1619!
invalid operand: 0000
 
CPU:    0
EIP:    0060:[<c0147a2d>]    Not tainted
EFLAGS: 00010283
EIP is at cache_alloc_debugcheck_after+0x4d/0xa0
eax: 04000409   ebx: c15bd398   ecx: 00000068   edx: c15bd400
esi: c7fff320   edi: 00000246   ebp: 000001d0   esp: c148fe50
ds: 0068   es: 0068   ss: 0068
Process khubd (pid: 5, threadinfo=c148e000 task=c7f75940)
Stack: c7fff320 c148e000 c0146b82 c7fff320 000001d0 c15bd398 c15a7c00 c7e0f244 
       80000200 00000000 c031bd66 00000060 000001d0 c15a7c00 c031c29d 00000000 
       000001d0 00000028 c031c38f c15a7c00 80000200 c7e0f244 00000000 00000000 
Call Trace:
 [<c0146b82>] kmalloc+0x82/0xb0
 [<c031bd66>] usb_alloc_urb+0x16/0x60
 [<c031c29d>] usb_internal_control_msg+0xd/0x80
 [<c031c38f>] usb_control_msg+0x7f/0xa0
 [<c031d04f>] usb_set_configuration+0x7f/0xe0
 [<c031793e>] usb_new_device+0x1be/0x3f0
 [<c03199df>] usb_hub_port_connect_change+0x17f/0x280
 [<c0319df0>] usb_hub_events+0x310/0x3d0
 [<c0319ee5>] usb_hub_thread+0x35/0xe0
 [<c011f7c0>] default_wake_function+0x0/0x40
 [<c0319eb0>] usb_hub_thread+0x0/0xe0
 [<c0108e15>] kernel_thread_helper+0x5/0x10

Code: 0f 0b 53 06 41 8f 45 c0 83 c3 04 8b 46 68 85 c0 74 06 f6 46 

Index: linux-2.5.47-zm1/drivers/usb/core/urb.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.47/drivers/usb/core/urb.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 urb.c
--- linux-2.5.47-zm1/drivers/usb/core/urb.c	11 Nov 2002 03:57:41 -0000	1.1.1.1
+++ linux-2.5.47-zm1/drivers/usb/core/urb.c	16 Nov 2002 09:32:47 -0000
@@ -33,17 +33,15 @@
 {
 	struct urb *urb;
 
-	urb = (struct urb *)kmalloc(sizeof(struct urb) + 
-		iso_packets * sizeof(struct usb_iso_packet_descriptor),
-		mem_flags);
-	if (!urb) {
+	urb = kmalloc(sizeof(*urb)
+			+ (iso_packets * sizeof(struct usb_iso_packet_descriptor)),
+			mem_flags);
+	if (urb) {
+		memset(urb, 0, sizeof(*urb));
+		atomic_set(&urb->count, 1);
+		spin_lock_init(&urb->lock);
+	} else
 		err("alloc_urb: kmalloc failed");
-		return NULL;
-	}
-
-	memset(urb, 0, sizeof(*urb));
-	urb->count = (atomic_t)ATOMIC_INIT(1);
-	spin_lock_init(&urb->lock);
 
 	return urb;
 }
-- 
function.linuxpower.ca

