Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVBXXcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVBXXcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVBXXcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:32:31 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:27063 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262556AbVBXX1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:27:30 -0500
Message-ID: <421E62DD.5030608@acm.org>
Date: Thu, 24 Feb 2005 17:27:25 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] I2C patch 2 - break up the SMBus formatting
Content-Type: multipart/mixed;
 boundary="------------080809050005040100080008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080809050005040100080008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is one in a series of patches for adding a non-blocking interface 
to the I2C driver for supporting the IPMI SMBus driver.

--------------080809050005040100080008
Content-Type: text/plain;
 name="i2c_breakup_formatting.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_breakup_formatting.diff"

This patch reorganizes the formatting code to  make it more
suitable for the upcoming non-blocking changes.  It also adds
an op queue entry that is used to pass data around (for now)
and will be used for queueing in the non-blocking case.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc4/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc4/drivers/i2c/i2c-core.c
@@ -583,51 +583,65 @@
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
 	struct i2c_adapter *adap=client->adapter;
 	struct i2c_msg msg;
 
-	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.len = count;
-		msg.buf = (char *)buf;
-	
-		dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
-			count);
+	msg.addr   = client->addr;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.len = count;
+	msg.buf = (char *)buf;
 	
-		down(&adap->bus_lock);
-		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus_lock);
+	dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
+		count);
 
-		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
-		 * transmitted, else error code.
-		 */
-		return (ret == 1 )? count : ret;
-	} else {
-		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
-		return -ENOSYS;
-	}
+	ret = i2c_transfer(adap, &msg, 1);
+
+	/* if everything went ok (i.e. 1 msg transmitted), return #bytes
+	 * transmitted, else error code.
+	 */
+	return (ret == 1 )? count : ret;
 }
 
 int i2c_master_recv(struct i2c_client *client, char *buf ,int count)
@@ -635,31 +649,25 @@
 	struct i2c_adapter *adap=client->adapter;
 	struct i2c_msg msg;
 	int ret;
-	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.flags |= I2C_M_RD;
-		msg.len = count;
-		msg.buf = buf;
 
-		dev_dbg(&client->adapter->dev, "master_recv: reading %d bytes.\n",
-			count);
-	
-		down(&adap->bus_lock);
-		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus_lock);
+	msg.addr   = client->addr;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.flags |= I2C_M_RD;
+	msg.len = count;
+	msg.buf = buf;
+
+	dev_dbg(&client->adapter->dev, "master_recv: reading %d bytes.\n",
+		count);
 	
-		dev_dbg(&client->adapter->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
-			ret, count, client->addr);
+	ret = i2c_transfer(adap, &msg, 1);
+
+	dev_dbg(&client->adapter->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
+		ret, count, client->addr);
 	
-		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
-	 	* transmitted, else error code.
-	 	*/
-		return (ret == 1 )? count : ret;
-	} else {
-		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
-		return -ENOSYS;
-	}
+	/* if everything went ok (i.e. 1 msg transmitted), return #bytes
+	 * transmitted, else error code.
+	 */
+	return (ret == 1 )? count : ret;
 }
 
 
@@ -1052,184 +1060,263 @@
 	}
 }
 
