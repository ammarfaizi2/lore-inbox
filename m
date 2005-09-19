Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVISPMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVISPMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 11:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVISPMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 11:12:52 -0400
Received: from verein.lst.de ([213.95.11.210]:15023 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932457AbVISPMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 11:12:51 -0400
Date: Mon, 19 Sep 2005 17:12:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TIOC* compat ioctl handling
Message-ID: <20050919151244.GB13544@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSTART and TIOCSTOP are defined in asm/ioctls.h and asm/termios.h
by various architectures but not actually implemented anywhere but in
the IRIX compatibility layer, so remove their COMPATIBLE_IOCTL from
parisc, ppc64 and sparc64.

Move the TIOCSLTC COMPATIBLE_IOCTL to common code, guided by an ifdef
to only show up on architectures that support it (same as the code
handling it in tty_ioctl.c), aswell as it's brother TIOCGLTC that
wasn't handled so far.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/parisc/kernel/ioctl32.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/ioctl32.c	2005-09-19 15:18:12.000000000 +0200
+++ linux-2.6/arch/parisc/kernel/ioctl32.c	2005-09-19 15:19:35.000000000 +0200
@@ -37,11 +37,6 @@
 #define DECLARES
 #include "compat_ioctl.c"
 
-/* Might be moved to compat_ioctl.h with some ifdefs... */
-COMPATIBLE_IOCTL(TIOCSTART)
-COMPATIBLE_IOCTL(TIOCSTOP)
-COMPATIBLE_IOCTL(TIOCSLTC)
-
 /* PA-specific ioctls */
 COMPATIBLE_IOCTL(PA_PERF_ON)
 COMPATIBLE_IOCTL(PA_PERF_OFF)
Index: linux-2.6/arch/ppc64/kernel/ioctl32.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/ioctl32.c	2005-09-18 13:46:55.000000000 +0200
+++ linux-2.6/arch/ppc64/kernel/ioctl32.c	2005-09-19 15:19:35.000000000 +0200
@@ -39,9 +39,7 @@
 #include <linux/compat_ioctl.h>
 #define DECLARES
 #include "compat_ioctl.c"
-COMPATIBLE_IOCTL(TIOCSTART)
-COMPATIBLE_IOCTL(TIOCSTOP)
-COMPATIBLE_IOCTL(TIOCSLTC)
+
 /* Little p (/dev/rtc, /dev/envctrl, etc.) */
 COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-09-19 15:18:12.000000000 +0200
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-09-19 15:19:35.000000000 +0200
@@ -124,9 +124,6 @@
 #include <linux/compat_ioctl.h>
 #define DECLARES
 #include "compat_ioctl.c"
-COMPATIBLE_IOCTL(TIOCSTART)
-COMPATIBLE_IOCTL(TIOCSTOP)
-COMPATIBLE_IOCTL(TIOCSLTC)
 COMPATIBLE_IOCTL(FBIOGTYPE)
 COMPATIBLE_IOCTL(FBIOSATTR)
 COMPATIBLE_IOCTL(FBIOGATTR)
Index: linux-2.6/fs/compat_ioctl.c
===================================================================
--- linux-2.6.orig/fs/compat_ioctl.c	2005-09-18 13:47:31.000000000 +0200
+++ linux-2.6/fs/compat_ioctl.c	2005-09-19 15:19:35.000000000 +0200
@@ -3046,6 +3046,10 @@
 /* Serial */
 HANDLE_IOCTL(TIOCGSERIAL, serial_struct_ioctl)
 HANDLE_IOCTL(TIOCSSERIAL, serial_struct_ioctl)
+#ifdef TIOCGLTC
+COMPATIBLE_IOCTL(TIOCGLTC)
+COMPATIBLE_IOCTL(TIOCSLTC)
+#endif
 /* Usbdevfs */
 HANDLE_IOCTL(USBDEVFS_CONTROL32, do_usbdevfs_control)
 HANDLE_IOCTL(USBDEVFS_BULK32, do_usbdevfs_bulk)
