Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVCBUJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVCBUJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVCBUIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:08:35 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:46490 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262452AbVCBUC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:02:59 -0500
Message-ID: <42261BF1.4040104@acm.org>
Date: Wed, 02 Mar 2005 14:02:57 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH] Add a non-blocking interface to the I2C code, part 5
Content-Type: multipart/mixed;
 boundary="------------030908010801060003050506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030908010801060003050506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See part 1 for details on what this does...


--------------030908010801060003050506
Content-Type: text/plain;
 name="i2c_add_non_blocking.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_add_non_blocking.diff"

This patch adds a non-blocking interface to the I2C code.  This
is needed by some RTC drivers on the I2C bus and is needed by
the IPMI code so it can do things at panic time.

The non-blocking interface requires changes to the driver
below it.  The current drivers will work as-is, but will not
be able to use the non-blocking interfaces.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc5-mm1.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
@@ -680,7 +680,8 @@
 		return;
 
 	if (sequence_match) {
-		/* Poll will go here. */
+		/* This is the one we expected, call the poll routine. */
+		adap->algo->poll(adap, entry, t->next_call_time);
 
 		if (!entry_completed(entry))
 			i2c_start_timer(adap, entry);
@@ -697,13 +698,102 @@
  * ----------------------------------------------------
  */
 
+/* Must be called with the q_lock held. */
+static void i2c_start_entry(struct i2c_adapter * adap,
+			    struct i2c_op_q_entry * entry)
+{
+	entry->started = 1;
+	switch (entry->xfer_type) {
+	case I2C_OP_I2C:
+		adap->algo->master_start(adap, entry);
+		break;
+	case I2C_OP_SMBUS:
+		adap->algo->smbus_start(adap, entry);
+		break;
+	default:
+		entry->result = -EINVAL;
+		i2c_op_done(adap, entry);
+	}
+
+	if (!entry_completed(entry) && entry->use_timer)
+		i2c_start_timer(adap, entry);
+}
+
+static void i2c_wait_complete(struct i2c_op_q_entry * entry)
+{
+	struct completion *done = entry->handler_data;
+	pr_debug("i2c_wait_complete %p\n", entry);
+	complete(done);
+}
+
+static void i2c_perform_op_wait(struct i2c_adapter * adap,
+				struct i2c_op_q_entry * entry)
+{
+	struct completion    done;
+	unsigned long        flags;
+	struct i2c_algorithm *algo = adap->algo;
+
+	pr_debug("i2c_perform_op_wait %p %p\n", adap, entry);
+	init_completion(&done);
+	entry->start = NULL;
+	entry->handler = i2c_wait_complete;
+	entry->handler_data = &done;
+	entry->started = 0;
+	atomic_set(&entry->completed, 1);
+	entry->result = 0;
+	entry->use_timer = 0; /* We poll it directly. */
+	entry->data = NULL;
+	kref_init(&entry->usecount);
+	spin_lock_irqsave(&adap->q_lock, flags);
+	list_add_tail(&entry->link, &adap->q);
+	if (adap->q.next == &entry->link) {
+		/* Added to the list head, start it */
+		spin_unlock_irqrestore(&adap->q_lock, flags);
+		i2c_start_entry(adap, entry);
+	} else {
+		struct completion start;
+		init_completion(&start);
+		entry->start = &start;
+		spin_unlock_irqrestore(&adap->q_lock, flags);
+
+		wait_for_completion_interruptible(&start);
+
+		spin_lock_irqsave(&adap->q_lock, flags);
+		if (!entry->started) {
+			/* Operation was interrupted.  There
+			   is a race, we can't use the
+			   wait_for_completion return code. */
+			entry->result = -ERESTARTSYS;
+			atomic_set(&entry->completed, 0);
+			list_del(&entry->link);
+		}
+		spin_unlock_irqrestore(&adap->q_lock, flags);
+	}
+
+	/* Once the operation is started, we will not
+	   interrupt it. */
+	while (!entry_completed(entry)) {
+		unsigned int timeout = entry->call_again_us;
+		timeout += (USEC_PER_JIFFIE - 1);
+		timeout /= USEC_PER_JIFFIE;
+		if (timeout == 0)
+			timeout = 1;
+		wait_for_completion_timeout(&done, timeout);
+		if (entry_completed(entry))
+			break;
+		algo->poll(adap, entry, timeout * USEC_PER_JIFFIE);
+	}
+}
+
 static void i2c_transfer_entry(struct i2c_adapter * adap,
 			       struct i2c_op_q_entry * entry)
 {
 	entry->xfer_type = I2C_OP_I2C;
 	entry->complete = NULL;
 	kref_init(&entry->usecount);
-	if (adap->algo->master_xfer) {
+	if (adap->algo->master_start) {
+		i2c_perform_op_wait(adap, entry);
+	} else if (adap->algo->master_xfer) {
  	 	dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n",
 			entry->i2c.num);
 
@@ -1412,7 +1502,9 @@
 
 	i2c_smbus_format_entry(adap, entry);
 
-	if (algo->smbus_xfer) {
+	if (algo->smbus_start) {
+		i2c_perform_op_wait(adap, entry);
+	} else if (algo->smbus_xfer) {
 		down(&adap->bus_lock);
 		entry->result = adap->algo->smbus_xfer(adap,
 						       entry->smbus.addr,
@@ -1436,6 +1528,63 @@
 	return result;
 }
 
+int i2c_non_blocking_capable(struct i2c_adapter *adap)
+{
+	return adap->algo->poll != NULL;
+}
+
+void i2c_poll(struct i2c_client *client,
+	      unsigned int us_since_last_call)
+{
+	struct i2c_adapter *adap = client->adapter;
+	struct i2c_op_q_entry *entry;
+    
+	entry = i2c_entry_get(adap);
+	if (!entry)
+		return;
+	adap->algo->poll(adap, entry, us_since_last_call);
+	i2c_entry_put(adap, entry);
+}
+
+int i2c_non_blocking_op(struct i2c_client *client,
+			struct i2c_op_q_entry *entry)
+{
+	unsigned long      flags;
+	struct i2c_adapter *adap = client->adapter;
+
+	if (!i2c_non_blocking_capable(adap))
+		return -ENOSYS;
+
+	entry->smbus.addr = client->addr;
+	entry->smbus.flags = client->flags;
+
+	if (entry->xfer_type == I2C_OP_SMBUS) {
+		i2c_smbus_format_entry(adap, entry);
+		if (!adap->algo->smbus_start) {
+			if (i2c_smbus_emu_format(adap, entry))
+				return -EINVAL;
+		}
+	}
+
+	entry->start = NULL;
+	entry->started = 0;
+	atomic_set(&entry->completed, 1);
+	entry->result = 0;
+	entry->use_timer = 1; /* Let the timer code poll it. */
+	entry->data = NULL;
+	kref_init(&entry->usecount);
+
+	spin_lock_irqsave(&adap->q_lock, flags);
+	list_add_tail(&entry->link, &adap->q);
+	if (adap->q.next == &entry->link) {
+		/* Added to the list head, start it */
+		spin_unlock_irqrestore(&adap->q_lock, flags);
+		i2c_start_entry(adap, entry);
+	} else
+		spin_unlock_irqrestore(&adap->q_lock, flags);
+	return 0;
+}
+
 /* You should always define `functionality'; the 'else' is just for
    backward compatibility. */ 
 u32 i2c_get_functionality (struct i2c_adapter *adap)
@@ -1513,7 +1662,7 @@
 		entry->handler(entry);
 
 		if (new_entry) {
-			/* start entry will go here. */
+			i2c_start_entry(adap, new_entry);
 			if (new_entry->start)
 				complete(new_entry->start);
 			/* Do tail recursion ourself. */
@@ -1584,6 +1733,10 @@
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
+EXPORT_SYMBOL(i2c_non_blocking_capable);
+EXPORT_SYMBOL(i2c_poll);
+EXPORT_SYMBOL(i2c_non_blocking_op);
+
 EXPORT_SYMBOL(i2c_get_functionality);
 EXPORT_SYMBOL(i2c_check_functionality);
 
Index: linux-2.6.11-rc5-mm1/include/linux/i2c.h
===================================================================
--- linux-2.6.11-rc5-mm1.orig/include/linux/i2c.h
+++ linux-2.6.11-rc5-mm1/include/linux/i2c.h
@@ -102,6 +102,23 @@
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
 
+/* Non-blocking interface.  The user should fill out the public
+   portions of the entry structure.  All data in the entry structure
+   should be guaranteed to be available until the handler callback is
+   called with the entry. */
+extern int i2c_non_blocking_op(struct i2c_client *client,
+			       struct i2c_op_q_entry *entry);
+
+/* Can the adapter do non-blocking operations? */
+extern int i2c_non_blocking_capable(struct i2c_adapter *adap);
+
+/* Poll the i2c interface.  This should only be called in a situation
+   where scheduling and interrupts are off.  You should put the amount
+   of microseconds between calls in us_since_last_call. */
+extern void i2c_poll(struct i2c_client *client,
+		     unsigned int us_since_last_call);
+
+
 /*
  * A driver is capable of handling one or more physical devices present on
  * I2C adapters. This information is used to inform the driver of adapter
@@ -231,6 +248,31 @@
 	                   unsigned short flags, char read_write,
 	                   u8 command, int size, union i2c_smbus_data * data);
 
+	/* These are like the previous calls, but they will only start
+	   the operation.  The poll call will be called periodically
+	   to drive the operation of the bus.  Each of these calls
+	   should set the result on an error, and set the timeout as
+	   necessary.  Note that even interrupt driven drivers need to
+	   poll so they can time out operations.  When the operation
+	   is complete, these should call i2c_op_done().  Note that
+	   all the data structures passed in are guaranteed to be kept
+	   around until the operation completes.  These may be called
+	   from interrupt context.  If the start operation fails, this
+	   should set the result and call i2c_op_done(). */
+	void (*master_start)(struct i2c_adapter    *adap,
+			     struct i2c_op_q_entry *entry);
+	void (*smbus_start)(struct i2c_adapter    *adap,
+			    struct i2c_op_q_entry *entry);
+	/* us_since_last_poll is the amount of time since the last
+	   time poll was called. Note that this may be *less* than the
+	   time you requested, so always use this number and don't
+	   assume it's the one you gave it.  This time is approximate
+	   and is only guaranteed to be >= the time since the last
+	   poll.  The value may be zero. */
+	void (*poll)(struct i2c_adapter *adap,
+		     struct i2c_op_q_entry *entry,
+		     unsigned int us_since_last_poll);
+
 	/* --- these optional/future use for some adapter types.*/
 	int (*slave_send)(struct i2c_adapter *,char*,int);
 	int (*slave_recv)(struct i2c_adapter *,char*,int);

--------------030908010801060003050506--
