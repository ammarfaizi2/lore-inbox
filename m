Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVCFKeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVCFKeg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 05:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVCFKch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 05:32:37 -0500
Received: from coderock.org ([193.77.147.115]:55208 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261361AbVCFKcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 05:32:10 -0500
Subject: [patch 4/6] 13/34: cdrom/mcd: remove sleep_on() usage
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 11:32:01 +0100
Message-Id: <20050306103201.A2F961F203@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Directly use wait-queues instead of the deprecated sleep_on().
This required adding a local waitqueue. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/cdrom/mcd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/cdrom/mcd.c~sleep_on-drivers_cdrom_mcd drivers/cdrom/mcd.c
--- kj/drivers/cdrom/mcd.c~sleep_on-drivers_cdrom_mcd	2005-03-05 16:11:47.000000000 +0100
+++ kj-domen/drivers/cdrom/mcd.c	2005-03-05 16:11:47.000000000 +0100
@@ -95,6 +95,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/config.h>
+#include <linux/wait.h>
 
 /* #define REALLY_SLOW_IO  */
 #include <asm/system.h>
@@ -1273,11 +1274,14 @@ static void mcdStatTimer(unsigned long d
 static int getMcdStatus(int timeout)
 {
 	int st;
+	DEFINE_WAIT(wait);
 
+	prepare_to_wait(&mcd_waitq, &wait, TASK_UNINTERRUPTIBLE);
 	McdTimeout = timeout;
 	mcd_timer.function = mcdStatTimer;
 	mod_timer(&mcd_timer, jiffies + 1);
-	sleep_on(&mcd_waitq);
+	schedule();
+	finish_wait(&mcd_waitq, &wait);
 	if (McdTimeout <= 0)
 		return -1;
 
_
