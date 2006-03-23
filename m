Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWCWTJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWCWTJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWCWTJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:09:59 -0500
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:37135 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932583AbWCWTJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:09:58 -0500
Date: Thu, 23 Mar 2006 20:10:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       "Mark A.Greer" <mgreer@mvista.com>, Randy Vinson <rvinson@mvista.com>
Subject: [PATCH, RFC] Stop using tasklet in ds1374 RTC driver
Message-Id: <20060323201030.ccded642.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have the following patch, which addresses a might-sleep-in-tasklet
issue in the ds1374 driver. I'm not too sure if the new code is right
or not, as I have never been using workqueues before, and I also don't
have a DS1374 chip to test my changes on.

Can anyone comment on the patch and tell me if anything is wrong?

Can anyone with a DS1374 chip please test it?

I want this to be fixed now, because in -mm the ds1374 driver also uses
the new mutex implementation, which is not allowed in tasklets, but is
OK in workqueues.

Thanks.

* * * * *

A tasklet is not suitable for what the ds1374 driver does: neither sleeping
nor mutex operations are allowed in tasklets, and ds1374_set_tlet may do
both.

We can use a workqueue instead, where both sleeping and mutex operations
are allowed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/chips/ds1374.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- linux-2.6.16-git.orig/drivers/i2c/chips/ds1374.c	2006-03-23 10:21:48.000000000 +0100
+++ linux-2.6.16-git/drivers/i2c/chips/ds1374.c	2006-03-23 19:37:25.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 #define DS1374_REG_TOD0		0x00
 #define DS1374_REG_TOD1		0x01
@@ -139,7 +140,7 @@
 	return t1;
 }
 
-static void ds1374_set_tlet(ulong arg)
+static void ds1374_set_work(void *arg)
 {
 	ulong t1, t2;
 	int limit = 10;		/* arbitrary retry limit */
@@ -168,19 +169,15 @@
 
 static ulong new_time;
 
-static DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet,
-				(ulong) & new_time);
+static struct workqueue_struct *ds1374_workqueue;
+
+static DECLARE_WORK(ds1374_work, ds1374_set_work, &new_time);
 
 int ds1374_set_rtc_time(ulong nowtime)
 {
 	new_time = nowtime;
 
-	if (in_interrupt())
-		tasklet_schedule(&ds1374_tasklet);
-	else
-		ds1374_set_tlet((ulong) & new_time);
-
-	return 0;
+	return queue_work(ds1374_workqueue, &ds1374_work);
 }
 
 /*
@@ -204,6 +201,8 @@
 	client->adapter = adap;
 	client->driver = &ds1374_driver;
 
+	ds1374_workqueue = create_singlethread_workqueue("ds1374");
+
 	if ((rc = i2c_attach_client(client)) != 0) {
 		kfree(client);
 		return rc;
@@ -227,7 +226,7 @@
 
 	if ((rc = i2c_detach_client(client)) == 0) {
 		kfree(i2c_get_clientdata(client));
-		tasklet_kill(&ds1374_tasklet);
+		destroy_workqueue(ds1374_workqueue);
 	}
 	return rc;
 }

-- 
Jean Delvare
