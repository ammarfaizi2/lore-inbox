Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUDCRLl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 12:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbUDCRLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 12:11:40 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:34820 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261680AbUDCRKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 12:10:15 -0500
Date: Sat, 3 Apr 2004 19:10:23 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC 2.6] Rework memory allocation in i2c chip drivers
Message-Id: <20040403191023.08f60ff1.khali@linux-fr.org>
Reply-To: sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, hi all,

Some times ago, Ralf Roesch reported that the memory allocation scheme
used in the i2c eeprom driver was causing trouble on MIPS architecture:

http://archives.andrew.net.au/lm-sensors/msg07233.html

The cause of the problems is that we do allocate two structures with a
single kmalloc, which breaks alignment. This doesn't seem to be a
problem on x86, but is on mips and probably on other architectures as
well. It happens that all other chip drivers work the same way too, so
they all would need to be fixed.

Here comes my proposal to fix the problem. A few notes:

1* The patch is against 2.6.5-rc3-mm4. Greg, I'd like to know the status
of two patches that are pending: swap_bytes and pcf8591. Since they are
not part of 2.6.5-rc3-mm4, my proposal ignores them, but I'll update it
if needed.

2* The problem being the same for all the drivers, the fix is the same
too.

3* However, it87 and via686a had bugs in the error paths (as far as I
could say) so I fixed them too.

4* Contrary to the patch I proposed for the lm_sensors CVS repository,
this one is meant to minimize the changes. I avoided renaming labels
most of the time (new labels have a "B" appended when necessary), so the
patch is both less error-prone and more readable.

Tested on w83781d and lm90 drivers, work for me.

Thanks.

diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/adm1021.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/adm1021.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/adm1021.c	Sat Apr  3 12:02:31 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/adm1021.c	Sat Apr  3 14:12:44 2004
@@ -228,16 +228,18 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access adm1021_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct adm1021_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto error0;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct adm1021_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto error0b;
+	}
+	memset(data, 0x00, sizeof(struct adm1021_data));
 
