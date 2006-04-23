Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWDWKw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWDWKw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 06:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDWKw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 06:52:27 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:29960 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751016AbWDWKw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 06:52:27 -0400
Message-ID: <444B5FC1.9090502@gentoo.org>
Date: Sun, 23 Apr 2006 12:06:41 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, linux-parport@lists.infradead.org
Subject: 2.6.16 doesn't boot with CONFIG_TIPAR=y 
Content-Type: multipart/mixed;
 boundary="------------040809000600060205000904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040809000600060205000904
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Your commit titled "[PATCH] tipar fixes" breaks the boot of 2.6.16 and 
newer when CONFIG_TIPAR=y, and the appropriate parallel port driver is 
compiled-in, and the system has at least one parallel port.

The problem is as follows:

drivers/Makefile loads char/tipar.c early during boot (before any 
parport stuff).

tipar_init_module does some stuff and then reaches:
	if (parport_register_driver(&tipar_driver) || tp_count == 0) {
		destroy sysfs class
		return failure
	}

At this point, parport_register_driver() succeeds, but the tipar_attach 
function is *not* called as the parport system hasn't been initialised 
yet. This means that tp_count == 0, so we clean up a bit and return 
failure. Note that we do not unregister from the parport driver, so as 
far as parport is concerned, all is fine.

Later on, drivers/Makefile loads parport/*. parport then calls the 
tipar_attach function which we registered earlier, which then does some 
sysfs stuff. This is a problem because we destroyed the sysfs class 
earlier on.

This is the end result:

tipar: parallel link cable driver, version 1.19
tipar: unable to register with parport
initcall at 0xc03cf1c6: tipar_init_module+0x0/0xa1(): returned with 
error code -5
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16450
parport0: PC-style at 0x378 [PCSPP,EPP]
BUG: unable to handle kernel paging request at virtual address 00a0008f
  printing eip:
c0167263
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c0167263>]    Not tainted VLI
EFLAGS: 00000286   (2.6.17-rc2 #3)
EIP is at create_dir+0x15/0x165
eax: c12cedc8   ebx: c12cedcc   ecx: c12cedcc   edx: 00a00087
esi: 00000000   edi: c12cedcc   ebp: c113deac   esp: c113de8c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c113c000 task=c1139a10)
Stack: <0>00a00087 c12cedc8 c12cedc8 00000000 c12cedc8 c12768a0 c016740f 
c113deac
        00000000 c12cedc8 c019e611 c12cedc8 c12768b8 c019e7e5 c12cee38 
c12cedc0
        c12cedc8 c021986b ffffffea 00000000 00000000 c12cedc0 fffffff4 
c12768a0
Call Trace:
  <c016740f> sysfs_create_dir+0x4b/0x5d   <c019e611> create_dir+0x10/0x2f
  <c019e7e5> kobject_add+0x90/0xd8   <c021986b> class_device_add+0x9b/0x1dc
  <c0219a32> class_device_create+0x76/0x8c   <c01f562e> 
tipar_register+0x52/0x9e
  <c01f569a> tipar_attach+0x20/0x33   <c02123b5> 
attach_driver_chain+0x21/0x2e
  <c0212751> parport_announce_port+0x72/0x94   <c0216aca> 
parport_pc_probe_port+0x428/0x496
  <c0217475> parport_pc_find_isa_ports+0x3c/0x67   <c03d0004> 
parport_pc_find_ports+0x14/0x37
  <c03d03de> parport_pc_init+0x7f/0x86   <c03be67f> do_initcalls+0x53/0xda
  <c0163422> proc_mkdir_mode+0x37/0x49   <c010027c> init+0x0/0x118
  <c01002ae> init+0x32/0x118   <c0100cbd> kernel_thread_helper+0x5/0xb
Code: 00 00 00 e5 2d c0 31 c0 c3 c7 80 88 00 00 00 40 f7 34 c0 31 c0 c3 
55 57 56 53 53 53 89 cb 8b 6c 24 1c 89 df 89 14 24 89 44 24 04 <8b> 42 
08 83 c0 70 e8 83 16 17 00 31 c0 83 c9 ff f2 ae f7 d1 49
EIP: [<c0167263>] create_dir+0x15/0x165 SS:ESP 0068:c113de8c
  <0>Kernel panic - not syncing: Attempted to kill init!

I've attached a patch to solve this, but I'm not sure if it is correct: 
it reverts part of your patch. From the description it sounds like this 
path may be covered by your changes in tipar_open() so maybe it is OK...

--------------040809000600060205000904
Content-Type: text/x-patch;
 name="tipar-boot-oops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tipar-boot-oops.patch"

[PATCH] Fix tipar/parport boot crash

If compiled into the kernel, parport_register_driver() is called before the
parport driver has been initalised.

This means that it is expected that tp_count is 0 after the
parport_register_driver() call() - tipar's attach function will not be called
until later during bootup.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--- linux-2.6.17-rc2/drivers/char/tipar.c.orig	2006-04-23 12:03:08.000000000 +0100
+++ linux-2.6.17-rc2/drivers/char/tipar.c	2006-04-23 11:42:30.000000000 +0100
@@ -515,7 +515,7 @@ tipar_init_module(void)
 		err = PTR_ERR(tipar_class);
 		goto out_chrdev;
 	}
-	if (parport_register_driver(&tipar_driver) || tp_count == 0) {
+	if (parport_register_driver(&tipar_driver)) {
 		printk(KERN_ERR "tipar: unable to register with parport\n");
 		err = -EIO;
 		goto out_class;

--------------040809000600060205000904--
