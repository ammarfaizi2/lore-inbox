Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130429AbQLJUbe>; Sun, 10 Dec 2000 15:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130473AbQLJUbY>; Sun, 10 Dec 2000 15:31:24 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:23738 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130429AbQLJUbD>; Sun, 10 Dec 2000 15:31:03 -0500
Message-ID: <3A33E0DE.81720F77@haque.net>
Date: Sun, 10 Dec 2000 15:00:30 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre8
In-Reply-To: <Pine.LNX.4.10.10012101014000.3153-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------1DDF7EEE192527A0104715CC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1DDF7EEE192527A0104715CC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Could someome who knows what they are doing check over the following
patch please?

Linus Torvalds wrote:
>  - pre8:
>     - Stephen Rothwell: APM updates
>     - Johannes Erdfelt: USB updates
>     - me: call_usermodehelper(/sbin/hotplug) cleanup and deadlock fix
>     - Leonard Zubkoff: DAC960 Driver Update
>     - Martin Diehl: fix PCI PM callback ordering
>     - Andrew Morton: call_usermodehelper() fixes
>     - Urban Widmark: clean up and enable shared mmap on smbfs.
>     - Trond Myklebust: fix NFS path revalidation.
>     - me: proper locking around buffer b_end_io

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------1DDF7EEE192527A0104715CC
Content-Type: text/plain; charset=us-ascii;
 name="tq_struct-t12p8-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tq_struct-t12p8-fix.diff"

--- linux/drivers/i2o/i2o_lan.c	Sun Dec 10 14:17:22 2000
+++ linux-2.4.0-test12.mhaque/drivers/i2o/i2o_lan.c	Sun Dec 10 14:28:27 2000
@@ -112,8 +112,10 @@
 };
 static int lan_context;
 
-static struct tq_struct i2o_post_buckets_task = {
-	0, 0, (void (*)(void *))i2o_lan_receive_post, (void *) 0
+DECLARE_TASK_QUEUE(i2o_post_buckets_task);
+struct tq_struct run_i2o_post_buckets_task = {
+	routine: (void (*)(void *)) run_task_queue,
+	data: (void *) 0
 };
 
 /* Functions to handle message failures and transaction errors:
@@ -379,8 +381,8 @@
 	/* If DDM has already consumed bucket_thresh buckets, post new ones */
 
 	if (atomic_read(&priv->buckets_out) <= priv->max_buckets_out - priv->bucket_thresh) {
-		i2o_post_buckets_task.data = (void *)dev;
-		queue_task(&i2o_post_buckets_task, &tq_immediate);
+		run_i2o_post_buckets_task.data = (void *)dev;
+		queue_task(&run_i2o_post_buckets_task, &tq_immediate);
 		mark_bh(IMMEDIATE_BH);
 	}
 
@@ -1401,7 +1403,7 @@
 	atomic_set(&priv->tx_out, 0);
 	priv->tx_count = 0;
 
-	priv->i2o_batch_send_task.next    = NULL;
+	list_add_tail(&priv->i2o_batch_send_task.list, NULL);
 	priv->i2o_batch_send_task.sync    = 0;
 	priv->i2o_batch_send_task.routine = (void *)i2o_lan_batch_send;
 	priv->i2o_batch_send_task.data    = (void *)dev;
--- linux/drivers/net/aironet4500_core.c	Sun Dec 10 14:30:20 2000
+++ linux-2.4.0-test12.mhaque/drivers/net/aironet4500_core.c	Sun Dec 10 14:31:04 2000
@@ -2868,7 +2868,7 @@
 	
 	priv->command_semaphore_on = 0;
 	priv->unlock_command_postponed = 0;
-	priv->immediate_bh.next 	= NULL;
+	list_add_tail(&priv->immediate_bh.list, NULL);
 	priv->immediate_bh.sync 	= 0;
 	priv->immediate_bh.routine 	= (void *)(void *)awc_bh;
 	priv->immediate_bh.data 	= dev;
--- linux/drivers/usb/serial/keyspan_pda.c	Sun Dec 10 13:55:25 2000
+++ linux-2.4.0-test12.mhaque/drivers/usb/serial/keyspan_pda.c	Sun Dec 10 14:11:18 2000
@@ -742,11 +742,11 @@
 	if (!priv)
 		return (1); /* error */
 	init_waitqueue_head(&serial->port[0].write_wait);
-	priv->wakeup_task.next = NULL;
+	list_add_tail(&priv->wakeup_task.list, NULL);
 	priv->wakeup_task.sync = 0;
 	priv->wakeup_task.routine = (void *)keyspan_pda_wakeup_write;
 	priv->wakeup_task.data = (void *)(&serial->port[0]);
-	priv->unthrottle_task.next = NULL;
+	list_add_tail(&priv->unthrottle_task.list, NULL);
 	priv->unthrottle_task.sync = 0;
 	priv->unthrottle_task.routine = (void *)keyspan_pda_request_unthrottle;
 	priv->unthrottle_task.data = (void *)(serial);
--- linux/fs/smbfs/sock.c	Sun Dec 10 14:33:49 2000
+++ linux-2.4.0-test12.mhaque/fs/smbfs/sock.c	Sun Dec 10 14:34:28 2000
@@ -163,7 +163,7 @@
 		found_data(sk);
 		return;
 	}
-	job->cb.next = NULL;
+	list_add_tail(&job->cb.list, NULL);
 	job->cb.sync = 0;
 	job->cb.routine = smb_data_callback;
 	job->cb.data = job;

--------------1DDF7EEE192527A0104715CC--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
