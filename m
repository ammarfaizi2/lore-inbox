Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVCBUH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVCBUH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVCBUGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:06:22 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:14479 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262447AbVCBUCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:02:23 -0500
Message-ID: <42261BCD.6030301@acm.org>
Date: Wed, 02 Mar 2005 14:02:21 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH] Add a non-blocking interface to the I2C code, part 4
Content-Type: multipart/mixed;
 boundary="------------090501030104080505080204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501030104080505080204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See part 1 for details on what this does...


--------------090501030104080505080204
Content-Type: text/plain;
 name="i2c_add_timer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_add_timer.diff"

Add a timer to the I2C layer.  This doesn't do much until the
non-blocking code shows up.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc5-mm1.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
@@ -30,9 +30,16 @@
 #include <linux/init.h>
 #include <linux/idr.h>
 #include <linux/seq_file.h>
+#include <linux/rcupdate.h>
 #include <asm/uaccess.h>
 
 
+static int i2c_stop_timer(struct i2c_adapter * adap);
+static void i2c_start_timer(struct i2c_adapter * adap,
+			    struct i2c_op_q_entry * entry);
+
+#define USEC_PER_JIFFIE (1000000 / HZ)
+
 static LIST_HEAD(adapters);
 static LIST_HEAD(drivers);
 static DECLARE_MUTEX(core_lists);
@@ -174,6 +181,19 @@
 	list_add_tail(&adap->list,&adapters);
 	INIT_LIST_HEAD(&adap->clients);
 
+	adap->timer = kmalloc(sizeof(*adap->timer), GFP_KERNEL);
+	if (!adap->timer) {
+		res = -ENOMEM;
+		goto out_unlock;
+	}
+		
+	init_timer(&adap->timer->timer);
+	spin_lock_init(&adap->timer->lock);
+	adap->timer->deleted = 0;
+	adap->timer->running = 0;
+	adap->timer->next_call_time = 0;
+	adap->timer->adapter = adap;
+
 	/* Add the adapter to the driver core.
 	 * If the parent pointer is not set up,
 	 * we add this adapter to the host bus.
@@ -216,6 +236,7 @@
 	struct i2c_driver *driver;
 	struct i2c_client *client;
 	int res = 0;
+	unsigned long flags;
 
 	down(&core_lists);
 
@@ -260,6 +281,19 @@
 		}
 	}
 
+	/* Stop the timer and free its memory */
+	spin_lock_irqsave(&adap->timer->lock, flags);
+	if (i2c_stop_timer(adap)) {
+		spin_unlock_irqrestore(&adap->timer->lock, flags);
+		kfree(adap->timer);
+	} else {
+		adap->timer->deleted = 1;
+		spin_unlock_irqrestore(&adap->timer->lock, flags);
+	}
+	/* Wait to make sure the timer is done. */
+	synchronize_kernel();
+	adap->timer = NULL;
+
 	/* clean up the sysfs representation */
 	init_completion(&adap->dev_released);
 	init_completion(&adap->class_dev_released);
