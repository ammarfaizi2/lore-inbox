Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWANQZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWANQZn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWANQZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:25:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11727 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964801AbWANQZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:25:15 -0500
Date: Sat, 14 Jan 2006 17:25:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Jean Delvare <khali@linux-fr.org>
Subject: [patch 2.6.15-mm4] sem2mutex: I2C, #2
Message-ID: <20060114162527.GA4822@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 drivers/i2c/busses/i2c-amd756-s4882.c |   14 ++++++-----
 drivers/i2c/busses/i2c-isa.c          |    2 -
 drivers/i2c/chips/eeprom.c            |    9 +++----
 drivers/i2c/chips/max6875.c           |   10 +++----
 drivers/i2c/chips/pcf8591.c           |   13 +++++-----
 drivers/i2c/chips/tps65010.c          |   43 +++++++++++++++++-----------------
 drivers/i2c/i2c-core.c                |   34 +++++++++++++-------------
 include/linux/i2c.h                   |    6 ++--
 8 files changed, 68 insertions(+), 63 deletions(-)

Index: linux/drivers/i2c/busses/i2c-amd756-s4882.c
===================================================================
--- linux.orig/drivers/i2c/busses/i2c-amd756-s4882.c
+++ linux/drivers/i2c/busses/i2c-amd756-s4882.c
@@ -38,6 +38,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/mutex.h>
+
 
 extern struct i2c_adapter amd756_smbus;
 
@@ -45,7 +47,7 @@ static struct i2c_adapter *s4882_adapter
 static struct i2c_algorithm *s4882_algo;
 
 /* Wrapper access functions for multiplexed SMBus */
-static struct semaphore amd756_lock;
+static struct mutex amd756_lock;
 
 static s32 amd756_access_virt0(struct i2c_adapter * adap, u16 addr,
 			       unsigned short flags, char read_write,
@@ -59,12 +61,12 @@ static s32 amd756_access_virt0(struct i2
 	 || addr == 0x18)
 		return -1;
 
-	down(&amd756_lock);
+	mutex_lock(&amd756_lock);
 
 	error = amd756_smbus.algo->smbus_xfer(adap, addr, flags, read_write,
 					      command, size, data);
 
-	up(&amd756_lock);
+	mutex_unlock(&amd756_lock);
 
 	return error;
 }
