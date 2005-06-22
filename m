Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVFVGcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVFVGcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVFVG3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:29:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:28828 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262799AbVFVFWF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:05 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Remove redundancy from i2c-core.c
In-Reply-To: <11194174641612@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:44 -0700
Message-Id: <11194174641478@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Remove redundancy from i2c-core.c

Call i2c_transfer() from i2c_master_send() and i2c_master_recv() to
avoid the redundant code that was in all three functions.  It also
removes unnecessary debug statements as suggested by Jean Delvare.

This is important for the non-blocking interfaces because they will
have to handle a non-blocking interface in this area.  Having it in
one place greatly simplifies the changes.

Signed-off-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 815f55f280fb2781ba1c2a350516b73e55119c60
tree 48c06bd1650d44aa274989ce2696eb5091d3805c
parent 30aedcb33970367e50b5edf373e9cd1a5cebcbe1
author Jean Delvare <khali@linux-fr.org> Sat, 07 May 2005 22:58:46 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:55 -0700

 drivers/i2c/i2c-core.c |   64 +++++++++++++++---------------------------------
 1 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -611,27 +611,16 @@ int i2c_master_send(struct i2c_client *c
 	struct i2c_adapter *adap=client->adapter;
 	struct i2c_msg msg;
 
-	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.len = count;
-		msg.buf = (char *)buf;
+	msg.addr = client->addr;
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
+	/* If everything went ok (i.e. 1 msg transmitted), return #bytes
+	   transmitted, else error code. */
+	return (ret == 1) ? count : ret;
 }
 
 int i2c_master_recv(struct i2c_client *client, char *buf ,int count)
@@ -639,31 +628,18 @@ int i2c_master_recv(struct i2c_client *c
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
+	msg.addr = client->addr;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.flags |= I2C_M_RD;
+	msg.len = count;
+	msg.buf = buf;
+
+	ret = i2c_transfer(adap, &msg, 1);
+
+	/* If everything went ok (i.e. 1 msg transmitted), return #bytes
+	   transmitted, else error code. */
+	return (ret == 1) ? count : ret;
 }
 
 

