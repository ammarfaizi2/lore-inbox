Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271152AbTG1WOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 18:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271153AbTG1WOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 18:14:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:38830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271152AbTG1WN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 18:13:59 -0400
Date: Mon, 28 Jul 2003 15:11:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: jcwren@jcwren.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Assorted 2.6.0-test2 build warnings
Message-Id: <20030728151104.300ae225.rddunlap@osdl.org>
In-Reply-To: <200307272057.31859.jcwren@jcwren.com>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
	<20030727165831.05904792.davem@redhat.com>
	<200307280211590888.10957DD9@192.168.128.16>
	<200307272057.31859.jcwren@jcwren.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 20:57:31 -0400 "J.C. Wren" <jcwren@jcwren.com> wrote:

| Assorted warnings building 2.6.0-test2, on an Athlon:
| 
|   CC      fs/ntfs/super.o
| fs/ntfs/super.c: In function `is_boot_sector_ntfs':
| fs/ntfs/super.c:375: warning: integer constant is too large for "long" type

Please see if the patch below fixes this one.

|   CC      fs/smbfs/ioctl.o
| fs/smbfs/ioctl.c: In function `smb_ioctl':
| fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
| fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
| fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
| fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type

Hm, appears to be on NEW_TO_OLD_UID(server->mnt->mounted_uid)
to me.  mounted_uid is of type __kernel_uid_t, which is unsigned short
on i386, so NEW_TO_OLD_UID() is rather useless on it.
Should mounted_uid be __kernel_uid32_t instead?

|   CC      drivers/char/vt_ioctl.o
| drivers/char/vt_ioctl.c: In function `do_kdsk_ioctl':
| drivers/char/vt_ioctl.c:85: warning: comparison is always false due to limited range of data type
| drivers/char/vt_ioctl.c:85: warning: comparison is always false due to limited range of data type

Yes, line 85 is useless as it is.

What -W (?) options are you compiling with?  I'm not seeing these.

| drivers/char/vt_ioctl.c: In function `do_kdgkb_ioctl':
| drivers/char/vt_ioctl.c:211: warning: comparison is always false due to limited range of data type

Another unsigned char compared to value > 255.

|   CC      drivers/char/keyboard.o
| drivers/char/keyboard.c: In function `k_fn':
| drivers/char/keyboard.c:665: warning: comparison is always true due to limited range of data type

Right, same as above.


|   CC      drivers/video/matrox/matroxfb_g450.o
| drivers/video/matrox/matroxfb_g450.c: In function `g450_compute_bwlevel':
| drivers/video/matrox/matroxfb_g450.c:129: warning: duplicate `const'
| drivers/video/matrox/matroxfb_g450.c:130: warning: duplicate `const'

|   AS      arch/i386/boot/setup.o
| arch/i386/boot/setup.S: Assembler messages:
| arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff

Interesting.  How do I make this happen on my system?

Are you using some old (or new) version of gcc/gas or what?

--
~Randy


patch_name:	ntfs_ulong.patch
patch_version:	2003-07-28.14:29:57
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	make a constant be UL;
product:	Linux
product_versions: 2.6.0-test2
maintainer:	Anton Altaparmakov <aia21@cantab.net>
diffstat:	=
 fs/ntfs/layout.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naurp ./fs/ntfs/layout.h~type ./fs/ntfs/layout.h
--- ./fs/ntfs/layout.h~type	2003-07-27 10:02:48.000000000 -0700
+++ ./fs/ntfs/layout.h	2003-07-28 14:05:20.000000000 -0700
@@ -43,7 +43,7 @@
 #define const_cpu_to_le64(x)	__constant_cpu_to_le64(x)
 
 /* The NTFS oem_id */
-#define magicNTFS	const_cpu_to_le64(0x202020205346544e) /* "NTFS    " */
+#define magicNTFS	const_cpu_to_le64(0x202020205346544eUL) /* "NTFS    " */
 
 /*
  * Location of bootsector on partition:
