Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263419AbUEGJsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUEGJsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 05:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUEGJsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 05:48:41 -0400
Received: from S01060050bfec5d4e.cg.shawcable.net ([68.144.57.107]:18304 "EHLO
	eviltron.local.lan") by vger.kernel.org with ESMTP id S263419AbUEGJsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 05:48:36 -0400
Date: Fri, 7 May 2004 03:48:24 -0600
From: Steve Young <sdyoung@vt220.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] change pts allocation behaviour in tty_io.c, v2
Message-ID: <20040507094824.GA25043@eviltron.local.lan>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040507084242.GA11389@eviltron.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507084242.GA11389@eviltron.local.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 02:42:42AM -0600, Steve Young wrote:
>   Here is a patch to change the way ptses are allocated.  It applies against
> 2.6.6-rc3.  Basically it tries to humour old glibc by always obtaining a pts

  I realized this won't properly cope when driver->num < MAX_PREFERRED_PTY.
Use this patch instead.  I've tested it on my box.

  Thanks,
  Steve.

diff -ur linux-2.6.5-virgin/drivers/char/tty_io.c linux-2.6.5-eviltron/drivers/char/tty_io.c
--- linux-2.6.5-virgin/drivers/char/tty_io.c	2004-05-07 03:39:25.085624064 -0600
+++ linux-2.6.5-eviltron/drivers/char/tty_io.c	2004-05-07 03:37:51.697821168 -0600
@@ -1362,14 +1362,25 @@
 #ifdef CONFIG_UNIX98_PTYS
 	if (device == MKDEV(TTYAUX_MAJOR,2)) {
 		/* find a device that is not in use. */
-		static int next_ptmx_dev = 0;
+		static int next_ptmx_dev = MAX_PREFERRED_PTY;
 		retval = -1;
 		driver = ptm_driver;
-		while (driver->refcount < pty_limit) {
-			index = next_ptmx_dev;
-			next_ptmx_dev = (next_ptmx_dev+1) % driver->num;
-			if (!init_dev(driver, index, &tty))
-				goto ptmx_found; /* ok! */
+		/* first, try and allocate a pty < 256 for old glibc */
+		for (index = 0; index < MAX_PREFERRED_PTY && driver->refcount < pty_limit && index < driver->num; index++) {
+			if (!init_dev(driver, index, &tty)) 
+				goto ptmx_found;
+		}
+		/* nothing below MAX_PREFERRED_PTY, try something higher, unless
+		 * we've already run out of options */
+		if (index != driver->num) {
+			while (driver->refcount < pty_limit) {
+				index = next_ptmx_dev;
+				next_ptmx_dev = (next_ptmx_dev+1) % driver->num;
+				if (!next_ptmx_dev) 
+					next_ptmx_dev = MAX_PREFERRED_PTY;
+				if (!init_dev(driver, index, &tty)) 
+					goto ptmx_found; /* ok! */
+			}
 		}
 		return -EIO; /* no free ptys */
 	ptmx_found:

diff -ur linux-2.6.5-virgin/include/linux/tty.h linux-2.6.5-eviltron/include/linux/tty.h
--- linux-2.6.5-virgin/include/linux/tty.h	2004-05-07 03:39:26.953340128 -0600
+++ linux-2.6.5-eviltron/include/linux/tty.h	2004-05-07 01:43:55.000000000 -0600
@@ -35,6 +35,7 @@
 #define NR_UNIX98_PTY_DEFAULT	4096      /* Default maximum for Unix98 ptys */
 #define NR_UNIX98_PTY_MAX	(1 << MINORBITS) /* Absolute limit */
 #define NR_LDISCS		16
+#define MAX_PREFERRED_PTY	256			/* we prefer to allocate ptys beneath this number */
 
 /*
  * These are set up by the setup-routine at boot-time:
