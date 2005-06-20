Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVFTXBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVFTXBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVFTXBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:01:48 -0400
Received: from coderock.org ([193.77.147.115]:21401 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261674AbVFTVzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:55:37 -0400
Message-Id: <20050620215148.561754000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:48 +0200
From: domen@coderock.org
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 2/4] cdrom/aztcd: remove sleep_on() usage
Content-Disposition: inline; filename=sleep_on-drivers_cdrom_aztcd.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Directly use wait-queues instead of the deprecated sleep_on().
This required adding a local waitqueue. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 aztcd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: quilt/drivers/cdrom/aztcd.c
===================================================================
--- quilt.orig/drivers/cdrom/aztcd.c
+++ quilt/drivers/cdrom/aztcd.c
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

--
