Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVCWPmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVCWPmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVCWPmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:42:07 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:19404 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261641AbVCWPhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:37:48 -0500
Message-ID: <42418D47.1070605@acm.org>
Date: Wed, 23 Mar 2005 09:37:43 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH] I2C Part 3 - Add an operation queue data structure
Content-Type: multipart/mixed;
 boundary="------------040509000805090409040405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040509000805090409040405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040509000805090409040405
Content-Type: text/x-patch;
 name="i2c_add_op_q.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_add_op_q.diff"

This patch adds an operation queue structure and converts over the
passing around of data to use the operation queue.  The op queue
entry will be used for queueing in the non-blocking case.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-mm1/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-mm1.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-mm1/drivers/i2c/i2c-core.c
@@ -582,24 +582,45 @@
  * ----------------------------------------------------
  */
 
-int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
+static void i2c_transfer_entry(struct i2c_adapter * adap,
+			       struct i2c_op_q_entry * entry)
 {
-	int ret;
-
+	entry->xfer_type = I2C_OP_I2C;
+	entry->complete = NULL;
 	if (adap->algo->master_xfer) {
- 	 	dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num);
+ 	 	dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n",
+			entry->i2c.num);
 
 		down(&adap->bus_lock);
-		ret = adap->algo->master_xfer(adap,msgs,num);
+		entry->result = adap->algo->master_xfer(adap, entry->i2c.msgs,
+							entry->i2c.num);
 		up(&adap->bus_lock);
-
-		return ret;
+		if (entry->complete)
+		    entry->complete(adap, entry);
 	} else {
 		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
-		return -ENOSYS;
+		entry->result = -ENOSYS;
 	}
 }
 
+int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
+{
+	struct i2c_op_q_entry *entry;
+	int                   rv;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+	    return -ENOMEM;
+
+	entry->i2c.msgs = msgs;
+	entry->i2c.num = num;
+
+	i2c_transfer_entry(adap, entry);
+	rv = entry->result;
+	kfree(entry);
+	return rv;
+}
+
 int i2c_master_send(struct i2c_client *client,const char *buf ,int count)
 {
 	int ret;
@@ -1038,185 +1059,181 @@
 	}
 }
 
