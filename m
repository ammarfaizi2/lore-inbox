Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbUL1P5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUL1P5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 10:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUL1P5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 10:57:07 -0500
Received: from postman2.arcor-online.net ([151.189.20.157]:6560 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261248AbUL1P5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 10:57:00 -0500
Date: Tue, 28 Dec 2004 16:56:57 +0100
From: Juergen Quade <quade@hsnr.de>
To: torvalds@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: PATCH for a little bug in deadline-iosched.c
Message-ID: <20041228155657.GA372@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is some (obvious) mess with "unsigned int" and "int" in
the deadline-io-scheduler (sysfs-section). Try to change 
the attribute "writes_starved":

	root@ezs-mobil:/sys/block/hda/queue# cat scheduler
	noop anticipatory [deadline]
	root@ezs-mobil:/sys/block/hda/queue# cd iosched/
	root@ezs-mobil:/sys/block/hda/queue/iosched# ls
	fifo_batch  front_merges  read_expire  write_expire  writes_starved
	root@ezs-mobil:/sys/block/hda/queue/iosched# cat writes_starved
	2
	root@ezs-mobil:/sys/block/hda/queue/iosched# echo 4 >writes_starved
	root@ezs-mobil:/sys/block/hda/queue/iosched# cat writes_starved
	-2147483648
	root@ezs-mobil:/sys/block/hda/queue/iosched#  

Because all attribute-variables are defined as "int", the patch
below changes them to "int". Now it works as expected...

                Juergen.

P.S.: Does it really make sense to allow a negative "writes_starved"?

==========================================================================
Signed-off-by: Juergen Quade <quade@hsnr.de>

--- linux-2.6.10/drivers/block/deadline-iosched.c.org	2004-12-28 16:19:46.000000000 +0100
+++ linux-2.6.10/drivers/block/deadline-iosched.c	2004-12-28 16:36:59.000000000 +0100
@@ -791,24 +791,24 @@
 };
 
 static ssize_t
-deadline_var_show(unsigned int var, char *page)
+deadline_var_show(int var, char *page)
 {
 	return sprintf(page, "%d\n", var);
 }
 
 static ssize_t
-deadline_var_store(unsigned int *var, const char *page, size_t count)
+deadline_var_store(int *var, const char *page, size_t count)
 {
 	char *p = (char *) page;
 
-	*var = simple_strtoul(p, &p, 10);
+	*var = (int)simple_strtol(p, &p, 10);
 	return count;
 }
 
 #define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				\
 static ssize_t __FUNC(struct deadline_data *dd, char *page)		\
 {									\
-	unsigned int __data = __VAR;					\
+	int __data = __VAR;					\
 	if (__CONV)							\
 		__data = jiffies_to_msecs(__data);			\
 	return deadline_var_show(__data, (page));			\
@@ -823,7 +823,7 @@
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\
 static ssize_t __FUNC(struct deadline_data *dd, const char *page, size_t count)	\
 {									\
-	unsigned int __data;						\
+	int __data;							\
 	int ret = deadline_var_store(&__data, (page), count);		\
 	if (__data < (MIN))						\
 		__data = (MIN);						\
