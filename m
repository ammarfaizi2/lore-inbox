Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbULPIYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbULPIYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 03:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbULPIYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 03:24:42 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42751 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262641AbULPIXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 03:23:14 -0500
Date: Thu, 16 Dec 2004 09:22:47 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Gerald Schaefer <geraldsc@de.ibm.com>
Subject: [patch 2/2] s390: z/VM watchdog driver bugfix.
Message-ID: <20041216082247.GC5043@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/2] s390: z/VM watchdog driver bugfix.

From: Gerald Schaefer <geraldsc@de.ibm.com>

 - Remove ESPIPE logic, use nonseekable_open() instead.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 drivers/s390/char/vmwatchdog.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -urN linux-2.6/drivers/s390/char/vmwatchdog.c linux-2.6-patched/drivers/s390/char/vmwatchdog.c
--- linux-2.6/drivers/s390/char/vmwatchdog.c	2004-12-16 08:52:03.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/vmwatchdog.c	2004-12-16 08:52:24.000000000 +0100
@@ -168,7 +168,7 @@
 	ret = vmwdt_keepalive();
 	if (ret)
 		clear_bit(0, &vmwdt_is_open);
-	return ret;
+	return ret ? ret : nonseekable_open(i, f);
 }
 
 static int vmwdt_close(struct inode *i, struct file *f)
@@ -238,10 +238,6 @@
 static ssize_t vmwdt_write(struct file *f, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	/* We can't seek */
-	if(ppos != &f->f_pos)
-		return -ESPIPE;
-
 	if(count) {
 		if (!vmwdt_nowayout) {
 			size_t i;
