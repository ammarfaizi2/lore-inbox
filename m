Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVBXXec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVBXXec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVBXXd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:33:56 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:30685 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262558AbVBXX3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:29:38 -0500
Message-ID: <421E6361.90009@acm.org>
Date: Thu, 24 Feb 2005 17:29:37 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] I2C patch 3 - Add handling for I2C operation queue entries
Content-Type: multipart/mixed;
 boundary="------------030405070502080907060108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030405070502080907060108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is one in a series of patches for adding a non-blocking interface 
to the I2C driver for supporting the IPMI SMBus driver.

--------------030405070502080907060108
Content-Type: text/plain;
 name="i2c_opq_handling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_opq_handling.diff"

This patch adds handling of the op q to the I2C main code
in preparation for the non-blocking changes.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc4/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc4/drivers/i2c/i2c-core.c
@@ -54,6 +54,8 @@
 	complete(&adap->dev_released);
 }
 
+#define entry_completed(e) (atomic_read(&(e)->completed) <= 0)
+
 static struct device_driver i2c_adapter_driver = {
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
@@ -134,6 +136,8 @@
 	}
 
 	adap->nr =  id & MAX_ID_MASK;
+	spin_lock_init(&adap->q_lock);
+	INIT_LIST_HEAD(&adap->q);
 	init_MUTEX(&adap->bus_lock);
 	init_MUTEX(&adap->clist_lock);
 	list_add_tail(&adap->list,&adapters);
@@ -1334,6 +1338,100 @@
 	return (func & adap_func) == func;
 }
 
+/* ----------------------------------------------------
+ * Entry handling
+ * ----------------------------------------------------
+ */
+
+/* Get the first entry off the head of the queue and lock it there.
+   The entry is guaranteed to remain first in the list and the handler
+   not be called until i2c_entry_put() is called. */
+static struct i2c_op_q_entry *_i2c_entry_get(struct i2c_adapter * adap)
+{
+	struct i2c_op_q_entry * entry = NULL;
+
+	if (!list_empty(&adap->q)) {
+		struct list_head * link = adap->q.next;
+		entry = list_entry(link, struct i2c_op_q_entry, link);
+		if (entry_completed(entry))
+			entry = NULL;
+		else {
+			int val = atomic_add_return(1, &entry->usecount);
+
+			/* This is subtle.  If we increment the
+			   usecount and the value is 1, that means it
+			   was zero before.  This means the put()
+			   routine has decremented the value to zero
+			   and is between tha decrement and the
+			   spinlock.  In this case, return NULL
+			   because the current list head is complete
+			   and the next list item is not yet
+			   started. */
+			if  (val == 1) {
+				atomic_dec(&entry->usecount);
+				entry = NULL;
+			}
+		}
+	}
+	pr_debug("_i2c_entry_get %p %p\n", adap, entry);
+	return entry;
+}
+
+struct i2c_op_q_entry *i2c_entry_get(struct i2c_adapter * adap)
+{
+	unsigned long flags;
+	struct i2c_op_q_entry * entry;
+
+	spin_lock_irqsave(&adap->q_lock, flags);
+	entry = _i2c_entry_get(adap);
+	spin_unlock_irqrestore(&adap->q_lock, flags);
+	return entry;
+}
+
+void i2c_entry_put(struct i2c_adapter * adap,
+		   struct i2c_op_q_entry * entry)
+{
+	unsigned long flags;
+	struct i2c_op_q_entry * new_entry = NULL;
+
+ restart:
+	pr_debug("i2c_put %p %p\n", adap, entry);
+	/* Subtle reasons why we don't need a lock before the dec, see
+	   the get routine for more details. */
+	if (atomic_dec_and_test(&entry->usecount)) {
+		spin_lock_irqsave(&adap->q_lock, flags);
+		list_del(&entry->link);
+
+		/* Get the next entry to start. */
+		new_entry = _i2c_entry_get(adap);
+		spin_unlock_irqrestore(&adap->q_lock, flags);
+
+		entry->handler(entry);
+
+		if (new_entry) {
+			/* start entry will go here. */
+			if (new_entry->start)
+				complete(new_entry->start);
+			/* Do tail recursion ourself. */
+			entry = new_entry;
+			goto restart;
+		}
+	}
+}
+
+void i2c_op_done(struct i2c_adapter *adap, struct i2c_op_q_entry *e)
+{
+	pr_debug("i2c_op_done: %p %p\n", adap, e);
+	if (atomic_dec_and_test(&e->completed)) {
+		/* We are the lucky winner!  We get to clean up the
+		   entry. */
+		if (e->complete)
+			e->complete(adap, e);
+	}
+
+	i2c_entry_put(adap, e);
+}
+
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
@@ -1345,6 +1443,7 @@
 EXPORT_SYMBOL(i2c_clients_command);
 EXPORT_SYMBOL(i2c_check_addr);
 
+EXPORT_SYMBOL(i2c_op_done);
 EXPORT_SYMBOL(i2c_master_send);
 EXPORT_SYMBOL(i2c_master_recv);
 EXPORT_SYMBOL(i2c_control);
Index: linux-2.6.11-rc4/include/linux/i2c.h
===================================================================
--- linux-2.6.11-rc4.orig/include/linux/i2c.h
+++ linux-2.6.11-rc4/include/linux/i2c.h
@@ -33,6 +33,8 @@
 #include <linux/i2c-id.h>
 #include <linux/device.h>	/* for struct device */
 #include <linux/completion.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
@@ -184,6 +186,33 @@
 }
 
 /*
+ * About locking and the non-blocking interface.
+ *
+ * The poll operations are called single-threaded (along with the
+ * xxx_start operations), so if the driver is only polled then there
+ * is no need to do any locking.  If you are using interrupts, then
+ * the timer operations and interrupts can race and you need to lock
+ * appropriately.
+ * 
+ * i2c_op_done() can be called multiple times on the same entry (as
+ * long as each one has a get operation).  This handles poll and
+ * interrupt races calling i2c_op_done().  It will do the right thing.
+ */
+
+/* Called from an non-blocking interface to get the current working
+   entry.  Returns NULL if there is none.  This is primarily for
+   interrupt handlers to determine what they should be working on.
+   Note that if you call i2c_entry_get() and get a non-null entry, you
+   must call i2c_entry_put() on it. */
+struct i2c_op_q_entry *i2c_entry_get(struct i2c_adapter * adap);
+void i2c_entry_put(struct i2c_adapter * adap,
+		   struct i2c_op_q_entry * entry);
+
+/* Called from an non-blocking interface to report that an operation
+   has completed.  Can be called from interrupt context. */
+void i2c_op_done(struct i2c_adapter *adap, struct i2c_op_q_entry *entry);
+
+/*
  * The following structs are for those who like to implement new bus drivers:
  * i2c_algorithm is the interface to a class of hardware solutions which can
  * be addressed using the same bus algorithms - i.e. bit-banging or the PCF8584
@@ -231,6 +260,9 @@
 	int (*client_unregister)(struct i2c_client *);
 
 	/* data fields that are valid for all devices	*/
+	struct list_head q;
+	spinlock_t q_lock;
+
 	struct semaphore bus_lock;
 
 	int timeout;

--------------030405070502080907060108--
