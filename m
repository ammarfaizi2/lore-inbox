Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262327AbSI1UrI>; Sat, 28 Sep 2002 16:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262329AbSI1UrI>; Sat, 28 Sep 2002 16:47:08 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:3933 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262327AbSI1UrH>; Sat, 28 Sep 2002 16:47:07 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: scott.feldman@intel.com
Subject: [patch] e100 schedule while atomic
Date: Sat, 28 Sep 2002 22:53:14 +0200
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209282252.58796.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running e100 on linux-2.5.39 showed that the driver incorrectly
holds a lock while calling request_irq(), which does kmalloc().

This patch appears to solve the problem. Not sure if it is correct,
but something like it has to be done.

	Arnd <><

===== drivers/net/e100/e100_main.c 1.25 vs edited =====
--- 1.25/drivers/net/e100/e100_main.c	Fri Sep 20 01:58:59 2002
+++ edited/drivers/net/e100/e100_main.c	Sat Sep 28 21:41:11 2002
@@ -986,11 +986,20 @@
 	netif_start_queue(dev);
 
 	e100_start_ru(bdp);
-	if ((rc = request_irq(dev->irq, &e100intr, SA_SHIRQ,
-			      dev->name, dev)) != 0) {
-		del_timer_sync(&bdp->watchdog_timer);
-		goto err_exit;
+
+	read_unlock(&(bdp->isolate_lock));
+	rc = request_irq(dev->irq, &e100intr, SA_SHIRQ, dev->name, dev);
+	read_lock(&(bdp->isolate_lock));
+
+	if (rc != 0)
+		goto err_exit2;
+
+	if (bdp->driver_isolated) {
+		free_irq(dev->irq, dev);
+		rc = -EBUSY;
+		goto err_exit2;
 	}
+
 	if (bdp->params.b_params & PRM_RX_CONG) {
 		DECLARE_TASKLET(polling_tasklet,
 				e100_polling_tasklet, (unsigned long) bdp);
@@ -1003,6 +1012,8 @@
 
 	goto exit;
 
+err_exit2:
+	del_timer_sync(&bdp->watchdog_timer);
 err_exit:
 	e100_clear_pools(bdp);
 exit:

