Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbRBWTyL>; Fri, 23 Feb 2001 14:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129394AbRBWTyB>; Fri, 23 Feb 2001 14:54:01 -0500
Received: from gemini.yars.free.net ([193.233.48.66]:13268 "EHLO
	gemini.yars.free.net") by vger.kernel.org with ESMTP
	id <S129134AbRBWTxm>; Fri, 23 Feb 2001 14:53:42 -0500
From: "Alexander V. Lukyanov" <lav@long.yar.ru>
Date: Fri, 23 Feb 2001 22:51:59 +0300
To: Michael Bacarella <mbac@nyct.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to fix 3dfx.o + question about char drivers..
Message-ID: <20010223225159.A2555@long.yar.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bacarella wrote:
> So, I upgrade to 2.4.0 and it's cool, except that I can't do
> anything neat with my voodoo3 anymore. I've been looking
> for a solution for weeks but to no avail. 3dfx's web site
> looks like it's gone and nothing on lk about it.
> 
> The process calls ioctl() after opening /dev/3dfx. That ioctl() triggers
> an mmap() call, the driver gets addresses it's totally not expecting,
> and it returns -EPERM.

struct file_operations has changed in 2.4.0. The following patch for 3dfx
module fixes the structure initialization and makes it work just fine.

--- 3dfx_driver.c	Sun Apr  9 03:44:10 2000
+++ 3dfx_driver.c	Fri Feb 23 22:42:06 2001
@@ -707,25 +707,10 @@
 #endif /* HAVE_MTRR */
 
 static struct file_operations fops_3dfx = {
-	NULL,			/* llseek (2.1) / lseek (2.0) */
-	NULL,			/* read */
-	NULL,			/* write */
-	NULL,			/* readdir */
-	NULL,			/* poll (2.1) / select (2.0) */
-	ioctl_3dfx,		/* ioctl */
-	mmap_3dfx,		/* mmap */
-	open_3dfx,		/* open */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 1, 118)
-	NULL,			/* flush (2.1.118+) */
-#endif
-	release_3dfx,		/* release */
-	NULL,			/* fsync */
-	NULL,			/* fasync */
-	NULL,			/* check_media_change */
-	NULL,			/* revalidate */
-#ifdef KERNEL_VER_2_1
-	NULL			/* lock (2.1) */
-#endif
+	ioctl:		ioctl_3dfx,
+	mmap:		mmap_3dfx,
+	open:		open_3dfx,
+	release:	release_3dfx
 };
 
 #ifdef MODULE
