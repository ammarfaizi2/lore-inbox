Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbVGKWJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbVGKWJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVGKWG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:06:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:62172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262878AbVGKWDw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:52 -0400
Cc: david-b@pacbell.net
Subject: [PATCH] I2C: minor TPS6501x cleanups
In-Reply-To: <11211193762794@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:57 -0700
Message-Id: <11211193772771@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: minor TPS6501x cleanups

This includes various small cleanups and fixes to the TPS 6501x driver that
came mostly from review feedback by Jean Delvare; thanks Jean!  Also some
goofy whitespace gets fixed.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 65fc50e50ff9f8b82c3756eccd7e7db6a267ffe9
tree b78c1f954841ceb64732ebf355dc070b5ce79094
parent 6328c0e163abfce679b1beffb166f72900bf0a22
author david-b@pacbell.net <david-b@pacbell.net> Wed, 29 Jun 2005 07:13:00 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/chips/Kconfig    |    1 -
 drivers/i2c/chips/tps65010.c |   61 ++++++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -509,7 +509,6 @@ config TPS65010
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps65010.
 
-
 config SENSORS_M41T00
 	tristate "ST M41T00 RTC chip"
 	depends on I2C && PPC32
diff --git a/drivers/i2c/chips/tps65010.c b/drivers/i2c/chips/tps65010.c
--- a/drivers/i2c/chips/tps65010.c
+++ b/drivers/i2c/chips/tps65010.c
@@ -18,7 +18,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#undef	DEBUG
 
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -49,11 +48,7 @@
 MODULE_DESCRIPTION("TPS6501x Power Management Driver");
 MODULE_LICENSE("GPL");
 
