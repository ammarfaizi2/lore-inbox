Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSL1AhH>; Fri, 27 Dec 2002 19:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSL1AhH>; Fri, 27 Dec 2002 19:37:07 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:1180 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265275AbSL1AhG>;
	Fri, 27 Dec 2002 19:37:06 -0500
Date: Sat, 28 Dec 2002 01:45:22 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212280045.BAA01994@harpo.it.uu.se>
To: davej@codemonkey.org.uk
Subject: [PATCH] 2.5.53 AGP module oops
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Kernel 2.5.53 changed the AGP config options so that
CONFIG_AGP=m forces =m on the HW-specific config. When I
insmod the HW-specific module (intel-agp in my case)
after insmod agpgart, the kernel immediately oopses:

Unable to handle kernel NULL pointer dereference at virtual address 00000074
 printing eip:
d089800c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<d089800c>]    Not tainted
EFLAGS: 00010206
EIP is at 0xd089800c
eax: c0221714   ebx: cff4d000   ecx: ce606080   edx: c0221750
esi: 00000000   edi: cff4d04c   ebp: 00000000   esp: ce367ef0
ds: 0068   es: 0068   ss: 0068
Process insmod (pid: 577, threadinfo=ce366000 task=ce606080)
Stack: d08a60ba cff4d000 00000000 cff4d04c cff4d000 00000000 d08a62ac cff4d000 
       cff4d000 d089ad10 cff4d000 d08addc8 c016af49 cff4d000 d089ae50 cff4d04c 
       d08addc8 ffffffed d08addc8 d08adda0 c0171677 cff4d04c cff4d04c cff4d054 
Call Trace:
 [<d08a60ba>] agp_backend_initialize+0x16/0x168 [agpgart]
 [<d08a62ac>] agp_register_driver+0x28/0xa0 [agpgart]
 [<d089ad10>] 0xd089ad10
 [<d08addc8>] agp_intel_pci_driver+0x28/0x9c [intel_agp]
 [<c016af49>] pci_device_probe+0x41/0x5c
 [<d089ae50>] 0xd089ae50
 [<d08addc8>] agp_intel_pci_driver+0x28/0x9c [intel_agp]
 [<d08addc8>] agp_intel_pci_driver+0x28/0x9c [intel_agp]
 [<d08adda0>] agp_intel_pci_driver+0x0/0x9c [intel_agp]
 [<c0171677>] bus_match+0x37/0x68
 [<c0171743>] driver_attach+0x37/0x60
 [<d08addc8>] agp_intel_pci_driver+0x28/0x9c [intel_agp]
 [<d08adb62>] __module_pci_device_size+0x12/0x30 [intel_agp]
 [<d08addc8>] agp_intel_pci_driver+0x28/0x9c [intel_agp]
 [<c01719de>] bus_add_driver+0x92/0xb4
 [<d08addc8>] agp_intel_pci_driver+0x28/0x9c [intel_agp]
 [<d08adde8>] agp_intel_pci_driver+0x48/0x9c [intel_agp]
 [<c0171d9c>] driver_register+0x34/0x38
 [<d08addc8>] agp_intel_pci_driver+0x28/0x9c [intel_agp]
 [<c016b042>] pci_register_driver+0x42/0x54
 [<d08addc8>] agp_intel_pci_driver+0x28/0x9c [intel_agp]
 [<d089ad3e>] 0xd089ad3e
 [<d08adda0>] agp_intel_pci_driver+0x0/0x9c [intel_agp]
 [<c01247e9>] sys_init_module+0xe9/0x170
 [<c0108897>] syscall_call+0x7/0xb

Code: 69 6e 74 65 6c 5f 61 67 70 00 00 00 00 00 00 00 00 00 00 00 
 
The stack trace shows that we should be in agp_find_max() as
called from agp_backend_initialize(). However, agp_find_max()
is __init and its code has already been removed at this point
(since agpgart and intel-agp are separate modules), causing
the kernel to execute random code and eventually oops.

The patch below works around this by changing agpgart's __init
code & data to normal code & data. Tested, works for me.

/Mikael

--- linux-2.5.53/drivers/char/agp/backend.c.~1~	2002-12-24 13:53:50.000000000 +0100
+++ linux-2.5.53/drivers/char/agp/backend.c	2002-12-28 01:08:30.000000000 +0100
@@ -73,7 +73,7 @@
 	int agp;
 };
 
-static struct agp_max_table maxes_table[9] __initdata =
+static struct agp_max_table maxes_table[9] =
 {
 	{0, 0},
 	{32, 4},
@@ -86,7 +86,7 @@
 	{4096, 3932}
 };
 
-static int __init agp_find_max (void)
+static int agp_find_max (void)
 {
 	long memory, index, result;
 
