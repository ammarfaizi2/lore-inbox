Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292505AbSBPUmW>; Sat, 16 Feb 2002 15:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292506AbSBPUmM>; Sat, 16 Feb 2002 15:42:12 -0500
Received: from 205-158-62-44.outblaze.com ([205.158.62.44]:16347 "EHLO
	mta1-3.us4.outblaze.com") by vger.kernel.org with ESMTP
	id <S292505AbSBPUmC>; Sat, 16 Feb 2002 15:42:02 -0500
Message-ID: <20020216204156.8560.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Rudmer van Dijk" <rudmer@linuxmail.org>
To: <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 17 Feb 2002 04:41:56 +0800
Subject: Re: [PATCH] 2.5.5-pre1, allow RAM disk to be build
X-Originating-Ip: 212.129.187.93
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@suse.de>

> On Sun, Feb 17, 2002 at 02:07:35AM +0800, Rudmer van Dijk wrote:
>  > since 2.5.x (can't remember version correctly) the setup for RAM disk changed and I could not build it anymore into the kernel due to compilation errors.
>  > In the latest prepatch (2.5.5-pre1) this is still not fixed. I am using the following patch to fix this and it works from 2.5.x upto 2.5.5-pre1 without any problems.
> 
> The real fix I think is to fix include/linux/blk.h
> setup.c uses it inside CONFIG_BLK_DEV_RAM, but blk.h
> only defines it with CONFIG_BLK_DEV_INITRD
>
It was a quick fix because I thought someone else was going to fix it...

How about the following patch?
kernel builds and boots with patch (with CONFIG_BLK_DEV_INITRD disabled).

I think this is unrelated but I suddenly got the following messages while trying to build another kernel:
Feb 18 00:02:51 frodo kernel: hdc: lost interrupt
Feb 18 00:03:31 frodo last message repeated 4 times
Feb 18 00:04:31 frodo last message repeated 6 times
Feb 18 00:05:31 frodo last message repeated 6 times
Feb 18 00:06:31 frodo last message repeated 6 times

now my some files (including gcc) are screwed and I cannot test this patch with CONFIG_BLK_DEV_INITRD enabled...

Rudmer

--
frodo:/home/rudmer/linux-2.5.5-pre1 # diff -uN include/linux/blk.h.orig include/linux/blk.h
--- include/linux/blk.h.orig    Sun Feb 17 20:27:28 2002
+++ include/linux/blk.h Sun Feb 17 19:49:27 2002
@@ -16,18 +16,24 @@
 extern void set_device_ro(kdev_t dev,int flag);
 extern void add_blkdev_randomness(int major);

+#ifdef CONFIG_BLK_DEV_RAM
+
+extern int rd_doload;          /* 1 = load ramdisk, 0 = don't load */
+extern int rd_prompt;          /* 1 = prompt for ramdisk, 0 = don't prompt */
+extern int rd_image_start;     /* starting block # of image */
+
 #ifdef CONFIG_BLK_DEV_INITRD

 #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */

 extern unsigned long initrd_start,initrd_end;
 extern int initrd_below_start_ok; /* 1 if it is not an error if initrd_start < memory_start */
-extern int rd_doload;          /* 1 = load ramdisk, 0 = don't load */
-extern int rd_prompt;          /* 1 = prompt for ramdisk, 0 = don't prompt */
-extern int rd_image_start;     /* starting block # of image */
 void initrd_init(void);

+#endif /* CONFIG_BLK_DEV_INITRD */
+
 #endif
+
 /*
  * end_request() and friends. Must be called with the request queue spinlock
  * acquired. All functions called within end_request() _must_be_ atomic.
-- 

Get your free email from www.linuxmail.org 


Powered by Outblaze
