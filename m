Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbTCYB35>; Mon, 24 Mar 2003 20:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbTCYB3b>; Mon, 24 Mar 2003 20:29:31 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:19984 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261331AbTCYB2F>;
	Mon, 24 Mar 2003 20:28:05 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <1048556321143@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563223599@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.357.6, 2003/03/21 16:16:01-08:00, greg@kroah.com

i2c: Removed the name variable from i2c_client as the dev one should be used instead.


 drivers/i2c/chips/adm1021.c |    2 +-
 drivers/i2c/chips/lm75.c    |    2 +-
 drivers/i2c/i2c-core.c      |   14 +++++++-------
 drivers/i2c/i2c-dev.c       |    4 +++-
 include/linux/i2c.h         |    1 -
 5 files changed, 12 insertions(+), 11 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Mar 24 17:28:07 2003
+++ b/drivers/i2c/chips/adm1021.c	Mon Mar 24 17:28:07 2003
@@ -299,7 +299,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strcpy(new_client->name, client_name);
+	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	new_client->id = adm1021_id++;
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Mon Mar 24 17:28:07 2003
+++ b/drivers/i2c/chips/lm75.c	Mon Mar 24 17:28:07 2003
@@ -180,7 +180,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strcpy(new_client->name, client_name);
+	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 
 	new_client->id = lm75_id++;
 	data->valid = 0;
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 24 17:28:07 2003
+++ b/drivers/i2c/i2c-core.c	Mon Mar 24 17:28:07 2003
@@ -291,9 +291,9 @@
 				    client->driver == driver) {
 					DEB2(printk(KERN_DEBUG "i2c-core.o: "
 						    "detaching client %s:\n",
-					            client->name));
+					            client->dev.name));
 					if ((res = driver->detach_client(client))) {
- 						dev_err(&adap->dev, "while "
+						dev_err(&adap->dev, "while "
 						       "unregistering driver "
 						       "`%s', the client at "
 						       "address %02x of "
@@ -355,7 +355,7 @@
 
 	printk(KERN_WARNING 
 	       " i2c-core.o: attach_client(%s) - enlarge I2C_CLIENT_MAX.\n",
-	       client->name);
+	       client->dev.name);
 
  out_unlock_list:
 	up(&adapter->list);
@@ -374,7 +374,7 @@
 	}
 
 	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter "
-			"(pos. %d).\n", client->name, i));
+			"(pos. %d).\n", client->dev.name, i));
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;
@@ -395,7 +395,7 @@
 		if (res) {
 			printk(KERN_ERR
 			       "i2c-core.o: client_unregister [%s] failed, "
-			       "client not detached", client->name);
+			       "client not detached", client->dev.name);
 			goto out;
 		}
 	}
@@ -410,7 +410,7 @@
 
 	printk(KERN_WARNING
 	       " i2c-core.o: unregister_client [%s] not found\n",
-	       client->name);
+	       client->dev.name);
 	res = -ENODEV;
 
  out_unlock:
@@ -522,7 +522,7 @@
 				client = adapters[i]->clients[order[j]];
 				len += sprintf(kbuf+len,"%02x\t%-32s\t%-32s\n",
 				              client->addr,
-				              client->name,
+				              client->dev.name,
 				              client->driver->name);
 			}
 			len = len - file->f_pos;
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Mar 24 17:28:07 2003
+++ b/drivers/i2c/i2c-dev.c	Mon Mar 24 17:28:07 2003
@@ -86,7 +86,9 @@
 };
 
 static struct i2c_client i2cdev_client_template = {
-	.name		= "I2C /dev entry",
+	.dev		= {
+		.name	= "I2C /dev entry",
+	},
 	.id		= 1,
 	.addr		= -1,
 	.driver		= &i2cdev_driver,
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Mon Mar 24 17:28:07 2003
+++ b/include/linux/i2c.h	Mon Mar 24 17:28:07 2003
@@ -156,7 +156,6 @@
  * function is mainly used for lookup & other admin. functions.
  */
 struct i2c_client {
-	char name[32];
 	int id;
 	unsigned int flags;		/* div., see below		*/
 	unsigned int addr;		/* chip address - NOTE: 7bit 	*/

