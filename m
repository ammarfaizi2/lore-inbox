Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTFEU6C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTFEUtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:49:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39093 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265132AbTFEUrB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:47:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1054846559915@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.70
In-Reply-To: <10548465592184@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 13:55:59 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1259.3.2, 2003/06/05 12:45:04-07:00, mhoffman@lightlink.com

[PATCH] I2C: more w83781d fixes

This patch fixes the various return values in the w83781d_detect()
error paths.  It also cleans up some formatting here and there.
It should be applied on top of the previous one.

It works for me; same caveat as above w.r.t. ISA.


 drivers/i2c/chips/w83781d.c |   62 +++++++++++++++++++++++++++++++-------------
 1 files changed, 44 insertions(+), 18 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Thu Jun  5 13:50:10 2003
+++ b/drivers/i2c/chips/w83781d.c	Thu Jun  5 13:50:10 2003
@@ -1039,7 +1039,7 @@
 		struct i2c_client *new_client)
 {
 	int i, val1 = 0, id;
-	int err = 0;
+	int err;
 	const char *client_name;
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 
@@ -1058,7 +1058,8 @@
 			    force_subclients[i] > 0x4f) {
 				dev_err(&new_client->dev, "Invalid subclient "
 					"address %d; must be 0x48-0x4f\n",
-			       force_subclients[i]);
+					force_subclients[i]);
+				err = -EINVAL;
 				goto ERROR_SC_1;
 			}
 		}
@@ -1082,6 +1083,7 @@
 			dev_err(&new_client->dev,
 			       "Duplicate addresses 0x%x for subclients.\n",
 			       data->lm75[0].addr);
+			err = -EBUSY;
 			goto ERROR_SC_1;
 		}
 	}
@@ -1119,7 +1121,7 @@
 			break;
 	}
 
-	return err;
+	return 0;
 
 /* Undo inits in case of errors */
 ERROR_SC_2:
@@ -1136,18 +1138,22 @@
 	int i = 0, val1 = 0, val2;
 	struct i2c_client *new_client;
 	struct w83781d_data *data;
-	int err = 0;
+	int err;
 	const char *client_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 	enum vendor { winbond, asus } vendid;
 
 	if (!is_isa
-	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		err = -EINVAL;
 		goto ERROR0;
+	}
 
 	if (is_isa)
-		if (!request_region(address, W83781D_EXTENT, "w83781d"))
+		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
+			err = -EBUSY;
 			goto ERROR0;
+		}
 
 	/* Probe whether there is anything available on this address. Already
 	   done for SMBus clients */
@@ -1155,15 +1161,21 @@
 		if (is_isa) {
 
 #define REALLY_SLOW_IO
-			/* We need the timeouts for at least some LM78-like chips. But only
-			   if we read 'undefined' registers. */
+			/* We need the timeouts for at least some LM78-like
+			   chips. But only if we read 'undefined' registers. */
 			i = inb_p(address + 1);
-			if (inb_p(address + 2) != i)
+			if (inb_p(address + 2) != i) {
+				err = -ENODEV;
 				goto ERROR1;
-			if (inb_p(address + 3) != i)
+			}
+			if (inb_p(address + 3) != i) {
+				err = -ENODEV;
 				goto ERROR1;
-			if (inb_p(address + 7) != i)
+			}
+			if (inb_p(address + 7) != i) {
+				err = -ENODEV;
 				goto ERROR1;
+			}
 #undef REALLY_SLOW_IO
 
 			/* Let's just hope nothing breaks here */
@@ -1171,7 +1183,8 @@
 			outb_p(~i & 0x7f, address + 5);
 			if ((inb_p(address + 5) & 0x7f) != (~i & 0x7f)) {
 				outb_p(i, address + 5);
-				return 0;
+				err = -ENODEV;
+				goto ERROR1;
 			}
 		}
 	}
@@ -1204,8 +1217,10 @@
 	   force_*=... parameter, and the Winbond will be reset to the right
 	   bank. */
 	if (kind < 0) {
-		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80)
+		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80){
+			err = -ENODEV;
 			goto ERROR2;
+		}
 		val1 = w83781d_read_value(new_client, W83781D_REG_BANK);
 		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
 		/* Check for Winbond or Asus ID if in bank 0 */
@@ -1213,14 +1228,19 @@
 		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3)
 		      && (val2 != 0x94))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)
-			 && (val2 != 0x06))))
+			 && (val2 != 0x06)))) {
+			err = -ENODEV;
 			goto ERROR2;
-		/* If Winbond SMBus, check address at 0x48. Asus doesn't support */
+		}
+		/* If Winbond SMBus, check address at 0x48.
+		   Asus doesn't support */
 		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 == 0xa3)) ||
 				  ((val1 & 0x80) && (val2 == 0x5c)))) {
 			if (w83781d_read_value
-			    (new_client, W83781D_REG_I2C_ADDR) != address)
+			    (new_client, W83781D_REG_I2C_ADDR) != address) {
+				err = -ENODEV;
 				goto ERROR2;
+			}
 		}
 	}
 
@@ -1239,8 +1259,11 @@
 			vendid = winbond;
 		else if ((val2 == 0x12) || (val2 == 0x06))
 			vendid = asus;
-		else
+		else {
+			err = -ENODEV;
 			goto ERROR2;
+		}
+
 		/* mask off lower bit, not reliable */
 		val1 =
 		    w83781d_read_value(new_client, W83781D_REG_WCHIPID) & 0xfe;
@@ -1262,6 +1285,7 @@
 				       "Ignoring 'force' parameter for unknown chip at"
 				       "adapter %d, address 0x%02x\n",
 				       i2c_adapter_id(adapter), address);
+			err = -EINVAL;
 			goto ERROR2;
 		}
 	}
@@ -1279,7 +1303,9 @@
 	} else if (kind == w83697hf) {
 		client_name = "W83697HF chip";
 	} else {
-		dev_err(&new_client->dev, "Internal error: unknown kind (%d)?!?", kind);
+		dev_err(&new_client->dev, "Internal error: unknown "
+						"kind (%d)?!?", kind);
+		err = -ENODEV;
 		goto ERROR2;
 	}
 

