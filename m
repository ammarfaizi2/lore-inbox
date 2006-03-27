Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWC0WcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWC0WcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWC0WcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:32:23 -0500
Received: from [65.200.49.156] ([65.200.49.156]:52740 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S1751166AbWC0WcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:32:23 -0500
Message-ID: <442867BD.8020904@mvista.com>
Date: Mon, 27 Mar 2006 15:31:25 -0700
From: Randy Vinson <rvinson@mvista.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: "Mark A. Greer" <mgreer@mvista.com>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH, RFC] Stop using tasklet in ds1374 RTC driver
References: <20060323201030.ccded642.khali@linux-fr.org>	<4423084B.1070701@mvista.com>	<20060323214028.GB21477@mag.az.mvista.com>	<20060324215311.8ea42d20.khali@linux-fr.org>	<20060327203802.GA10238@mag.az.mvista.com> <20060327231527.be0b1db4.khali@linux-fr.org>
In-Reply-To: <20060327231527.be0b1db4.khali@linux-fr.org>
Content-Type: multipart/mixed;
 boundary="------------040708050703080600010101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708050703080600010101
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> 
> Well I already have a patch for ds1374. This is basically a mix between
> Randy's and my original patch: I've kept the dedicated workqueue as my
> patch had, but preserved the in_interrupt() call as in Randy's. Here's
> the result:
> 
> * * * * *
> 
> A tasklet is not suitable for what the ds1374 driver does: neither sleeping
> nor mutex operations are allowed in tasklets, and ds1374_set_tlet may do
> both.
> 
> We can use a workqueue instead, where both sleeping and mutex operations
> are allowed.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/i2c/chips/ds1374.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.16-git.orig/drivers/i2c/chips/ds1374.c	2006-03-27 18:25:17.000000000 +0200
> +++ linux-2.6.16-git/drivers/i2c/chips/ds1374.c	2006-03-27 18:59:05.000000000 +0200
> @@ -27,6 +27,7 @@
>  #include <linux/rtc.h>
>  #include <linux/bcd.h>
>  #include <linux/mutex.h>
> +#include <linux/workqueue.h>
>  
>  #define DS1374_REG_TOD0		0x00
>  #define DS1374_REG_TOD1		0x01
> @@ -139,7 +140,7 @@
>  	return t1;
>  }
>  
> -static void ds1374_set_tlet(ulong arg)
> +static void ds1374_set_work(void *arg)
>  {
>  	ulong t1, t2;
>  	int limit = 10;		/* arbitrary retry limit */
> @@ -168,17 +169,18 @@
>  
>  static ulong new_time;
>  
> -static DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet,
> -				(ulong) & new_time);
> +static struct workqueue_struct *ds1374_workqueue;
> +
> +static DECLARE_WORK(ds1374_work, ds1374_set_work, &new_time);
>  
>  int ds1374_set_rtc_time(ulong nowtime)
>  {
>  	new_time = nowtime;
>  
>  	if (in_interrupt())
> -		tasklet_schedule(&ds1374_tasklet);
> +		queue_work(ds1374_workqueue, &ds1374_work);
>  	else
> -		ds1374_set_tlet((ulong) & new_time);
> +		ds1374_set_work(&new_time);
>  
>  	return 0;
>  }
> @@ -204,6 +206,8 @@
>  	client->adapter = adap;
>  	client->driver = &ds1374_driver;
>  
> +	ds1374_workqueue = create_singlethread_workqueue("ds1374");
> +
>  	if ((rc = i2c_attach_client(client)) != 0) {
>  		kfree(client);
>  		return rc;
> @@ -227,7 +231,7 @@
>  
>  	if ((rc = i2c_detach_client(client)) == 0) {
>  		kfree(i2c_get_clientdata(client));
> -		tasklet_kill(&ds1374_tasklet);
> +		destroy_workqueue(ds1374_workqueue);
>  	}
>  	return rc;
>  }
> 
> * * * * *
> 
> If it's OK, then Randy can just sign it off and I'll push it to Greg
> quickly. If it's not OK for some reason, I'll just wait for a new patch
> from Randy.
I've tested the patch. It works fine for me.

	Randy V.

--------------040708050703080600010101
Content-Type: text/plain;
 name="ds1374_final.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ds1374_final.patch"

A tasklet is not suitable for what the ds1374 driver does: neither sleeping
nor mutex operations are allowed in tasklets, and ds1374_set_tlet may do
both.

We can use a workqueue instead, where both sleeping and mutex operations
are allowed.

Acked-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/chips/ds1374.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- linux-2.6.16-git.orig/drivers/i2c/chips/ds1374.c	2006-03-27 18:25:17.000000000 +0200
+++ linux-2.6.16-git/drivers/i2c/chips/ds1374.c	2006-03-27 18:59:05.000000000 +0200
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
@@ -168,17 +169,18 @@
 
 static ulong new_time;
 
-static DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet,
-				(ulong) & new_time);
+static struct workqueue_struct *ds1374_workqueue;
+
+static DECLARE_WORK(ds1374_work, ds1374_set_work, &new_time);
 
 int ds1374_set_rtc_time(ulong nowtime)
 {
 	new_time = nowtime;
 
 	if (in_interrupt())
-		tasklet_schedule(&ds1374_tasklet);
+		queue_work(ds1374_workqueue, &ds1374_work);
 	else
-		ds1374_set_tlet((ulong) & new_time);
+		ds1374_set_work(&new_time);
 
 	return 0;
 }
@@ -204,6 +206,8 @@
 	client->adapter = adap;
 	client->driver = &ds1374_driver;
 
+	ds1374_workqueue = create_singlethread_workqueue("ds1374");
+
 	if ((rc = i2c_attach_client(client)) != 0) {
 		kfree(client);
 		return rc;
@@ -227,7 +231,7 @@
 
 	if ((rc = i2c_detach_client(client)) == 0) {
 		kfree(i2c_get_clientdata(client));
-		tasklet_kill(&ds1374_tasklet);
+		destroy_workqueue(ds1374_workqueue);
 	}
 	return rc;
 }

--------------040708050703080600010101--
