Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVCFKeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVCFKeg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 05:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVCFKct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 05:32:49 -0500
Received: from coderock.org ([193.77.147.115]:56232 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261362AbVCFKcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 05:32:13 -0500
Subject: [patch 5/6] 15/34: cdrom/sjcd: remove sleep_on() usage
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 11:32:04 +0100
Message-Id: <20050306103204.C22611F204@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Directly use wait-queues instead of the deprecated sleep_on().
This required adding a local waitqueue. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/cdrom/sjcd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/cdrom/sjcd.c~sleep_on-drivers_cdrom_sjcd drivers/cdrom/sjcd.c
--- kj/drivers/cdrom/sjcd.c~sleep_on-drivers_cdrom_sjcd	2005-03-05 16:11:48.000000000 +0100
+++ kj-domen/drivers/cdrom/sjcd.c	2005-03-05 16:11:48.000000000 +0100
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
_
