Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263194AbTDCAD7>; Wed, 2 Apr 2003 19:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbTDCADJ>; Wed, 2 Apr 2003 19:03:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:44798 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263207AbTDCACL> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:11 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289582408@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <10493289583037@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:58 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.7, 2003/04/02 11:34:13-08:00, greg@kroah.com

i2c: remove sysctl and proc functions from via686a.c driver

This still needs to be converted to use sysfs files, but due to
lack of hardware, I can not do this.  This change is necessary as
the sysctl and proc interface is about to go away.


 drivers/i2c/chips/via686a.c |   56 +++++++++++++-------------------------------
 1 files changed, 17 insertions(+), 39 deletions(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Wed Apr  2 16:01:14 2003
+++ b/drivers/i2c/chips/via686a.c	Wed Apr  2 16:01:14 2003
@@ -369,8 +369,6 @@
    dynamically allocated, at the same time when a new via686a client is
    allocated. */
 struct via686a_data {
-	int sysctl_id;
-
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -390,8 +388,7 @@
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
 static int via686a_attach_adapter(struct i2c_adapter *adapter);
-static int via686a_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind);
+static int via686a_detect(struct i2c_adapter *adapter, int address, int kind);
 static int via686a_detach_client(struct i2c_client *client);
 
 static int via686a_read_value(struct i2c_client *client, u8 register);
@@ -400,18 +397,6 @@
 static void via686a_update_client(struct i2c_client *client);
 static void via686a_init_client(struct i2c_client *client);
 
-
-static void via686a_in(struct i2c_client *client, int operation,
-		       int ctl_name, int *nrels_mag, long *results);
-static void via686a_fan(struct i2c_client *client, int operation,
-			int ctl_name, int *nrels_mag, long *results);
-static void via686a_temp(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results);
-static void via686a_alarms(struct i2c_client *client, int operation,
-			   int ctl_name, int *nrels_mag, long *results);
-static void via686a_fan_div(struct i2c_client *client, int operation,
-			    int ctl_name, int *nrels_mag, long *results);
-
 static int via686a_id = 0;
 
 /* The driver. I choose to use type i2c_driver, as at is identical to both
@@ -457,6 +442,7 @@
 
 /* -- SENSORS SYSCTL END -- */
 
+#if 0
 /* These files are created for each detected VIA686A. This is just a template;
    though at first sight, you might think we could use a statically
    allocated list, we need some way to get back to the parent - which
@@ -489,6 +475,7 @@
 	 &i2c_proc_real, &i2c_sysctl_real, NULL, &via686a_alarms},
 	{0}
 };
+#endif
 
 static inline int via686a_read_value(struct i2c_client *client, u8 reg)
 {
@@ -507,15 +494,12 @@
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
 
-int via686a_detect(struct i2c_adapter *adapter, int address,
-		   unsigned short flags, int kind)
+static int via686a_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	int i;
 	struct i2c_client *new_client;
 	struct via686a_data *data;
 	int err = 0;
-	const char *type_name = "via686a";
-	const char client_name[] = "via686a chip";
+	const char *name = "via686a";
 	u16 val;
 
 	/* Make sure we are probing the ISA bus!!  */
@@ -570,7 +554,7 @@
 	new_client->flags = 0;
 
 	/* Fill in the remaining client fields and put into the global list */
-	snprintf(new_client->dev.name, DEVICE_NAME_SIZE, client_name);
+	snprintf(new_client->dev.name, DEVICE_NAME_SIZE, name);
 
 	new_client->id = via686a_id++;
 	data->valid = 0;
@@ -579,21 +563,10 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
 
-	/* Register a new directory entry with module sensors */
-	if ((i = i2c_register_entry((struct i2c_client *) new_client,
-					type_name,
-					via686a_dir_table_template)) < 0) {
-		err = i;
-		goto ERROR4;
-	}
-	data->sysctl_id = i;
-
 	/* Initialize the VIA686A chip */
 	via686a_init_client(new_client);
 	return 0;
 
-      ERROR4:
-	i2c_detach_client(new_client);
       ERROR3:
 	release_region(address, VIA686A_EXTENT);
 	kfree(new_client);
@@ -604,8 +577,6 @@
 static int via686a_detach_client(struct i2c_client *client)
 {
 	int err;
-	struct via686a_data *data = i2c_get_clientdata(client);
-	i2c_deregister_entry(data->sysctl_id);
 
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
@@ -752,6 +723,9 @@
    large enough (by checking the incoming value of *nrels). This is not very
    good practice, but as long as you put less than about 5 values in results,
    you can assume it is large enough. */
+/* FIXME, remove these functions, they are here to verify the sysfs conversion
+ * is correct, or not */
+__attribute__((unused))
 static void via686a_in(struct i2c_client *client, int operation, int ctl_name,
                int *nrels_mag, long *results)
 {
@@ -780,7 +754,8 @@
 	}
 }
 
-void via686a_fan(struct i2c_client *client, int operation, int ctl_name,
+__attribute__((unused))
+static void via686a_fan(struct i2c_client *client, int operation, int ctl_name,
 		 int *nrels_mag, long *results)
 {
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -808,7 +783,8 @@
 	}
 }
 
-void via686a_temp(struct i2c_client *client, int operation, int ctl_name,
+__attribute__((unused))
+static void via686a_temp(struct i2c_client *client, int operation, int ctl_name,
 		  int *nrels_mag, long *results)
 {
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -838,7 +814,8 @@
 	}
 }
 
-void via686a_alarms(struct i2c_client *client, int operation, int ctl_name,
+__attribute__((unused))
+static void via686a_alarms(struct i2c_client *client, int operation, int ctl_name,
 		    int *nrels_mag, long *results)
 {
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -851,7 +828,8 @@
 	}
 }
 
-void via686a_fan_div(struct i2c_client *client, int operation,
+__attribute__((unused))
+static void via686a_fan_div(struct i2c_client *client, int operation,
 		     int ctl_name, int *nrels_mag, long *results)
 {
 	struct via686a_data *data = i2c_get_clientdata(client);

