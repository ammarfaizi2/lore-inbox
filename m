Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVDFROK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVDFROK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVDFROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:14:10 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:45196 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262231AbVDFRNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:13:21 -0400
Message-ID: <425418AD.6060102@acm.org>
Date: Wed, 06 Apr 2005 12:13:17 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH] Remove redundancy from i2c-core.c
Content-Type: multipart/mixed;
 boundary="------------040102050700030907040701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040102050700030907040701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040102050700030907040701
Content-Type: text/x-patch;
 name="i2c_remove_redundant_check.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_remove_redundant_check.diff"

Call i2c_transfer() from i2c_master_send() and i2c_master_recv()
to avoid the redundant code that was in all three functions.  It
also removes unnecessary debug statements as suggested by Jean
Delvare.

This is important for the non-blocking interfaces because they
will have to handle a non-blocking interface in this area.  Having
it in one place greatly simplifies the changes.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc1/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.12-rc1.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.12-rc1/drivers/i2c/i2c-core.c
@@ -612,27 +612,17 @@
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
-
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
@@ -640,31 +630,19 @@
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
-	
-		dev_dbg(&client->adapter->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
-			ret, count, client->addr);
-	
-		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
-	 	* transmitted, else error code.
-	 	*/
-		return (ret == 1 )? count : ret;
-	} else {
-		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
-		return -ENOSYS;
-	}
+	msg.addr   = client->addr;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.flags |= I2C_M_RD;
+	msg.len = count;
+	msg.buf = buf;
+
+	ret = i2c_transfer(adap, &msg, 1);
+
+	/* if everything went ok (i.e. 1 msg transmitted), return #bytes
+	 * transmitted, else error code.
+	 */
+	return (ret == 1 )? count : ret;
 }
 
 

--------------040102050700030907040701--