-	data = (struct adm1021_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -329,6 +331,8 @@
 	return 0;
 
 error1:
+	kfree(data);
+error0b:
 	kfree(new_client);
 error0:
 	return err;
@@ -352,6 +356,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/asb100.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/asb100.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/asb100.c	Sat Apr  3 12:02:31 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/asb100.c	Sat Apr  3 14:04:46 2004
@@ -722,17 +722,20 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access asb100_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-			sizeof(struct asb100_data), GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		pr_debug("asb100.o: detect failed, kmalloc failed!\n");
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(new_client, 0, sizeof(struct i2c_client));
 
-	memset(new_client, 0,
-		sizeof(struct i2c_client) + sizeof(struct asb100_data));
+	if (!(data = kmalloc(sizeof(struct asb100_data), GFP_KERNEL))) {
+		pr_debug("asb100.o: detect failed, kmalloc failed!\n");
+		err = -ENOMEM;
+		goto ERROR0B;
+	}
+	memset(data, 0, sizeof(struct asb100_data));
 
-	data = (struct asb100_data *) (new_client + 1);
 	init_MUTEX(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
@@ -842,6 +845,8 @@
 ERROR2:
 	i2c_detach_client(new_client);
 ERROR1:
+	kfree(data);
+ERROR0B:
 	kfree(new_client);
 ERROR0:
 	return err;
@@ -857,6 +862,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 
 	return 0;
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/ds1621.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/ds1621.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/ds1621.c	Sat Apr  3 12:01:38 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/ds1621.c	Sat Apr  3 14:06:40 2004
@@ -202,16 +202,18 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access ds1621_{read,write}_value. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct ds1621_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0, sizeof(struct i2c_client) +
-	       sizeof(struct ds1621_data));
+	memset(new_client, 0, sizeof(struct i2c_client));
+	
+	if (!(data = kmalloc(sizeof(struct ds1621_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_free1;
+	}
+	memset(data, 0, sizeof(struct ds1621_data));
 	
-	data = (struct ds1621_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -264,6 +266,8 @@
 /* OK, this is not exactly good programming practice, usually. But it is
    very code-efficient in this case. */
       exit_free:
+	kfree(data);
+      exit_free1:
 	kfree(new_client);
       exit:
 	return err;
@@ -279,6 +283,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 
 	return 0;
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/eeprom.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/eeprom.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/eeprom.c	Sat Apr  3 12:02:31 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/eeprom.c	Sat Apr  3 14:06:39 2004
@@ -187,16 +187,18 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access eeprom_{read,write}_value. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct eeprom_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct eeprom_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_kfree1;
+	}
+	memset(data, 0x00, sizeof(struct eeprom_data));
 
-	data = (struct eeprom_data *) (new_client + 1);
 	memset(data->data, 0xff, EEPROM_SIZE);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
@@ -244,6 +246,8 @@
 	return 0;
 
 exit_kfree:
+	kfree(data);
+exit_kfree1:
 	kfree(new_client);
 exit:
 	return err;
@@ -259,6 +263,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 
 	return 0;
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/fscher.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/fscher.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/fscher.c	Sat Apr  3 12:01:38 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/fscher.c	Sat Apr  3 14:06:39 2004
@@ -309,17 +309,18 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	 * client structure, even though we cannot fill it completely yet.
 	 * But it allows us to access i2c_smbus_read_byte_data. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-	    sizeof(struct fscher_data), GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
   	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	       sizeof(struct fscher_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct fscher_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_free1;
+  	}
+	memset(data, 0x00, sizeof(struct fscher_data));
 
-	/* The Hermes-specific data is placed right after the common I2C
-	 * client data. */
-	data = (struct fscher_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -371,6 +372,8 @@
 	return 0;
 
 exit_free:
+	kfree(data);
+exit_free1:
 	kfree(new_client);
 exit:
 	return err;
@@ -386,6 +389,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/gl518sm.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/gl518sm.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/gl518sm.c	Sat Apr  3 12:01:38 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/gl518sm.c	Sat Apr  3 14:06:38 2004
@@ -354,16 +354,18 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access gl518_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct gl518_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-		sizeof(struct gl518_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct gl518_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_free1;
+	}
+	memset(data, 0x00, sizeof(struct gl518_data));
 
-	data = (struct gl518_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 
 	new_client->addr = address;
@@ -445,6 +447,8 @@
    very code-efficient in this case. */
 
 exit_free:
+	kfree(data);
+exit_free1:
 	kfree(new_client);
 exit:
 	return err;
@@ -479,6 +483,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 
 	return 0;
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/it87.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/it87.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/it87.c	Sat Apr  3 12:01:39 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/it87.c	Sat Apr  3 14:06:36 2004
@@ -545,7 +545,7 @@
 			outb_p(~i & 0x7f, address + 5);
 			if ((inb_p(address + 5) & 0x7f) != (~i & 0x7f)) {
 				outb_p(i, address + 5);
-				return 0;
+				goto ERROR1;
 			}
 		}
 	}
@@ -554,16 +554,18 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access it87_{read,write}_value. */
 
-	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
-					sizeof(struct it87_data),
-					GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct it87_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct it87_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR2;
+	}
+	memset(data, 0x00, sizeof(struct it87_data));
 
-	data = (struct it87_data *) (new_client + 1);
 	if (is_isa)
 		init_MUTEX(&data->lock);
 	i2c_set_clientdata(new_client, data);
@@ -576,10 +578,10 @@
 
 	if (kind < 0) {
 		if (it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
-			goto ERROR1;
+			goto ERROR3;
 		if (!is_isa
-			&& (it87_read_value(new_client, IT87_REG_I2C_ADDR) !=
-			address)) goto ERROR1;
+		 && it87_read_value(new_client, IT87_REG_I2C_ADDR) != address)
+			goto ERROR3;
 	}
 
 	/* Determine the chip type. */
@@ -594,7 +596,7 @@
 					"Ignoring 'force' parameter for unknown chip at "
 					"adapter %d, address 0x%02x\n",
 					i2c_adapter_id(adapter), address);
-			goto ERROR1;
+			goto ERROR3;
 		}
 	}
 
@@ -613,7 +615,7 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto ERROR1;
+		goto ERROR3;
 
 	/* Initialize the IT87 chip */
 	it87_init_client(new_client, data);
@@ -669,9 +671,13 @@
 
 	return 0;
 
-ERROR1:
+ERROR3:
+	kfree(data);
+
+ERROR2:
 	kfree(new_client);
 
+ERROR1:
 	if (is_isa)
 		release_region(address, IT87_EXTENT);
 ERROR0:
@@ -690,6 +696,7 @@
 
 	if(i2c_is_isa_client(client))
 		release_region(client->addr, IT87_EXTENT);
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 
 	return 0;
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm75.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm75.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm75.c	Sat Apr  3 12:01:39 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm75.c	Sat Apr  3 14:06:36 2004
@@ -135,16 +135,18 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm75_{read,write}_value. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct lm75_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct lm75_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_free1;
+	}
+	memset(data, 0x00, sizeof(struct lm75_data));
 
