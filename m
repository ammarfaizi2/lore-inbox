Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbUEGIoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUEGIoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUEGIng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:43:36 -0400
Received: from S01060050bfec5d4e.cg.shawcable.net ([68.144.57.107]:10368 "EHLO
	eviltron.local.lan") by vger.kernel.org with ESMTP id S263325AbUEGImy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:42:54 -0400
Date: Fri, 7 May 2004 02:42:42 -0600
From: Steve Young <sdyoung@vt220.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] change pts allocation behaviour in
Message-ID: <20040507084242.GA11389@eviltron.local.lan>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  Here is a patch to change the way ptses are allocated.  It applies against
2.6.6-rc3.  Basically it tries to humour old glibc by always obtaining a pts
in the range of 0-255 first.  However, if that fails, then it will search the
higher ranges.  The net effect should be that old glibc users won't notice
problems until they try and get more than 256 concurrent ptses (which would
break under the first-fit scheme anyway), yet we reduce the average number of 
iterations required to find a new pts when a lot are in use.  In the very
worst case of only one pts available, this still performs no worse than
the either the old or more recent allocation schemes.

  Thanks,
  Steve.

diff -ur linux-2.6.5-virgin/drivers/char/tty_io.c linux-2.6.5-deflowered/drivers/char/tty_io.c
--- linux-2.6.5-virgin/drivers/char/tty_io.c	2004-05-07 02:07:45.486690184 -0600
+++ linux-2.6.5-deflowered/drivers/char/tty_io.c	2004-05-07 01:57:19.447753528 -0600
@@ -1362,14 +1362,24 @@
 #ifdef CONFIG_UNIX98_PTYS
 	if (device == MKDEV(TTYAUX_MAJOR,2)) {
 		/* find a device that is not in use. */
-		static int next_ptmx_dev = 0;
+		static int next_ptmx_dev = MAX_PREFERRED_PTY;
 		retval = -1;
 		driver = ptm_driver;
+		/* first, try for a pty < 256 for old glibc that doesn't support
+		 * larger pts numbers */
+		for (index = 0; index < MAX_PREFERRED_PTY && driver->refcount < pty_limit; index++) {
+			if (!init_dev(driver, index, &tty)) 
+				goto ptmx_found;
+		}
+		/* nothing below MAX_PREFERRED_PTY, try something higher */
 		while (driver->refcount < pty_limit) {
 			index = next_ptmx_dev;
 			next_ptmx_dev = (next_ptmx_dev+1) % driver->num;
-			if (!init_dev(driver, index, &tty))
+			if (!next_ptmx_dev) 
+				next_ptmx_dev = MAX_PREFERRED_PTY;
+			if (!init_dev(driver, index, &tty)) {
 				goto ptmx_found; /* ok! */
+			}
 		}
 		return -EIO; /* no free ptys */
 	ptmx_found:
diff -ur linux-2.6.5-virgin/include/linux/tty.h linux-2.6.5-deflowered/include/linux/tty.h
--- linux-2.6.5-virgin/include/linux/tty.h	2004-05-07 02:07:47.386401384 -0600
+++ linux-2.6.5-deflowered/include/linux/tty.h	2004-05-07 01:43:55.000000000 -0600
@@ -35,6 +35,7 @@
 #define NR_UNIX98_PTY_DEFAULT	4096      /* Default maximum for Unix98 ptys */
 #define NR_UNIX98_PTY_MAX	(1 << MINORBITS) /* Absolute limit */
 #define NR_LDISCS		16
+#define MAX_PREFERRED_PTY	256			/* we prefer to allocate ptys beneath this number */
 
 /*
  * These are set up by the setup-routine at boot-time:
