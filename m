Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVCBUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVCBUFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVCBUFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:05:10 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:8437 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262450AbVCBUBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:01:18 -0500
Message-ID: <42261B8A.9070409@acm.org>
Date: Wed, 02 Mar 2005 14:01:14 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH] Add a non-blocking interface to the I2C code, part3
Content-Type: multipart/mixed;
 boundary="------------000003040609010400020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000003040609010400020705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See part 1 for details on what this does...


--------------000003040609010400020705
Content-Type: text/plain;
 name="i2c_opq_handling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_opq_handling.diff"

This patch adds handling of the op q to the I2C main code
in preparation for the non-blocking changes.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc5-mm1.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
@@ -85,6 +85,8 @@
 	complete(&adap->dev_released);
 }
 
+#define entry_completed(e) (atomic_read(&(e)->completed) <= 0)
+
 static struct device_driver i2c_adapter_driver = {
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
@@ -165,6 +167,8 @@
 	}
 
 	adap->nr =  id & MAX_ID_MASK;
+	spin_lock_init(&adap->q_lock);
+	INIT_LIST_HEAD(&adap->q);
 	init_MUTEX(&adap->bus_lock);
 	init_MUTEX(&adap->clist_lock);
 	list_add_tail(&adap->list,&adapters);
@@ -587,6 +591,7 @@
 {
 	entry->xfer_type = I2C_OP_I2C;
 	entry->complete = NULL;
+	kref_init(&entry->usecount);
 	if (adap->algo->master_xfer) {
  	 	dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n",
 			entry->i2c.num);
@@ -1284,6 +1289,7 @@
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 	    return -ENOMEM;
+	kref_init(&entry->usecount);
 
 	entry->xfer_type = I2C_OP_SMBUS;
 	entry->smbus.addr = addr;
@@ -1335,6 +1341,91 @@
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
+		else
+			kref_get(&entry->usecount);
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
+static void i2c_op_release(struct kref *ref)
+{
+	/* Nothing to do here, all handling is from the kref_put return
+	   code. */
+}
+
+void i2c_entry_put(struct i2c_adapter * adap,
+		   struct i2c_op_q_entry * entry)
+{
+	unsigned long flags;
+	struct i2c_op_q_entry * new_entry;
+
+ restart:
+	pr_debug("i2c_put %p %p\n", adap, entry);
+
+	spin_lock_irqsave(&adap->q_lock, flags);
+	if (kref_put(&entry->usecount, i2c_op_release)) {
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
+	} else
+		spin_unlock_irqrestore(&adap->q_lock, flags);
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
@@ -1346,6 +1437,7 @@
 EXPORT_SYMBOL(i2c_clients_command);
 EXPORT_SYMBOL(i2c_check_addr);
 
+EXPORT_SYMBOL(i2c_op_done);
 EXPORT_SYMBOL(i2c_master_send);
 EXPORT_SYMBOL(i2c_master_recv);
 EXPORT_SYMBOL(i2c_control);
Index: linux-2.6.11-rc5-mm1/include/linux/i2c.h
===================================================================
--- linux-2.6.11-rc5-mm1.orig/include/linux/i2c.h
+++ linux-2.6.11-rc5-mm1/include/linux/i2c.h
@@ -34,6 +34,8 @@
 #include <linux/device.h>	/* for struct device */
 #include <linux/completion.h>
 #include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
@@ -182,6 +184,33 @@
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
@@ -229,6 +258,9 @@
 	int (*client_unregister)(struct i2c_client *);
 
 	/* data fields that are valid for all devices	*/
+	struct list_head q;
+	spinlock_t q_lock;
+
 	struct semaphore bus_lock;
 
 	int timeout;

--------------000003040609010400020705--
