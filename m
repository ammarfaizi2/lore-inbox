Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTDFW3y (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTDFW3y (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:29:54 -0400
Received: from f63.law11.hotmail.com ([64.4.17.63]:61969 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S263146AbTDFW3t (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 18:29:49 -0400
X-Originating-IP: [144.92.164.196]
X-Originating-Email: [rhino_tom@hotmail.com]
From: "Tom Reinhart" <rhino_tom@hotmail.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21pre7 make raw devices appear in devfs
Date: Sun, 06 Apr 2003 15:41:18 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F63cltA05BqSyu3beYg0001c1c0@hotmail.com>
X-OriginalArrivalTime: 06 Apr 2003 22:41:18.0299 (UTC) FILETIME=[A378DAB0:01C2FC8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This short patch was originally posted a while back by someone else.  For 
the original post and patch, see:

http://www.cs.helsinki.fi/linux/linux-kernel/2001-24/0435.html

This fix makes the raw devices appear in devfs.  Its useful for DVD movie 
playback, among other things.

I've had this patch applied for 6 months running Gentoo Linux, and its still 
working fine for me in 2.4.21pre7 so I thought I'd bring your attention to 
it again.

Thanks,
Tom


--- drivers/char/raw.c.orig     2003-04-05 12:12:48.000000000 -0600
+++ drivers/char/raw.c  2003-04-05 12:14:14.000000000 -0600
@@ -15,6 +15,7 @@
#include <linux/raw.h>
#include <linux/capability.h>
#include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
#include <asm/uaccess.h>

#define dprintk(x...)
@@ -53,7 +54,23 @@
static int __init raw_init(void)
{
        int i;
-       register_chrdev(RAW_MAJOR, "raw", &raw_fops);
+       if (devfs_register_chrdev(RAW_MAJOR, "raw", &raw_fops) != 0) {
+               printk(KERN_ERR "Unable to get major device %d for raw block 
devices",
+               RAW_MAJOR);
+       } else {
+               /*
+                * Make a directory for raw devices to go in ...
+                */
+               devfs_mk_dir(NULL, "raw", NULL);
+
+               /*
+                * Make the "control" device node for raw devices ...
+                */
+               devfs_register(NULL, "rawctl", DEVFS_FL_DEFAULT,
+                       RAW_MAJOR, 0,
+                       S_IFCHR | S_IRUSR | S_IWUSR,
+                       &raw_fops, NULL);
+       }

        for (i = 0; i < 256; i++)
                init_MUTEX(&raw_devices[i].mutex);

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

