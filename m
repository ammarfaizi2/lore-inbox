Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267567AbUHWVzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267567AbUHWVzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267628AbUHWVzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:55:02 -0400
Received: from server18.wavepath.com ([63.247.70.66]:29076 "EHLO
	bradgoodman.com") by vger.kernel.org with ESMTP id S267567AbUHWVwm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:52:42 -0400
Date: Mon, 23 Aug 2004 17:57:48 -0400
From: "bradgoodman.com" <bkgoodman@bradgoodman.com>
Message-Id: <200408232157.i7NLvmB30968@bradgoodman.com>
To: akpm@zip.com.au, Atul.Mukker@lsil.com, bgoodman@acopia.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       torvalds@osdl.org
Subject: [PATCH] 2.6.8.1 MegaRAID Driver Race
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] 2.6.8.1 to LSI Logic MegaRAID Adapter - ioctl function calls 
mega_internal_command, which uses wait_event, which calls schedule.
This means schedule() is called while big kernel_lock is held.

Locks/Unlocks were done here because 

1. There are a lot of return()s in the ioctl function to dodge.
2. mega_internal_command is also called by read and writes,
   which don't hold big kernel_lock

Brad Goodman <brad@bradgoodman.com>


--- drivers/scsi/megaraid.c.orig	Mon Aug 23 15:57:09 2004
+++ drivers/scsi/megaraid.c	Mon Aug 23 15:18:48 2004
@@ -38,6 +38,7 @@
 #include <linux/blkdev.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/reboot.h>
@@ -3622,7 +3623,9 @@
 			/*
 			 * Issue the command
 			 */
+			unlock_kernel();
 			mega_internal_command(adapter, LOCK_INT, &mc, pthru);
+			lock_kernel();
 
 			rval = mega_n_to_m((void __user *)arg, &mc);
 
@@ -3705,7 +3708,9 @@
 			/*
 			 * Issue the command
 			 */
+			unlock_kernel();
 			mega_internal_command(adapter, LOCK_INT, &mc, NULL);
+			lock_kernel();
 
 			rval = mega_n_to_m((void __user *)arg, &mc);
 
