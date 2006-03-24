Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbWCXBSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbWCXBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWCXBSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:18:16 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:10572 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932621AbWCXBSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:18:15 -0500
Date: Thu, 23 Mar 2006 18:18:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: LM Sensors <lm-sensors@lm-sensors.org>
Cc: Rudolf Marek <r.marek@sh.cvut.cz>, lkml <linux-kernel@vger.kernel.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 2.6.16-mm1 1/3] rtc: m41t00 driver should use workqueue instead of tasklet
Message-ID: <20060324011846.GC9560@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz> <zt2d4LqL.1141645514.2993990.khali@localhost> <20060307170107.GA5250@mag.az.mvista.com> <20060318001254.GA14079@mag.az.mvista.com> <20060323210856.f1bfd02b.khali@linux-fr.org> <20060323203843.GA18912@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323203843.GA18912@mag.az.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The m41t00 i2c/rtc driver currently uses a tasklet to schedule interrupt-level
writes to the rtc.  This patch causes the driver to use a workqueue instead.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 m41t00.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)
---

diff -Nurp linux-2.6.16-mm1/drivers/i2c/chips/m41t00.c linux-2.6.16-mm1-wq/drivers/i2c/chips/m41t00.c
--- linux-2.6.16-mm1/drivers/i2c/chips/m41t00.c	2006-03-23 15:04:55.000000000 -0700
+++ linux-2.6.16-mm1-wq/drivers/i2c/chips/m41t00.c	2006-03-23 16:04:01.000000000 -0700
@@ -25,6 +25,7 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 #include <asm/time.h>
 #include <asm/rtc.h>
@@ -32,6 +33,7 @@
 #define	M41T00_DRV_NAME		"m41t00"
 
 static DEFINE_MUTEX(m41t00_mutex);
+static struct work_struct set_rtc_time_task;
 
 static struct i2c_driver m41t00_driver;
 static struct i2c_client *save_client;
@@ -111,7 +113,7 @@ m41t00_get_rtc_time(void)
 }
 
 static void
-m41t00_set_tlet(ulong arg)
+m41t00_set(void *arg)
 {
 	struct rtc_time	tm;
 	ulong	nowtime = *(ulong *)arg;
@@ -147,17 +149,15 @@ m41t00_set_tlet(ulong arg)
 
 static ulong	new_time;
 
-DECLARE_TASKLET_DISABLED(m41t00_tasklet, m41t00_set_tlet, (ulong)&new_time);
-
 int
 m41t00_set_rtc_time(ulong nowtime)
 {
 	new_time = nowtime;
 
 	if (in_interrupt())
-		tasklet_schedule(&m41t00_tasklet);
+		schedule_work(&set_rtc_time_task);
 	else
-		m41t00_set_tlet((ulong)&new_time);
+		m41t00_set((void *)&new_time);
 
 	return 0;
 }
@@ -189,6 +189,7 @@ m41t00_probe(struct i2c_adapter *adap, i
 		return rc;
 	}
 
+	INIT_WORK(&set_rtc_time_task, &m41t00_set, &new_time);
 	save_client = client;
 	return 0;
 }
@@ -206,7 +207,7 @@ m41t00_detach(struct i2c_client *client)
 
 	if ((rc = i2c_detach_client(client)) == 0) {
 		kfree(client);
-		tasklet_kill(&m41t00_tasklet);
+		flush_scheduled_work();
 	}
 	return rc;
 }
