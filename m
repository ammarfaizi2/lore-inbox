Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSLNSYF>; Sat, 14 Dec 2002 13:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSLNSYF>; Sat, 14 Dec 2002 13:24:05 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:36226 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S265806AbSLNSYD>;
	Sat, 14 Dec 2002 13:24:03 -0500
Date: Sat, 14 Dec 2002 12:31:55 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: linux-kernel@vger.kernel.org
Cc: rth@twiddle.net
Subject: 2.5.51 on Alpha oopses on mount
Message-Id: <20021214123155.7383524c.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get a workable 2.5.51 (*eventually* with modules and everything)
on my Alpha test box. Right now whenever I try to boot and mount anything
(2.11-n from Debian testing) I get an oops and mount segfaults. FYI, I have
the following two changes to my tree to get it to compile (thanks to rth for
advice on the first):

diff -Nru a/include/asm-alpha/pci.h b/include/asm-alpha/pci.h
+++ a/include/asm-alpha/pci.h
--- b/include/asm-alpha/pci.h
@@ -6,7 +6,6 @@
 #include <linux/spinlock.h>
 #include <asm/scatterlist.h>
 #include <asm/machvec.h>
-#include <asm/io.h>
 
 
 /*
diff -Nru a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
+++ a/drivers/scsi/sr_ioctl.c
--- b/drivers/scsi/sr_ioctl.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <asm/uaccess.h>
+#include <asm/io.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/blk.h>


Here's the decoded oops.

ksymoops 2.4.6 on alpha 2.4.19-pre7-rmap13.  Options used
     -v /home/arashi/kernels/arashi-2.5/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.5.51 (specified)

Unable to handle kernel paging request at virtual address 000000012002e000
mount(20): Oops 0
pc = [<fffffc00004a5240>]  ra = [<fffffc00003850c0>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000001300  t0 = 0000000000000000  t1 = 000000012002f300
t2 = 0000000000000000  t3 = 0000000000001300  t4 = fffffc0000664f30
t5 = fffffc000f914d00  t6 = 000000012002e000  t7 = fffffc000f8b0000
s0 = 000000012002d300  s1 = fffffc000f914000  s2 = fffffc000f8b3ef8
s3 = 000000012002d360  s4 = 00000000c0ed0000  s5 = 0000000120029b60
s6 = 000000012002d2a0
a0 = fffffc0000a6cb20  a1 = 0000000000000000  a2 = 0000000000002000
a3 = 00000000c0ed0000  a4 = 000000012002d360  a5 = 000000011ffffbd8
t8 = 0000000000002000  t9 = 0000020000144d40  t10= 0000000000000008
t11= 00000200001bda00  pv = fffffc00004a5140  at = fffffc0000385128
gp = fffffc000076c548  sp = fffffc000f8b3ea8
Trace:fffffc0000385920 fffffc0000313064 fffffc0000313064 
Code: f41ffff5  c3e00013  e480000a  2ffe0000  47ff041f  2ffe0000 <a4270000> 40811524 


>>RA;  fffffc00003850c0 <copy_mount_options+40/140>

>>PC;  fffffc00004a5240 <__copy_user+100/1d4>   <=====

Trace; fffffc0000385920 <sys_mount+40/160>
Trace; fffffc0000313064 <entSys+a4/c0>
Trace; fffffc0000313064 <entSys+a4/c0>

Code;  fffffc00004a5228 <__copy_user+e8/1d4>
0000000000000000 <_PC>:
Code;  fffffc00004a5228 <__copy_user+e8/1d4>
   0:   f5 ff 1f f4       bne  v0,ffffffffffffffd8 <_PC+0xffffffffffffffd8> fffffc00004a5200 <__copy_user+c0/1d4>
Code;  fffffc00004a522c <__copy_user+ec/1d4>
   4:   13 00 e0 c3       br   54 <_PC+0x54> fffffc00004a527c <__copy_user+13c/1d4>
Code;  fffffc00004a5230 <__copy_user+f0/1d4>
   8:   0a 00 80 e4       beq  t3,34 <_PC+0x34> fffffc00004a525c <__copy_user+11c/1d4>
Code;  fffffc00004a5234 <__copy_user+f4/1d4>
   c:   00 00 fe 2f       unop 
Code;  fffffc00004a5238 <__copy_user+f8/1d4>
  10:   1f 04 ff 47       nop  
Code;  fffffc00004a523c <__copy_user+fc/1d4>
  14:   00 00 fe 2f       unop 
Code;  fffffc00004a5240 <__copy_user+100/1d4>   <=====
  18:   00 00 27 a4       ldq  t0,0(t6)   <=====
Code;  fffffc00004a5244 <__copy_user+104/1d4>
  1c:   24 15 81 40       subq t3,0x8,t3

Matt
