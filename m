Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVCaWES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVCaWES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVCaWES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:04:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31728 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261977AbVCaWD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:03:56 -0500
Message-ID: <424C73C7.4020400@mvista.com>
Date: Thu, 31 Mar 2005 16:03:51 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] I2C Part 1 - Remove some redundancy from the i2c-core.c
 file
References: <42418B36.5030407@mvista.com> <20050323224430.634e0a75.khali@linux-fr.org>
In-Reply-To: <20050323224430.634e0a75.khali@linux-fr.org>
Content-Type: multipart/mixed;
 boundary="------------010203000002020803000108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------010203000002020803000108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, I have taken some time from suffering (packaging perl modules) to 
get back to this.

Here's a new patch with the debug calls removed, as you requested.

Thanks,

-Corey

Jean Delvare wrote:

>Hi Corey,
>
>  
>
>>Call i2c_transfer() from i2c_master_send() and i2c_master_recv()
>>to avoid the redundant code that was in all three functions.
>>    
>>
>
>I like this. You're right, there is code duplication here, which we can
>get rid of, so let's do so. I'd only have one comments about your patch:
>
>You can get rid of the dev_dbg calls in i2c_master_send() and
>i2c_master_recv() altogether IMHO. I recently updated i2c_transfer() to
>make it more verbose in debug mode [1], so the debug messages in
>i2c_master_send() and i2c_master_recv() are mostly redundant now as far
>as I can see.
>
>[1] http://archives.andrew.net.au/lm-sensors/msg29859.html
>
>Thanks,
>  
>


--------------010203000002020803000108
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
 
 

--------------010203000002020803000108--
