Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSKRHHR>; Mon, 18 Nov 2002 02:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSKRHHR>; Mon, 18 Nov 2002 02:07:17 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:19102
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261561AbSKRHHP>; Mon, 18 Nov 2002 02:07:15 -0500
Date: Mon, 18 Nov 2002 02:17:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Greg Kroah-Hartmann <greg@kroah.com>
Subject: [PATCH][2.5] USB core/config.c == memory corruption (resend)
Message-ID: <Pine.LNX.4.44.0211180202090.1538-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch appended, tested with an OV511 on an Intel PIIX4

drivers/usb/core/hub.c: new USB device 00:07.2-1, assigned address 2
------------[ cut here ]------------
kernel BUG at mm/slab.c:1453!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c014550a>]    Not tainted
EFLAGS: 00010093
eax: 00000000   ebx: 00000048   ecx: c7e00000   edx: c7e00190
esi: c7e00148   edi: c7e0014c   ebp: c7fff1d0   esp: c7f09e6c
ds: 0068   es: 0068   ss: 0068
Process khubd (pid: 5, threadinfo=c7f08000 task=c7fa7940)
Stack: c7efbc00 c7fff1d0 c7e0014c 00000292 c01448b1 c7fff1d0 c7e0014c c1494195
       c7e00170 c15a8768 c7e0014c c031c9c2 c7e0014c c149418e c7e00194 00000040
       00000000 c1494155 00000000 c1494155 c031cda3 c1565ed4 c1494155 00000040
Call Trace: [<c01448b1>]  [<c031c9c2>]  [<c031cda3>]  [<c031d221>]  [<c0316ebf>]
 [<c0318f3f>]  [<c0319350>]  [<c0319445>]  [<c011eae0>]  [<c0319410>]  [<c0108df5>]

Code: 0f 0b ad 05 21 26 46 c0 8b 5d 38 8b 79 0c 89 f0 29 f8 31 d2
<1>Unable to handle kernel paging request at virtual address 5a5a5a5c
 printing eip:
c0322781
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0322781>]    Not tainted
EFLAGS: 00010287
eax: 00000002   ebx: 00000014   ecx: c7b74000   edx: c7b56182
esi: c7b56182   edi: 5a5a5a5a   ebp: 00000002   esp: c7b75e08
ds: 0068   es: 0068   ss: 0068
Process grep (pid: 58, threadinfo=c7b74000 task=c15e7980)
Stack: 00000001 00000001 000000ff c048d578 00000000 00000000 00000001 c1565ed4
       c1565ed4 00000014 c15a875c 00000001 c7b57f00 c0322a5e 00000002 c7b56182
       c7b57f00 5a5a5a5a c1565ed4 00000002 00000002 c7b57f00 c0322b5a 00000002
Call Trace: [<c0322a5e>]  [<c0322b5a>]  [<c0322ddd>]  [<c0322ed4>]  [<c0322fdc>]
 [<c032317f>]  [<c015730c>]  [<c015751a>]  [<c010b207>]

Code: 8a 47 02 31 d2 88 44 24 17 83 e0 80 88 c2 c6 44 24 23 49 85

This is only the first oops decoded, the second one is a fallout.

>>EIP; c014550a <cache_free_debugcheck+8a/190>   <=====

>>ecx; c7e00000 <_end+7811944/302159a4>
>>edx; c7e00190 <_end+7811ad4/302159a4>
>>esi; c7e00148 <_end+7811a8c/302159a4>
>>edi; c7e0014c <_end+7811a90/302159a4>
>>ebp; c7fff1d0 <_end+7a10b14/302159a4>
>>esp; c7f09e6c <_end+791b7b0/302159a4>

Trace; c01448b1 <kfree+61/e0>
Trace; c031c9c2 <usb_parse_interface+b2/320>
Trace; c031cda3 <usb_parse_configuration+173/230>
Trace; c031d221 <usb_get_configuration+181/260>
Trace; c0316ebf <usb_new_device+1cf/3e0>
Trace; c0318f3f <usb_hub_port_connect_change+17f/280>
Trace; c0319350 <usb_hub_events+310/3d0>
Trace; c0319445 <usb_hub_thread+35/e0>
Trace; c011eae0 <default_wake_function+0/40>
Trace; c0319410 <usb_hub_thread+0/e0>
Trace; c0108df5 <kernel_thread_helper+5/10>

Code;  c014550a <cache_free_debugcheck+8a/190>
00000000 <_EIP>:
Code;  c014550a <cache_free_debugcheck+8a/190>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014550c <cache_free_debugcheck+8c/190>
   2:   ad                        lods   %ds:(%esi),%eax
Code;  c014550d <cache_free_debugcheck+8d/190>
   3:   05 21 26 46 c0            add    $0xc0462621,%eax
Code;  c0145512 <cache_free_debugcheck+92/190>
   8:   8b 5d 38                  mov    0x38(%ebp),%ebx
Code;  c0145515 <cache_free_debugcheck+95/190>
   b:   8b 79 0c                  mov    0xc(%ecx),%edi
Code;  c0145518 <cache_free_debugcheck+98/190>
   e:   89 f0                     mov    %esi,%eax
Code;  c014551a <cache_free_debugcheck+9a/190>
  10:   29 f8                     sub    %edi,%eax
Code;  c014551c <cache_free_debugcheck+9c/190>
  12:   31 d2                     xor    %edx,%edx

Index: linux-2.5.48/drivers/usb/core/config.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.48/drivers/usb/core/config.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 config.c
--- linux-2.5.48/drivers/usb/core/config.c	18 Nov 2002 05:11:02 -0000	1.1.1.1
+++ linux-2.5.48/drivers/usb/core/config.c	18 Nov 2002 07:09:57 -0000
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

