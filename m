Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264525AbTDXXz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTDXXuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:50:40 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:43439 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264549AbTDXXpH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:45:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512287461640@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.68
In-Reply-To: <10512287461373@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:59:06 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1179.3.6, 2003/04/24 10:26:56-07:00, greg@kroah.com

[PATCH] i2c: fix up it87.c check_region mess.


 drivers/i2c/chips/it87.c |   38 ++++++++++++++++----------------------
 1 files changed, 16 insertions(+), 22 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Thu Apr 24 16:46:54 2003
+++ b/drivers/i2c/chips/it87.c	Thu Apr 24 16:46:54 2003
@@ -224,7 +224,6 @@
    allocated. */
 struct it87_data {
 	struct semaphore lock;
-	int sysctl_id;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -533,22 +532,21 @@
 int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
-	struct i2c_client *new_client;
+	struct i2c_client *new_client = NULL;
 	struct it87_data *data;
 	int err = 0;
 	const char *name = "";
 	const char *client_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 
-	if (!is_isa
-	    && !i2c_check_functionality(adapter,
-					I2C_FUNC_SMBUS_BYTE_DATA)) goto
-		    ERROR0;
+	if (!is_isa && 
+	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto ERROR0;
 
-	if (is_isa) {
-		if (check_region(address, IT87_EXTENT))
+	/* Reserve the ISA region */
+	if (is_isa)
+		if (!request_region(address, IT87_EXTENT, name))
 			goto ERROR0;
-	}
 
 	/* Probe whether there is anything available on this address. Already
 	   done for SMBus clients */
@@ -560,11 +558,11 @@
 			   if we read 'undefined' registers. */
 			i = inb_p(address + 1);
 			if (inb_p(address + 2) != i)
-				goto ERROR0;
+				goto ERROR1;
 			if (inb_p(address + 3) != i)
-				goto ERROR0;
+				goto ERROR1;
 			if (inb_p(address + 7) != i)
-				goto ERROR0;
+				goto ERROR1;
 #undef REALLY_SLOW_IO
 
 			/* Let's just hope nothing breaks here */
@@ -585,7 +583,7 @@
 					sizeof(struct it87_data),
 					GFP_KERNEL))) {
 		err = -ENOMEM;
-		goto ERROR0;
+		goto ERROR1;
 	}
 
 	data = (struct it87_data *) (new_client + 1);
@@ -635,10 +633,6 @@
 		goto ERROR1;
 	}
 
-	/* Reserve the ISA region */
-	if (is_isa)
-		request_region(address, IT87_EXTENT, name);
-
 	/* Fill in the remaining client fields and put it into the global list */
 	strncpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
 
@@ -650,7 +644,7 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto ERROR2;
+		goto ERROR1;
 
 	/* register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_in_input0);
@@ -689,12 +683,12 @@
 	it87_init_client(new_client);
 	return 0;
 
-      ERROR2:
+ERROR1:
+	kfree(new_client);
+
 	if (is_isa)
 		release_region(address, IT87_EXTENT);
-      ERROR1:
-	kfree(new_client);
-      ERROR0:
+ERROR0:
 	return err;
 }
 