-	data = (struct lm75_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -194,6 +196,8 @@
 	return 0;
 
 exit_free:
+	kfree(data);
+exit_free1:
 	kfree(new_client);
 exit:
 	return err;
@@ -202,6 +206,7 @@
 static int lm75_detach_client(struct i2c_client *client)
 {
 	i2c_detach_client(client);
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm78.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm78.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm78.c	Sat Apr  3 12:02:31 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm78.c	Sat Apr  3 14:06:34 2004
@@ -552,16 +552,18 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm78_{read,write}_value. */
 
-	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
-				   sizeof(struct lm78_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(new_client, 0, sizeof(struct i2c_client) + 
-			      sizeof(struct lm78_data));
+	memset(new_client, 0, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct lm78_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR1B;
+	}
+	memset(data, 0, sizeof(struct lm78_data));
 
-	data = (struct lm78_data *) (new_client + 1);
 	if (is_isa)
 		init_MUTEX(&data->lock);
 	i2c_set_clientdata(new_client, data);
@@ -671,6 +673,8 @@
 	return 0;
 
 ERROR2:
+	kfree(data);
+ERROR1B:
 	kfree(new_client);
 ERROR1:
 	if (is_isa)
@@ -694,6 +698,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 
 	return 0;
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm80.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm80.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm80.c	Sat Apr  3 12:01:39 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm80.c	Sat Apr  3 14:06:34 2004
@@ -357,15 +357,18 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm80_{read,write}_value. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-	    sizeof(struct lm80_data), GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	       sizeof(struct lm80_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct lm80_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto error_free1;
+	}
+	memset(data, 0x00, sizeof(struct lm80_data));
 
-	data = (struct lm80_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -439,6 +442,8 @@
 	return 0;
 
 error_free:
+	kfree(data);
+error_free1:
 	kfree(new_client);
 exit:
 	return err;
@@ -454,6 +459,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm83.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm83.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm83.c	Sat Apr  3 12:01:39 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm83.c	Sat Apr  3 14:06:33 2004
@@ -234,17 +234,18 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-	    sizeof(struct lm83_data), GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	    sizeof(struct lm83_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct lm83_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_free1;
+	}
+	memset(data, 0x00, sizeof(struct lm83_data));
 
-	/* The LM83-specific data is placed right after the common I2C
-	 * client data. */
-	data = (struct lm83_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -329,6 +330,8 @@
 	return 0;
 
 exit_free:
+	kfree(data);
+exit_free1:
 	kfree(new_client);
 exit:
 	return err;
@@ -344,6 +347,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm85.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm85.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm85.c	Sat Apr  3 12:01:39 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm85.c	Sat Apr  3 14:06:32 2004
@@ -736,16 +736,18 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm85_{read,write}_value. */
 
-	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
-				    sizeof(struct lm85_data),
-				    GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(new_client, 0, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct lm85_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR0B;
+	}
+	memset(data, 0, sizeof(struct lm85_data));
 
-	memset(new_client, 0, sizeof(struct i2c_client) +
-			      sizeof(struct lm85_data));
-	data = (struct lm85_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -886,6 +888,8 @@
 
 	/* Error out and cleanup code */
     ERROR1:
+	kfree(data);
+    ERROR0B:
 	kfree(new_client);
     ERROR0:
 	return err;
@@ -894,6 +898,7 @@
 int lm85_detach_client(struct i2c_client *client)
 {
 	i2c_detach_client(client);
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm90.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm90.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/lm90.c	Sat Apr  3 12:01:39 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm90.c	Sat Apr  3 14:06:31 2004
@@ -280,17 +280,18 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-	    sizeof(struct lm90_data), GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	       sizeof(struct lm90_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct lm90_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_free1;
+	}
+	memset(data, 0x00, sizeof(struct lm90_data));
 
-	/* The LM90-specific data is placed right after the common I2C
-	 * client data. */
-	data = (struct lm90_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -390,6 +391,8 @@
 	return 0;
 
 exit_free:
+	kfree(data);
+exit_free1:
 	kfree(new_client);
 exit:
 	return err;
@@ -420,6 +423,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/pcf8574.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/pcf8574.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/pcf8574.c	Sat Apr  3 12:02:31 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/pcf8574.c	Sat Apr  3 14:06:30 2004
@@ -127,17 +127,18 @@
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct pcf8574_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
+	memset(new_client, 0, sizeof(struct i2c_client));
 
-	memset(new_client, 0, sizeof(struct i2c_client) +
-	       sizeof(struct pcf8574_data));
+	if (!(data = kmalloc(sizeof(struct pcf8574_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_free1;
+	}
+	memset(data, 0, sizeof(struct pcf8574_data));
 
-	data = (struct pcf8574_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -182,6 +183,8 @@
    very code-efficient in this case. */
 
       exit_free:
+	kfree(data);
+      exit_free1:
 	kfree(new_client);
       exit:
 	return err;
@@ -197,6 +200,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/via686a.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/via686a.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/via686a.c	Sat Apr  3 12:02:31 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/via686a.c	Sat Apr  3 14:06:29 2004
@@ -687,16 +687,18 @@
 		return -ENODEV;
 	}
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct via686a_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client));
+
+	if (!(data = kmalloc(sizeof(struct via686a_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR1;
+	}
+	memset(data, 0x00, sizeof(struct via686a_data));
 
-	memset(new_client,0x00, sizeof(struct i2c_client) +
-				sizeof(struct via686a_data));
-	data = (struct via686a_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -752,9 +754,11 @@
 	return 0;
 
       ERROR3:
-	release_region(address, VIA686A_EXTENT);
+	kfree(data);
+      ERROR1:
 	kfree(new_client);
       ERROR0:
+	release_region(address, VIA686A_EXTENT);
 	return err;
 }
 
@@ -769,6 +773,7 @@
 	}
 
 	release_region(client->addr, VIA686A_EXTENT);
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 
 	return 0;
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/w83627hf.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/w83627hf.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/w83627hf.c	Sat Apr  3 12:02:31 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/w83627hf.c	Sat Apr  3 14:06:22 2004
@@ -941,17 +941,18 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83627hf_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct w83627hf_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client));
 
-	memset(new_client, 0x00, sizeof (struct i2c_client) +
-	       sizeof (struct w83627hf_data));
+	if (!(data = kmalloc(sizeof(struct w83627hf_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR1B;
+	}
+	memset(data, 0x00, sizeof (struct w83627hf_data));
 
-	data = (struct w83627hf_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	init_MUTEX(&data->lock);
@@ -1042,6 +1043,8 @@
 	return 0;
 
       ERROR2:
+	kfree(data);
+      ERROR1B:
 	kfree(new_client);
       ERROR1:
 	release_region(address, WINB_EXTENT);
@@ -1060,6 +1063,7 @@
 	}
 
 	release_region(client->addr, WINB_EXTENT);
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 
 	return 0;
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/w83781d.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/w83781d.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/w83781d.c	Sat Apr  3 12:02:31 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/w83781d.c	Sat Apr  3 14:06:21 2004
@@ -1117,16 +1117,18 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83781d_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof (struct i2c_client) +
-				   sizeof (struct w83781d_data), GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client));
 
-	memset(new_client, 0x00, sizeof (struct i2c_client) +
-	       sizeof (struct w83781d_data));
+	if (!(data = kmalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR1B;
+	}
+	memset(data, 0x00, sizeof (struct w83781d_data));
 
-	data = (struct w83781d_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	init_MUTEX(&data->lock);
@@ -1326,6 +1328,8 @@
 ERROR3:
 	i2c_detach_client(new_client);
 ERROR2:
+	kfree(data);
+ERROR1B:
 	kfree(new_client);
 ERROR1:
 	if (is_isa)
@@ -1348,6 +1352,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 
 	return 0;
diff -ru linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/w83l785ts.c linux-2.6.5-rc3-mm4/drivers/i2c/chips/w83l785ts.c
--- linux-2.6.5-rc3-mm4/drivers/i2c/chips.orig/w83l785ts.c	Sat Apr  3 12:01:39 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/w83l785ts.c	Sat Apr  3 14:06:20 2004
@@ -164,18 +164,18 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +  
-		sizeof(struct w83l785ts_data), GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-	       sizeof(struct w83l785ts_data));
+	memset(new_client, 0x00, sizeof(struct i2c_client));
 
+	if (!(data = kmalloc(sizeof(struct w83l785ts_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_free1;
+	}
+	memset(data, 0x00, sizeof(struct w83l785ts_data));
 
-	/* The W83L785TS-specific data is placed right after the common I2C
-	 * client data. */
-	data = (struct w83l785ts_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -255,6 +255,8 @@
 	return 0;
 
 exit_free:
+	kfree(data);
+exit_free1:
 	kfree(new_client);
 exit:
 	return err;
@@ -270,6 +272,7 @@
 		return err;
 	}
 
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
