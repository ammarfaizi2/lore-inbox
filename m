Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285114AbRLQMua>; Mon, 17 Dec 2001 07:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285120AbRLQMuV>; Mon, 17 Dec 2001 07:50:21 -0500
Received: from sanpo-gw.t.u-tokyo.ac.jp ([133.11.74.27]:43763 "EHLO
	mail.sanpo.t.u-tokyo.ac.jp") by vger.kernel.org with ESMTP
	id <S285114AbRLQMuM>; Mon, 17 Dec 2001 07:50:12 -0500
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.16 Fix NULL pointer dereferencing in agpgart_be.c
From: Yoshiki Hayashi <yoshiki@xemacs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: 17 Dec 2001 21:50:03 +0900
Message-ID: <87zo4iroxw.fsf@u.sanpo.t.u-tokyo.ac.jp>
User-Agent: T-gnus/6.15.3 (based on Oort Gnus v0.03) (revision 06)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.4.16.  I couldn't find maintainer in
MAINTAINERS file so I'm simply sending this to Linus and
linux-kernel list.

In apggart_be.c, if the chip is i830M and the secondary device is not
found, linux kernel tries to dereference NULL pointer.  It checks NULL
and returns from the function in the next statement but it's too late.

The attached patch add NULL check before dereferencing the
pointer to fix the problem.

The error log is:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 564M
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
e8808238
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e8808238>]    Not tainted
EFLAGS: 00010296
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: c025cb28
esi: c1a08400   edi: e8809ba8   ebp: 00000000   esp: e695def0
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 564, stackpage=e695d000)
Stack: e8804000 00000000 00000000 00809ba8 00000000 e88084b2 e8804000 00000000 
       e8804068 00005be0 00000000 e88086ac e8809420 00000000 00000063 e8804000 
       c011525d e695c000 40020a30 bfffcf9c bfffcf5c 000055df e5eb8000 00000060 
Call Trace: [<e88084b2>] [<e8804068>] [<e88086ac>] [<e8809420>] [sys_init_module+1285/1448] 
   [<e8804060>] [system_call+51/56] 

Code: f6 43 20 07 74 15 53 68 77 35 00 00 68 86 80 00 00 e8 f2 97 

--- drivers/char/agp/agpgart_be.c~	Sat Nov 17 03:11:22 2001
+++ drivers/char/agp/agpgart_be.c	Sat Dec 15 12:02:51 2001
@@ -3879,7 +3879,7 @@
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
 									   PCI_DEVICE_ID_INTEL_830_M_1,
 									   NULL);
-			if(PCI_FUNC(i810_dev->devfn) != 0) {
+			if(i810_dev != NULL && PCI_FUNC(i810_dev->devfn) != 0) {
 				i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
 										   PCI_DEVICE_ID_INTEL_830_M_1,
 										   i810_dev);

-- 
Yoshiki Hayashi