@@ -582,6 +616,83 @@
 module_exit(i2c_exit);
 
 /* ----------------------------------------------------
+ * Timer operations
+ * ----------------------------------------------------
+ */
+static void i2c_handle_timer(unsigned long data);
+
+static void i2c_start_timer(struct i2c_adapter * adap,
+			    struct i2c_op_q_entry * entry)
+{
+	unsigned int wait_jiffies;
+	struct i2c_timer *t = adap->timer;
+	unsigned long flags;
+
+	wait_jiffies = ((entry->call_again_us + USEC_PER_JIFFIE - 1)
+			/ USEC_PER_JIFFIE);
+	if (wait_jiffies == 0)
+		wait_jiffies = 1;
+	/* This won't be polled from the user code, so
+	   start a timer to poll it. */
+	spin_lock_irqsave(&t->lock, flags);
+	if (! t->running) {
+		t->timer.expires = jiffies + wait_jiffies;
+		t->timer.data = (unsigned long) t;
+		t->timer.function = i2c_handle_timer;
+		t->running = 1;
+		t->next_call_time = wait_jiffies * USEC_PER_JIFFIE;
+		add_timer(&t->timer);
+		t->sequence = adap->timer_sequence;
+	}
+	spin_unlock_irqrestore(&t->lock, flags);
+}
+
+/* Returns true if the timer is stopped (or was not running), false if
+   not.  Must be called with the timer lock held. */
+static int i2c_stop_timer(struct i2c_adapter * adap)
+{
+	return (!adap->timer->running || del_timer(&adap->timer->timer));
+}
+
+static void i2c_handle_timer(unsigned long data)
+{
+	struct i2c_timer      * t = (void *) data;
+	struct i2c_adapter    * adap;
+	unsigned long         flags;
+	struct i2c_op_q_entry * entry;
+	unsigned int          sequence_match;
+
+	spin_lock_irqsave(&t->lock, flags);
+	if (t->deleted) {
+		spin_unlock_irqrestore(&t->lock, flags);
+		kfree(t);
+		return;
+	}
+
+	adap = t->adapter;
+	t->running = 0;
+	sequence_match = adap->timer_sequence == t->sequence;
+	spin_unlock_irqrestore(&t->lock, flags);
+
+	entry = i2c_entry_get(adap);
+	pr_debug("i2c_handle_timer: %p %p\n", adap, entry);
+	if (!entry)
+		return;
+
+	if (sequence_match) {
+		/* Poll will go here. */
+
+		if (!entry_completed(entry))
+			i2c_start_timer(adap, entry);
+	} else if (entry->use_timer)
+		/* We raced in timer deletion, just restart the
+		   timer if necessary. */
+		i2c_start_timer(adap, entry);
+
+	i2c_entry_put(adap, entry);
+}
+
+/* ----------------------------------------------------
  * the functional interface to the i2c busses.
  * ----------------------------------------------------
  */
@@ -1419,6 +1530,21 @@
 	if (atomic_dec_and_test(&e->completed)) {
 		/* We are the lucky winner!  We get to clean up the
 		   entry. */
+		if (e->use_timer) {
+			unsigned long    flags;
+			struct i2c_timer *t = adap->timer;
+			spin_lock_irqsave(&t->lock, flags);
+			if (!i2c_stop_timer(adap))
+				/* If we are unable to stop the timer, that
+				   means the timer has gone off but has not
+				   yet run the first part of the handler call.
+				   Increment the sequence so the timer handler
+				   can detect this. */
+				adap->timer_sequence++;
+			else
+				t->running = 0;
+			spin_unlock_irqrestore(&t->lock, flags);
+		}
 		if (e->complete)
 			e->complete(adap, e);
 	}
Index: linux-2.6.11-rc5-mm1/include/linux/i2c.h
===================================================================
--- linux-2.6.11-rc5-mm1.orig/include/linux/i2c.h
+++ linux-2.6.11-rc5-mm1/include/linux/i2c.h
@@ -36,6 +36,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/timer.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
@@ -242,6 +243,21 @@
 };
 
 /*
+ * The timer has it's own separately allocated data structure because
+ * it needs to be able to exist even if the adapter is deleted (due to
+ * timer cancellation races).
+ */
+struct i2c_timer {
+	spinlock_t lock;
+	int deleted;
+	struct timer_list timer;
+	int running;
+	unsigned int next_call_time;
+	struct i2c_adapter *adapter;
+	unsigned int sequence;
+};
+
+/*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
  */
@@ -263,6 +279,11 @@
 
 	struct semaphore bus_lock;
 
+	/* Used to time non-blocking operations.  The sequence is used
+	   to handle race conditions in the timer handler. */
+	struct i2c_timer *timer;
+	unsigned int timer_sequence;
+
 	int timeout;
 	int retries;
 	struct device dev;		/* the adapter device */

--------------090501030104080505080204--
