Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVCFKeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVCFKeg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 05:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVCFKc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 05:32:27 -0500
Received: from coderock.org ([193.77.147.115]:53672 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261360AbVCFKcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 05:32:06 -0500
Subject: [patch 3/6] 11/34: cdrom/aztcd: remove sleep_on() usage
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 11:31:58 +0100
Message-Id: <20050306103158.7722E1E46E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Directly use wait-queues instead of the deprecated sleep_on().
This required adding a local waitqueue. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/cdrom/aztcd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/cdrom/aztcd.c~sleep_on-drivers_cdrom_aztcd drivers/cdrom/aztcd.c
--- kj/drivers/cdrom/aztcd.c~sleep_on-drivers_cdrom_aztcd	2005-03-05 16:11:46.000000000 +0100
+++ kj-domen/drivers/cdrom/aztcd.c	2005-03-05 16:11:46.000000000 +0100
@@ -179,6 +179,7 @@
 #include <linux/ioport.h>
 #include <linux/string.h>
 #include <linux/major.h>
+#include <linux/wait.h>
 
 #include <linux/init.h>
 
@@ -429,9 +430,12 @@ static void dten_low(void)
 #define STEN_LOW_WAIT   statusAzt()
 static void statusAzt(void)
 {
+	DEFINE_WAIT(wait);
 	AztTimeout = AZT_STATUS_DELAY;
 	SET_TIMER(aztStatTimer, HZ / 100);
-	sleep_on(&azt_waitq);
+	prepare_to_wait(&azt_waitq, &wait, TASK_UNINTERRUPTIBLE);
+	schedule();
+	finish_wait(&azt_waitq, &wait);
 	if (AztTimeout <= 0)
 		printk("aztcd: Error Wait STEN_LOW_WAIT command:%x\n",
 		       aztCmd);
_
