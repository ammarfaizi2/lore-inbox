Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVHOS0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVHOS0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVHOS0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:26:01 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:35718 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964889AbVHOS0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:26:00 -0400
Date: Mon, 15 Aug 2005 11:25:57 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: markus.lidel@shadowconnect.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [-mm PATCH 26/32] message: fix-up schedule_timeout() usage
Message-ID: <20050815182557.GC2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Use schedule_timeout_interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 drivers/message/fusion/mptlan.c   |   10 ++++------
 drivers/message/fusion/mptscsih.c |    6 ++----
 drivers/message/i2o/iop.c         |   15 +++++----------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff -urpN 2.6.13-rc5-mm1/drivers/message/fusion/mptlan.c 2.6.13-rc5-mm1-dev/drivers/message/fusion/mptlan.c
--- 2.6.13-rc5-mm1/drivers/message/fusion/mptlan.c	2005-08-07 09:57:59.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/message/fusion/mptlan.c	2005-08-08 15:49:30.000000000 -0700
@@ -506,7 +506,7 @@ mpt_lan_close(struct net_device *dev)
 {
 	struct mpt_lan_priv *priv = netdev_priv(dev);
 	MPT_ADAPTER *mpt_dev = priv->mpt_dev;
-	unsigned int timeout;
+	unsigned long timeout;
 	int i;
 
 	dlprintk((KERN_INFO MYNAM ": mpt_lan_close called\n"));
@@ -521,11 +521,9 @@ mpt_lan_close(struct net_device *dev)
 
 	mpt_lan_reset(dev);
 
-	timeout = 2 * HZ;
-	while (atomic_read(&priv->buckets_out) && --timeout) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	timeout = jiffies + 2 * HZ;
+	while (atomic_read(&priv->buckets_out) && time_before(jiffies, timeout))
+		schedule_timeout_interruptible(1);
 
 	for (i = 0; i < priv->max_buckets_out; i++) {
 		if (priv->RcvCtl[i].skb != NULL) {
diff -urpN 2.6.13-rc5-mm1/drivers/message/fusion/mptscsih.c 2.6.13-rc5-mm1-dev/drivers/message/fusion/mptscsih.c
--- 2.6.13-rc5-mm1/drivers/message/fusion/mptscsih.c	2005-08-07 10:05:20.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/message/fusion/mptscsih.c	2005-08-08 15:52:12.000000000 -0700
@@ -974,10 +974,8 @@ mptscsih_remove(struct pci_dev *pdev)
 	spin_lock_irqsave(&dvtaskQ_lock, flags);
 	if (dvtaskQ_active) {
 		spin_unlock_irqrestore(&dvtaskQ_lock, flags);
-		while(dvtaskQ_active && --count) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1);
-		}
+		while(dvtaskQ_active && --count)
+			schedule_timeout_interruptible(1);
 	} else {
 		spin_unlock_irqrestore(&dvtaskQ_lock, flags);
 	}
diff -urpN 2.6.13-rc5-mm1/drivers/message/i2o/iop.c 2.6.13-rc5-mm1-dev/drivers/message/i2o/iop.c
--- 2.6.13-rc5-mm1/drivers/message/i2o/iop.c	2005-08-07 09:58:00.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/message/i2o/iop.c	2005-08-08 15:53:24.000000000 -0700
@@ -92,8 +92,7 @@ u32 i2o_msg_get_wait(struct i2o_controll
 				  c->name);
 			return I2O_QUEUE_EMPTY;
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	}
 
 	return m;
@@ -484,8 +483,7 @@ static int i2o_iop_init_outbound_queue(s
 			osm_warn("%s: Timeout Initializing\n", c->name);
 			return -ETIMEDOUT;
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	}
 
 	m = c->out_queue.phys;
@@ -547,8 +545,7 @@ static int i2o_iop_reset(struct i2o_cont
 		if (time_after(jiffies, timeout))
 			break;
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	}
 
 	switch (*status) {
@@ -576,8 +573,7 @@ static int i2o_iop_reset(struct i2o_cont
 				rc = -ETIMEDOUT;
 				goto exit;
 			}
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 
 			m = i2o_msg_get_wait(c, &msg, I2O_TIMEOUT_RESET);
 		}
@@ -987,8 +983,7 @@ int i2o_status_get(struct i2o_controller
 			return -ETIMEDOUT;
 		}
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	}
 
 #ifdef DEBUG
