Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVCBUAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVCBUAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVCBUAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:00:21 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:57338 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262443AbVCBT6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:58:53 -0500
Message-ID: <42261AFB.40001@acm.org>
Date: Wed, 02 Mar 2005 13:58:51 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH] Add a non-blocking interface to the I2C code, part 1
Content-Type: multipart/mixed;
 boundary="------------080403010204060606090102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080403010204060606090102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the next try at adding the non-blocking interface to the I2C code,
broken into finer patches and a few problems fixed from the previous
release.
                                                                               
 
The IPMI SMBus driver needs a non-blocking interface; it needs to do
things to the system at times when it cannot schedule, such as at
panic or shutdown time.  This interface lets it perform I2C operations
and for polling.  This also may be useful for systems that put the
RTC out on the SMBus, or other things that may need to be accessed
where running from a task context is not an option, or not simple.
                                                                               
 
Note that the I2C bus driver needs to be changed to support this.  The
old interface to the I2C code is still supported, so no drivers need
to change until they need the new interface.  Currently, only the
i801 driver is updated.

-Corey

--------------080403010204060606090102
Content-Type: text/plain;
 name="i2c_breakup_formatting.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_breakup_formatting.diff"

This patch reorganizes the I2C SMBus formatting code to make it more
suitable for the upcoming non-blocking changes.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc4/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc4/drivers/i2c/i2c-core.c
@@ -606,27 +606,20 @@
 	struct i2c_adapter *adap=client->adapter;
 	struct i2c_msg msg;
 
-	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.len = count;
-		msg.buf = (char *)buf;
+	msg.addr   = client->addr;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.len = count;
+	msg.buf = (char *)buf;
 	
