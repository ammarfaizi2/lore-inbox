Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269715AbUICSJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269715AbUICSJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269680AbUICSGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:06:11 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:47207 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269701AbUICSEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:04:38 -0400
Subject: [PATCH] 2.6.9-rc1-bk9 synclink_cs.c kernel janitor changes
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1094234676.4313.13.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Sep 2004 13:04:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel janitor changes:

* use kernel provided min/max
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Paul Fulghum <paulkf@microgate.com>

* use kernel provided msecs_to_jiffies
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Paul Fulghum <paulkf@microgate.com>

Please apply.
 
 
--
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.9/drivers/char/pcmcia/synclink_cs.c	2004-09-02 11:23:58.000000000 -0500
+++ linux-2.6.9-mg/drivers/char/pcmcia/synclink_cs.c	2004-09-03 12:49:25.178204163 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/pcmcia/synclink_cs.c
  *
- * $Id: synclink_cs.c,v 4.26 2004/08/11 19:30:02 paulkf Exp $
+ * $Id: synclink_cs.c,v 4.28 2004/09/03 15:46:40 paulkf Exp $
  *
  * Device driver for Microgate SyncLink PC Card
  * multiprotocol serial adapter.
@@ -41,6 +41,7 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/tty.h>
@@ -443,8 +444,6 @@
 static int set_rxenable(MGSLPC_INFO *info, int enable);
 static int wait_events(MGSLPC_INFO *info, int __user *mask);
 
-#define jiffies_from_ms(a) ((((a) * HZ)/1000)+1)
-
 static MGSLPC_INFO *mgslpc_device_list = NULL;
 static int mgslpc_device_count = 0;
 
@@ -484,7 +483,7 @@
 MODULE_LICENSE("GPL");
 
 static char *driver_name = "SyncLink PC Card driver";
-static char *driver_version = "$Revision: 4.26 $";
+static char *driver_version = "$Revision: 4.28 $";
 
 static struct tty_driver *serial_driver;
 
@@ -494,10 +493,6 @@
 static void mgslpc_change_params(MGSLPC_INFO *info);
 static void mgslpc_wait_until_sent(struct tty_struct *tty, int timeout);
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /* PCMCIA prototypes */
 
 static void mgslpc_config(dev_link_t *link);
@@ -1191,7 +1186,7 @@
 		return;
 
 	while (info->tx_count && fifo_count) {
-		c = MIN(2, MIN(fifo_count, MIN(info->tx_count, TXBUFSIZE - info->tx_get)));
+		c = min(2, min_t(int, fifo_count, min(info->tx_count, TXBUFSIZE - info->tx_get)));
 		
 		if (c == 1) {
 			write_reg(info, CHA + TXFIFO, *(info->tx_buf + info->tx_get));
@@ -1754,8 +1749,8 @@
 	}
 
 	for (;;) {
-		c = MIN(count,
-			MIN(TXBUFSIZE - info->tx_count - 1,
+		c = min(count,
+			min(TXBUFSIZE - info->tx_count - 1,
 			    TXBUFSIZE - info->tx_put));
 		if (c <= 0)
 			break;
@@ -2641,7 +2636,7 @@
 		char_time = 1;
 		
 	if (timeout)
-		char_time = MIN(char_time, timeout);
+		char_time = min_t(unsigned long, char_time, timeout);
 		
 	if (info->params.mode == MGSL_MODE_HDLC) {
 		while (info->tx_active) {
@@ -3654,7 +3649,7 @@
 		} else {
 			info->tx_active = 1;
 			tx_ready(info);
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
+			info->tx_timer.expires = jiffies + msecs_to_jiffies(5000);
 			add_timer(&info->tx_timer);	
 		}
 	}
@@ -4114,7 +4109,7 @@
 	end_time=100;
 	while(end_time-- && !info->irq_occurred) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(jiffies_from_ms(10));
+		schedule_timeout(msecs_to_jiffies(10));
 	}
 	
 	info->testing_irq = FALSE;



