Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVCWP36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVCWP36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVCWP3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:29:46 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11508 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261648AbVCWP3S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:29:18 -0500
Message-ID: <42418B36.5030407@mvista.com>
Date: Wed, 23 Mar 2005 09:28:54 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH] I2C Part 1 - Remove some redundancy from the i2c-core.c file
Content-Type: multipart/mixed;
 boundary="------------040206060309040504080807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040206060309040504080807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a series of patches to add a non-blocking interface to the I2C 
driver.  Hopefully it is broken into small enough functional changes.  
I'm not posting the whole series right now, just the first few.

--------------040206060309040504080807
Content-Type: text/x-patch;
 name="i2c_remove_redundant_check.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_remove_redundant_check.diff"

Call i2c_transfer() from i2c_master_send() and i2c_master_recv()
to avoid the redundant code that was in all three functions.

This is important for the non-blocking interfaces because they
will have to handle a non-blocking interface in this area.  Having
it in one place greatly simplifies the changes.

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
 
 

--------------040206060309040504080807--