-/* Simulate a SMBus command using the i2c protocol 
-   No checking of parameters is done!  */
-static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr, 
-                                   unsigned short flags,
-                                   char read_write, u8 command, int size, 
-                                   union i2c_smbus_data * data)
-{
-	/* So we need to generate a series of msgs. In the case of writing, we
-	  need to use only one message; when reading, we need two. We initialize
-	  most things with sane defaults, to keep the code below somewhat
-	  simpler. */
-	unsigned char msgbuf0[34];
-	unsigned char msgbuf1[34];
-	int num = read_write == I2C_SMBUS_READ?2:1;
-	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 }, 
-	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
-	                        };
+static void i2c_smbus_complete_entry(struct i2c_adapter * adap,
+				     struct i2c_op_q_entry * entry)
+{
+	if (entry->result < 0)
+		return;
+
+	if(entry->result >= 0 && entry->swpec &&
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
+}
+
+static void i2c_smbus_format_entry(struct i2c_adapter * adap,
+				   struct i2c_op_q_entry * entry)
+{
+	entry->swpec = 0;
+	entry->partial = 0;
+	entry->smbus.flags &= I2C_M_TEN | I2C_CLIENT_PEC;
+	if((entry->smbus.flags & I2C_CLIENT_PEC) &&
+	   !(i2c_check_functionality(adap, I2C_FUNC_SMBUS_HWPEC_CALC))) {
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
+	}
+
+	entry->complete = i2c_smbus_complete_entry;
+}
+
+static void i2c_smbus_emu_complete(struct i2c_adapter * adap,
+				   struct i2c_op_q_entry * entry)
+{
+	unsigned char *msgbuf0 = entry->i2c.msgs[0].buf;
+	unsigned char *msgbuf1 = entry->i2c.msgs[1].buf;
 	int i;
 
-	msgbuf0[0] = command;
-	switch(size) {
+	if (entry->smbus.read_write != I2C_SMBUS_READ)
+		return;
+
+	switch(entry->smbus.size) {
+	case I2C_SMBUS_BYTE:
+		entry->smbus.data->byte = msgbuf0[0];
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		entry->smbus.data->byte = msgbuf1[0];
+		break;
+	case I2C_SMBUS_WORD_DATA: 
+	case I2C_SMBUS_PROC_CALL:
+		entry->smbus.data->word = msgbuf1[0]|(msgbuf1[1] << 8);
+		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		/* fixed at 32 for now */
+		entry->smbus.data->block[0] = I2C_SMBUS_I2C_BLOCK_MAX;
+		for (i = 0; i < I2C_SMBUS_I2C_BLOCK_MAX; i++)
+			entry->smbus.data->block[i+1] = msgbuf1[i];
+		break;
+	}
+
+	entry->xfer_type = I2C_OP_SMBUS;
+	i2c_smbus_complete_entry(adap, entry);
+}
+
+static int i2c_smbus_emu_format(struct i2c_adapter *adap,
+				struct i2c_op_q_entry * entry)
+{
+	/* So we need to generate a series of msgs. In the case of
+	   writing, we need to use only one message; when reading, we
+	   need two. We initialize most things with sane defaults, to
+	   keep the code below somewhat simpler. */
+	unsigned char *msgbuf0 = entry->msgbuf0;
+	unsigned char *msgbuf1 = entry->msgbuf1;
+	int num = entry->smbus.read_write == I2C_SMBUS_READ?2:1;
+	struct i2c_msg *msg = entry->msg;
+	int i;
+
+	entry->i2c.msgs = msg;
+	entry->i2c.msgs[0].buf = msgbuf0;
+	entry->i2c.msgs[1].buf = msgbuf1;
+
+	msg[0].addr = entry->smbus.addr;
+	msg[0].flags = entry->smbus.flags;
+	msg[0].len = 1;
+	msg[1].addr = entry->smbus.addr;
+	msg[1].flags = entry->smbus.flags | I2C_M_RD;
+	msg[1].len = 0;
+
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
-			dev_err(&adapter->dev, "Block read not supported "
+		if (entry->smbus.read_write == I2C_SMBUS_READ) {
+			dev_err(&adap->dev, "Block read not supported "
 			       "under I2C emulation!\n");
 			return -1;
 		} else {
-			msg[0].len = data->block[0] + 2;
+			msg[0].len = entry->smbus.data->block[0] + 2;
 			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
-				dev_err(&adapter->dev, "smbus_access called with "
+				dev_err(&adap->dev,
+					"smbus_access called with "
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
 	case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-		dev_dbg(&adapter->dev, "Block process call not supported "
+		dev_dbg(&adap->dev, "Block process call not supported "
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
-				dev_err(&adapter->dev, "i2c_smbus_xfer_emulated called with "
+				dev_err(&adap->dev,
+					"i2c_smbus_xfer_emulated called with "
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
-		dev_err(&adapter->dev, "smbus_access called with invalid size (%d)\n",
-		       size);
+		dev_err(&adap->dev,
+			"smbus_access called with invalid size (%d)\n",
+		       entry->smbus.size);
 		return -1;
 	}
 
-	if (i2c_transfer(adapter, msg, num) < 0)
-		return -1;
-
-	if (read_write == I2C_SMBUS_READ)
-		switch(size) {
-			case I2C_SMBUS_BYTE:
-				data->byte = msgbuf0[0];
-				break;
-			case I2C_SMBUS_BYTE_DATA:
-				data->byte = msgbuf1[0];
-				break;
-			case I2C_SMBUS_WORD_DATA: 
-			case I2C_SMBUS_PROC_CALL:
-				data->word = msgbuf1[0] | (msgbuf1[1] << 8);
-				break;
-			case I2C_SMBUS_I2C_BLOCK_DATA:
-				/* fixed at 32 for now */
-				data->block[0] = I2C_SMBUS_I2C_BLOCK_MAX;
-				for (i = 0; i < I2C_SMBUS_I2C_BLOCK_MAX; i++)
-					data->block[i+1] = msgbuf1[i];
-				break;
-		}
+	entry->xfer_type = I2C_OP_I2C;
+	entry->i2c.msgs = msg;
+	entry->i2c.num = num;
+	entry->complete = i2c_smbus_emu_complete;
 	return 0;
 }
 
-
-s32 i2c_smbus_xfer(struct i2c_adapter * adapter, u16 addr, unsigned short flags,
+s32 i2c_smbus_xfer(struct i2c_adapter * adap, u16 addr, unsigned short flags,
                    char read_write, u8 command, int size, 
                    union i2c_smbus_data * data)
 {
-	s32 res;
-	int swpec = 0;
-	u8 partial = 0;
-
-	flags &= I2C_M_TEN | I2C_CLIENT_PEC;
-	if((flags & I2C_CLIENT_PEC) &&
-	   !(i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HWPEC_CALC))) {
-		swpec = 1;
-		if(read_write == I2C_SMBUS_READ &&
-		   size == I2C_SMBUS_BLOCK_DATA)
-			size = I2C_SMBUS_BLOCK_DATA_PEC;
-		else if(size == I2C_SMBUS_PROC_CALL)
-			size = I2C_SMBUS_PROC_CALL_PEC;
-		else if(size == I2C_SMBUS_BLOCK_PROC_CALL) {
-			i2c_smbus_add_pec(addr, command,
-		                          I2C_SMBUS_BLOCK_DATA, data);
-			partial = data->block[data->block[0] + 1];
-			size = I2C_SMBUS_BLOCK_PROC_CALL_PEC;
-		} else if(read_write == I2C_SMBUS_WRITE &&
-		          size != I2C_SMBUS_QUICK &&
-		          size != I2C_SMBUS_I2C_BLOCK_DATA)
-			size = i2c_smbus_add_pec(addr, command, size, data);
-	}
-
-	if (adapter->algo->smbus_xfer) {
-		down(&adapter->bus_lock);
-		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
-		                                command,size,data);
-		up(&adapter->bus_lock);
-	} else
-		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
-	                                      command,size,data);
-
-	if(res >= 0 && swpec &&
-	   size != I2C_SMBUS_QUICK && size != I2C_SMBUS_I2C_BLOCK_DATA &&
-	   (read_write == I2C_SMBUS_READ || size == I2C_SMBUS_PROC_CALL_PEC ||
-	    size == I2C_SMBUS_BLOCK_PROC_CALL_PEC)) {
-		if(i2c_smbus_check_pec(addr, command, size, partial, data))
-			return -1;
+	struct i2c_op_q_entry *entry;
+	struct i2c_algorithm  *algo = adap->algo;
+	int                   result;
+
+
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
+	i2c_smbus_format_entry(adap, entry);
+
+	if (algo->smbus_xfer) {
+		down(&adap->bus_lock);
+		entry->result = adap->algo->smbus_xfer(adap,
+						       entry->smbus.addr,
+						       entry->smbus.flags,
+						       entry->smbus.read_write,
+						       entry->smbus.command,
+						       entry->smbus.size,
+						       entry->smbus.data);
+		up(&adap->bus_lock);
+		if (entry->complete)
+		    entry->complete(adap, entry);
+	} else {
+		if (i2c_smbus_emu_format(adap, entry))
+			entry->result = -EINVAL;
+		else
+			i2c_transfer_entry(adap, entry);
 	}
-	return res;
-}
 
+	result = entry->result;
+	kfree(entry);
+	return result;
+}
 
 /* You should always define `functionality'; the 'else' is just for
    backward compatibility. */ 
Index: linux-2.6.11-rc4/include/linux/i2c.h
===================================================================
--- linux-2.6.11-rc4.orig/include/linux/i2c.h
+++ linux-2.6.11-rc4/include/linux/i2c.h
@@ -32,7 +32,9 @@
 #include <linux/types.h>
 #include <linux/i2c-id.h>
 #include <linux/device.h>	/* for struct device */
+#include <linux/completion.h>
 #include <asm/semaphore.h>
+#include <asm/atomic.h>
 
 /* --- General options ------------------------------------------------	*/
 
@@ -43,6 +45,7 @@
 struct i2c_driver;
 struct i2c_client_address_data;
 union i2c_smbus_data;
+struct i2c_op_q_entry;
 
 /*
  * The master routines are the ones normally used to transmit data to devices
@@ -229,7 +232,6 @@
 
 	/* data fields that are valid for all devices	*/
 	struct semaphore bus_lock;
-	struct semaphore clist_lock;
 
 	int timeout;
 	int retries;
@@ -242,6 +244,7 @@
 #endif /* def CONFIG_PROC_FS */
 
 	int nr;
+	struct semaphore clist_lock;
 	struct list_head clients;
 	struct list_head list;
 	char name[I2C_NAME_SIZE];
@@ -395,6 +398,92 @@
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
+	atomic_t usecount;
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

--------------080809050005040100080008--