-		dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
-			count);
-	
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
@@ -634,31 +627,25 @@
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
 
 
@@ -1051,31 +1038,135 @@
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
+static int i2c_smbus_complete_entry(struct i2c_adapter * adap, u16 addr,
+				    unsigned short flags, char read_write,
+				    u8 command, int size,
+				    union i2c_smbus_data * data,
+				    int swpec, int partial,
+				    int result)
+{
+	if (result < 0)
+		return result;
+
+	if(swpec &&
+	   size != I2C_SMBUS_QUICK &&
+	   size != I2C_SMBUS_I2C_BLOCK_DATA &&
+	   (read_write == I2C_SMBUS_READ ||
+	    size == I2C_SMBUS_PROC_CALL_PEC ||
+	    size == I2C_SMBUS_BLOCK_PROC_CALL_PEC)) {
+		if(i2c_smbus_check_pec(addr,
+				       command,
+				       size,
+				       partial,
+				       data))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void i2c_smbus_format_entry(struct i2c_adapter * adap, u16 addr,
+				   unsigned short *flags, char read_write,
+				   u8 command, int *size,
+				   union i2c_smbus_data * data,
+				   int *swpec, int *partial)
+{
+	*swpec = 0;
+	*partial = 0;
+	*flags &= I2C_M_TEN | I2C_CLIENT_PEC;
+	if((*flags & I2C_CLIENT_PEC) &&
+	   !(i2c_check_functionality(adap, I2C_FUNC_SMBUS_HWPEC_CALC))) {
+		*swpec = 1;
+		if(read_write == I2C_SMBUS_READ &&
+		   *size == I2C_SMBUS_BLOCK_DATA)
+			*size = I2C_SMBUS_BLOCK_DATA_PEC;
+		else if(*size == I2C_SMBUS_PROC_CALL)
+			*size = I2C_SMBUS_PROC_CALL_PEC;
+		else if(*size == I2C_SMBUS_BLOCK_PROC_CALL) {
+			unsigned char *sdata = data->block;
+			i2c_smbus_add_pec(addr, command, I2C_SMBUS_BLOCK_DATA,
+					  data);
+			*partial = sdata[sdata[0] + 1];
+			*size = I2C_SMBUS_BLOCK_PROC_CALL_PEC;
+		} else if(read_write == I2C_SMBUS_WRITE &&
+		          *size != I2C_SMBUS_QUICK &&
+		          *size != I2C_SMBUS_I2C_BLOCK_DATA)
+			*size = i2c_smbus_add_pec(addr, command, *size, data);
+	}
+}
+
+static int i2c_smbus_emu_complete(struct i2c_adapter * adap, u16 addr,
+				  unsigned short flags, char read_write,
+				  u8 command, int size, 
+				  union i2c_smbus_data * data,
+				  struct i2c_msg *msg,
+				  int swpec, int partial,
+				  int result)
+{
+	unsigned char *msgbuf0 = msg[0].buf;
+	unsigned char *msgbuf1 = msg[1].buf;
+	int i;
+
+
+	if (result < 0)
+		return result;
+
+	if (read_write != I2C_SMBUS_READ)
+		return result;
+
+	switch(size) {
+	case I2C_SMBUS_BYTE:
+		data->byte = msgbuf0[0];
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		data->byte = msgbuf1[0];
+		break;
+	case I2C_SMBUS_WORD_DATA: 
+	case I2C_SMBUS_PROC_CALL:
+		data->word = msgbuf1[0]|(msgbuf1[1] << 8);
+		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		/* fixed at 32 for now */
+		data->block[0] = I2C_SMBUS_I2C_BLOCK_MAX;
+		for (i = 0; i < I2C_SMBUS_I2C_BLOCK_MAX; i++)
+			data->block[i+1] = msgbuf1[i];
+		break;
+	}
+
+	return i2c_smbus_complete_entry(adap, addr, flags,
+					read_write, command,
+					size, data, swpec, partial, result);
+}
+
+static int i2c_smbus_emu_format(struct i2c_adapter *adap, u16 addr,
+				unsigned short flags, char read_write,
+				u8 command, int size, 
+				union i2c_smbus_data * data,
+				struct i2c_msg *msg)
+{
+	/* So we need to generate a series of msgs. In the case of
+	   writing, we need to use only one message; when reading, we
+	   need two. We initialize most things with sane defaults, to
+	   keep the code below somewhat simpler. */
+	unsigned char *msgbuf0 = msg[0].buf;
 	int num = read_write == I2C_SMBUS_READ?2:1;
-	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 }, 
-	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
-	                        };
 	int i;
 
+	msg[0].addr = addr;
+	msg[0].flags = flags;
+	msg[0].len = 1;
+	msg[1].addr = addr;
+	msg[1].flags = flags | I2C_M_RD;
+	msg[1].len = 0;
+
 	msgbuf0[0] = command;
 	switch(size) {
 	case I2C_SMBUS_QUICK:
 		msg[0].len = 0;
 		/* Special case: The read/write field is used as data */
-		msg[0].flags = flags | (read_write==I2C_SMBUS_READ)?I2C_M_RD:0;
+		msg[0].flags = (flags |
+				((read_write==I2C_SMBUS_READ)
+				 ? I2C_M_RD : 0));
 		num = 1;
 		break;
 	case I2C_SMBUS_BYTE:
@@ -1113,13 +1204,14 @@
 	case I2C_SMBUS_BLOCK_DATA:
 	case I2C_SMBUS_BLOCK_DATA_PEC:
 		if (read_write == I2C_SMBUS_READ) {
-			dev_err(&adapter->dev, "Block read not supported "
+			dev_err(&adap->dev, "Block read not supported "
 			       "under I2C emulation!\n");
 			return -1;
 		} else {
 			msg[0].len = data->block[0] + 2;
 			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
-				dev_err(&adapter->dev, "smbus_access called with "
+				dev_err(&adap->dev,
+					"smbus_access called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
 				return -1;
@@ -1132,7 +1224,7 @@
 		break;
 	case I2C_SMBUS_BLOCK_PROC_CALL:
 	case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-		dev_dbg(&adapter->dev, "Block process call not supported "
+		dev_dbg(&adap->dev, "Block process call not supported "
 		       "under I2C emulation!\n");
 		return -1;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
@@ -1141,7 +1233,8 @@
 		} else {
 			msg[0].len = data->block[0] + 1;
 			if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 1) {
-				dev_err(&adapter->dev, "i2c_smbus_xfer_emulated called with "
+				dev_err(&adap->dev,
+					"i2c_smbus_xfer_emulated called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
 				return -1;
@@ -1151,84 +1244,61 @@
 		}
 		break;
 	default:
-		dev_err(&adapter->dev, "smbus_access called with invalid size (%d)\n",
+		dev_err(&adap->dev,
+			"smbus_access called with invalid size (%d)\n",
 		       size);
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
+	struct i2c_algorithm  *algo = adap->algo;
+	int                   result;
+	int                   swpec, partial;
+
+
+	i2c_smbus_format_entry(adap, addr, &flags,
+			       read_write, command,
+			       &size, data, &swpec, &partial);
+
+	if (algo->smbus_xfer) {
+		down(&adap->bus_lock);
+		result = adap->algo->smbus_xfer(adap, addr, flags,
+						read_write, command,
+						size, data);
+		up(&adap->bus_lock);
+		result = i2c_smbus_complete_entry(adap, addr, flags,
+						  read_write, command,
+						  size, data, swpec, partial,
+						  result);
+	} else {
+		unsigned char msgbuf0[34];
+		unsigned char msgbuf1[34];
+		struct i2c_msg msg[2];
+
+		msg[0].buf = msgbuf0;
+		msg[1].buf = msgbuf1;
+		if (i2c_smbus_emu_format(adap, addr, flags,
+					 read_write, command,
+					 size, data, msg))
+			result = -EINVAL;
+		else {
+			result = i2c_transfer(adap, msg, 2);
+			result = i2c_smbus_emu_complete(adap, addr, flags,
+							read_write, command,
+							size, data, msg,
+							swpec, partial,
+							result);
+		}
 	}
-	return res;
-}
 
+	return result;
+}
 
 /* You should always define `functionality'; the 'else' is just for
    backward compatibility. */ 

--------------080403010204060606090102--