-static int i2c_smbus_complete_entry(struct i2c_adapter * adapter, u16 addr,
-				    unsigned short flags, char read_write,
-				    u8 command, int size,
-				    union i2c_smbus_data * data,
-				    int swpec, u8 partial,
-				    int result)
-{
-	if (result < 0)
-		return result;
-
-	if(swpec &&
-	   size != I2C_SMBUS_QUICK &&
-	   size != I2C_SMBUS_I2C_BLOCK_DATA &&
-	   (read_write == I2C_SMBUS_READ ||
-	    size == I2C_SMBUS_PROC_CALL_PEC ||
-	    size == I2C_SMBUS_BLOCK_PROC_CALL_PEC)) {
-		if(i2c_smbus_check_pec(addr,
-				       command,
-				       size,
-				       partial,
-				       data))
-			return -EINVAL;
-	}
+static void i2c_smbus_complete_entry(struct i2c_adapter * adapter,
+				     struct i2c_op_q_entry * entry)
+{
+	if (entry->result < 0)
+		return;
 
-	return 0;
+	if(entry->swpec &&
+	   entry->smbus.size != I2C_SMBUS_QUICK &&
+	   entry->smbus.size != I2C_SMBUS_I2C_BLOCK_DATA &&
+	   (entry->smbus.read_write == I2C_SMBUS_READ ||
+	    entry->smbus.size == I2C_SMBUS_PROC_CALL_PEC ||
+	    entry->smbus.size == I2C_SMBUS_BLOCK_PROC_CALL_PEC)) {
+		if(i2c_smbus_check_pec(entry->smbus.addr,
+				       entry->smbus.command,
+				       entry->smbus.size,
+				       entry->partial,
+				       entry->smbus.data))
+			entry->result = -EINVAL;
+	}
 }
 
-static void i2c_smbus_format_entry(struct i2c_adapter * adapter, u16 addr,
-				   unsigned short *flags, char read_write,
-				   u8 command, int *size,
-				   union i2c_smbus_data * data,
-				   int *swpec, u8 *partial)
-{
-	*swpec = 0;
-	*partial = 0;
-	*flags &= I2C_M_TEN | I2C_CLIENT_PEC;
-	if((*flags & I2C_CLIENT_PEC) &&
+static void i2c_smbus_format_entry(struct i2c_adapter * adapter,
+				   struct i2c_op_q_entry * entry)
+{
+	entry->swpec = 0;
+	entry->partial = 0;
+	entry->smbus.flags &= I2C_M_TEN | I2C_CLIENT_PEC;
+	if((entry->smbus.flags & I2C_CLIENT_PEC) &&
 	   !(i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HWPEC_CALC))) {
-		*swpec = 1;
-		if(read_write == I2C_SMBUS_READ &&
-		   *size == I2C_SMBUS_BLOCK_DATA)
-			*size = I2C_SMBUS_BLOCK_DATA_PEC;
-		else if(*size == I2C_SMBUS_PROC_CALL)
-			*size = I2C_SMBUS_PROC_CALL_PEC;
-		else if(*size == I2C_SMBUS_BLOCK_PROC_CALL) {
-			unsigned char *sdata = data->block;
-			i2c_smbus_add_pec(addr, command, I2C_SMBUS_BLOCK_DATA,
-					  data);
-			*partial = sdata[sdata[0] + 1];
-			*size = I2C_SMBUS_BLOCK_PROC_CALL_PEC;
-		} else if(read_write == I2C_SMBUS_WRITE &&
-		          *size != I2C_SMBUS_QUICK &&
-		          *size != I2C_SMBUS_I2C_BLOCK_DATA)
-			*size = i2c_smbus_add_pec(addr, command, *size, data);
+		entry->swpec = 1;
+		if(entry->smbus.read_write == I2C_SMBUS_READ &&
+		   entry->smbus.size == I2C_SMBUS_BLOCK_DATA)
+			entry->smbus.size = I2C_SMBUS_BLOCK_DATA_PEC;
+		else if(entry->smbus.size == I2C_SMBUS_PROC_CALL)
+			entry->smbus.size = I2C_SMBUS_PROC_CALL_PEC;
+		else if(entry->smbus.size == I2C_SMBUS_BLOCK_PROC_CALL) {
+			unsigned char *data = entry->smbus.data->block;
+			i2c_smbus_add_pec(entry->smbus.addr,
+					  entry->smbus.command,
+		                          I2C_SMBUS_BLOCK_DATA,
+					  entry->smbus.data);
+			entry->partial = data[data[0] + 1];
+			entry->smbus.size = I2C_SMBUS_BLOCK_PROC_CALL_PEC;
+		} else if(entry->smbus.read_write == I2C_SMBUS_WRITE &&
+		          entry->smbus.size != I2C_SMBUS_QUICK &&
+		          entry->smbus.size != I2C_SMBUS_I2C_BLOCK_DATA)
+			entry->smbus.size =
+				i2c_smbus_add_pec(entry->smbus.addr,
+						  entry->smbus.command,
+						  entry->smbus.size,
+						  entry->smbus.data);
 	}
+
+	entry->complete = i2c_smbus_complete_entry;
 }
 
-static int i2c_smbus_emu_complete(struct i2c_adapter * adapter, u16 addr,
-				  unsigned short flags, char read_write,
-				  u8 command, int size, 
-				  union i2c_smbus_data * data,
-				  struct i2c_msg *msg,
-				  int swpec, u8 partial,
-				  int result)
+static void i2c_smbus_emu_complete(struct i2c_adapter * adapter,
+				   struct i2c_op_q_entry * entry)
 {
-	unsigned char *msgbuf0 = msg[0].buf;
-	unsigned char *msgbuf1 = msg[1].buf;
+	unsigned char *msgbuf0 = entry->i2c.msgs[0].buf;
+	unsigned char *msgbuf1 = entry->i2c.msgs[1].buf;
 	int i;
 
+	if (entry->result < 0)
+		return;
 
-	if (result < 0)
-		return result;
+	if (entry->smbus.read_write != I2C_SMBUS_READ)
+		return;
 
-	if (read_write != I2C_SMBUS_READ)
-		return result;
-
-	switch(size) {
+	switch(entry->smbus.size) {
 	case I2C_SMBUS_BYTE:
-		data->byte = msgbuf0[0];
+		entry->smbus.data->byte = msgbuf0[0];
 		break;
 	case I2C_SMBUS_BYTE_DATA:
-		data->byte = msgbuf1[0];
+		entry->smbus.data->byte = msgbuf1[0];
 		break;
 	case I2C_SMBUS_WORD_DATA: 
 	case I2C_SMBUS_PROC_CALL:
-		data->word = msgbuf1[0]|(msgbuf1[1] << 8);
+		entry->smbus.data->word = msgbuf1[0]|(msgbuf1[1] << 8);
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
 		/* fixed at 32 for now */
-		data->block[0] = I2C_SMBUS_I2C_BLOCK_MAX;
+		entry->smbus.data->block[0] = I2C_SMBUS_I2C_BLOCK_MAX;
 		for (i = 0; i < I2C_SMBUS_I2C_BLOCK_MAX; i++)
-			data->block[i+1] = msgbuf1[i];
+			entry->smbus.data->block[i+1] = msgbuf1[i];
 		break;
 	}
 
-	return i2c_smbus_complete_entry(adapter, addr, flags,
-					read_write, command,
-					size, data, swpec, partial, result);
+	entry->xfer_type = I2C_OP_SMBUS;
+	i2c_smbus_complete_entry(adapter, entry);
 }
 
-static int i2c_smbus_emu_format(struct i2c_adapter *adapter, u16 addr,
-				unsigned short flags, char read_write,
-				u8 command, int size, 
-				union i2c_smbus_data * data,
-				struct i2c_msg *msg)
+static int i2c_smbus_emu_format(struct i2c_adapter *adapter,
+				struct i2c_op_q_entry * entry)
 {
 	/* So we need to generate a series of msgs. In the case of
 	   writing, we need to use only one message; when reading, we
 	   need two. We initialize most things with sane defaults, to
 	   keep the code below somewhat simpler. */
-	unsigned char *msgbuf0 = msg[0].buf;
-	int num = read_write == I2C_SMBUS_READ?2:1;
+	unsigned char *msgbuf0 = entry->msgbuf0;
+	int num = entry->smbus.read_write == I2C_SMBUS_READ?2:1;
+	struct i2c_msg *msg = entry->msg;
 	int i;
 
-	msg[0].addr = addr;
-	msg[0].flags = flags;
+	entry->i2c.msgs = msg;
+	entry->i2c.msgs[0].buf = msgbuf0;
+	entry->i2c.msgs[1].buf = entry->msgbuf1;
+
+	msg[0].addr = entry->smbus.addr;
+	msg[0].flags = entry->smbus.flags;
 	msg[0].len = 1;
-	msg[1].addr = addr;
-	msg[1].flags = flags | I2C_M_RD;
+	msg[1].addr = entry->smbus.addr;
+	msg[1].flags = entry->smbus.flags | I2C_M_RD;
 	msg[1].len = 0;
 
-	msgbuf0[0] = command;
-	switch(size) {
+	msgbuf0[0] = entry->smbus.command;
+	switch(entry->smbus.size) {
 	case I2C_SMBUS_QUICK:
 		msg[0].len = 0;
 		/* Special case: The read/write field is used as data */
-		msg[0].flags = flags | (read_write==I2C_SMBUS_READ)?I2C_M_RD:0;
+		msg[0].flags = (entry->smbus.flags |
+				((entry->smbus.read_write==I2C_SMBUS_READ)
+				 ? I2C_M_RD : 0));
 		num = 1;
 		break;
 	case I2C_SMBUS_BYTE:
-		if (read_write == I2C_SMBUS_READ) {
+		if (entry->smbus.read_write == I2C_SMBUS_READ) {
 			/* Special case: only a read! */
-			msg[0].flags = I2C_M_RD | flags;
+			msg[0].flags = I2C_M_RD | entry->smbus.flags;
 			num = 1;
 		}
 		break;
 	case I2C_SMBUS_BYTE_DATA:
-		if (read_write == I2C_SMBUS_READ)
+		if (entry->smbus.read_write == I2C_SMBUS_READ)
 			msg[1].len = 1;
 		else {
 			msg[0].len = 2;
-			msgbuf0[1] = data->byte;
+			msgbuf0[1] = entry->smbus.data->byte;
 		}
 		break;
 	case I2C_SMBUS_WORD_DATA:
-		if (read_write == I2C_SMBUS_READ)
+		if (entry->smbus.read_write == I2C_SMBUS_READ)
 			msg[1].len = 2;
 		else {
 			msg[0].len=3;
-			msgbuf0[1] = data->word & 0xff;
-			msgbuf0[2] = (data->word >> 8) & 0xff;
+			msgbuf0[1] = entry->smbus.data->word & 0xff;
+			msgbuf0[2] = (entry->smbus.data->word >> 8) & 0xff;
 		}
 		break;
 	case I2C_SMBUS_PROC_CALL:
 		num = 2; /* Special case */
-		read_write = I2C_SMBUS_READ;
+		entry->smbus.read_write = I2C_SMBUS_READ;
 		msg[0].len = 3;
 		msg[1].len = 2;
-		msgbuf0[1] = data->word & 0xff;
-		msgbuf0[2] = (data->word >> 8) & 0xff;
+		msgbuf0[1] = entry->smbus.data->word & 0xff;
+		msgbuf0[2] = (entry->smbus.data->word >> 8) & 0xff;
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 	case I2C_SMBUS_BLOCK_DATA_PEC:
-		if (read_write == I2C_SMBUS_READ) {
+		if (entry->smbus.read_write == I2C_SMBUS_READ) {
 			dev_err(&adapter->dev, "Block read not supported "
 			       "under I2C emulation!\n");
 			return -1;
 		} else {
-			msg[0].len = data->block[0] + 2;
+			msg[0].len = entry->smbus.data->block[0] + 2;
 			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
 				dev_err(&adapter->dev, "smbus_access called with "
 				       "invalid block write size (%d)\n",
-				       data->block[0]);
+				       entry->smbus.data->block[0]);
 				return -1;
 			}
-			if(size == I2C_SMBUS_BLOCK_DATA_PEC)
+			if(entry->smbus.size == I2C_SMBUS_BLOCK_DATA_PEC)
 				(msg[0].len)++;
 			for (i = 1; i <= msg[0].len; i++)
-				msgbuf0[i] = data->block[i-1];
+				msgbuf0[i] = entry->smbus.data->block[i-1];
 		}
 		break;
 	case I2C_SMBUS_BLOCK_PROC_CALL:
@@ -1225,26 +1242,30 @@
 		       "under I2C emulation!\n");
 		return -1;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
-		if (read_write == I2C_SMBUS_READ) {
+		if (entry->smbus.read_write == I2C_SMBUS_READ) {
 			msg[1].len = I2C_SMBUS_I2C_BLOCK_MAX;
 		} else {
-			msg[0].len = data->block[0] + 1;
+			msg[0].len = entry->smbus.data->block[0] + 1;
 			if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 1) {
 				dev_err(&adapter->dev, "i2c_smbus_xfer_emulated called with "
 				       "invalid block write size (%d)\n",
-				       data->block[0]);
+				       entry->smbus.data->block[0]);
 				return -1;
 			}
-			for (i = 1; i <= data->block[0]; i++)
-				msgbuf0[i] = data->block[i];
+			for (i = 1; i <= entry->smbus.data->block[0]; i++)
+				msgbuf0[i] = entry->smbus.data->block[i];
 		}
 		break;
 	default:
 		dev_err(&adapter->dev, "smbus_access called with invalid size (%d)\n",
-		       size);
+		       entry->smbus.size);
 		return -1;
 	}
 
+	entry->xfer_type = I2C_OP_I2C;
+	entry->i2c.msgs = msg;
+	entry->i2c.num = num;
+	entry->complete = i2c_smbus_emu_complete;
 	return 0;
 }
 
@@ -1253,46 +1274,42 @@
                    char read_write, u8 command, int size, 
                    union i2c_smbus_data * data)
 {
+	struct i2c_op_q_entry *entry;
 	s32 res;
-	int swpec = 0;
-	u8 partial = 0;
 	struct i2c_algorithm *algo = adapter->algo;
 
 
-	i2c_smbus_format_entry(adapter, addr, &flags,
-			       read_write, command,
-			       &size, data, &swpec, &partial);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+	    return -ENOMEM;
+
+	entry->xfer_type = I2C_OP_SMBUS;
+	entry->smbus.addr = addr;
+	entry->smbus.flags = flags;
+	entry->smbus.read_write = read_write;
+	entry->smbus.command = command;
+	entry->smbus.size = size;
+	entry->smbus.data = data;
+
+	i2c_smbus_format_entry(adapter, entry);
 
 	if (algo->smbus_xfer) {
 		down(&adapter->bus_lock);
-		res = adapter->algo->smbus_xfer(adapter, addr, flags,
-						read_write, command,
-						size, data);
+		entry->result = adapter->algo->smbus_xfer
+		  (adapter, entry->smbus.addr, entry->smbus.flags,
+		   entry->smbus.read_write, entry->smbus.command,
+		   entry->smbus.size, entry->smbus.data);
 		up(&adapter->bus_lock);
-		res = i2c_smbus_complete_entry(adapter, addr, flags,
-					       read_write, command,
-					       size, data, swpec, partial,
-					       res);
+		if (entry->complete)
+		    entry->complete(adapter, entry);
 	} else {
-		unsigned char msgbuf0[34];
-		unsigned char msgbuf1[34];
-		struct i2c_msg msg[2];
-
-		msg[0].buf = msgbuf0;
-		msg[1].buf = msgbuf1;
-		if (i2c_smbus_emu_format(adapter, addr, flags,
-					 read_write, command,
-					 size, data, msg))
-			res = -EINVAL;
-		else {
-			res = i2c_transfer(adapter, msg, 2);
-			res = i2c_smbus_emu_complete(adapter, addr, flags,
-						     read_write, command,
-						     size, data, msg,
-						     swpec, partial,
-						     res);
-		}
+		if (i2c_smbus_emu_format(adapter, entry))
+			entry->result = -EINVAL;
+		else
+			i2c_transfer_entry(adapter, entry);
 	}
+	res = entry->result;
+	kfree(entry);
 	return res;
 }
 
