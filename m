Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUCUWvH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUCUWvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:51:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:63464 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261437AbUCUWuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:50:52 -0500
Subject: [PATCH] pmac_zilog: sleep fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079908594.911.150.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 09:36:35 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fix a problem with semaphore usage on wakeup from
sleep in pmac_zilog (crashing some laptops on wakeup).
Please apply,

Ben.

===== drivers/serial/pmac_zilog.c 1.6 vs edited =====
--- 1.6/drivers/serial/pmac_zilog.c	Wed Mar 10 21:18:32 2004
+++ edited/drivers/serial/pmac_zilog.c	Mon Mar 22 09:35:13 2004
@@ -1563,15 +1563,21 @@
 static int pmz_suspend(struct macio_dev *mdev, u32 pm_state)
 {
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
-	struct uart_state *state = pmz_uart_reg.state + uap->port.line;
+	struct uart_state *state;
 	unsigned long flags;
 
-	if (uap == NULL)
+	if (uap == NULL) {
+		printk("HRM... pmz_suspend with NULL uap\n");
 		return 0;
+	}
 
 	if (pm_state == mdev->ofdev.dev.power_state || pm_state < 2)
 		return 0;
 
+	pmz_debug("suspend, switching to state %d\n", pm_state);
+
+	state = pmz_uart_reg.state + uap->port.line;
+
 	down(&pmz_irq_sem);
 	down(&state->sem);
 
@@ -1607,6 +1613,8 @@
 	up(&state->sem);
 	up(&pmz_irq_sem);
 
+	pmz_debug("suspend, switching complete\n");
+
 	mdev->ofdev.dev.power_state = pm_state;
 
 	return 0;
@@ -1616,7 +1624,7 @@
 static int pmz_resume(struct macio_dev *mdev)
 {
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
-	struct uart_state *state = pmz_uart_reg.state + uap->port.line;
+	struct uart_state *state;
 	unsigned long flags;
 	int pwr_delay;
 
@@ -1626,6 +1634,10 @@
 	if (mdev->ofdev.dev.power_state == 0)
 		return 0;
 	
+	pmz_debug("resume, switching to state 0\n");
+
+	state = pmz_uart_reg.state + uap->port.line;
+
 	down(&pmz_irq_sem);
 	down(&state->sem);
 
@@ -1658,6 +1670,7 @@
 		enable_irq(uap->port.irq);
 	}
 
+ bail:
 	up(&state->sem);
 	up(&pmz_irq_sem);
 
@@ -1670,7 +1683,8 @@
 		schedule_timeout((pwr_delay * HZ)/1000);
 	}
 
- bail:
+	pmz_debug("resume, switching complete\n");
+
 	mdev->ofdev.dev.power_state = 0;
 
 	return 0;


