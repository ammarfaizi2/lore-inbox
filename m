Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVFTXUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVFTXUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVFTXBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:01:02 -0400
Received: from coderock.org ([193.77.147.115]:22169 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261710AbVFTVzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:55:38 -0400
Message-Id: <20050620215149.610416000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:49 +0200
From: domen@coderock.org
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 3/4] cdrom/sjcd: remove sleep_on() usage
Content-Disposition: inline; filename=sleep_on-drivers_cdrom_sjcd.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Directly use wait-queues instead of the deprecated sleep_on().
This required adding a local waitqueue. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 sjcd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: quilt/drivers/cdrom/sjcd.c
===================================================================
--- quilt.orig/drivers/cdrom/sjcd.c
+++ quilt/drivers/cdrom/sjcd.c
@@ -70,6 +70,7 @@
 #include <linux/string.h>
 #include <linux/major.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -407,9 +408,12 @@ static void sjcd_status_timer(void)
  */
 static int sjcd_wait_for_status(void)
 {
+	DEFINE_WAIT(wait);
 	sjcd_status_timeout = SJCD_WAIT_FOR_STATUS_TIMEOUT;
 	SJCD_SET_TIMER(sjcd_status_timer, 1);
-	sleep_on(&sjcd_waitq);
+	prepare_to_wait(&sjcd_waitq, &wait, TASK_UNINTERRUPTIBLE);
+	schedule();
+	finish_wait(&sjcd_waitq, &wait);
 #if defined( SJCD_DIAGNOSTIC ) || defined ( SJCD_TRACE )
 	if (sjcd_status_timeout <= 0)
 		printk("SJCD: Error Wait For Status.\n");

--
