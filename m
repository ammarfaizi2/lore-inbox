Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVKTX3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVKTX3H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVKTX3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:29:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45584 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932123AbVKTX3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:29:05 -0500
Date: Mon, 21 Nov 2005 00:29:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill drivers/net/irda/sir_core.c
Message-ID: <20051120232904.GM16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_SYMBOL's do nowadays belong to the files where the actual 
functions are.

Moving the module_init/module_exit to the file with the actual functions 
has the advantage of saving a few bytes due to the removal of two 
functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/irda/Makefile      |    2 -
 drivers/net/irda/sir-dev.h     |    2 -
 drivers/net/irda/sir_core.c    |   56 ---------------------------------
 drivers/net/irda/sir_dev.c     |   10 +++++
 drivers/net/irda/sir_dongle.c  |    2 +
 drivers/net/irda/sir_kthread.c |   11 +++++-
 6 files changed, 21 insertions(+), 62 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/net/irda/Makefile.old	2005-11-20 20:22:17.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/net/irda/Makefile	2005-11-20 20:22:24.000000000 +0100
@@ -45,4 +45,4 @@
 obj-$(CONFIG_MA600_DONGLE)	+= ma600-sir.o
 
 # The SIR helper module
-sir-dev-objs := sir_core.o sir_dev.o sir_dongle.o sir_kthread.o
+sir-dev-objs := sir_dev.o sir_dongle.o sir_kthread.o
--- linux-2.6.15-rc1-mm2-full/drivers/net/irda/sir-dev.h.old	2005-11-20 20:18:25.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/net/irda/sir-dev.h	2005-11-20 20:18:37.000000000 +0100
@@ -133,8 +133,6 @@
 
 extern void sirdev_enable_rx(struct sir_dev *dev);
 extern int sirdev_schedule_request(struct sir_dev *dev, int state, unsigned param);
-extern int __init irda_thread_create(void);
-extern void __exit irda_thread_join(void);
 
 /* inline helpers */
 
--- linux-2.6.15-rc1-mm2-full/drivers/net/irda/sir_kthread.c.old	2005-11-20 20:18:47.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/net/irda/sir_kthread.c	2005-11-20 20:42:21.000000000 +0100
@@ -466,7 +466,7 @@
 	return 0;
 }
 
-int __init irda_thread_create(void)
+static int __init irda_thread_create(void)
 {
 	struct completion startup;
 	int pid;
@@ -488,7 +488,7 @@
 	return 0;
 }
 
-void __exit irda_thread_join(void) 
+static void __exit irda_thread_join(void) 
 {
 	if (irda_rq_queue.thread) {
 		flush_irda_queue();
@@ -499,3 +499,10 @@
 	}
 }
 
+module_init(irda_thread_create);
+module_exit(irda_thread_join);
+
+MODULE_AUTHOR("Martin Diehl <info@mdiehl.de>");
+MODULE_DESCRIPTION("IrDA SIR core");
+MODULE_LICENSE("GPL");
+
--- linux-2.6.15-rc1-mm2-full/drivers/net/irda/sir_dongle.c.old	2005-11-20 20:21:23.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/net/irda/sir_dongle.c	2005-11-20 20:22:02.000000000 +0100
@@ -50,6 +50,7 @@
 	up(&dongle_list_lock);
 	return 0;
 }
+EXPORT_SYMBOL(irda_register_dongle);
 
 int irda_unregister_dongle(struct dongle_driver *drv)
 {
@@ -58,6 +59,7 @@
 	up(&dongle_list_lock);
 	return 0;
 }
+EXPORT_SYMBOL(irda_unregister_dongle);
 
 int sirdev_get_dongle(struct sir_dev *dev, IRDA_DONGLE type)
 {
--- linux-2.6.15-rc1-mm2-full/drivers/net/irda/sir_dev.c.old	2005-11-20 20:22:37.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/net/irda/sir_dev.c	2005-11-20 20:24:00.000000000 +0100
@@ -60,6 +60,7 @@
 	up(&dev->fsm.sem);
 	return err;
 }
+EXPORT_SYMBOL(sirdev_set_dongle);
 
 /* used by dongle drivers for dongle programming */
 
@@ -94,6 +95,7 @@
 	spin_unlock_irqrestore(&dev->tx_lock, flags);
 	return ret;
 }
+EXPORT_SYMBOL(sirdev_raw_write);
 
 /* seems some dongle drivers may need this */
 
@@ -116,6 +118,7 @@
 
 	return count;
 }
+EXPORT_SYMBOL(sirdev_raw_read);
 
 int sirdev_set_dtr_rts(struct sir_dev *dev, int dtr, int rts)
 {
@@ -124,7 +127,8 @@
 		ret =  dev->drv->set_dtr_rts(dev, dtr, rts);
 	return ret;
 }
-	
+EXPORT_SYMBOL(sirdev_set_dtr_rts);
+
 /**********************************************************************/
 
 /* called from client driver - likely with bh-context - to indicate
@@ -227,6 +231,7 @@
 done:
 	spin_unlock_irqrestore(&dev->tx_lock, flags);
 }
+EXPORT_SYMBOL(sirdev_write_complete);
 
 /* called from client driver - likely with bh-context - to give us
  * some more received bytes. We put them into the rx-buffer,
@@ -279,6 +284,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(sirdev_receive);
 
 /**********************************************************************/
 
@@ -641,6 +647,7 @@
 out:
 	return NULL;
 }
+EXPORT_SYMBOL(sirdev_get_instance);
 
 int sirdev_put_instance(struct sir_dev *dev)
 {
@@ -673,4 +680,5 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(sirdev_put_instance);
 
--- linux-2.6.15-rc1-mm2-full/drivers/net/irda/sir_core.c	2005-11-20 20:24:09.000000000 +0100
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,56 +0,0 @@
-/*********************************************************************
- *
- *	sir_core.c:	module core for irda-sir abstraction layer
- *
- *	Copyright (c) 2002 Martin Diehl
- * 
- *	This program is free software; you can redistribute it and/or 
- *	modify it under the terms of the GNU General Public License as 
- *	published by the Free Software Foundation; either version 2 of 
- *	the License, or (at your option) any later version.
- *
- ********************************************************************/    
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <net/irda/irda.h>
-
-#include "sir-dev.h"
-
-/***************************************************************************/
-
-MODULE_AUTHOR("Martin Diehl <info@mdiehl.de>");
-MODULE_DESCRIPTION("IrDA SIR core");
-MODULE_LICENSE("GPL");
-
-/***************************************************************************/
-
-EXPORT_SYMBOL(irda_register_dongle);
-EXPORT_SYMBOL(irda_unregister_dongle);
-
-EXPORT_SYMBOL(sirdev_get_instance);
-EXPORT_SYMBOL(sirdev_put_instance);
-
-EXPORT_SYMBOL(sirdev_set_dongle);
-EXPORT_SYMBOL(sirdev_write_complete);
-EXPORT_SYMBOL(sirdev_receive);
-
-EXPORT_SYMBOL(sirdev_raw_write);
-EXPORT_SYMBOL(sirdev_raw_read);
-EXPORT_SYMBOL(sirdev_set_dtr_rts);
-
-static int __init sir_core_init(void)
-{
-	return irda_thread_create();
-}
-
-static void __exit sir_core_exit(void)
-{
-	irda_thread_join();
-}
-
-module_init(sir_core_init);
-module_exit(sir_core_exit);
-

