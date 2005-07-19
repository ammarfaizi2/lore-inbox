Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVGSV65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVGSV65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVGSV5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:57:15 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:4613 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261999AbVGSV40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:56:26 -0400
Date: Tue, 19 Jul 2005 23:56:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (5/9)
Message-Id: <20050719235635.42eca56e.khali@linux-fr.org>
In-Reply-To: <20050719233902.40282559.khali@linux-fr.org>
References: <20050719233902.40282559.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call the ISA chip drivers detection function directly instead of relying
on i2c_detect. The net effect is that address lists won't be handled
anymore, but they were mostly useless in the ISA case anyway (pc87360,
smsc47m1, smsc47b397 had already dropped them).

We don't need to handle multiple devices, all we may need is a way to
force a given address instead of the original one (some drivers already
do: sis5595, via686a, w83627hf), and, for drivers supporting multiple
chips, a way to force one given kind. All this may be added later on
demand, but I actually don't think there will be much demand.

 drivers/hwmon/it87.c       |   16 ++++++++++----
 drivers/hwmon/lm78.c       |   11 ++++++++--
 drivers/hwmon/pc87360.c    |   38 ++++++++--------------------------
 drivers/hwmon/sis5595.c    |   41 ++++++++-----------------------------
 drivers/hwmon/smsc47b397.c |   48 +++++++++++---------------------------------
 drivers/hwmon/smsc47m1.c   |   42 ++++++++------------------------------
 drivers/hwmon/via686a.c    |   41 +++++++------------------------------
 drivers/hwmon/w83627ehf.c  |   35 ++++++++------------------------
 drivers/hwmon/w83627hf.c   |   49 +++++++++++----------------------------------
 drivers/hwmon/w83781d.c    |   12 +++++++++--
 10 files changed, 98 insertions(+), 235 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/pc87360.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/pc87360.c	2005-07-17 12:47:11.000000000 +0200
@@ -39,25 +39,17 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <asm/io.h>
 
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
-static struct i2c_force_data forces[] = {{ NULL }};
 static u8 devid;
-static unsigned int extra_isa[3];
+static unsigned short address;
+static unsigned short extra_isa[3];
 static u8 confreg[4];
 
 enum chips { any_chip, pc87360, pc87363, pc87364, pc87365, pc87366 };
-static struct i2c_address_data addr_data = {
-	.normal_i2c		= normal_i2c,
-	.normal_isa		= normal_isa,
-	.forces			= forces,
-};
 
 static int init = 1;
 module_param(init, int, 0);
@@ -228,8 +220,7 @@
  * Functions declaration
  */
 
-static int pc87360_attach_adapter(struct i2c_adapter *adapter);
-static int pc87360_detect(struct i2c_adapter *adapter, int address, int kind);
+static int pc87360_detect(struct i2c_adapter *adapter);
 static int pc87360_detach_client(struct i2c_client *client);
 
 static int pc87360_read_value(struct pc87360_data *data, u8 ldi, u8 bank,
@@ -246,8 +237,7 @@
 static struct i2c_driver pc87360_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "pc87360",
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= pc87360_attach_adapter,
+	.attach_adapter	= pc87360_detect,
 	.detach_client	= pc87360_detach_client,
 };
 
@@ -636,12 +626,7 @@
  * Device detection, registration and update
  */
 
-static int pc87360_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_detect(adapter, &addr_data, pc87360_detect);
-}
-
-static int pc87360_find(int sioaddr, u8 *devid, int *address)
+static int pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
 {
 	u16 val;
 	int i;
@@ -687,7 +672,7 @@
 			continue;
 		}
 
-		address[i] = val;
+		addresses[i] = val;
 
 		if (i==0) { /* Fans */
 			confreg[0] = superio_inb(sioaddr, 0xF0);
@@ -731,9 +716,7 @@
 	return 0;
 }
 
