Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTF0Fim (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 01:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTF0Fim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 01:38:42 -0400
Received: from dp.samba.org ([66.70.73.150]:46258 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263786AbTF0Fil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 01:38:41 -0400
Date: Fri, 27 Jun 2003 15:54:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL] Fix compile with !CONFIG_VT
Message-ID: <20030627055408.GL1521@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

Architectures using the generic 32/64-bit ioctl() compatibility shims
will get a link error if CONFIG_VT is not defined, since the
compatbility ioctl() code calls functions in drivers/char/vt.c which
is only included in the build if CONFIG_VT is set.

This fixes the compile with a couple of #ifdefs:

diff -urN /scratch/anton/export/fs/compat_ioctl.c linux-gogogo/fs/compat_ioctl.c
--- /scratch/anton/export/fs/compat_ioctl.c	2003-06-20 00:42:50.000000000 +1000
+++ linux-gogogo/fs/compat_ioctl.c	2003-06-27 15:36:38.000000000 +1000
@@ -1562,6 +1562,8 @@
 
 extern int tty_ioctl(struct inode * inode, struct file * file, unsigned int cmd, unsigned long arg);
 
+#ifdef CONFIG_VT
+
 static int vt_check(struct file *file)
 {
 	struct tty_struct *tty;
@@ -1693,6 +1695,8 @@
 	return 0;
 }
 
+#endif /* CONFIG_VT */
+
 static int do_smb_getmountuid(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	mm_segment_t old_fs = get_fs();
@@ -2398,11 +2402,13 @@
 HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
+#ifdef CONFIG_VT
 HANDLE_IOCTL(PIO_FONTX, do_fontx_ioctl)
 HANDLE_IOCTL(GIO_FONTX, do_fontx_ioctl)
 HANDLE_IOCTL(PIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(GIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(KDFONTOP, do_kdfontop_ioctl)
+#endif
 HANDLE_IOCTL(EXT2_IOC32_GETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
