Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUIWUmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUIWUmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUIWUlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:41:42 -0400
Received: from baikonur.stro.at ([213.239.196.228]:21191 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266555AbUIWUZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:03 -0400
Subject: [patch 03/26]  char/dtlk: replace 	schedule_timeout()/dtlk_delay() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:01 +0200
Message-ID: <E1CAa9F-0007pK-Sz@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout() /
dtlk_delay() to guarantee the task delays as expected. Removes the
definition/prototype of dtlk_delay().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/dtlk.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff -puN drivers/char/dtlk.c~msleep_interruptible-drivers_char_dtlk drivers/char/dtlk.c
--- linux-2.6.9-rc2-bk7/drivers/char/dtlk.c~msleep_interruptible-drivers_char_dtlk	2004-09-21 21:08:00.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/dtlk.c	2004-09-21 21:08:00.000000000 +0200
@@ -107,7 +107,6 @@ static struct file_operations dtlk_fops 
 };
 
 /* local prototypes */
-static void dtlk_delay(int ms);
 static int dtlk_dev_probe(void);
 static struct dtlk_settings *dtlk_interrogate(void);
 static int dtlk_readable(void);
@@ -146,7 +145,7 @@ static ssize_t dtlk_read(struct file *fi
 			return i;
 		if (file->f_flags & O_NONBLOCK)
 			break;
-		dtlk_delay(100);
+		msleep_interruptible(100);
 	}
 	if (retries == loops_per_jiffy)
 		printk(KERN_ERR "dtlk_read times out\n");
@@ -191,7 +190,7 @@ static ssize_t dtlk_write(struct file *f
 				   rate to 500 bytes/sec, but that's
 				   still enough to keep up with the
 				   speech synthesizer. */
-				dtlk_delay(1);
+				msleep_interruptible(1);
 			else {
 				/* the RDY bit goes zero 2-3 usec
 				   after writing, and goes 1 again
@@ -212,7 +211,7 @@ static ssize_t dtlk_write(struct file *f
 		if (file->f_flags & O_NONBLOCK)
 			break;
 
-		dtlk_delay(1);
+		msleep_interruptible(1);
 
 		if (++retries > 10 * HZ) { /* wait no more than 10 sec
 					      from last write */
@@ -351,8 +350,7 @@ static int __init dtlk_init(void)
 static void __exit dtlk_cleanup (void)
 {
 	dtlk_write_bytes("goodbye", 8);
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(5 * HZ / 10);		/* nap 0.50 sec but
+	msleep_interruptible(500);		/* nap 0.50 sec but
 						   could be awakened
 						   earlier by
 						   signals... */
@@ -368,13 +366,6 @@ module_exit(dtlk_cleanup);
 
 /* ------------------------------------------------------------------------ */
 
-/* sleep for ms milliseconds */
-static void dtlk_delay(int ms)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout((ms * HZ + 1000 - HZ) / 1000);
-}
-
 static int dtlk_readable(void)
 {
 #ifdef TRACING
@@ -431,7 +422,7 @@ static int __init dtlk_dev_probe(void)
 			/* posting an index takes 18 msec.  Here, we
 			   wait up to 100 msec to see whether it
 			   appears. */
-			dtlk_delay(100);
+			msleep_interruptible(100);
 			dtlk_has_indexing = dtlk_readable();
 #ifdef TRACING
 			printk(", indexing %d\n", dtlk_has_indexing);
_