-/* only two addresses possible */
-#define	TPS_BASE	0x48
-static unsigned short normal_i2c[] = {
-	TPS_BASE,
-	I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x48, /* 0x49, */ I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 I2C_CLIENT_INSMOD;
@@ -102,7 +97,7 @@ struct tps65010 {
 	u8			chgstatus, regstatus, chgconf;
 	u8			nmask1, nmask2;
 
-	/* plus four GPIOs, probably used to switch power */
+	/* not currently tracking GPIO state */
 };
 
 #define	POWER_POLL_DELAY	msecs_to_jiffies(800)
@@ -135,7 +130,7 @@ static void dbg_regstat(char *buf, size_
 		(regstatus & TPS_REG_COVER) ? " uncover" : "",
 		(regstatus & TPS_REG_UVLO) ? " UVLO" : "",
 		(regstatus & TPS_REG_NO_CHG) ? " NO_CHG" : "",
-		(regstatus & TPS_REG_PG_LD02) ? " ld01_bad" : "",
+		(regstatus & TPS_REG_PG_LD02) ? " ld02_bad" : "",
 		(regstatus & TPS_REG_PG_LD01) ? " ld01_bad" : "",
 		(regstatus & TPS_REG_PG_MAIN) ? " main_bad" : "",
 		(regstatus & TPS_REG_PG_CORE) ? " core_bad" : "");
@@ -143,7 +138,7 @@ static void dbg_regstat(char *buf, size_
 
 static void dbg_chgconf(int por, char *buf, size_t len, u8 chgconfig)
 {
-	char *hibit;
+	const char *hibit;
 
 	if (por)
 		hibit = (chgconfig & TPS_CHARGE_POR)
@@ -295,7 +290,7 @@ static int dbg_show(struct seq_file *s, 
 	seq_printf(s, "defgpio %02x mask3 %02x\n", value, v2);
 
 	for (i = 0; i < 4; i++) {
-		if (value & (1 << (4 +i)))
+		if (value & (1 << (4 + i)))
 			seq_printf(s, "  gpio%d-out %s\n", i + 1,
 				(value & (1 << i)) ? "low" : "hi ");
 		else
@@ -481,7 +476,7 @@ static int __exit tps65010_detach_client
 	debugfs_remove(tps->file);
 	if (i2c_detach_client(client) == 0)
 		kfree(tps);
-	the_tps = 0;
+	the_tps = NULL;
 	return 0;
 }
 
@@ -514,7 +509,6 @@ tps65010_probe(struct i2c_adapter *bus, 
 	INIT_WORK(&tps->work, tps65010_work, tps);
 	tps->irq = -1;
 	tps->client.addr = address;
-	i2c_set_clientdata(&tps->client, tps);
 	tps->client.adapter = bus;
 	tps->client.driver = &tps65010_driver;
 	strlcpy(tps->client.name, DRIVER_NAME, I2C_NAME_SIZE);
@@ -523,9 +517,7 @@ tps65010_probe(struct i2c_adapter *bus, 
 	if (status < 0) {
 		dev_dbg(&bus->dev, "can't attach %s to device %d, err %d\n",
 				DRIVER_NAME, address, status);
-fail1:
-		kfree(tps);
-		return 0;
+		goto fail1;
 	}
 
 #ifdef	CONFIG_ARM
@@ -535,7 +527,7 @@ fail1:
 		tps->irq = OMAP_GPIO_IRQ(58);
 		omap_request_gpio(58);
 		omap_set_gpio_direction(58, 1);
-		omap_set_gpio_edge_ctrl(58, OMAP_GPIO_FALLING_EDGE);
+		set_irq_type(tps->irq, IRQT_FALLING);
 	}
 	if (machine_is_omap_osk()) {
 		tps->model = TPS65010;
@@ -543,7 +535,7 @@ fail1:
 		tps->irq = OMAP_GPIO_IRQ(OMAP_MPUIO(1));
 		omap_request_gpio(OMAP_MPUIO(1));
 		omap_set_gpio_direction(OMAP_MPUIO(1), 1);
-		omap_set_gpio_edge_ctrl(OMAP_MPUIO(1), OMAP_GPIO_FALLING_EDGE);
+		set_irq_type(tps->irq, IRQT_FALLING);
 	}
 	if (machine_is_omap_h3()) {
 		tps->model = TPS65013;
@@ -633,6 +625,9 @@ fail1:
 	tps->file = debugfs_create_file(DRIVER_NAME, S_IRUGO, NULL,
 				tps, DEBUG_FOPS);
 	return 0;
+fail1:
+	kfree(tps);
+	return 0;
 }
 
 static int __init tps65010_scan_bus(struct i2c_adapter *bus)
@@ -645,7 +640,6 @@ static int __init tps65010_scan_bus(stru
 static struct i2c_driver tps65010_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "tps65010",
-	.id		= 888,		/* FIXME assign "official" value */
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= tps65010_scan_bus,
 	.detach_client	= __exit_p(tps65010_detach_client),
@@ -744,7 +738,7 @@ int tps65010_set_led(unsigned led, unsig
 	if (!the_tps)
 		return -ENODEV;
 
-	if(led == LED1)
+	if (led == LED1)
 		offs = 0;
 	else {
 		offs = 2;
@@ -753,11 +747,13 @@ int tps65010_set_led(unsigned led, unsig
 
 	down(&the_tps->lock);
 
-	dev_dbg (&the_tps->client.dev, "led%i_on   0x%02x\n", led,
-		i2c_smbus_read_byte_data(&the_tps->client, TPS_LED1_ON + offs));
-
-	dev_dbg (&the_tps->client.dev, "led%i_per  0x%02x\n", led,
-		i2c_smbus_read_byte_data(&the_tps->client, TPS_LED1_PER + offs));
+	pr_debug("%s: led%i_on   0x%02x\n", DRIVER_NAME, led,
+		i2c_smbus_read_byte_data(&the_tps->client,
+				TPS_LED1_ON + offs));
+
+	pr_debug("%s: led%i_per  0x%02x\n", DRIVER_NAME, led,
+		i2c_smbus_read_byte_data(&the_tps->client,
+				TPS_LED1_PER + offs));
 
 	switch (mode) {
 	case OFF:
@@ -773,7 +769,7 @@ int tps65010_set_led(unsigned led, unsig
 		led_per = 0x08 | (1 << 7);
 		break;
 	default:
-		printk(KERN_ERR "%s: Wrong mode parameter for tps65010_set_led()\n",
+		printk(KERN_ERR "%s: Wrong mode parameter for set_led()\n",
 		       DRIVER_NAME);
 		up(&the_tps->lock);
 		return -EINVAL;
@@ -789,7 +785,7 @@ int tps65010_set_led(unsigned led, unsig
 		return status;
 	}
 
-	dev_dbg (&the_tps->client.dev, "led%i_on   0x%02x\n", led,
+	pr_debug("%s: led%i_on   0x%02x\n", DRIVER_NAME, led,
 		i2c_smbus_read_byte_data(&the_tps->client, TPS_LED1_ON + offs));
 
 	status = i2c_smbus_write_byte_data(&the_tps->client,
@@ -802,8 +798,9 @@ int tps65010_set_led(unsigned led, unsig
 		return status;
 	}
 
-	dev_dbg (&the_tps->client.dev, "led%i_per  0x%02x\n", led,
-		i2c_smbus_read_byte_data(&the_tps->client, TPS_LED1_PER + offs));
+	pr_debug("%s: led%i_per  0x%02x\n", DRIVER_NAME, led,
+		i2c_smbus_read_byte_data(&the_tps->client,
+				TPS_LED1_PER + offs));
 
 	up(&the_tps->lock);
 
@@ -874,7 +871,7 @@ int tps65010_set_low_pwr(unsigned mode)
 
 	if (status != 0)
 		printk(KERN_ERR "%s: Failed to write vdcdc1 register\n",
-		       DRIVER_NAME);
+			DRIVER_NAME);
 	else
 		pr_debug("%s: vdcdc1 0x%02x\n", DRIVER_NAME,
 			i2c_smbus_read_byte_data(&the_tps->client, TPS_VDCDC1));
@@ -900,14 +897,14 @@ int tps65010_config_vregs1(unsigned valu
 	down(&the_tps->lock);
 
 	pr_debug("%s: vregs1 0x%02x\n", DRIVER_NAME,
-		        i2c_smbus_read_byte_data(&the_tps->client, TPS_VREGS1));
+			i2c_smbus_read_byte_data(&the_tps->client, TPS_VREGS1));
 
 	status = i2c_smbus_write_byte_data(&the_tps->client,
 			TPS_VREGS1, value);
 
 	if (status != 0)
 		printk(KERN_ERR "%s: Failed to write vregs1 register\n",
-		        DRIVER_NAME);
+			DRIVER_NAME);
 	else
 		pr_debug("%s: vregs1 0x%02x\n", DRIVER_NAME,
 			i2c_smbus_read_byte_data(&the_tps->client, TPS_VREGS1));
@@ -1009,7 +1006,7 @@ static int __init tps_init(void)
 		msleep(10);
 	}
 
-#if defined(CONFIG_ARM)
+#ifdef	CONFIG_ARM
 	if (machine_is_omap_osk()) {
 
 		// FIXME: More should be placed in the initialization code