Index: linux-2.6.11-mm1/include/linux/i2c.h
===================================================================
--- linux-2.6.11-mm1.orig/include/linux/i2c.h
+++ linux-2.6.11-mm1/include/linux/i2c.h
@@ -32,7 +32,10 @@
 #include <linux/types.h>
 #include <linux/i2c-id.h>
 #include <linux/device.h>	/* for struct device */
+#include <linux/completion.h>
+#include <linux/kref.h>
 #include <asm/semaphore.h>
+#include <asm/atomic.h>
 
 /* --- General options ------------------------------------------------	*/
 
@@ -43,6 +46,7 @@
 struct i2c_driver;
 struct i2c_client_address_data;
 union i2c_smbus_data;
+struct i2c_op_q_entry;
 
 /*
  * The master routines are the ones normally used to transmit data to devices
@@ -392,6 +396,92 @@
  	__u8 *buf;		/* pointer to msg data			*/
 };
 
+/*
+ * Hold a queue of I2C operations to perform, and used to pass data
+ * around.
+ */
+typedef void (*i2c_op_done_cb)(struct i2c_op_q_entry *entry);
+
+#define I2C_OP_I2C	0
+#define I2C_OP_SMBUS	1
+struct i2c_op_q_entry {
+	/* The result will be set to the result of the operation when
+	   it completes. */
+	s32 result;
+
+	/**************************************************************/
+	/* Public interface.  The user should set these up (and the
+	   proper structure below). */
+	int            xfer_type;
+
+	/* Handler may be called from interrupt context, so be
+	   careful. */
+	i2c_op_done_cb handler;
+	void           *handler_data;
+
+	/* Note that this is not a union because an smbus operation
+	   may be converted into an i2c operation (thus both
+	   structures will be used).  The data in these may be changd
+	   by the driver. */
+	struct {
+		struct i2c_msg *msgs;
+		int num;
+	} i2c;
+	struct {
+		/* Addr and flags are filled in by the non-blocking
+		   send routine that takes a client. */
+		u16 addr;
+		unsigned short flags;
+
+		char read_write;
+		u8 command;
+
+		/* Note that the size is *not* the length of the data.
+		   It is the transaction type, like I2C_SMBUS_QUICK
+		   and the ones after that below.  If this is a block
+		   transaction, the length of the rest of the data is
+		   in the first byte of the data, for both transmit
+		   and receive. */
+		int size;
+		union i2c_smbus_data *data;
+	} smbus;
+
+	/**************************************************************/
+	/* For use by the bus interface.  The bus interface sets the
+	   timeout in microseconds until the next poll operation.
+	   This *must* be set in the start operation.  The time_left
+	   and data can be used for anything the bus interface likes.
+	   data will be set to NULL before being started so the bus
+	   interface can use that to tell if it has been set up
+	   yet. */
+	unsigned int call_again_us;
+	long         time_left;
+	void         *data;
+
+	/**************************************************************/
+	/* Internals */
+	struct list_head  link;
+	struct completion *start;
+	atomic_t          completed;
+	unsigned int      started : 1;
+	unsigned int      use_timer : 1;
+	u8                swpec;
+	u8                partial;
+	void (*complete)(struct i2c_adapter    *adap,
+			 struct i2c_op_q_entry *entry);
+
+	/* It's wierd, but we use a usecount to track if an q entry is
+	   in use and when it should be reported back to the user. */
+	struct kref usecount;
+
+	/* These are here for SMBus emulation over I2C.  I don't like
+	   them taking this much room in the data structure, but they
+	   need to be available in this case. */
+	unsigned char msgbuf0[34];
+	unsigned char msgbuf1[34];
+	struct i2c_msg msg[2];
+};
+
 /* To determine what functionality is present */
 
 #define I2C_FUNC_I2C			0x00000001

--------------040509000805090409040405--
