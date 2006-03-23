Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWCWUoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWCWUoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWCWUoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:44:01 -0500
Received: from [65.200.49.156] ([65.200.49.156]:29188 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S1422685AbWCWUnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:43:46 -0500
Message-ID: <4423084B.1070701@mvista.com>
Date: Thu, 23 Mar 2006 13:42:51 -0700
From: Randy Vinson <rvinson@mvista.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       "Mark A.Greer" <mgreer@mvista.com>
Subject: Re: [PATCH, RFC] Stop using tasklet in ds1374 RTC driver
References: <20060323201030.ccded642.khali@linux-fr.org>
In-Reply-To: <20060323201030.ccded642.khali@linux-fr.org>
Content-Type: multipart/mixed;
 boundary="------------020601070206020202020901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020601070206020202020901
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi all,
> 
> I have the following patch, which addresses a might-sleep-in-tasklet
> issue in the ds1374 driver. I'm not too sure if the new code is right
> or not, as I have never been using workqueues before, and I also don't
> have a DS1374 chip to test my changes on.
> 
> Can anyone comment on the patch and tell me if anything is wrong?
> 
> Can anyone with a DS1374 chip please test it?

I've attached a similar patch that has been tested using the DS1374 on the Freescale MPC8349MDS reference system. It is patterned after a similar change made to the m41t00 driver. The changes work, but I am also unfamiliar with workqueues, so my patch may not be any better.

> 
> I want this to be fixed now, because in -mm the ds1374 driver also uses
> the new mutex implementation, which is not allowed in tasklets, but is
> OK in workqueues.
> 
> Thanks.
> 


--------------020601070206020202020901
Content-Type: text/plain;
 name="ds1374_workqueue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ds1374_workqueue.patch"

This patch changes the DS1374 driver to use workqueues (taken from a
similar change to the m41t00.c driver.) This patch has been tested on the
Freescale MPC8349MDS.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Index: linux-2.6.10_wrk/drivers/i2c/chips/ds1374.c
===================================================================
--- linux-2.6.10_wrk.orig/drivers/i2c/chips/ds1374.c
+++ linux-2.6.10_wrk/drivers/i2c/chips/ds1374.c
@@ -26,6 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/workqueue.h>
 
 #include <asm/time.h>
 
@@ -51,6 +52,8 @@ static struct i2c_client *save_client;
 static unsigned short ignore[] = { I2C_CLIENT_END };
 static unsigned short normal_addr[] = { 0x68, I2C_CLIENT_END };
 
+static struct work_struct set_rtc_time_task;
+
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c = normal_addr,
 	.normal_i2c_range = ignore,
@@ -180,7 +183,7 @@ int ds1374_set_rtc_time(ulong nowtime)
 	new_time = nowtime;
 
 	if (in_interrupt())
-		tasklet_schedule(&ds1374_tasklet);
+		schedule_work(&set_rtc_time_task);
 	else
 		ds1374_set_tlet((ulong) & new_time);
 
@@ -215,6 +218,9 @@ static int ds1374_probe(struct i2c_adapt
 		return rc;
 	}
 
+	INIT_WORK(&set_rtc_time_task,
+			(void (*)(void *))&ds1374_set_tlet, &new_time);
+
 	save_client = client;
 
 	ds1374_check_rtc_status();
@@ -233,7 +239,7 @@ static int ds1374_detach(struct i2c_clie
 
 	if ((rc = i2c_detach_client(client)) == 0) {
 		kfree(i2c_get_clientdata(client));
-		tasklet_kill(&ds1374_tasklet);
+		flush_scheduled_work();
 	}
 	return rc;
 }

--------------020601070206020202020901--
