Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUCPB0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbUCPBZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:25:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:35503 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262913AbUCPACo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:44 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <107939139416@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:34 -0800
Message-Id: <1079391394926@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.15, 2004/03/15 13:08:51-08:00, khali@linux-fr.org

[PATCH] I2C: Don't handle kind errors that cannot happen

A number of chip drivers in 2.6.4-mm1 try to handle an error case that
cannot happen when setting the chip name. The following patch changes
that.

Affected drivers: adm1021, it87, lm75, lm78, lm85, w83627hf, w83781d.

Note that in any case, the worst that could happen (but then again, it
cannot happen) is that the chip name would be set to an empty string,
which doesn't hurt much.

The patch also cleans up a few things in it87, w83627hf and w83781d,
which are tightly related to the rest of the changes and necessary for
them to be safe.

it87: There is only really one "kind" in this driver, so I removed all
references to other kinds.

w83627hf: The driver did not handle unknown chips.

w83781d: The user shouldn't be allowed to force a kind that doesn't
match the chip's bus type (I2C or ISA). The code was not meant to handle
that case, although no check was done so far.

Tested on my AS99127F, works as intended.


 drivers/i2c/chips/adm1021.c  |    4 ----
 drivers/i2c/chips/it87.c     |   16 ++--------------
 drivers/i2c/chips/lm75.c     |    6 +-----
 drivers/i2c/chips/lm78.c     |    5 -----
 drivers/i2c/chips/lm85.c     |    4 ----
 drivers/i2c/chips/w83627hf.c |   10 +++++-----
 drivers/i2c/chips/w83781d.c  |   26 ++++++++++++++++++--------
 7 files changed, 26 insertions(+), 45 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:34:04 2004
+++ b/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:34:04 2004
@@ -297,10 +297,6 @@
 		type_name = "gl523sm";
 	} else if (kind == mc1066) {
 		type_name = "mc1066";
-	} else {
-		dev_err(&adapter->dev, "Internal error: unknown kind (%d)?!?",
-			kind);
-		goto error1;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Mar 15 14:34:04 2004
+++ b/drivers/i2c/chips/it87.c	Mon Mar 15 14:34:04 2004
@@ -47,7 +47,7 @@
 static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_4(it87, it8705, it8712, sis950);
+SENSORS_INSMOD_1(it87);
 
 
 /* Update battery voltage after every reading if true */
@@ -600,12 +600,6 @@
 
 	if (kind == it87) {
 		name = "it87";
-	} /* else if (kind == it8712) {
-		name = "it8712";
-	} */ else {
-		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
-			kind);
-		goto ERROR1;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
@@ -833,13 +827,7 @@
 		}
 
 		/* The 8705 does not have VID capability */
-		/*if (data->type == it8712) {
-			data->vid = it87_read_value(client, IT87_REG_VID);
-			data->vid &= 0x1f;
-		}
-		else */ {
-			data->vid = 0x1f;
-		}
+		data->vid = 0x1f;
 
 		i = it87_read_value(client, IT87_REG_FAN_DIV);
 		data->fan_div[0] = i & 0x07;
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Mon Mar 15 14:34:04 2004
+++ b/drivers/i2c/chips/lm75.c	Mon Mar 15 14:34:04 2004
@@ -116,7 +116,7 @@
 	struct i2c_client *new_client;
 	struct lm75_data *data;
 	int err = 0;
-	const char *name;
+	const char *name = "";
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
 	   at this moment; i2c_detect really won't call us. */
@@ -170,10 +170,6 @@
 
 	if (kind == lm75) {
 		name = "lm75";
-	} else {
-		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
-			kind);
-		goto exit_free;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Mon Mar 15 14:34:04 2004
+++ b/drivers/i2c/chips/lm78.c	Mon Mar 15 14:34:04 2004
@@ -609,11 +609,6 @@
 		client_name = "lm78-j";
 	} else if (kind == lm79) {
 		client_name = "lm79";
-	} else {
-		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
-			kind);
-		err = -ENODEV;
-		goto ERROR2;
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Mar 15 14:34:04 2004
+++ b/drivers/i2c/chips/lm85.c	Mon Mar 15 14:34:04 2004
@@ -815,10 +815,6 @@
 		type_name = "adm1027";
 	} else if ( kind == adt7463 ) {
 		type_name = "adt7463";
-	} else {
-		dev_dbg(&adapter->dev, "Internal error, invalid kind (%d)!", kind);
-		err = -EFAULT ;
-		goto ERROR1;
 	}
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Mon Mar 15 14:34:04 2004
+++ b/drivers/i2c/chips/w83627hf.c	Mon Mar 15 14:34:04 2004
@@ -923,6 +923,11 @@
 		kind = w83627thf;
 	else if(val == W637_DEVID)
 		kind = w83637hf;
+	else {
+		dev_info(&adapter->dev,
+			 "Unsupported chip (dev_id=0x%02X).\n", val);
+		goto ERROR1;
+	}
 
 	superio_select(W83627HF_LD_HWM);
 	if((val = 0x01 & superio_inb(WINB_ACT_REG)) == 0)
@@ -960,11 +965,6 @@
 		client_name = "w83697hf";
 	} else if (kind == w83637hf) {
 		client_name = "w83637hf";
-	} else {
-		dev_err(&new_client->dev, "Internal error: unknown "
-						"kind (%d)?!?", kind);
-		err = -ENODEV;
-		goto ERROR2;
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:34:04 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:34:04 2004
@@ -966,7 +966,7 @@
 {
 	int i, val1 = 0, id;
 	int err;
-	const char *client_name;
+	const char *client_name = "";
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 
 	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
@@ -1032,8 +1032,6 @@
 		client_name = "w83627hf subclient";
 	else if (kind == as99127f)
 		client_name = "as99127f subclient";
-	else
-		client_name = "unknown subclient?";
 
 	for (i = 0; i <= 1; i++) {
 		/* store all data in w83781d */
@@ -1087,6 +1085,23 @@
 		goto ERROR0;
 	}
 
+	/* Prevent users from forcing a kind for a bus it isn't supposed
+	   to possibly be on */
+	if (is_isa && (kind == as99127f || kind == w83783s)) {
+		dev_err(&adapter->dev,
+			"Cannot force I2C-only chip for ISA address 0x%02x.\n",
+			address);
+		err = -EINVAL;
+		goto ERROR0;
+	}
+	if (!is_isa && kind == w83697hf) {
+		dev_err(&adapter->dev,
+			"Cannot force ISA-only chip for I2C address 0x%02x.\n",
+			address);
+		err = -EINVAL;
+		goto ERROR0;
+	}
+	
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
 			err = -EBUSY;
@@ -1240,11 +1255,6 @@
 		client_name = "as99127f";
 	} else if (kind == w83697hf) {
 		client_name = "w83697hf";
-	} else {
-		dev_err(&new_client->dev, "Internal error: unknown "
-						"kind (%d)?!?", kind);
-		err = -ENODEV;
-		goto ERROR2;
 	}
 
 	/* Fill in the remaining client fields and put into the global list */