@@ -87,7 +89,7 @@ static inline s32 amd756_access_channel(
 	if (addr != 0x4c && (addr & 0xfc) != 0x50 && (addr & 0xfc) != 0x30)
 		return -1;
 
-	down(&amd756_lock);
+	mutex_lock(&amd756_lock);
 
 	if (last_channels != channels) {
 		union i2c_smbus_data mplxdata;
@@ -105,7 +107,7 @@ static inline s32 amd756_access_channel(
 					      command, size, data);
 
 UNLOCK:
-	up(&amd756_lock);
+	mutex_unlock(&amd756_lock);
 	return error;
 }
 
@@ -166,7 +168,7 @@ static int __init amd756_s4882_init(void
 	}
 
 	printk(KERN_INFO "Enabling SMBus multiplexing for Tyan S4882\n");
-	init_MUTEX(&amd756_lock);
+	mutex_init(&amd756_lock);
 
 	/* Define the 5 virtual adapters and algorithms structures */
 	if (!(s4882_adapter = kzalloc(5 * sizeof(struct i2c_adapter),
Index: linux/drivers/i2c/busses/i2c-isa.c
===================================================================
--- linux.orig/drivers/i2c/busses/i2c-isa.c
+++ linux/drivers/i2c/busses/i2c-isa.c
@@ -137,7 +137,7 @@ int i2c_isa_del_driver(struct i2c_driver
 
 static int __init i2c_isa_init(void)
 {
-	init_MUTEX(&isa_adapter.clist_lock);
+	mutex_init(&isa_adapter.clist_lock);
 	INIT_LIST_HEAD(&isa_adapter.clients);
 
 	isa_adapter.nr = ANY_I2C_ISA_BUS;
Index: linux/drivers/i2c/chips/eeprom.c
===================================================================
--- linux.orig/drivers/i2c/chips/eeprom.c
+++ linux/drivers/i2c/chips/eeprom.c
@@ -33,6 +33,7 @@
 #include <linux/sched.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/mutex.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
@@ -54,7 +55,7 @@ enum eeprom_nature {
 /* Each client has this additional data */
 struct eeprom_data {
 	struct i2c_client client;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	u8 valid;			/* bitfield, bit!=0 if slice is valid */
 	unsigned long last_updated[8];	/* In jiffies, 8 slices */
 	u8 data[EEPROM_SIZE];		/* Register values */
@@ -81,7 +82,7 @@ static void eeprom_update_client(struct 
 	struct eeprom_data *data = i2c_get_clientdata(client);
 	int i, j;
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 
 	if (!(data->valid & (1 << slice)) ||
 	    time_after(jiffies, data->last_updated[slice] + 300 * HZ)) {
@@ -107,7 +108,7 @@ static void eeprom_update_client(struct 
 		data->valid |= (1 << slice);
 	}
 exit:
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 }
 
 static ssize_t eeprom_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
@@ -187,7 +188,7 @@ static int eeprom_detect(struct i2c_adap
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, "eeprom", I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
 	data->nature = UNKNOWN;
 
 	/* Tell the I2C layer a new client has arrived */
Index: linux/drivers/i2c/chips/max6875.c
===================================================================
--- linux.orig/drivers/i2c/chips/max6875.c
+++ linux/drivers/i2c/chips/max6875.c
@@ -31,7 +31,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 /* Do not scan - the MAX6875 access method will write to some EEPROM chips */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
@@ -54,7 +54,7 @@ I2C_CLIENT_INSMOD_1(max6875);
 /* Each client has this additional data */
 struct max6875_data {
 	struct i2c_client	client;
-	struct semaphore	update_lock;
+	struct mutex		update_lock;
 
 	u32			valid;
 	u8			data[USER_EEPROM_SIZE];
@@ -83,7 +83,7 @@ static void max6875_update_slice(struct 
 	if (slice >= USER_EEPROM_SLICES)
 		return;
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 
 	buf = &data->data[slice << SLICE_BITS];
 
@@ -122,7 +122,7 @@ static void max6875_update_slice(struct 
 		data->valid |= (1 << slice);
 	}
 exit_up:
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 }
 
 static ssize_t max6875_read(struct kobject *kobj, char *buf, loff_t off,
@@ -196,7 +196,7 @@ static int max6875_detect(struct i2c_ada
 	real_client->driver = &max6875_driver;
 	real_client->flags = 0;
 	strlcpy(real_client->name, "max6875", I2C_NAME_SIZE);
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
 
 	/* Init fake client data */
 	/* set the client data to the i2c_client so that it will get freed */
Index: linux/drivers/i2c/chips/pcf8591.c
===================================================================
--- linux.orig/drivers/i2c/chips/pcf8591.c
+++ linux/drivers/i2c/chips/pcf8591.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/mutex.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
@@ -74,7 +75,7 @@ MODULE_PARM_DESC(input_mode,
 
 struct pcf8591_data {
 	struct i2c_client client;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 
 	u8 control;
 	u8 aout;
@@ -144,13 +145,13 @@ static ssize_t set_out0_enable(struct de
 	struct pcf8591_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	if (val)
 		data->control |= PCF8591_CONTROL_AOEF;
 	else
 		data->control &= ~PCF8591_CONTROL_AOEF;
 	i2c_smbus_write_byte(client, data->control);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 
@@ -200,7 +201,7 @@ static int pcf8591_detect(struct i2c_ada
 	/* Fill in the remaining client fields and put it into the global 
 	   list */
 	strlcpy(new_client->name, "pcf8591", I2C_NAME_SIZE);
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
@@ -265,7 +266,7 @@ static int pcf8591_read_channel(struct d
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 
 	if ((data->control & PCF8591_CONTROL_AICH_MASK) != channel) {
 		data->control = (data->control & ~PCF8591_CONTROL_AICH_MASK)
@@ -278,7 +279,7 @@ static int pcf8591_read_channel(struct d
 	}
 	value = i2c_smbus_read_byte(client);
 
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	if ((channel == 2 && input_mode == 2) ||
 	    (channel != 3 && (input_mode == 1 || input_mode == 3)))
Index: linux/drivers/i2c/chips/tps65010.c
===================================================================
--- linux.orig/drivers/i2c/chips/tps65010.c
+++ linux/drivers/i2c/chips/tps65010.c
@@ -32,6 +32,7 @@
 #include <linux/suspend.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/mutex.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
@@ -218,7 +219,7 @@ static int dbg_show(struct seq_file *s, 
 	seq_printf(s, "driver  %s\nversion %s\nchip    %s\n\n",
 			DRIVER_NAME, DRIVER_VERSION, chip);
 
-	down(&tps->lock);
+	mutex_lock(&tps->lock);
 
 	/* FIXME how can we tell whether a battery is present?
 	 * likely involves a charge gauging chip (like BQ26501).
@@ -300,7 +301,7 @@ static int dbg_show(struct seq_file *s, 
 				(v2 & (1 << (4 + i))) ? "rising" : "falling");
 	}
 
-	up(&tps->lock);
+	mutex_unlock(&tps->lock);
 	return 0;
 }
 
@@ -416,7 +417,7 @@ static void tps65010_work(void *_tps)
 {
 	struct tps65010		*tps = _tps;
 
-	down(&tps->lock);
+	mutex_lock(&tps->lock);
 
 	tps65010_interrupt(tps);
 
@@ -444,7 +445,7 @@ static void tps65010_work(void *_tps)
 	if (test_and_clear_bit(FLAG_IRQ_ENABLE, &tps->flags))
 		enable_irq(tps->irq);
 
-	up(&tps->lock);
+	mutex_unlock(&tps->lock);
 }
 
 static irqreturn_t tps65010_irq(int irq, void *_tps, struct pt_regs *regs)
@@ -505,7 +506,7 @@ tps65010_probe(struct i2c_adapter *bus, 
 	if (!tps)
 		return 0;
 
-	init_MUTEX(&tps->lock);
+	mutex_init(&tps->lock);
 	INIT_WORK(&tps->work, tps65010_work, tps);
 	tps->irq = -1;
 	tps->client.addr = address;
@@ -695,7 +696,7 @@ int tps65010_set_gpio_out_value(unsigned
 	if ((gpio < GPIO1) || (gpio > GPIO4))
 		return -EINVAL;
 
-	down(&the_tps->lock);
+	mutex_lock(&the_tps->lock);
 
 	defgpio = i2c_smbus_read_byte_data(&the_tps->client, TPS_DEFGPIO);
 
@@ -720,7 +721,7 @@ int tps65010_set_gpio_out_value(unsigned
 		gpio, value ? "high" : "low",
 		i2c_smbus_read_byte_data(&the_tps->client, TPS_DEFGPIO));
 
-	up(&the_tps->lock);
+	mutex_unlock(&the_tps->lock);
 	return status;
 }
 EXPORT_SYMBOL(tps65010_set_gpio_out_value);
@@ -745,7 +746,7 @@ int tps65010_set_led(unsigned led, unsig
 		led = LED2;
 	}
 
-	down(&the_tps->lock);
+	mutex_lock(&the_tps->lock);
 
 	pr_debug("%s: led%i_on   0x%02x\n", DRIVER_NAME, led,
 		i2c_smbus_read_byte_data(&the_tps->client,
@@ -771,7 +772,7 @@ int tps65010_set_led(unsigned led, unsig
 	default:
 		printk(KERN_ERR "%s: Wrong mode parameter for set_led()\n",
 		       DRIVER_NAME);
-		up(&the_tps->lock);
+		mutex_unlock(&the_tps->lock);
 		return -EINVAL;
 	}
 
@@ -781,7 +782,7 @@ int tps65010_set_led(unsigned led, unsig
 	if (status != 0) {
 		printk(KERN_ERR "%s: Failed to write led%i_on register\n",
 		       DRIVER_NAME, led);
-		up(&the_tps->lock);
+		mutex_unlock(&the_tps->lock);
 		return status;
 	}
 
@@ -794,7 +795,7 @@ int tps65010_set_led(unsigned led, unsig
 	if (status != 0) {
 		printk(KERN_ERR "%s: Failed to write led%i_per register\n",
 		       DRIVER_NAME, led);
-		up(&the_tps->lock);
+		mutex_unlock(&the_tps->lock);
 		return status;
 	}
 
@@ -802,7 +803,7 @@ int tps65010_set_led(unsigned led, unsig
 		i2c_smbus_read_byte_data(&the_tps->client,
 				TPS_LED1_PER + offs));
 
-	up(&the_tps->lock);
+	mutex_unlock(&the_tps->lock);
 
 	return status;
 }
@@ -820,7 +821,7 @@ int tps65010_set_vib(unsigned value)
 	if (!the_tps)
 		return -ENODEV;
 
-	down(&the_tps->lock);
+	mutex_lock(&the_tps->lock);
 
 	vdcdc2 = i2c_smbus_read_byte_data(&the_tps->client, TPS_VDCDC2);
 	vdcdc2 &= ~(1 << 1);
@@ -831,7 +832,7 @@ int tps65010_set_vib(unsigned value)
 
 	pr_debug("%s: vibrator %s\n", DRIVER_NAME, value ? "on" : "off");
 
-	up(&the_tps->lock);
+	mutex_unlock(&the_tps->lock);
 	return status;
 }
 EXPORT_SYMBOL(tps65010_set_vib);
@@ -848,7 +849,7 @@ int tps65010_set_low_pwr(unsigned mode)
 	if (!the_tps)
 		return -ENODEV;
 
-	down(&the_tps->lock);
+	mutex_lock(&the_tps->lock);
 
 	pr_debug("%s: %s low_pwr, vdcdc1 0x%02x\n", DRIVER_NAME,
 		mode ? "enable" : "disable",
@@ -876,7 +877,7 @@ int tps65010_set_low_pwr(unsigned mode)
 		pr_debug("%s: vdcdc1 0x%02x\n", DRIVER_NAME,
 			i2c_smbus_read_byte_data(&the_tps->client, TPS_VDCDC1));
 
-	up(&the_tps->lock);
+	mutex_unlock(&the_tps->lock);
 
 	return status;
 }
@@ -894,7 +895,7 @@ int tps65010_config_vregs1(unsigned valu
 	if (!the_tps)
 		return -ENODEV;
 
-	down(&the_tps->lock);
+	mutex_lock(&the_tps->lock);
 
 	pr_debug("%s: vregs1 0x%02x\n", DRIVER_NAME,
 			i2c_smbus_read_byte_data(&the_tps->client, TPS_VREGS1));
@@ -909,7 +910,7 @@ int tps65010_config_vregs1(unsigned valu
 		pr_debug("%s: vregs1 0x%02x\n", DRIVER_NAME,
 			i2c_smbus_read_byte_data(&the_tps->client, TPS_VREGS1));
 
-	up(&the_tps->lock);
+	mutex_unlock(&the_tps->lock);
 
 	return status;
 }
@@ -931,7 +932,7 @@ int tps65013_set_low_pwr(unsigned mode)
 	if (!the_tps || the_tps->por)
 		return -ENODEV;
 
-	down(&the_tps->lock);
+	mutex_lock(&the_tps->lock);
 
 	pr_debug("%s: %s low_pwr, chgconfig 0x%02x vdcdc1 0x%02x\n",
 		DRIVER_NAME,
@@ -959,7 +960,7 @@ int tps65013_set_low_pwr(unsigned mode)
 	if (status != 0) {
 		printk(KERN_ERR "%s: Failed to write chconfig register\n",
 	 DRIVER_NAME);
-		up(&the_tps->lock);
+		mutex_unlock(&the_tps->lock);
 		return status;
 	}
 
@@ -977,7 +978,7 @@ int tps65013_set_low_pwr(unsigned mode)
 		pr_debug("%s: vdcdc1 0x%02x\n", DRIVER_NAME,
 			i2c_smbus_read_byte_data(&the_tps->client, TPS_VDCDC1));
 
-	up(&the_tps->lock);
+	mutex_unlock(&the_tps->lock);
 
 	return status;
 }
Index: linux/drivers/i2c/i2c-core.c
===================================================================
--- linux.orig/drivers/i2c/i2c-core.c
+++ linux/drivers/i2c/i2c-core.c
@@ -169,8 +169,8 @@ int i2c_add_adapter(struct i2c_adapter *
 	}
 
 	adap->nr =  id & MAX_ID_MASK;
-	init_MUTEX(&adap->bus_lock);
-	init_MUTEX(&adap->clist_lock);
+	mutex_init(&adap->bus_lock);
+	mutex_init(&adap->clist_lock);
 	list_add_tail(&adap->list,&adapters);
 	INIT_LIST_HEAD(&adap->clients);
 
@@ -385,9 +385,9 @@ int i2c_check_addr(struct i2c_adapter *a
 {
 	int rval;
 
-	down(&adapter->clist_lock);
+	mutex_lock(&adapter->clist_lock);
 	rval = __i2c_check_addr(adapter, addr);
-	up(&adapter->clist_lock);
+	mutex_unlock(&adapter->clist_lock);
 
 	return rval;
 }
@@ -396,13 +396,13 @@ int i2c_attach_client(struct i2c_client 
 {
 	struct i2c_adapter *adapter = client->adapter;
 
-	down(&adapter->clist_lock);
+	mutex_lock(&adapter->clist_lock);
 	if (__i2c_check_addr(client->adapter, client->addr)) {
-		up(&adapter->clist_lock);
+		mutex_unlock(&adapter->clist_lock);
 		return -EBUSY;
 	}
 	list_add_tail(&client->list,&adapter->clients);
-	up(&adapter->clist_lock);
+	mutex_unlock(&adapter->clist_lock);
 	
 	if (adapter->client_register)  {
 		if (adapter->client_register(client))  {
@@ -451,12 +451,12 @@ int i2c_detach_client(struct i2c_client 
 		}
 	}
 
-	down(&adapter->clist_lock);
+	mutex_lock(&adapter->clist_lock);
 	list_del(&client->list);
 	init_completion(&client->released);
 	device_remove_file(&client->dev, &dev_attr_client_name);
 	device_unregister(&client->dev);
-	up(&adapter->clist_lock);
+	mutex_unlock(&adapter->clist_lock);
 	wait_for_completion(&client->released);
 
  out:
@@ -514,19 +514,19 @@ void i2c_clients_command(struct i2c_adap
 	struct list_head  *item;
 	struct i2c_client *client;
 
-	down(&adap->clist_lock);
+	mutex_lock(&adap->clist_lock);
 	list_for_each(item,&adap->clients) {
 		client = list_entry(item, struct i2c_client, list);
 		if (!try_module_get(client->driver->driver.owner))
 			continue;
 		if (NULL != client->driver->command) {
-			up(&adap->clist_lock);
+			mutex_unlock(&adap->clist_lock);
 			client->driver->command(client,cmd,arg);
-			down(&adap->clist_lock);
+			mutex_lock(&adap->clist_lock);
 		}
 		module_put(client->driver->driver.owner);
        }
-       up(&adap->clist_lock);
+       mutex_unlock(&adap->clist_lock);
 }
 
 static int __init i2c_init(void)
@@ -570,9 +570,9 @@ int i2c_transfer(struct i2c_adapter * ad
 		}
 #endif
 
-		down(&adap->bus_lock);
+		mutex_lock(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,msgs,num);
-		up(&adap->bus_lock);
+		mutex_unlock(&adap->bus_lock);
 
 		return ret;
 	} else {
@@ -1119,10 +1119,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter * 
 	flags &= I2C_M_TEN | I2C_CLIENT_PEC;
 
 	if (adapter->algo->smbus_xfer) {
-		down(&adapter->bus_lock);
+		mutex_lock(&adapter->bus_lock);
 		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
 		                                command,size,data);
-		up(&adapter->bus_lock);
+		mutex_unlock(&adapter->bus_lock);
 	} else
 		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
 	                                      command,size,data);
Index: linux/include/linux/i2c.h
===================================================================
--- linux.orig/include/linux/i2c.h
+++ linux/include/linux/i2c.h
@@ -32,7 +32,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 /* --- For i2c-isa ---------------------------------------------------- */
 
@@ -225,8 +225,8 @@ struct i2c_adapter {
 	int (*client_unregister)(struct i2c_client *);
 
 	/* data fields that are valid for all devices	*/
-	struct semaphore bus_lock;
-	struct semaphore clist_lock;
+	struct mutex bus_lock;
+	struct mutex clist_lock;
 
 	int timeout;
 	int retries;