-/* We don't really care about the address.
-   Read from extra_isa instead. */
-int pc87360_detect(struct i2c_adapter *adapter, int address, int kind)
+static int pc87360_detect(struct i2c_adapter *adapter)
 {
 	int i;
 	struct i2c_client *new_client;
@@ -742,9 +725,6 @@
 	const char *name = "pc87360";
 	int use_thermistors = 0;
 
-	if (!i2c_is_isa_adapter(adapter))
-		return -ENODEV;
-
 	if (!(data = kmalloc(sizeof(struct pc87360_data), GFP_KERNEL)))
 		return -ENOMEM;
 	memset(data, 0x00, sizeof(struct pc87360_data));
@@ -1334,12 +1314,12 @@
 	/* Arbitrarily pick one of the addresses */
 	for (i = 0; i < 3; i++) {
 		if (extra_isa[i] != 0x0000) {
-			normal_isa[0] = extra_isa[i];
+			address = extra_isa[i];
 			break;
 		}
 	}
 
-	if (normal_isa[0] == 0x0000) {
+	if (address == 0x0000) {
 		printk(KERN_WARNING "pc87360: No active logical device, "
 		       "module not inserted.\n");
 		return -ENODEV;
--- linux-2.6.13-rc3.orig/drivers/hwmon/sis5595.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/sis5595.c	2005-07-17 10:11:17.000000000 +0200
@@ -71,14 +71,10 @@
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");
 
-/* Addresses to scan.
+/* Device address
    Note that we can't determine the ISA address until we have initialized
    our module */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
-
-/* Insmod parameters */
-SENSORS_INSMOD_1(sis5595);
+static unsigned short address;
 
 /* Many SIS5595 constants specified below */
 
@@ -194,8 +190,7 @@
 
 static struct pci_dev *s_bridge;	/* pointer to the (only) sis5595 */
 
-static int sis5595_attach_adapter(struct i2c_adapter *adapter);
-static int sis5595_detect(struct i2c_adapter *adapter, int address, int kind);
+static int sis5595_detect(struct i2c_adapter *adapter);
 static int sis5595_detach_client(struct i2c_client *client);
 
 static int sis5595_read_value(struct i2c_client *client, u8 register);
@@ -206,9 +201,7 @@
 static struct i2c_driver sis5595_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "sis5595",
-	.id		= I2C_DRIVERID_SIS5595,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= sis5595_attach_adapter,
+	.attach_adapter	= sis5595_detect,
 	.detach_client	= sis5595_detach_client,
 };
 
@@ -480,14 +473,7 @@
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
  
 /* This is called when the module is loaded */
-static int sis5595_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_detect(adapter, &addr_data, sis5595_detect);
-}
-
-int sis5595_detect(struct i2c_adapter *adapter, int address, int kind)
+static int sis5595_detect(struct i2c_adapter *adapter)
 {
 	int err = 0;
 	int i;
@@ -496,10 +482,6 @@
 	char val;
 	u16 a;
 
-	/* Make sure we are probing the ISA bus!!  */
-	if (!i2c_is_isa_adapter(adapter))
-		goto exit;
-
 	if (force_addr)
 		address = force_addr & ~(SIS5595_EXTENT - 1);
 	/* Reserve the ISA region */
@@ -642,8 +624,7 @@
 		return err;
 	}
 
-	if (i2c_is_isa_client(client))
-		release_region(client->addr, SIS5595_EXTENT);
+	release_region(client->addr, SIS5595_EXTENT);
 
 	kfree(data);
 
@@ -760,7 +741,6 @@
 {
 	u16 val;
 	int *i;
-	int addr = 0;
 
 	for (i = blacklist; *i != 0; i++) {
 		struct pci_dev *dev;
@@ -776,19 +756,16 @@
 	    pci_read_config_word(dev, SIS5595_BASE_REG, &val))
 		return -ENODEV;
 	
-	addr = val & ~(SIS5595_EXTENT - 1);
-	if (addr == 0 && force_addr == 0) {
+	address = val & ~(SIS5595_EXTENT - 1);
+	if (address == 0 && force_addr == 0) {
 		dev_err(&dev->dev, "Base address not set - upgrade BIOS or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
-	if (force_addr)
-		addr = force_addr;	/* so detect will get called */
 
-	if (!addr) {
+	if (!address) {
 		dev_err(&dev->dev,"No SiS 5595 sensors found.\n");
 		return -ENODEV;
 	}
-	normal_isa[0] = addr;
 
 	s_bridge = pci_dev_get(dev);
 	if (i2c_isa_add_driver(&sis5595_driver)) {
--- linux-2.6.13-rc3.orig/drivers/hwmon/via686a.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/via686a.c	2005-07-17 10:11:25.000000000 +0200
@@ -50,14 +50,10 @@
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");
 
-/* Addresses to scan.
+/* Device address
    Note that we can't determine the ISA address until we have initialized
    our module */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
-
-/* Insmod parameters */
-SENSORS_INSMOD_1(via686a);
+static unsigned short address;
 
 /*
    The Via 686a southbridge has a LM78-like chip integrated on the same IC.
@@ -319,8 +315,7 @@
 
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
-static int via686a_attach_adapter(struct i2c_adapter *adapter);
-static int via686a_detect(struct i2c_adapter *adapter, int address, int kind);
+static int via686a_detect(struct i2c_adapter *adapter);
 static int via686a_detach_client(struct i2c_client *client);
 
 static inline int via686a_read_value(struct i2c_client *client, u8 reg)
@@ -580,22 +575,13 @@
 static struct i2c_driver via686a_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "via686a",
-	.id		= I2C_DRIVERID_VIA686A,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= via686a_attach_adapter,
+	.attach_adapter	= via686a_detect,
 	.detach_client	= via686a_detach_client,
 };
 
 
 /* This is called when the module is loaded */
-static int via686a_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_detect(adapter, &addr_data, via686a_detect);
-}
-
-static int via686a_detect(struct i2c_adapter *adapter, int address, int kind)
+static int via686a_detect(struct i2c_adapter *adapter)
 {
 	struct i2c_client *new_client;
 	struct via686a_data *data;
@@ -603,13 +589,6 @@
 	const char client_name[] = "via686a";
 	u16 val;
 
-	/* Make sure we are probing the ISA bus!!  */
-	if (!i2c_is_isa_adapter(adapter)) {
-		dev_err(&adapter->dev,
-		"via686a_detect called for an I2C bus adapter?!?\n");
-		return 0;
-	}
-
 	/* 8231 requires multiple of 256, we enforce that on 686 as well */
 	if (force_addr)
 		address = force_addr & 0xFF00;
@@ -825,26 +804,22 @@
 				       const struct pci_device_id *id)
 {
 	u16 val;
-	int addr = 0;
 
 	if (PCIBIOS_SUCCESSFUL !=
 	    pci_read_config_word(dev, VIA686A_BASE_REG, &val))
 		return -ENODEV;
 
-	addr = val & ~(VIA686A_EXTENT - 1);
-	if (addr == 0 && force_addr == 0) {
+	address = val & ~(VIA686A_EXTENT - 1);
+	if (address == 0 && force_addr == 0) {
 		dev_err(&dev->dev, "base address not set - upgrade BIOS "
 			"or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
-	if (force_addr)
-		addr = force_addr;	/* so detect will get called */
 
-	if (!addr) {
+	if (!address) {
 		dev_err(&dev->dev, "No Via 686A sensors found.\n");
 		return -ENODEV;
 	}
-	normal_isa[0] = addr;
 
 	s_bridge = pci_dev_get(dev);
 	if (i2c_isa_add_driver(&via686a_driver)) {
--- linux-2.6.13-rc3.orig/drivers/hwmon/it87.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/it87.c	2005-07-17 13:56:38.000000000 +0200
@@ -48,7 +48,8 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
 					0x2e, 0x2f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
 SENSORS_INSMOD_2(it87, it8712);
@@ -222,7 +223,7 @@
 
 
 static int it87_attach_adapter(struct i2c_adapter *adapter);
-static int it87_find(int *address);
+static int it87_isa_attach_adapter(struct i2c_adapter *adapter);
 static int it87_detect(struct i2c_adapter *adapter, int address, int kind);
 static int it87_detach_client(struct i2c_client *client);
 
@@ -246,7 +247,7 @@
 static struct i2c_driver it87_isa_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "it87-isa",
-	.attach_adapter	= it87_attach_adapter,
+	.attach_adapter	= it87_isa_attach_adapter,
 	.detach_client	= it87_detach_client,
 };
 
@@ -701,7 +702,12 @@
 	return i2c_detect(adapter, &addr_data, it87_detect);
 }
 
-/* SuperIO detection - will change normal_isa[0] if a chip is found */
+static int it87_isa_attach_adapter(struct i2c_adapter *adapter)
+{
+	return it87_detect(adapter, isa_address, -1);
+}
+
+/* SuperIO detection - will change isa_address if a chip is found */
 static int it87_find(int *address)
 {
 	int err = -ENODEV;
@@ -1184,7 +1190,7 @@
 	int addr, res;
 
 	if (!it87_find(&addr)) {
-		normal_isa[0] = addr;
+		isa_address = addr;
 	}
 
 	res = i2c_add_driver(&it87_driver);
--- linux-2.6.13-rc3.orig/drivers/hwmon/lm78.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/lm78.c	2005-07-17 09:28:50.000000000 +0200
@@ -34,7 +34,8 @@
 					0x25, 0x26, 0x27, 0x28, 0x29,
 					0x2a, 0x2b, 0x2c, 0x2d, 0x2e,
 					0x2f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
 SENSORS_INSMOD_3(lm78, lm78j, lm79);
@@ -160,6 +161,7 @@
 
 
 static int lm78_attach_adapter(struct i2c_adapter *adapter);
+static int lm78_isa_attach_adapter(struct i2c_adapter *adapter);
 static int lm78_detect(struct i2c_adapter *adapter, int address, int kind);
 static int lm78_detach_client(struct i2c_client *client);
 
@@ -181,7 +183,7 @@
 static struct i2c_driver lm78_isa_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm78-isa",
-	.attach_adapter	= lm78_attach_adapter,
+	.attach_adapter	= lm78_isa_attach_adapter,
 	.detach_client	= lm78_detach_client,
 };
 
@@ -480,6 +482,11 @@
 	return i2c_detect(adapter, &addr_data, lm78_detect);
 }
 
+static int lm78_isa_attach_adapter(struct i2c_adapter *adapter)
+{
+	return lm78_detect(adapter, isa_address, -1);
+}
+
 /* This function is called by i2c_detect */
 int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83781d.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83781d.c	2005-07-17 09:36:20.000000000 +0200
@@ -50,7 +50,8 @@
 static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
 					0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
 					0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
 SENSORS_INSMOD_5(w83781d, w83782d, w83783s, w83627hf, as99127f);
@@ -259,6 +260,7 @@
 };
 
 static int w83781d_attach_adapter(struct i2c_adapter *adapter);
+static int w83781d_isa_attach_adapter(struct i2c_adapter *adapter);
 static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83781d_detach_client(struct i2c_client *client);
 
@@ -280,7 +282,7 @@
 static struct i2c_driver w83781d_isa_driver = {
 	.owner = THIS_MODULE,
 	.name = "w83781d-isa",
-	.attach_adapter = w83781d_attach_adapter,
+	.attach_adapter = w83781d_isa_attach_adapter,
 	.detach_client = w83781d_detach_client,
 };
 
@@ -871,6 +873,12 @@
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
 
+static int
+w83781d_isa_attach_adapter(struct i2c_adapter *adapter)
+{
+	return w83781d_detect(adapter, isa_address, -1);
+}
+
 /* Assumes that adapter is of I2C, not ISA variety.
  * OTHERWISE DON'T CALL THIS
  */
--- linux-2.6.13-rc3.orig/drivers/hwmon/smsc47b397.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/smsc47b397.c	2005-07-17 09:48:06.000000000 +0200
@@ -32,25 +32,13 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <asm/io.h>
 
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 /* Address is autodetected, there is no default value */
-static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
-static struct i2c_force_data forces[] = {{NULL}};
-
-enum chips { any_chip, smsc47b397 };
-static struct i2c_address_data addr_data = {
-	.normal_i2c		= normal_i2c,
-	.normal_isa		= normal_isa,
-	.probe			= normal_i2c,		/* cheat */
-	.ignore			= normal_i2c,		/* cheat */
-	.forces			= forces,
-};
+static unsigned short address;
 
 /* Super-I/0 registers and commands */
 
@@ -219,15 +207,6 @@
 #define device_create_file_fan(client, num) \
 	device_create_file(&client->dev, &dev_attr_fan##num##_input)
 
-static int smsc47b397_detect(struct i2c_adapter *adapter, int addr, int kind);
-
-static int smsc47b397_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_detect(adapter, &addr_data, smsc47b397_detect);
-}
-
 static int smsc47b397_detach_client(struct i2c_client *client)
 {
 	struct smsc47b397_data *data = i2c_get_clientdata(client);
@@ -247,27 +226,24 @@
 	return 0;
 }
 
+static int smsc47b397_detect(struct i2c_adapter *adapter);
+
 static struct i2c_driver smsc47b397_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "smsc47b397",
-	.id		= I2C_DRIVERID_SMSC47B397,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= smsc47b397_attach_adapter,
+	.attach_adapter	= smsc47b397_detect,
 	.detach_client	= smsc47b397_detach_client,
 };
 
-static int smsc47b397_detect(struct i2c_adapter *adapter, int addr, int kind)
+static int smsc47b397_detect(struct i2c_adapter *adapter)
 {
 	struct i2c_client *new_client;
 	struct smsc47b397_data *data;
 	int err = 0;
 
-	if (!i2c_is_isa_adapter(adapter)) {
-		return 0;
-	}
-
-	if (!request_region(addr, SMSC_EXTENT, smsc47b397_driver.name)) {
-		dev_err(&adapter->dev, "Region 0x%x already in use!\n", addr);
+	if (!request_region(address, SMSC_EXTENT, smsc47b397_driver.name)) {
+		dev_err(&adapter->dev, "Region 0x%x already in use!\n",
+			address);
 		return -EBUSY;
 	}
 
@@ -279,7 +255,7 @@
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
-	new_client->addr = addr;
+	new_client->addr = address;
 	init_MUTEX(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &smsc47b397_driver;
@@ -315,11 +291,11 @@
 error_free:
 	kfree(data);
 error_release:
-	release_region(addr, SMSC_EXTENT);
+	release_region(address, SMSC_EXTENT);
 	return err;
 }
 
-static int __init smsc47b397_find(unsigned int *addr)
+static int __init smsc47b397_find(unsigned short *addr)
 {
 	u8 id, rev;
 
@@ -348,7 +324,7 @@
 {
 	int ret;
 
-	if ((ret = smsc47b397_find(normal_isa)))
+	if ((ret = smsc47b397_find(&address)))
 		return ret;
 
 	return i2c_isa_add_driver(&smsc47b397_driver);
--- linux-2.6.13-rc3.orig/drivers/hwmon/smsc47m1.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/smsc47m1.c	2005-07-17 09:59:58.000000000 +0200
@@ -37,17 +37,8 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 /* Address is autodetected, there is no default value */
-static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
-static struct i2c_force_data forces[] = {{NULL}};
-
-enum chips { any_chip, smsc47m1 };
-static struct i2c_address_data addr_data = {
-	.normal_i2c		= normal_i2c,
-	.normal_isa		= normal_isa,
-	.forces			= forces,
-};
+static unsigned short address;
 
 /* Super-I/0 registers and commands */
 
@@ -125,9 +116,7 @@
 };
 
 
-static int smsc47m1_attach_adapter(struct i2c_adapter *adapter);
-static int smsc47m1_find(int *address);
-static int smsc47m1_detect(struct i2c_adapter *adapter, int address, int kind);
+static int smsc47m1_detect(struct i2c_adapter *adapter);
 static int smsc47m1_detach_client(struct i2c_client *client);
 
 static int smsc47m1_read_value(struct i2c_client *client, u8 reg);
@@ -140,9 +129,7 @@
 static struct i2c_driver smsc47m1_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "smsc47m1",
-	.id		= I2C_DRIVERID_SMSC47M1,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= smsc47m1_attach_adapter,
+	.attach_adapter	= smsc47m1_detect,
 	.detach_client	= smsc47m1_detach_client,
 };
 
@@ -358,14 +345,7 @@
 
 static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
 
-static int smsc47m1_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_detect(adapter, &addr_data, smsc47m1_detect);
-}
-
-static int smsc47m1_find(int *address)
+static int smsc47m1_find(unsigned short *addr)
 {
 	u8 val;
 
@@ -392,10 +372,10 @@
 	}
 
 	superio_select();
-	*address = (superio_inb(SUPERIO_REG_BASE) << 8)
-		 |  superio_inb(SUPERIO_REG_BASE + 1);
+	*addr = (superio_inb(SUPERIO_REG_BASE) << 8)
+	      |  superio_inb(SUPERIO_REG_BASE + 1);
 	val = superio_inb(SUPERIO_REG_ACT);
-	if (*address == 0 || (val & 0x01) == 0) {
+	if (*addr == 0 || (val & 0x01) == 0) {
 		printk(KERN_INFO "smsc47m1: Device is disabled, will not use\n");
 		superio_exit();
 		return -ENODEV;
@@ -405,17 +385,13 @@
 	return 0;
 }
 
-static int smsc47m1_detect(struct i2c_adapter *adapter, int address, int kind)
+static int smsc47m1_detect(struct i2c_adapter *adapter)
 {
 	struct i2c_client *new_client;
 	struct smsc47m1_data *data;
 	int err = 0;
 	int fan1, fan2, pwm1, pwm2;
 
-	if (!i2c_is_isa_adapter(adapter)) {
-		return 0;
-	}
-
 	if (!request_region(address, SMSC_EXTENT, smsc47m1_driver.name)) {
 		dev_err(&adapter->dev, "Region 0x%x already in use!\n", address);
 		return -EBUSY;
@@ -589,7 +565,7 @@
 
 static int __init sm_smsc47m1_init(void)
 {
-	if (smsc47m1_find(normal_isa)) {
+	if (smsc47m1_find(&address)) {
 		return -ENODEV;
 	}
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83627ehf.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83627ehf.c	2005-07-17 10:02:50.000000000 +0200
@@ -38,19 +38,13 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
 
-/* Addresses to scan
-   The actual ISA address is read from Super-I/O configuration space */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
-
-/* Insmod parameters */
-SENSORS_INSMOD_1(w83627ehf);
+/* The actual ISA address is read from Super-I/O configuration space */
+static unsigned short address;
 
 /*
  * Super-I/O constants and functions
@@ -670,15 +664,12 @@
 	}
 }
 
-static int w83627ehf_detect(struct i2c_adapter *adapter, int address, int kind)
+static int w83627ehf_detect(struct i2c_adapter *adapter)
 {
 	struct i2c_client *client;
 	struct w83627ehf_data *data;
 	int i, err = 0;
 
-	if (!i2c_is_isa_adapter(adapter))
-		return 0;
-
 	if (!request_region(address, REGION_LENGTH, w83627ehf_driver.name)) {
 		err = -EBUSY;
 		goto exit;
@@ -773,13 +764,6 @@
 	return err;
 }
 
-static int w83627ehf_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_detect(adapter, &addr_data, w83627ehf_detect);
-}
-
 static int w83627ehf_detach_client(struct i2c_client *client)
 {
 	struct w83627ehf_data *data = i2c_get_clientdata(client);
@@ -801,12 +785,11 @@
 static struct i2c_driver w83627ehf_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "w83627ehf",
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= w83627ehf_attach_adapter,
+	.attach_adapter	= w83627ehf_detect,
 	.detach_client	= w83627ehf_detach_client,
 };
 
-static int __init w83627ehf_find(int sioaddr, int *address)
+static int __init w83627ehf_find(int sioaddr, unsigned short *addr)
 {
 	u16 val;
 
@@ -824,8 +807,8 @@
 	superio_select(W83627EHF_LD_HWM);
 	val = (superio_inb(SIO_REG_ADDR) << 8)
 	    | superio_inb(SIO_REG_ADDR + 1);
-	*address = val & ~(REGION_LENGTH - 1);
-	if (*address == 0) {
+	*addr = val & ~(REGION_LENGTH - 1);
+	if (*addr == 0) {
 		superio_exit();
 		return -ENODEV;
 	}
@@ -841,8 +824,8 @@
 
 static int __init sensors_w83627ehf_init(void)
 {
-	if (w83627ehf_find(0x2e, &normal_isa[0])
-	 && w83627ehf_find(0x4e, &normal_isa[0]))
+	if (w83627ehf_find(0x2e, &address)
+	 && w83627ehf_find(0x4e, &address))
 		return -ENODEV;
 
 	return i2c_isa_add_driver(&w83627ehf_driver);
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83627hf.c	2005-07-16 21:26:53.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83627hf.c	2005-07-17 12:48:53.000000000 +0200
@@ -59,12 +59,11 @@
 MODULE_PARM_DESC(force_i2c,
 		 "Initialize the i2c address of the sensors");
 
-/* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
+/* The actual ISA address is read from Super-I/O configuration space */
+static unsigned short address;
 
 /* Insmod parameters */
-SENSORS_INSMOD_4(w83627hf, w83627thf, w83697hf, w83637hf);
+enum chips { any_chip, w83627hf, w83627thf, w83697hf, w83637hf };
 
 static int init = 1;
 module_param(init, bool, 0);
@@ -318,9 +317,7 @@
 };
 
 
-static int w83627hf_attach_adapter(struct i2c_adapter *adapter);
-static int w83627hf_detect(struct i2c_adapter *adapter, int address,
-			  int kind);
+static int w83627hf_detect(struct i2c_adapter *adapter);
 static int w83627hf_detach_client(struct i2c_client *client);
 
 static int w83627hf_read_value(struct i2c_client *client, u16 register);
@@ -332,9 +329,7 @@
 static struct i2c_driver w83627hf_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "w83627hf",
-	.id		= I2C_DRIVERID_W83627HF,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= w83627hf_attach_adapter,
+	.attach_adapter	= w83627hf_detect,
 	.detach_client	= w83627hf_detach_client,
 };
 
@@ -963,16 +958,7 @@
 } while (0)
 
 
-/* This function is called when:
-     * w83627hf_driver is inserted (when this module is loaded), for each
-       available adapter
-     * when a new adapter is inserted (and w83627hf_driver is still present) */
-static int w83627hf_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_detect(adapter, &addr_data, w83627hf_detect);
-}
-
-static int w83627hf_find(int sioaddr, int *address)
+static int w83627hf_find(int sioaddr, unsigned short *addr)
 {
 	u16 val;
 
@@ -992,32 +978,24 @@
 	superio_select(W83627HF_LD_HWM);
 	val = (superio_inb(WINB_BASE_REG) << 8) |
 	       superio_inb(WINB_BASE_REG + 1);
-	*address = val & ~(WINB_EXTENT - 1);
-	if (*address == 0 && force_addr == 0) {
+	*addr = val & ~(WINB_EXTENT - 1);
+	if (*addr == 0 && force_addr == 0) {
 		superio_exit();
 		return -ENODEV;
 	}
-	if (force_addr)
-		*address = force_addr;	/* so detect will get called */
 
 	superio_exit();
 	return 0;
 }
 
-int w83627hf_detect(struct i2c_adapter *adapter, int address,
-		   int kind)
+static int w83627hf_detect(struct i2c_adapter *adapter)
 {
-	int val;
+	int val, kind;
 	struct i2c_client *new_client;
 	struct w83627hf_data *data;
 	int err = 0;
 	const char *client_name = "";
 
-	if (!i2c_is_isa_adapter(adapter)) {
-		err = -ENODEV;
-		goto ERROR0;
-	}
-
 	if(force_addr)
 		address = force_addr & ~(WINB_EXTENT - 1);
 
@@ -1500,13 +1478,10 @@
 
 static int __init sensors_w83627hf_init(void)
 {
-	int addr;
-
-	if (w83627hf_find(0x2e, &addr)
-	 && w83627hf_find(0x4e, &addr)) {
+	if (w83627hf_find(0x2e, &address)
+	 && w83627hf_find(0x4e, &address)) {
 		return -ENODEV;
 	}
-	normal_isa[0] = addr;
 
 	return i2c_isa_add_driver(&w83627hf_driver);
 }

-- 
Jean Delvare
