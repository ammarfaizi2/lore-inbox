Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVCWPdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVCWPdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVCWPdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:33:17 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:11170 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261629AbVCWPbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:31:18 -0500
Message-ID: <42418BC1.2020608@acm.org>
Date: Wed, 23 Mar 2005 09:31:13 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH] I2C Part 2 - Break up the formatting code into individual
 functions
Content-Type: multipart/mixed;
 boundary="------------000003090907020703050309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000003090907020703050309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------000003090907020703050309
Content-Type: text/x-patch;
 name="i2c_breakup_formatting.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_breakup_formatting.diff"

This patch reorganizes the I2C SMBus formatting code to make it more
suitable for the upcoming non-blocking changes.

The I2C main functions do the following:

 Format the data for transmission
 Send the data to the next layer down for handling
 Clean up the results

The original code did all this in single big function.  This patch
breaks the formatting and cleanup operations into separate functions.
Beyond one big function being ugly, the non-blocking code needs this
because it needs to perform these separately.  When you start the
operation, the non-blocking code needs to do the format then return.
Later on, when the operation is complete, the thread of execution
handling the completion will do the cleanup.

This patch does create some functions with lots of parameters.  That
goes away in a future patch that consolidates the data for an I2C
operation into a single data structure.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-mm1/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-mm1.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-mm1/drivers/i2c/i2c-core.c
@@ -1038,25 +1038,127 @@
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
+static int i2c_smbus_complete_entry(struct i2c_adapter * adapter, u16 addr,
+				    unsigned short flags, char read_write,
+				    u8 command, int size,
+				    union i2c_smbus_data * data,
+				    int swpec, u8 partial,
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
+static void i2c_smbus_format_entry(struct i2c_adapter * adapter, u16 addr,
+				   unsigned short *flags, char read_write,
+				   u8 command, int *size,
+				   union i2c_smbus_data * data,
+				   int *swpec, u8 *partial)
+{
+	*swpec = 0;
+	*partial = 0;
+	*flags &= I2C_M_TEN | I2C_CLIENT_PEC;
+	if((*flags & I2C_CLIENT_PEC) &&
+	   !(i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HWPEC_CALC))) {
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
+static int i2c_smbus_emu_complete(struct i2c_adapter * adapter, u16 addr,
+				  unsigned short flags, char read_write,
+				  u8 command, int size, 
+				  union i2c_smbus_data * data,
+				  struct i2c_msg *msg,
+				  int swpec, u8 partial,
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
+	return i2c_smbus_complete_entry(adapter, addr, flags,
+					read_write, command,
+					size, data, swpec, partial, result);
+}
+
+static int i2c_smbus_emu_format(struct i2c_adapter *adapter, u16 addr,
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
@@ -1143,28 +1245,6 @@
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
 
@@ -1176,42 +1256,42 @@
 	s32 res;
 	int swpec = 0;
 	u8 partial = 0;
+	struct i2c_algorithm *algo = adapter->algo;
 
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
 
-	if (adapter->algo->smbus_xfer) {
+	i2c_smbus_format_entry(adapter, addr, &flags,
+			       read_write, command,
+			       &size, data, &swpec, &partial);
+
+	if (algo->smbus_xfer) {
 		down(&adapter->bus_lock);
-		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
-		                                command,size,data);
+		res = adapter->algo->smbus_xfer(adapter, addr, flags,
+						read_write, command,
+						size, data);
 		up(&adapter->bus_lock);
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
+		res = i2c_smbus_complete_entry(adapter, addr, flags,
+					       read_write, command,
+					       size, data, swpec, partial,
+					       res);
+	} else {
+		unsigned char msgbuf0[34];
+		unsigned char msgbuf1[34];
+		struct i2c_msg msg[2];
+
+		msg[0].buf = msgbuf0;
+		msg[1].buf = msgbuf1;
+		if (i2c_smbus_emu_format(adapter, addr, flags,
+					 read_write, command,
+					 size, data, msg))
+			res = -EINVAL;
+		else {
+			res = i2c_transfer(adapter, msg, 2);
+			res = i2c_smbus_emu_complete(adapter, addr, flags,
+						     read_write, command,
+						     size, data, msg,
+						     swpec, partial,
+						     res);
+		}
 	}
 	return res;
 }

--------------000003090907020703050309--
