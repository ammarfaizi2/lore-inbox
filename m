Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUIQOzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUIQOzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268844AbUIQOzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:55:41 -0400
Received: from mail.convergence.de ([212.227.36.84]:32928 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268802AbUIQObq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:31:46 -0400
Message-ID: <414AF51D.4060308@linuxtv.org>
Date: Fri, 17 Sep 2004 16:30:53 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][6/14] convert frontend drivers to kernel i2c 2/3
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org>
In-Reply-To: <414AF4CE.7000000@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------010405030003040403010805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010405030003040403010805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010405030003040403010805
Content-Type: text/plain;
 name="06-DVB-frontend-conversion2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="06-DVB-frontend-conversion2.diff"

- [DVB] alps_tdlb7, alps_tdmb7, at76c651, cx24110, dst: convert from dvb-i2c to kernel-i2c, MODULE_PARM() to module_param(), dvb_delay() to mdelay()
- [DVB] alps_tdlb7: move from home-brewn firmware loading to firmware_class
- [DVB] dst: use sysfs attributes for type and flags for per-card parameters

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/alps_tdlb7.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/alps_tdlb7.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/alps_tdlb7.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/alps_tdlb7.c	2004-08-18 19:52:17.000000000 +0200
@@ -20,33 +20,38 @@
 
 */
 
-
 /* 
-    This driver needs a copy of the firmware file 'Sc_main.mc' from the Haupauge
-    windows driver in the '/usr/lib/DVB/driver/frontends' directory.
-    You can also pass the complete file name with the module parameter 'firmware_file'.
+    This driver needs a copy of the firmware file from the Technotrend
+    Windoze driver.
+
+    This page is worth a look:
+    http://www.heise.de/ct/ftp/projekte/vdr/firmware.shtml
     
+    Copy 'Sc_main.mc'  to '/usr/lib/hotplug/firmware/dvb-fe-tdlb7-2.16.fw'.
 */  
+#define SP887X_DEFAULT_FIRMWARE "dvb-fe-tdlb7-2.16.fw"
 
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/vmalloc.h>
-#include <linux/fs.h>
-#include <linux/unistd.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
 #include <linux/delay.h>
-#include <linux/syscalls.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
-#ifndef CONFIG_ALPS_TDLB7_FIRMWARE_LOCATION
-#define CONFIG_ALPS_TDLB7_FIRMWARE_LOCATION "/usr/lib/DVB/driver/frontends/Sc_main.mc"
-#endif
+#define FRONTEND_NAME "dvbfe_alps_tdlb7"
+
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
+
+static int debug;
 
-static char * firmware_file = CONFIG_ALPS_TDLB7_FIRMWARE_LOCATION;
-static int debug = 0;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 
-#define dprintk	if (debug) printk
 
 /* firmware size for sp8870 */
 #define SP8870_FIRMWARE_SIZE 16382
@@ -54,9 +59,6 @@
 /* starting point for firmware in file 'Sc_main.mc' */
 #define SP8870_FIRMWARE_OFFSET 0x0A
 
-
-static int errno;
-
 static struct dvb_frontend_info tdlb7_info = {
 	.name			= "Alps TDLB7",
 	.type			= FE_OFDM,
@@ -71,14 +73,18 @@
 				  FE_CAN_HIERARCHY_AUTO |  FE_CAN_RECOVER
 };
 
+struct tdlb7_state {
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+};
 
-static int sp8870_writereg (struct dvb_i2c_bus *i2c, u16 reg, u16 data)
+static int sp8870_writereg (struct i2c_adapter *i2c, u16 reg, u16 data)
 {
         u8 buf [] = { reg >> 8, reg & 0xff, data >> 8, data & 0xff };
 	struct i2c_msg msg = { .addr = 0x71, .flags = 0, .buf = buf, .len = 4 };
 	int err;
 
-        if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
+        if ((err = i2c_transfer (i2c, &msg, 1)) != 1) {
 		dprintk ("%s: writereg error (err == %i, reg == 0x%02x, data == 0x%02x)\n", __FUNCTION__, err, reg, data);
 		return -EREMOTEIO;
 	}
@@ -86,8 +92,7 @@
         return 0;
 }
 
-
-static u16 sp8870_readreg (struct dvb_i2c_bus *i2c, u16 reg)
+static u16 sp8870_readreg (struct i2c_adapter *i2c, u16 reg)
 {
 	int ret;
 	u8 b0 [] = { reg >> 8 , reg & 0xff };
@@ -95,7 +100,7 @@
 	struct i2c_msg msg [] = { { .addr = 0x71, .flags = 0, .buf = b0, .len = 2 },
 			   { .addr = 0x71, .flags = I2C_M_RD, .buf = b1, .len = 2 } };
 
-	ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer (i2c, msg, 2);
 
 	if (ret != 2) {
 		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
@@ -105,22 +110,26 @@
 	return (b1[0] << 8 | b1[1]);
 }
 
-
-static int sp5659_write (struct dvb_i2c_bus *i2c, u8 data [4])
+static int sp5659_write (struct i2c_adapter *i2c, u8 data [4])
 {
         int ret;
-        struct i2c_msg msg = { .addr = 0x60, .flags = 0, .buf = data, .len = 4 };
 
-        ret = i2c->xfer (i2c, &msg, 1);
+        u8 buf_open [] = { 0x206 >> 8, 0x206 & 0xff, 0x001 >> 8, 0x001 & 0xff };
+        u8 buf_close [] = { 0x206 >> 8, 0x206 & 0xff, 0x000 >> 8, 0x000 & 0xff };
+
+        struct i2c_msg msg[3] = { {.addr = 0x71, .flags = 0, .buf = buf_open, .len = 4 },
+				  {.addr = 0x60, .flags = 0, .buf = data, .len = 4 },
+				  {.addr = 0x71, .flags = 0, .buf = buf_close, .len = 4 } };
 
-        if (ret != 1)
+        ret = i2c_transfer (i2c, &msg[0], 3);
+
+        if (ret != 3)
                 printk("%s: i/o error (ret == %i)\n", __FUNCTION__, ret);
 
-        return (ret != 1) ? -1 : 0;
+        return (ret != 3) ? -EREMOTEIO : 0;
 }
 
-
-static void sp5659_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
+static void sp5659_set_tv_freq (struct i2c_adapter *i2c, u32 freq)
 {
         u32 div = (freq + 36200000) / 166666;
         u8 buf [4];
@@ -137,65 +146,23 @@
 	buf[3] = pwr << 6;
 
 	/* open i2c gate for PLL message transmission... */
-	sp8870_writereg(i2c, 0x206, 0x001);
 	sp5659_write (i2c, buf);
-	sp8870_writereg(i2c, 0x206, 0x000);
 }
 
-
-static int sp8870_read_firmware_file (const char *fn, char **fp)
-{
-        int fd;
-	loff_t filesize;
-	char *dp;
-
-	fd = sys_open(fn, 0, 0);
-	if (fd == -1) {
-                printk("%s: unable to open '%s'.\n", __FUNCTION__, fn);
-		return -EIO;
-	}
-
-	filesize = sys_lseek(fd, 0L, 2);
-	if (filesize <= 0 || filesize < SP8870_FIRMWARE_OFFSET + SP8870_FIRMWARE_SIZE) {
-	        printk("%s: firmware filesize to small '%s'\n", __FUNCTION__, fn);
-		sys_close(fd);
-		return -EIO;
-	}
-
-	*fp= dp = vmalloc(SP8870_FIRMWARE_SIZE);
-	if (dp == NULL)	{
-		printk("%s: out of memory loading '%s'.\n", __FUNCTION__, fn);
-		sys_close(fd);
-		return -EIO;
-	}
-
-	sys_lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
-	if (sys_read(fd, dp, SP8870_FIRMWARE_SIZE) != SP8870_FIRMWARE_SIZE) {
-		printk("%s: failed to read '%s'.\n",__FUNCTION__, fn);
-		vfree(dp);
-		sys_close(fd);
-		return -EIO;
-	}
-
-	sys_close(fd);
-	*fp = dp;
-
-	return 0;
-}
-
-
-static int sp8870_firmware_upload (struct dvb_i2c_bus *i2c)
+static int sp8870_firmware_upload (struct i2c_adapter *i2c, const struct firmware *fw)
 {
 	struct i2c_msg msg;
-	char *fw_buf = NULL;
+	char *fw_buf = fw->data;
 	int fw_pos;
 	u8 tx_buf[255];
 	int tx_len;
 	int err = 0;
-	mm_segment_t fs = get_fs();
 
 	dprintk ("%s: ...\n", __FUNCTION__);
 
+	if (fw->size < SP8870_FIRMWARE_SIZE + SP8870_FIRMWARE_OFFSET)
+		return -EINVAL;
+
 	// system controller stop 
 	sp8870_writereg(i2c,0x0F00,0x0000);
 
@@ -205,19 +172,10 @@
 	// instruction RAM MWR
 	sp8870_writereg(i2c, 0x8F0A, ((SP8870_FIRMWARE_SIZE / 2) >> 16));
 
-	// reading firmware file to buffer
-	set_fs(get_ds());
-        err = sp8870_read_firmware_file(firmware_file, (char**) &fw_buf);
-	set_fs(fs);
-	if (err != 0) {
-		printk("%s: reading firmware file failed!\n", __FUNCTION__);
-		return err;
-	}
-
 	// do firmware upload
-	fw_pos = 0;
-	while (fw_pos < SP8870_FIRMWARE_SIZE){
-		tx_len = (fw_pos <= SP8870_FIRMWARE_SIZE - 252) ? 252 : SP8870_FIRMWARE_SIZE - fw_pos;
+	fw_pos = SP8870_FIRMWARE_OFFSET;
+	while (fw_pos < SP8870_FIRMWARE_SIZE + SP8870_FIRMWARE_OFFSET){
+		tx_len = (fw_pos <= SP8870_FIRMWARE_SIZE + SP8870_FIRMWARE_OFFSET - 252) ? 252 : SP8870_FIRMWARE_SIZE + SP8870_FIRMWARE_OFFSET - fw_pos;
 		// write register 0xCF0A
 		tx_buf[0] = 0xCF;
 		tx_buf[1] = 0x0A;
@@ -226,23 +184,19 @@
 		msg.flags=0;
 		msg.buf = tx_buf;
 		msg.len = tx_len + 2;
-        	if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
+        	if ((err = i2c_transfer (i2c, &msg, 1)) != 1) {
 			printk("%s: firmware upload failed!\n", __FUNCTION__);
 			printk ("%s: i2c error (err == %i)\n", __FUNCTION__, err);
-        		vfree(fw_buf);
 			return err;
 		}
 		fw_pos += tx_len;
 	}
 
-	vfree(fw_buf);
-
 	dprintk ("%s: done!\n", __FUNCTION__);
 	return 0;
 };
 
-
-static void sp8870_microcontroller_stop (struct dvb_i2c_bus *i2c)
+static void sp8870_microcontroller_stop (struct i2c_adapter *i2c)
 {
 	sp8870_writereg(i2c, 0x0F08, 0x000);
 	sp8870_writereg(i2c, 0x0F09, 0x000);
@@ -251,8 +205,7 @@
 	sp8870_writereg(i2c, 0x0F00, 0x000);
 }
 
-
-static void sp8870_microcontroller_start (struct dvb_i2c_bus *i2c)
+static void sp8870_microcontroller_start (struct i2c_adapter *i2c)
 {
 	sp8870_writereg(i2c, 0x0F08, 0x000);
 	sp8870_writereg(i2c, 0x0F09, 0x000);
@@ -264,8 +217,7 @@
 	sp8870_readreg(i2c, 0x0D01);
 }
 
-
-static int sp8870_init (struct dvb_i2c_bus *i2c)
+static int sp8870_init (struct i2c_adapter *i2c)
 {
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -291,8 +243,7 @@
 	return 0;
 }
 
-
-static int sp8870_read_status (struct dvb_i2c_bus *i2c,  fe_status_t * fe_status)
+static int sp8870_read_status (struct i2c_adapter *i2c,  fe_status_t * fe_status)
 {
 	int status;
 	int signal;
@@ -317,8 +268,7 @@
 	return 0;
 }
 
-
-static int sp8870_read_ber (struct dvb_i2c_bus *i2c, u32 * ber)
+static int sp8870_read_ber (struct i2c_adapter *i2c, u32 * ber)
 {
 	int ret;
 	u32 tmp;
@@ -345,8 +295,7 @@
 	return 0;
 	}
 
-
-static int sp8870_read_signal_strength (struct dvb_i2c_bus *i2c,  u16 * signal)
+static int sp8870_read_signal_strength (struct i2c_adapter *i2c,  u16 * signal)
 	{
 	int ret;
 	u16 tmp;
@@ -371,15 +320,13 @@
 	return 0;
 	}
 
-
-static int sp8870_read_snr(struct dvb_i2c_bus *i2c, u32* snr)
+static int sp8870_read_snr(struct i2c_adapter *i2c, u32* snr)
 	{
                 *snr=0;  
 		return -EOPNOTSUPP;
 	}
 
-
-static int sp8870_read_uncorrected_blocks (struct dvb_i2c_bus *i2c, u32* ublocks)
+static int sp8870_read_uncorrected_blocks (struct i2c_adapter *i2c, u32* ublocks)
 	{
 		int ret;
 
@@ -397,8 +344,7 @@
 		return 0;
 	}
 
-
-static int sp8870_read_data_valid_signal(struct dvb_i2c_bus *i2c)
+static int sp8870_read_data_valid_signal(struct i2c_adapter *i2c)
 {
 	return (sp8870_readreg(i2c, 0x0D02) > 0);
 }
@@ -476,8 +421,7 @@
 	return 0;
 }
 
-
-static int sp8870_set_frontend_parameters (struct dvb_i2c_bus *i2c,
+static int sp8870_set_frontend_parameters (struct i2c_adapter *i2c,
 				      struct dvb_frontend_parameters *p)
         {
 	int  err;
@@ -540,7 +483,7 @@
 // only for debugging: counter for channel switches
 static int switches = 0;
 
-static int sp8870_set_frontend (struct dvb_i2c_bus *i2c, struct dvb_frontend_parameters *p)
+static int sp8870_set_frontend (struct i2c_adapter *i2c, struct dvb_frontend_parameters *p)
 	{
 	/*
 	    The firmware of the sp8870 sometimes locks up after setting frontend parameters.
@@ -595,15 +538,13 @@
 	return 0;
 }
 
-
-static int sp8870_sleep(struct dvb_i2c_bus *i2c)
+static int sp8870_sleep(struct i2c_adapter *i2c)
 {
 	// tristate TS output and disable interface pins
 	return sp8870_writereg(i2c, 0xC18, 0x000);
 }
 
-
-static int sp8870_wake_up(struct dvb_i2c_bus *i2c)
+static int sp8870_wake_up(struct i2c_adapter *i2c)
 {
 	// enable TS output and interface pins
 	return sp8870_writereg(i2c, 0xC18, 0x00D);
@@ -609,10 +550,10 @@
 	return sp8870_writereg(i2c, 0xC18, 0x00D);
 }
 
-
 static int tdlb7_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct tdlb7_state *state = (struct tdlb7_state *) fe->data;
+	struct i2c_adapter *i2c = state->i2c;
 
         switch (cmd) {
         case FE_GET_INFO:
@@ -667,9 +608,15 @@
         return 0;
 }
 
+static struct i2c_client client_template;
 
-static int tdlb7_attach (struct dvb_i2c_bus *i2c, void **data)
+static int attach_adapter(struct i2c_adapter *adapter)
 {
+	struct i2c_client *client;
+	struct tdlb7_state *state;
+	const struct firmware *fw;
+	int ret;
+
         u8 b0 [] = { 0x02 , 0x00 };
         u8 b1 [] = { 0, 0 };
         struct i2c_msg msg [] = { { .addr = 0x71, .flags = 0, .buf = b0, .len = 2 },
@@ -677,48 +624,126 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-        if (i2c->xfer (i2c, msg, 2) != 2)
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		return -ENOMEM;
+	}
+
+	if (NULL == (state = kmalloc(sizeof(struct tdlb7_state), GFP_KERNEL))) {
+		kfree(client);
+		return -ENOMEM;
+	}
+	state->i2c = adapter;
+
+        if (i2c_transfer (adapter, msg, 2) != 2) {
+		kfree(state);
+		kfree(client);
                 return -ENODEV;
+	}
 
-	sp8870_firmware_upload(i2c);
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	i2c_set_clientdata(client, (void*)state);
 
-	return dvb_register_frontend (tdlb7_ioctl, i2c, NULL, &tdlb7_info);
+	ret = i2c_attach_client(client);
+	if (ret) {
+		kfree(client);
+		kfree(state);
+		return ret;
 }
 
+	/* request the firmware, this will block until someone uploads it */
+	printk("tdlb7: waiting for firmware upload...\n");
+	ret = request_firmware(&fw, SP887X_DEFAULT_FIRMWARE, &client->dev);
+	if (ret) {
+		printk("tdlb7: no firmware upload (timeout or file not found?)\n");
+		goto out;
+	}
 
-static void tdlb7_detach (struct dvb_i2c_bus *i2c, void *data)
-{
-	dprintk ("%s\n", __FUNCTION__);
+	ret = sp8870_firmware_upload(adapter, fw);
+	if (ret) {
+		printk("tdlb7: writing firmware to device failed\n");
+		release_firmware(fw);
+		goto out;
+	}
 
-	dvb_unregister_frontend (tdlb7_ioctl, i2c);
+	ret = dvb_register_frontend(tdlb7_ioctl, state->dvb, state,
+					&tdlb7_info, THIS_MODULE);
+	if (ret) {
+		printk("tdlb7: registering frontend to dvb-core failed.\n");
+		release_firmware(fw);
+		goto out;
 }
 
+	return 0;
+out:
+	i2c_detach_client(client);
+	kfree(client);
+	kfree(state);
+	return ret;
+}
 
-static int __init init_tdlb7 (void)
+static int detach_client(struct i2c_client *client)
 {
+	struct tdlb7_state *state = (struct tdlb7_state*)i2c_get_clientdata(client);
+
 	dprintk ("%s\n", __FUNCTION__);
 
-	return dvb_register_i2c_device (THIS_MODULE, tdlb7_attach, tdlb7_detach);
+	dvb_unregister_frontend_new (tdlb7_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
 }
 
-
-static void __exit exit_tdlb7 (void)
+static int command (struct i2c_client *client, unsigned int cmd, void *arg)
 {
+	struct tdlb7_state *state = (struct tdlb7_state*)i2c_get_clientdata(client);
+
 	dprintk ("%s\n", __FUNCTION__);
 
-	dvb_unregister_i2c_device (tdlb7_attach);
+	switch (cmd) {
+	case FE_REGISTER:
+		state->dvb = (struct dvb_adapter*)arg;
+		break;
+	case FE_UNREGISTER:
+		state->dvb = NULL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
 }
 
+static struct i2c_driver driver = {
+	.owner 		= THIS_MODULE,
+	.name 		= FRONTEND_NAME,
+	.id 		= I2C_DRIVERID_DVBFE_ALPS_TDLB7,
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client 	= detach_client,
+	.command 	= command,
+};
 
-module_init(init_tdlb7);
-module_exit(exit_tdlb7);
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags 		= I2C_CLIENT_ALLOW_USE,
+	.driver  	= &driver,
+};
 
+static int __init init_tdlb7(void)
+{
+	return i2c_add_driver(&driver);
+}
 
-MODULE_PARM(debug,"i");
-MODULE_PARM_DESC(debug, "enable verbose debug messages");
+static void __exit exit_tdlb7(void)
+{
+	if (i2c_del_driver(&driver))
+		printk("tdlb7: driver deregistration failed\n");
+}
 
-MODULE_PARM(firmware_file,"s");
-MODULE_PARM_DESC(firmware_file, "where to find the firmware file");
+module_init(init_tdlb7);
+module_exit(exit_tdlb7);
 
 MODULE_DESCRIPTION("TDLB7 DVB-T Frontend");
 MODULE_AUTHOR("Juergen Peitz");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/alps_tdmb7.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/alps_tdmb7.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/alps_tdmb7.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/alps_tdmb7.c	2004-08-18 19:52:17.000000000 +0200
@@ -23,15 +23,23 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
+#define FRONTEND_NAME "dvbfe_alps_tdmb7"
 
-static int debug = 0;
-#define dprintk	if (debug) printk
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
+
+static int debug;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 
 
 static struct dvb_frontend_info tdmb7_info = {
@@ -53,6 +61,10 @@
               FE_CAN_RECOVER
 };
 
+struct tdmb7_state {
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+};
 
 static u8 init_tab [] = {
 	0x04, 0x10,
@@ -75,8 +87,7 @@
 	0x47, 0x05,
 };
 
-
-static int cx22700_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
+static int cx22700_writereg (struct i2c_adapter *i2c, u8 reg, u8 data)
 {
 	int ret;
 	u8 buf [] = { reg, data };
@@ -84,7 +95,7 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	ret = i2c->xfer (i2c, &msg, 1);
+	ret = i2c_transfer (i2c, &msg, 1);
 
 	if (ret != 1) 
 		printk("%s: writereg error (reg == 0x%02x, val == 0x%02x, ret == %i)\n",
@@ -93,8 +104,7 @@
 	return (ret != 1) ? -1 : 0;
 }
 
-
-static u8 cx22700_readreg (struct dvb_i2c_bus *i2c, u8 reg)
+static u8 cx22700_readreg (struct i2c_adapter *i2c, u8 reg)
 {
 	int ret;
 	u8 b0 [] = { reg };
@@ -104,7 +114,7 @@
         
 	dprintk ("%s\n", __FUNCTION__);
 
-	ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer (i2c, msg, 2);
         
 	if (ret != 2) 
 		printk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
@@ -112,14 +122,13 @@
 	return b1[0];
 }
 
-
-static int pll_write (struct dvb_i2c_bus *i2c, u8 data [4])
+static int pll_write (struct i2c_adapter *i2c, u8 data [4])
 {
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = 4 };
 	int ret;
 
 	cx22700_writereg (i2c, 0x0a, 0x00);  /* open i2c bus switch */
-	ret = i2c->xfer (i2c, &msg, 1);
+	ret = i2c_transfer (i2c, &msg, 1);
 	cx22700_writereg (i2c, 0x0a, 0x01);  /* close i2c bus switch */
 
 	if (ret != 1)
@@ -133,7 +141,7 @@
  *   set up the downconverter frequency divisor for a 
  *   reference clock comparision frequency of 125 kHz.
  */
-static int pll_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
+static int pll_set_tv_freq (struct i2c_adapter *i2c, u32 freq)
 {
 	u32 div = (freq + 36166667) / 166667;
 #if 1 //ALPS_SETTINGS
@@ -149,8 +157,7 @@
 	return pll_write (i2c, buf);
 }
 
-
-static int cx22700_init (struct dvb_i2c_bus *i2c)
+static int cx22700_init (struct i2c_adapter *i2c)
 {
 	int i;
 
@@ -159,7 +166,7 @@
 	cx22700_writereg (i2c, 0x00, 0x02);   /*  soft reset */
 	cx22700_writereg (i2c, 0x00, 0x00);
 
-	dvb_delay(10);
+	msleep(10);
 	
 	for (i=0; i<sizeof(init_tab); i+=2)
 		cx22700_writereg (i2c, init_tab[i], init_tab[i+1]);
@@ -169,8 +176,7 @@
 	return 0;
 }
 
-
-static int cx22700_set_inversion (struct dvb_i2c_bus *i2c, int inversion)
+static int cx22700_set_inversion (struct i2c_adapter *i2c, int inversion)
 {
 	u8 val;
 
@@ -190,8 +196,7 @@
 	}
 }
 
-
-static int cx22700_set_tps (struct dvb_i2c_bus *i2c, struct dvb_ofdm_parameters *p)
+static int cx22700_set_tps (struct i2c_adapter *i2c, struct dvb_ofdm_parameters *p)
 {
 	static const u8 qam_tab [4] = { 0, 1, 0, 2 };
 	static const u8 fec_tab [6] = { 0, 1, 2, 0, 3, 4 };
@@ -253,8 +258,7 @@
 	return 0;
 }
 
-
-static int cx22700_get_tps (struct dvb_i2c_bus *i2c, struct dvb_ofdm_parameters *p)
+static int cx22700_get_tps (struct i2c_adapter *i2c, struct dvb_ofdm_parameters *p)
 {
 	static const fe_modulation_t qam_tab [3] = { QPSK, QAM_16, QAM_64 };
 	static const fe_code_rate_t fec_tab [5] = { FEC_1_2, FEC_2_3, FEC_3_4,
@@ -300,10 +302,10 @@
 	return 0;
 }
 
-
 static int tdmb7_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct tdmb7_state *state = fe->data;
+	struct i2c_adapter *i2c = state->i2c;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -406,10 +408,14 @@
 	return 0;
 }
 
+static struct i2c_client client_template;
 
-
-static int tdmb7_attach (struct dvb_i2c_bus *i2c, void **data)
+static int attach_adapter (struct i2c_adapter *adapter)
 {
+	struct tdmb7_state *state;
+	struct i2c_client *client;
+	int ret;
+
         u8 b0 [] = { 0x7 };
         u8 b1 [] = { 0 };
         struct i2c_msg msg [] = { { .addr = 0x43, .flags = 0, .buf = b0, .len = 1 },
@@ -417,41 +423,109 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-        if (i2c->xfer (i2c, msg, 2) != 2)
+	if (i2c_transfer(adapter, msg, 2) != 2)
                 return -ENODEV;
 
-	return dvb_register_frontend (tdmb7_ioctl, i2c, NULL, &tdmb7_info);
+	if (NULL == (state = kmalloc(sizeof(struct tdmb7_state), GFP_KERNEL)))
+		return -ENOMEM;
+
+	state->i2c = adapter;
+
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		kfree(state);
+		return -ENOMEM;
 }
 
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	i2c_set_clientdata(client, state);
 
-static void tdmb7_detach (struct dvb_i2c_bus *i2c, void *data)
+	ret = i2c_attach_client(client);
+	if (ret) {
+		kfree(state);
+		kfree(client);
+		return ret;
+	}
+
+	BUG_ON(!state->dvb);
+
+	ret = dvb_register_frontend (tdmb7_ioctl, state->dvb, state,
+					 &tdmb7_info, THIS_MODULE);
+	if (ret) {
+		i2c_detach_client(client);
+		kfree(state);
+		kfree(client);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int detach_client (struct i2c_client *client)
 {
+	struct tdmb7_state *state = i2c_get_clientdata(client);
+
 	dprintk ("%s\n", __FUNCTION__);
 
-	dvb_unregister_frontend (tdmb7_ioctl, i2c);
+	dvb_unregister_frontend_new (tdmb7_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
 }
 
-
-static int __init init_tdmb7 (void)
+static int command (struct i2c_client *client,
+		    unsigned int cmd, void *arg)
 {
+	struct tdmb7_state *state = i2c_get_clientdata(client);
+
 	dprintk ("%s\n", __FUNCTION__);
 
-	return dvb_register_i2c_device (THIS_MODULE, tdmb7_attach, tdmb7_detach);
+	switch (cmd) {
+	case FE_REGISTER:
+		state->dvb = arg;
+		break;
+	case FE_UNREGISTER:
+		state->dvb = NULL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 
+static struct i2c_driver driver = {
+	.owner		= THIS_MODULE,
+	.name		= FRONTEND_NAME,
+	.id		= I2C_DRIVERID_DVBFE_ALPS_TDMB7,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= attach_adapter,
+	.detach_client	= detach_client,
+	.command	= command,
+};
 
-static void __exit exit_tdmb7 (void)
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags		= I2C_CLIENT_ALLOW_USE,
+	.driver		= &driver,
+};
+
+static int __init init_tdmb7 (void)
 {
-	dprintk ("%s\n", __FUNCTION__);
+	return i2c_add_driver(&driver);
+}
 
-	dvb_unregister_i2c_device (tdmb7_attach);
+static void __exit exit_tdmb7 (void)
+{
+	if (i2c_del_driver(&driver))
+		printk(KERN_ERR "alps_tdmb7: driver deregistration failed.\n");
 }
 
 module_init (init_tdmb7);
 module_exit (exit_tdmb7);
 
-MODULE_PARM(debug,"i");
-MODULE_PARM_DESC(debug, "enable verbose debug messages");
 MODULE_DESCRIPTION("TDMB7 DVB Frontend driver");
 MODULE_AUTHOR("Holger Waechtler");
 MODULE_LICENSE("GPL");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/at76c651.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/at76c651.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/at76c651.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/at76c651.c	2004-08-18 19:52:17.000000000 +0200
@@ -1,10 +1,10 @@
 /*
  * at76c651.c
  * 
- * Atmel DVB-C Frontend Driver (at76c651/dat7021)
+ * Atmel DVB-C Frontend Driver (at76c651/tua6010xs)
  *
  * Copyright (C) 2001 fnbrd <fnbrd@gmx.de>
- *             & 2002 Andreas Oberritter <obi@linuxtv.org>
+ *             & 2002-2004 Andreas Oberritter <obi@linuxtv.org>
  *             & 2003 Wolfram Joost <dbox2@frokaschwei.de>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -21,10 +21,17 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
+ * AT76C651
+ * http://www.nalanda.nitc.ac.in/industry/datasheets/atmel/acrobat/doc1293.pdf
+ * http://www.atmel.com/atmel/acrobat/doc1320.pdf
+ *
+ * TUA6010XS
+ * http://www.infineon.com/cgi/ecrm.dll/ecrm/scripts/public_download.jsp?oid=19512
  */
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
@@ -34,29 +41,22 @@
 #endif
 
 #include "dvb_frontend.h"
-#include "dvb_i2c.h"
-#include "dvb_functions.h"
 
-static int debug = 0;
-static u8 at76c651_qam;
-static u8 at76c651_revision;
+#define FRONTEND_NAME "dvbfe_at76c651"
 
-#define dprintk	if (debug) printk
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
 
-/*
- * DAT7021
- * -------
- * Input Frequency Range (RF): 48.25 MHz to 863.25 MHz
- * Band Width: 8 MHz
- * Level Input (Range for Digital Signals): -61 dBm to -41 dBm
- * Output Frequency (IF): 36 MHz
- *
- * (see http://www.atmel.com/atmel/acrobat/doc1320.pdf)
- */
+static int debug;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 
-static struct dvb_frontend_info at76c651_info = {
 
-	.name = "Atmel AT76C651(B) with DAT7021",
+static struct dvb_frontend_info at76c651_info = {
+	.name = "Atmel AT76C651B with TUA6010XS",
 	.type = FE_QAM,
 	.frequency_min = 48250000,
 	.frequency_max = 863250000,
@@ -74,6 +74,13 @@
 	    FE_CAN_MUTE_TS | FE_CAN_QAM_256 | FE_CAN_RECOVER
 };
 
+struct at76c651_state {
+	u8 revision;
+	u8 qam;
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+};
+
 #if ! defined(__powerpc__)
 static __inline__ int __ilog2(unsigned long x)
 {
@@ -89,60 +96,55 @@
 }
 #endif
 
-static int at76c651_writereg(struct dvb_i2c_bus *i2c, u8 reg, u8 data)
+static int at76c651_writereg(struct i2c_adapter *i2c, u8 reg, u8 data)
 {
-
 	int ret;
 	u8 buf[] = { reg, data };
-	struct i2c_msg msg = { .addr = 0x1a >> 1, .flags = 0, .buf = buf, .len = 2 };
+	struct i2c_msg msg =
+		{ .addr = 0x1a >> 1, .flags = 0, .buf = buf, .len = 2 };
 
-	ret = i2c->xfer(i2c, &msg, 1);
+	ret = i2c_transfer(i2c, &msg, 1);
 
 	if (ret != 1)
 		dprintk("%s: writereg error "
 			"(reg == 0x%02x, val == 0x%02x, ret == %i)\n",
 			__FUNCTION__, reg, data, ret);
 
-	dvb_delay(10);
+	msleep(10);
 
 	return (ret != 1) ? -EREMOTEIO : 0;
-
 }
 
-static u8 at76c651_readreg(struct dvb_i2c_bus *i2c, u8 reg)
+static u8 at76c651_readreg(struct i2c_adapter *i2c, u8 reg)
 {
-
 	int ret;
-	u8 b0[] = { reg };
-	u8 b1[] = { 0 };
-	struct i2c_msg msg[] = { {.addr =  0x1a >> 1, .flags =  0, .buf =  b0, .len = 1},
-			  {.addr =  0x1a >> 1, .flags =  I2C_M_RD, .buf =  b1, .len = 1} };
+	u8 val;
+	struct i2c_msg msg[] = {
+		{ .addr = 0x1a >> 1, .flags = 0, .buf = &reg, .len = 1 },
+		{ .addr = 0x1a >> 1, .flags = I2C_M_RD, .buf = &val, .len = 1 }
+	};
 
-	ret = i2c->xfer(i2c, msg, 2);
+	ret = i2c_transfer(i2c, msg, 2);
 
 	if (ret != 2)
 		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
 
-	return b1[0];
-
+	return val;
 }
 
-static int at76c651_reset(struct dvb_i2c_bus *i2c)
+static int at76c651_reset(struct i2c_adapter *i2c)
 {
-
 	return at76c651_writereg(i2c, 0x07, 0x01);
-
 }
 
-static int at76c651_disable_interrupts(struct dvb_i2c_bus *i2c)
+static void at76c651_disable_interrupts(struct i2c_adapter *i2c)
 {
-
-	return at76c651_writereg(i2c, 0x0b, 0x00);
-
+	at76c651_writereg(i2c, 0x0b, 0x00);
 }
 
-static int at76c651_set_auto_config(struct dvb_i2c_bus *i2c)
+static int at76c651_set_auto_config(struct at76c651_state *state)
 {
+	struct i2c_adapter *i2c = state->i2c;
 
 	/*
 	 * Autoconfig
@@ -155,19 +157,19 @@
 	 */
 
 	at76c651_writereg(i2c, 0x10, 0x06);
-	at76c651_writereg(i2c, 0x11, ((at76c651_qam == 5) || (at76c651_qam == 7)) ? 0x12 : 0x10);
+	at76c651_writereg(i2c, 0x11, ((state->qam == 5) || (state->qam == 7)) ? 0x12 : 0x10);
 	at76c651_writereg(i2c, 0x15, 0x28);
 	at76c651_writereg(i2c, 0x20, 0x09);
-	at76c651_writereg(i2c, 0x24, ((at76c651_qam == 5) || (at76c651_qam == 7)) ? 0xC0 : 0x90);
+	at76c651_writereg(i2c, 0x24, ((state->qam == 5) || (state->qam == 7)) ? 0xC0 : 0x90);
 	at76c651_writereg(i2c, 0x30, 0x90);
-	if (at76c651_qam == 5)
+	if (state->qam == 5)
 		at76c651_writereg(i2c, 0x35, 0x2A);
 
 	/*
 	 * Initialize A/D-converter
 	 */
 
-	if (at76c651_revision == 0x11) {
+	if (state->revision == 0x11) {
 		at76c651_writereg(i2c, 0x2E, 0x38);
 		at76c651_writereg(i2c, 0x2F, 0x13);
 }
@@ -181,86 +183,62 @@
 	at76c651_reset(i2c);
 
 	return 0;
-
 }
 
-static int at76c651_set_bbfreq(struct dvb_i2c_bus *i2c)
+static void at76c651_set_bbfreq(struct i2c_adapter *i2c)
 {
-
 	at76c651_writereg(i2c, 0x04, 0x3f);
 	at76c651_writereg(i2c, 0x05, 0xee);
-
-	return 0;
-
 }
 
-static int at76c651_switch_tuner_i2c(struct dvb_i2c_bus *i2c, u8 enable)
+static int at76c651_pll_write(struct i2c_adapter *i2c, u8 *buf, size_t len)
 {
-
-	if (enable)
-		return at76c651_writereg(i2c, 0x0c, 0xc2 | 0x01);
-	else
-		return at76c651_writereg(i2c, 0x0c, 0xc2);
-
-}
-
-static int dat7021_write(struct dvb_i2c_bus *i2c, u32 tw)
-{
-
 	int ret;
 	struct i2c_msg msg =
-	    { .addr = 0xc2 >> 1, .flags = 0, .buf = (u8 *) & tw, .len = sizeof (tw) };
+	    { .addr = 0xc2 >> 1, .flags = 0, .buf = buf, .len = len };
 
-#ifdef __LITTLE_ENDIAN
-	tw = __cpu_to_be32(tw);
-#endif
-
-	at76c651_switch_tuner_i2c(i2c, 1);
-
-	ret = i2c->xfer(i2c, &msg, 1);
+	at76c651_writereg(i2c, 0x0c, 0xc3);
 
-	at76c651_switch_tuner_i2c(i2c, 0);
+	ret = i2c_transfer(i2c, &msg, 1);
 
-	if (ret != 4)
-		return -EFAULT;
+	at76c651_writereg(i2c, 0x0c, 0xc2);
 
-	at76c651_reset(i2c);
+	if (ret < 0)
+		return ret;
+	else if (ret != 1)
+		return -EREMOTEIO;
 
 	return 0;
-
 }
 
-static int dat7021_set_tv_freq(struct dvb_i2c_bus *i2c, u32 freq)
+static int tua6010_setfreq(struct i2c_adapter *i2c, u32 freq)
 {
+	u32 div;
+	u8 buf[4];
+	u8 vu, p2, p1, p0;
 
-	u32 dw;
-
-	freq /= 1000;
-
-	if ((freq < 48250) || (freq > 863250))
+	if ((freq < 50000000) || (freq > 900000000))
 		return -EINVAL;
 
-	/*
-	 * formula: dw=0x17e28e06+(freq-346000UL)/8000UL*0x800000
-	 *      or: dw=0x4E28E06+(freq-42000) / 125 * 0x20000
-	 */
-
-	dw = (freq - 42000) * 4096;
-	dw = dw / 125;
-	dw = dw * 32;
+	div = (freq + 36125000) / 62500;
 
-	if (freq > 394000)
-		dw += 0x4E28E85;
+	if (freq > 400000000)
+		vu = 1, p2 = 1, p1 = 0, p0 = 1;
+	else if (freq > 140000000)
+		vu = 0, p2 = 1, p1 = 1, p0 = 0;
 	else
-		dw += 0x4E28E06;
+		vu = 0, p2 = 0, p1 = 1, p0 = 1;
 
-	return dat7021_write(i2c, dw);
+	buf[0] = (div >> 8) & 0x7f;
+	buf[1] = (div >> 0) & 0xff;
+	buf[2] = 0x8e;
+	buf[3] = (vu << 7) | (p2 << 2) | (p1 << 1) | p0;
 
+	return at76c651_pll_write(i2c, buf, 4);
 }
 
-static int at76c651_set_symbolrate(struct dvb_i2c_bus *i2c, u32 symbolrate)
+static int at76c651_set_symbol_rate(struct i2c_adapter *i2c, u32 symbol_rate)
 {
-
 	u8 exponent;
 	u32 mantissa;
 
@@ -264,17 +242,17 @@
 	u8 exponent;
 	u32 mantissa;
 
-	if (symbolrate > 9360000)
+	if (symbol_rate > 9360000)
 		return -EINVAL;
 
 	/*
 	 * FREF = 57800 kHz
-	 * exponent = 10 + floor ( log2 ( symbolrate / FREF ) )
-	 * mantissa = ( symbolrate / FREF) * ( 1 << ( 30 - exponent ) )
+	 * exponent = 10 + floor (log2(symbol_rate / FREF))
+	 * mantissa = (symbol_rate / FREF) * (1 << (30 - exponent))
 	 */
 
-	exponent = __ilog2((symbolrate << 4) / 903125);
-	mantissa = ((symbolrate / 3125) * (1 << (24 - exponent))) / 289;
+	exponent = __ilog2((symbol_rate << 4) / 903125);
+	mantissa = ((symbol_rate / 3125) * (1 << (24 - exponent))) / 289;
 
 	at76c651_writereg(i2c, 0x00, mantissa >> 13);
 	at76c651_writereg(i2c, 0x01, mantissa >> 5);
@@ -281,37 +259,35 @@
 	at76c651_writereg(i2c, 0x02, (mantissa << 3) | exponent);
 
 	return 0;
-
 }
 
-static int at76c651_set_qam(struct dvb_i2c_bus *i2c, fe_modulation_t qam)
+static int at76c651_set_qam(struct at76c651_state *state, fe_modulation_t qam)
 {
-
 	switch (qam) {
 	case QPSK:
-		at76c651_qam = 0x02;
+		state->qam = 0x02;
 		break;
 	case QAM_16:
-		at76c651_qam = 0x04;
+		state->qam = 0x04;
 		break;
 	case QAM_32:
-		at76c651_qam = 0x05;
+		state->qam = 0x05;
 		break;
 	case QAM_64:
-		at76c651_qam = 0x06;
+		state->qam = 0x06;
 		break;
 	case QAM_128:
-		at76c651_qam = 0x07;
+		state->qam = 0x07;
 		break;
 	case QAM_256:
-		at76c651_qam = 0x08;
+		state->qam = 0x08;
 		break;
 #if 0
 	case QAM_512:
-		at76c651_qam = 0x09;
+		state->qam = 0x09;
 		break;
 	case QAM_1024:
-		at76c651_qam = 0x0A;
+		state->qam = 0x0A;
 		break;
 #endif
 	default:
@@ -319,14 +295,12 @@
 
 	}
 
-	return at76c651_writereg(i2c, 0x03, at76c651_qam);
-
+	return at76c651_writereg(state->i2c, 0x03, state->qam);
 }
 
-static int at76c651_set_inversion(struct dvb_i2c_bus *i2c,
+static int at76c651_set_inversion(struct i2c_adapter *i2c,
 		       fe_spectral_inversion_t inversion)
 {
-
 	u8 feciqinv = at76c651_readreg(i2c, 0x60);
 
 	switch (inversion) {
@@ -348,33 +322,36 @@
 	}
 
 	return at76c651_writereg(i2c, 0x60, feciqinv);
-
 }
 
-static int at76c651_set_parameters(struct dvb_i2c_bus *i2c,
+static int at76c651_set_parameters(struct at76c651_state *state,
 			struct dvb_frontend_parameters *p)
 {
+	struct i2c_adapter *i2c = state->i2c;
+	int ret;
 
-	dat7021_set_tv_freq(i2c, p->frequency);
-	at76c651_set_symbolrate(i2c, p->u.qam.symbol_rate);
-	at76c651_set_inversion(i2c, p->inversion);
-	at76c651_set_auto_config(i2c);
-        at76c651_reset(i2c);
+	if ((ret = tua6010_setfreq(i2c, p->frequency)))
+		return ret;
 
-	return 0;
+	if ((ret = at76c651_set_symbol_rate(i2c, p->u.qam.symbol_rate)))
+		return ret;
+
+	if ((ret = at76c651_set_inversion(i2c, p->inversion)))
+		return ret;
 
+	return at76c651_set_auto_config(state);
 }
 
-static int at76c651_set_defaults(struct dvb_i2c_bus *i2c)
+static int at76c651_set_defaults(struct at76c651_state *state)
 {
+	struct i2c_adapter *i2c = state->i2c;
 
-	at76c651_set_symbolrate(i2c, 6900000);
-	at76c651_set_qam(i2c, QAM_64);
+	at76c651_set_symbol_rate(i2c, 6900000);
+	at76c651_set_qam(state, QAM_64);
 	at76c651_set_bbfreq(i2c);
-	at76c651_set_auto_config(i2c);
+	at76c651_set_auto_config(state);
 
 	return 0;
-
 }
 
 static int at76c651_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
@@ -379,9 +356,10 @@
 
 static int at76c651_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
+	struct at76c651_state *state = fe->data;
+	struct i2c_adapter *i2c = state->i2c;
 
 	switch (cmd) {
-
 	case FE_GET_INFO:
 		memcpy(arg, &at76c651_info, sizeof (struct dvb_frontend_info));
 		break;
@@ -388,14 +366,13 @@
 
 	case FE_READ_STATUS:
 		{
-
-			fe_status_t *status = (fe_status_t *) arg;
+		fe_status_t *status = arg;
 			u8 sync;
 
 			/*
 			 * Bits: FEC, CAR, EQU, TIM, AGC2, AGC1, ADC, PLL (PLL=0) 
 			 */
-			sync = at76c651_readreg(fe->i2c, 0x80);
+		sync = at76c651_readreg(i2c, 0x80);
 
 			*status = 0;
 
@@ -420,13 +391,11 @@
 
 	case FE_READ_BER:
 		{
-			u32 *ber = (u32 *) arg;
-
-			*ber = (at76c651_readreg(fe->i2c, 0x81) & 0x0F) << 16;
-			*ber |= at76c651_readreg(fe->i2c, 0x82) << 8;
-			*ber |= at76c651_readreg(fe->i2c, 0x83);
+		u32 *ber = arg;
+		*ber = (at76c651_readreg(i2c, 0x81) & 0x0F) << 16;
+		*ber |= at76c651_readreg(i2c, 0x82) << 8;
+		*ber |= at76c651_readreg(i2c, 0x83);
 			*ber *= 10;
-
 			break;
 		}
 
@@ -432,25 +401,23 @@
 
 	case FE_READ_SIGNAL_STRENGTH:
 		{
-			u8 gain = ~at76c651_readreg(fe->i2c, 0x91);
-
+		u8 gain = ~at76c651_readreg(i2c, 0x91);
 			*(u16 *) arg = (gain << 8) | gain;
 			break;
 		}
 
 	case FE_READ_SNR:
-		*(u16 *) arg =
-		    0xFFFF -
-		    ((at76c651_readreg(fe->i2c, 0x8F) << 8) |
-		     at76c651_readreg(fe->i2c, 0x90));
+		*(u16 *)arg = 0xFFFF -
+		    ((at76c651_readreg(i2c, 0x8F) << 8) |
+		     at76c651_readreg(i2c, 0x90));
 		break;
 
 	case FE_READ_UNCORRECTED_BLOCKS:
-		*(u32 *) arg = at76c651_readreg(fe->i2c, 0x82);
+		*(u32 *)arg = at76c651_readreg(i2c, 0x82);
 		break;
 
 	case FE_SET_FRONTEND:
-		return at76c651_set_parameters(fe->i2c, arg);
+		return at76c651_set_parameters(state, arg);
 
 	case FE_GET_FRONTEND:
 		break;
@@ -459,15 +426,15 @@
 		break;
 
 	case FE_INIT:
-		return at76c651_set_defaults(fe->i2c);
+		return at76c651_set_defaults(state);
 
 	case FE_GET_TUNE_SETTINGS:
 	{
-	        struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
+	        struct dvb_frontend_tune_settings *fesettings = arg;
 	        fesettings->min_delay_ms = 50;
 	        fesettings->step_size = 0;
 	        fesettings->max_drift = 0;
-	        return 0;
+		break;
 	}	    
 
 	default:
@@ -475,61 +442,129 @@
 	}
 
 	return 0;
-
 }
 
-static int at76c651_attach(struct dvb_i2c_bus *i2c, void **data)
-{
-	if ( (at76c651_readreg(i2c, 0x0E) != 0x65) ||
-	     ( ( (at76c651_revision = at76c651_readreg(i2c, 0x0F)) & 0xFE) != 0x10) )
+static struct i2c_client client_template;
+
+static int attach_adapter(struct i2c_adapter *adapter)
 {
-		dprintk("no AT76C651(B) found\n");
+	struct at76c651_state *state;
+	struct i2c_client *client;
+	int ret;
+
+	if (at76c651_readreg(adapter, 0x0E) != 0x65)
+		return -ENODEV;
+
+	if (!(state = kmalloc(sizeof(struct at76c651_state), GFP_KERNEL)))
+		return -ENOMEM;
+
+	state->i2c = adapter;
+	state->revision = at76c651_readreg(adapter, 0x0F) & 0xFE;
+
+	switch (state->revision) {
+	case 0x10:
+		at76c651_info.name[14] = 'A';
+		break;
+	case 0x11:
+		at76c651_info.name[14] = 'B';
+		break;
+	default:
+		kfree(state);
 		return -ENODEV;
 	}
 
-	if (at76c651_revision == 0x10)
-	{
-		dprintk("AT76C651A found\n");
-		strcpy(at76c651_info.name,"Atmel AT76C651A with DAT7021");
+	if (!(client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		kfree(state);
+		return -ENOMEM;
+	}
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = 0x1a >> 1;
+	i2c_set_clientdata(client, state);
+
+	ret = i2c_attach_client(client);
+	if (ret) {
+		kfree(state);
+		kfree(client);
+		return ret;
+	}
+
+	BUG_ON(!state->dvb);
+
+	ret = dvb_register_frontend(at76c651_ioctl, state->dvb, state,
+					&at76c651_info, THIS_MODULE);
+	if (ret) {
+		i2c_detach_client(client);
+		kfree(client);
+		kfree(state);
+		return ret;
 		}
-	else
-	{
-		strcpy(at76c651_info.name,"Atmel AT76C651B with DAT7021");
-		dprintk("AT76C651B found\n");
+
+	return 0;
 	}
 
-	at76c651_set_defaults(i2c);
+static int detach_client(struct i2c_client *client)
+{
+	struct at76c651_state *state = i2c_get_clientdata(client);
 
-	return dvb_register_frontend(at76c651_ioctl, i2c, NULL, &at76c651_info);
+	dvb_unregister_frontend_new(at76c651_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
 
+	return 0;
 }
 
-static void at76c651_detach(struct dvb_i2c_bus *i2c, void *data)
+static int command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
+	struct at76c651_state *state = i2c_get_clientdata(client);
 
-	dvb_unregister_frontend(at76c651_ioctl, i2c);
+	switch (cmd) {
+	case FE_REGISTER:
+		state->dvb = arg;
+		break;
+	case FE_UNREGISTER:
+		state->dvb = NULL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 
+	return 0;
 }
 
-static int __init at76c651_init(void)
-{
+static struct i2c_driver driver = {
+	.owner		= THIS_MODULE,
+	.name		= FRONTEND_NAME,
+	.id		= I2C_DRIVERID_DVBFE_AT76C651,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= attach_adapter,
+	.detach_client	= detach_client,
+	.command	= command,
+};
 
-	return dvb_register_i2c_device(THIS_MODULE, at76c651_attach,
-				       at76c651_detach);
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags		= I2C_CLIENT_ALLOW_USE,
+	.driver		= &driver,
+};
 
+static int __init at76c651_init(void)
+{
+	return i2c_add_driver(&driver);
 }
 
 static void __exit at76c651_exit(void)
 {
-
-	dvb_unregister_i2c_device(at76c651_attach);
-
+	if (i2c_del_driver(&driver))
+		printk(KERN_ERR "at76c651: driver deregistration failed.\n");
 }
 
 module_init(at76c651_init);
 module_exit(at76c651_exit);
 
-MODULE_DESCRIPTION("at76c651/dat7021 dvb-c frontend driver");
+MODULE_DESCRIPTION("at76c651/tua6010xs dvb-c frontend driver");
 MODULE_AUTHOR("Andreas Oberritter <obi@linuxtv.org>");
 MODULE_LICENSE("GPL");
-MODULE_PARM(debug, "i");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/cx24110.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/cx24110.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/cx24110.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/cx24110.c	2004-08-18 19:52:17.000000000 +0200
@@ -35,13 +35,22 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
-static int debug = 0;
-#define dprintk	if (debug) printk
+#define FRONTEND_NAME "dvbfe_cx24110"
+
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
+
+static int debug;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 
 
 static struct dvb_frontend_info cx24110_info = {
@@ -63,6 +72,10 @@
 };
 /* fixme: are these values correct? especially ..._tolerance and caps */
 
+struct cx24110_state {
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+};
 
 static struct {u8 reg; u8 data;} cx24110_regdata[]=
                       /* Comments beginning with @ denote this value should
@@ -127,7 +140,7 @@
 	};
 
 
-static int cx24110_writereg (struct dvb_i2c_bus *i2c, int reg, int data)
+static int cx24110_writereg (struct i2c_adapter *i2c, int reg, int data)
 {
         u8 buf [] = { reg, data };
 	struct i2c_msg msg = { .addr = 0x55, .flags = 0, .buf = buf, .len = 2 };
@@ -135,8 +148,9 @@
    cx24110 might show up at any address */
 	int err;
 
-        if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
-		dprintk ("%s: writereg error (err == %i, reg == 0x%02x, data == 0x%02x)\n", __FUNCTION__, err, reg, data);
+        if ((err = i2c_transfer(i2c, &msg, 1)) != 1) {
+		dprintk ("%s: writereg error (err == %i, reg == 0x%02x,"
+			 " data == 0x%02x)\n", __FUNCTION__, err, reg, data);
 		return -EREMOTEIO;
 	}
 
@@ -144,7 +158,7 @@
 }
 
 
-static u8 cx24110_readreg (struct dvb_i2c_bus *i2c, u8 reg)
+static u8 cx24110_readreg (struct i2c_adapter *i2c, u8 reg)
 {
 	int ret;
 	u8 b0 [] = { reg };
@@ -152,7 +166,7 @@
 	struct i2c_msg msg [] = { { .addr = 0x55, .flags = 0, .buf = b0, .len = 1 },
 			   { .addr = 0x55, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
 /* fixme (medium): address might be different from 0x55 */
-	ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer(i2c, msg, 2);
 
 	if (ret != 2)
 		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
@@ -161,7 +175,7 @@
 }
 
 
-static int cx24108_write (struct dvb_i2c_bus *i2c, u32 data)
+static int cx24108_write (struct i2c_adapter *i2c, u32 data)
 {
 /* tuner data is 21 bits long, must be left-aligned in data */
 /* tuner cx24108 is written through a dedicated 3wire interface on the demod chip */
@@ -195,7 +209,7 @@
 }
 
 
-static int cx24108_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
+static int cx24108_set_tv_freq (struct i2c_adapter *i2c, u32 freq)
 {
 /* fixme (low): error handling */
         int i, a, n, pump;
@@ -247,7 +261,7 @@
         cx24108_write(i2c,pll);
         cx24110_writereg(i2c,0x56,0x7f);
 
-	dvb_delay(10); /* wait a moment for the tuner pll to lock */
+	msleep(10); /* wait a moment for the tuner pll to lock */
 
 	/* tuner pll lock can be monitored on GPIO pin 4 of cx24110 */
         while (!(cx24110_readreg(i2c,0x66)&0x20)&&i<1000)
@@ -259,7 +273,7 @@
 }
 
 
-static int cx24110_init (struct dvb_i2c_bus *i2c)
+static int cx24110_initfe(struct i2c_adapter *i2c)
 {
 /* fixme (low): error handling */
         int i;
@@ -274,7 +288,7 @@
 }
 
 
-static int cx24110_set_inversion (struct dvb_i2c_bus *i2c, fe_spectral_inversion_t inversion)
+static int cx24110_set_inversion (struct i2c_adapter *i2c, fe_spectral_inversion_t inversion)
 {
 /* fixme (low): error handling */
 
@@ -309,7 +323,7 @@
 }
 
 
-static int cx24110_set_fec (struct dvb_i2c_bus *i2c, fe_code_rate_t fec)
+static int cx24110_set_fec (struct i2c_adapter *i2c, fe_code_rate_t fec)
 {
 /* fixme (low): error handling */
 
@@ -355,7 +369,7 @@
 }
 
 
-static fe_code_rate_t cx24110_get_fec (struct dvb_i2c_bus *i2c)
+static fe_code_rate_t cx24110_get_fec (struct i2c_adapter *i2c)
 {
 	int i;
 
@@ -372,7 +386,7 @@
 }
 
 
-static int cx24110_set_symbolrate (struct dvb_i2c_bus *i2c, u32 srate)
+static int cx24110_set_symbolrate (struct i2c_adapter *i2c, u32 srate)
 {
 /* fixme (low): add error handling */
         u32 ratio;
@@ -454,7 +468,7 @@
 }
 
 
-static int cx24110_set_voltage (struct dvb_i2c_bus *i2c, fe_sec_voltage_t voltage)
+static int cx24110_set_voltage (struct i2c_adapter *i2c, fe_sec_voltage_t voltage)
 {
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
@@ -466,16 +480,17 @@
 	};
 }
 
-static void sendDiSEqCMessage(struct dvb_i2c_bus *i2c, struct dvb_diseqc_master_cmd *pCmd)
+static void cx24110_send_diseqc_msg(struct i2c_adapter *i2c,
+				    struct dvb_diseqc_master_cmd *cmd)
 {
 	int i, rv;
 
-	for (i = 0; i < pCmd->msg_len; i++)
-		cx24110_writereg(i2c, 0x79 + i, pCmd->msg[i]);
+	for (i = 0; i < cmd->msg_len; i++)
+		cx24110_writereg(i2c, 0x79 + i, cmd->msg[i]);
 
 	rv = cx24110_readreg(i2c, 0x76);
 
-	cx24110_writereg(i2c, 0x76, ((rv & 0x90) | 0x40) | ((pCmd->msg_len-3) & 3));
+	cx24110_writereg(i2c, 0x76, ((rv & 0x90) | 0x40) | ((cmd->msg_len-3) & 3));
 	for (i=500; i-- > 0 && !(cx24110_readreg(i2c,0x76)&0x40);)
 		; /* wait for LNB ready */
 }
@@ -483,7 +498,8 @@
 
 static int cx24110_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct cx24110_state *state = fe->data;
+	struct i2c_adapter *i2c = state->i2c;
 	static int lastber=0, lastbyer=0,lastbler=0, lastesn0=0, sum_bler=0;
 
         switch (cmd) {
@@ -618,7 +634,7 @@
 /* cannot do this from the FE end. How to communicate this to the place where it can be done? */
 		break;
         case FE_INIT:
-		return cx24110_init (i2c);
+		return cx24110_initfe(i2c);
 
 	case FE_SET_TONE:
 		return cx24110_writereg(i2c,0x76,(cx24110_readreg(i2c,0x76)&~0x10)|((((fe_sec_tone_mode_t) arg)==SEC_TONE_ON)?0x10:0));
@@ -626,7 +642,8 @@
 		return cx24110_set_voltage (i2c, (fe_sec_voltage_t) arg);
 
 	case FE_DISEQC_SEND_MASTER_CMD:
-		sendDiSEqCMessage(i2c, (struct dvb_diseqc_master_cmd*) arg);
+		// FIXME Status?
+		cx24110_send_diseqc_msg(i2c, (struct dvb_diseqc_master_cmd*) arg);
 		return 0;
 
 	default:
@@ -636,43 +653,118 @@
         return 0;
 }
 
+static struct i2c_client client_template;
 
-static int cx24110_attach (struct dvb_i2c_bus *i2c, void **data)
+static int attach_adapter (struct i2c_adapter *adapter)
 {
+	struct cx24110_state *state;
+	struct i2c_client *client;
+	int ret = 0;
 	u8 sig;
 
-	sig=cx24110_readreg (i2c, 0x00);
+	dprintk("Trying to attach to adapter 0x%x:%s.\n",
+		adapter->id, adapter->name);
+
+	sig = cx24110_readreg (adapter, 0x00);
 	if ( sig != 0x5a && sig != 0x69 )
 		return -ENODEV;
 
-	return dvb_register_frontend (cx24110_ioctl, i2c, NULL, &cx24110_info);
+	if ( !(state = kmalloc(sizeof(struct cx24110_state), GFP_KERNEL)) )
+		return -ENOMEM;
+
+	memset(state, 0, sizeof(struct cx24110_state));
+	state->i2c = adapter;
+
+	if ( !(client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)) ) {
+		kfree(state);
+		return -ENOMEM;
 }
 
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = 0x55;
+	i2c_set_clientdata(client, state);
 
-static void cx24110_detach (struct dvb_i2c_bus *i2c, void *data)
-{
-	dvb_unregister_frontend (cx24110_ioctl, i2c);
+	if ((ret = i2c_attach_client(client))) {
+		kfree(client);
+		kfree(state);
+		return ret;
 }
 
+	BUG_ON(!state->dvb);
 
-static int __init init_cx24110 (void)
-{
-	return dvb_register_i2c_device (THIS_MODULE, cx24110_attach, cx24110_detach);
+	if ((ret = dvb_register_frontend(cx24110_ioctl, state->dvb, state,
+					     &cx24110_info, THIS_MODULE))) {
+		i2c_detach_client(client);
+		kfree(client);
+		kfree(state);
+		return ret;
 }
 
+	return 0;
+}
 
-static void __exit exit_cx24110 (void)
+static int detach_client (struct i2c_client *client)
 {
-	dvb_unregister_i2c_device (cx24110_attach);
+	struct cx24110_state *state = i2c_get_clientdata(client);
+
+	dvb_unregister_frontend_new(cx24110_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
 }
 
+static int command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct cx24110_state *state = i2c_get_clientdata(client);
 
-module_init(init_cx24110);
-module_exit(exit_cx24110);
+	switch(cmd) {
+	case FE_REGISTER:
+		state->dvb = arg;
+		break;
+	case FE_UNREGISTER:
+		state->dvb = NULL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static struct i2c_driver driver = {
+	.owner		= THIS_MODULE,
+	.name		= FRONTEND_NAME,
+	.id		= I2C_DRIVERID_DVBFE_CX24110,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= attach_adapter,
+	.detach_client	= detach_client,
+	.command	= command,
+};
+
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags		= I2C_CLIENT_ALLOW_USE,
+	.driver		= &driver,
+};
+
+static int __init cx24110_init(void)
+{
+	return i2c_add_driver(&driver);
+}
+
+static void __exit cx24110_exit(void)
+{
+	if (i2c_del_driver(&driver))
+		printk(KERN_ERR "cx24110: driver deregistration failed.\n");
+}
 
+module_init(cx24110_init);
+module_exit(cx24110_exit);
 
 MODULE_DESCRIPTION("DVB Frontend driver module for the Conexant cx24108/cx24110 chipset");
 MODULE_AUTHOR("Peter Hettkamp");
 MODULE_LICENSE("GPL");
-MODULE_PARM(debug,"i");
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/dst.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/dst.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/dst.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/dst.c	2004-08-18 19:52:17.000000000 +0200
@@ -32,32 +30,19 @@
 #include <asm/div64.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 #include "dst-bt878.h"
 
-unsigned int dst_debug = 0;
 unsigned int dst_verbose = 0;
-
 MODULE_PARM(dst_verbose, "i");
-MODULE_PARM_DESC(dst_verbose,
-		 "verbose startup messages, default is 1 (yes)");
+MODULE_PARM_DESC(dst_verbose, "verbose startup messages, default is 1 (yes)");
+unsigned int dst_debug = 0;
 MODULE_PARM(dst_debug, "i");
 MODULE_PARM_DESC(dst_debug, "debug messages, default is 0 (no)");
 
-#define DST_MAX_CARDS	6
-unsigned int dst_cur_no = 0;
-
-unsigned int dst_type[DST_MAX_CARDS] = { [0 ... (DST_MAX_CARDS-1)] = (-1U)};
-unsigned int dst_type_flags[DST_MAX_CARDS] = { [0 ... (DST_MAX_CARDS-1)] = (-1U)};
-MODULE_PARM(dst_type, "1-" __stringify(DST_MAX_CARDS) "i");
-MODULE_PARM_DESC(dst_type,
-		"Type of DST card, 0 Satellite, 1 terrestial TV, 2 Cable, default driver determined");
-MODULE_PARM(dst_type_flags, "1-" __stringify(DST_MAX_CARDS) "i");
-MODULE_PARM_DESC(dst_type_flags,
-		"Type flags of DST card, bitfield 1=10 byte tuner, 2=TS is 204, 4=symdiv");
-
 #define dprintk	if (dst_debug) printk
 
+#define DST_I2C_ADDR 0x55
+
 #define DST_TYPE_IS_SAT		0
 #define DST_TYPE_IS_TERR	1
 #define DST_TYPE_IS_CABLE	2
@@ -90,8 +75,10 @@
 	unsigned long cur_jiff;
 	u8  k22;
 	fe_bandwidth_t bandwidth;
+
 	struct bt878 *bt;
-	struct dvb_i2c_bus *i2c;
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
 } ;
 
 static struct dvb_frontend_info dst_info_sat = {
@@ -105,8 +92,7 @@
 	.symbol_rate_max	= 45000000,
 /*     . symbol_rate_tolerance	= 	???,*/
 	.notifier_delay		= 50,                /* 1/20 s */
-	.caps = FE_CAN_FEC_AUTO |
-		FE_CAN_QPSK
+	.caps = FE_CAN_FEC_AUTO | FE_CAN_QPSK
 };
 
 static struct dvb_frontend_info dst_info_cable = {
@@ -119,19 +105,16 @@
 	.symbol_rate_max	= 45000000,
 /*     . symbol_rate_tolerance	= 	???,*/
 	.notifier_delay		= 50,                /* 1/20 s */
-	.caps = FE_CAN_FEC_AUTO |
-		FE_CAN_QAM_AUTO
+	.caps = FE_CAN_FEC_AUTO | FE_CAN_QAM_AUTO
 };
 
-static struct dvb_frontend_info dst_info_tv = {
+static struct dvb_frontend_info dst_info_terr = {
 	.name 			= "DST TERR",
 	.type 			= FE_OFDM,
 	.frequency_min 		= 137000000,
 	.frequency_max 		= 858000000,
 	.frequency_stepsize 	= 166667,
-	.caps = FE_CAN_FEC_AUTO |
-	    FE_CAN_QAM_AUTO |
-	    FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO
+	.caps = FE_CAN_FEC_AUTO | FE_CAN_QAM_AUTO | FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO
 };
 
 static void dst_packsize(struct dst_data *dst, int psize)
@@ -155,8 +138,7 @@
 		return -EREMOTEIO;
 	}
 
-	/* because complete disabling means no output, no need to do
-	 * output packet */
+	/* because complete disabling means no output, no need to do output packet */
 	if (enbb == 0)
 		return 0;
 
@@ -188,8 +170,7 @@
 #define DST_I2C_ENABLE	1
 #define DST_8820  	2
 
-static int
-dst_reset8820(struct dst_data *dst)
+static int dst_reset8820(struct dst_data *dst)
 {
 int retval;
 	/* pull 8820 gpio pin low, wait, high, wait, then low */
@@ -197,12 +178,12 @@
 	retval = dst_gpio_outb(dst, DST_8820, DST_8820, 0);
 	if (retval < 0)
 		return retval;
-	dvb_delay(10);
+	msleep(10);
 	retval = dst_gpio_outb(dst, DST_8820, DST_8820, DST_8820);
 	if (retval < 0)
 		return retval;
 	/* wait for more feedback on what works here *
-	dvb_delay(10);
+	   msleep(10);
 	retval = dst_gpio_outb(dst, DST_8820, DST_8820, 0);
 	if (retval < 0)
 		return retval;
@@ -210,8 +191,7 @@
 	return 0;
 }
 
-static int
-dst_i2c_enable(struct dst_data *dst)
+static int dst_i2c_enable(struct dst_data *dst)
 {
 int retval;
 	/* pull I2C enable gpio pin low, wait */
@@ -220,12 +200,11 @@
 	if (retval < 0)
 		return retval;
 	// dprintk ("%s: i2c enable delay\n", __FUNCTION__);
-	dvb_delay(33);
+	msleep(33);	
 	return 0;
 }
 
-static int
-dst_i2c_disable(struct dst_data *dst)
+static int dst_i2c_disable(struct dst_data *dst)
 {
 int retval;
 	/* release I2C enable gpio pin, wait */
@@ -234,12 +213,11 @@
 	if (retval < 0)
 		return retval;
 	// dprintk ("%s: i2c disable delay\n", __FUNCTION__);
-	dvb_delay(33);
+	msleep(33);
 	return 0;
 }
 
-static int
-dst_wait_dst_ready(struct dst_data *dst)
+static int dst_wait_dst_ready(struct dst_data *dst)
 {
 u8 reply;
 int retval;
@@ -252,18 +230,17 @@
 			dprintk ("%s: dst wait ready after %d\n", __FUNCTION__, i);
 			return 1;
 		}
-		dvb_delay(5);
+		msleep(5);
 	}
 	dprintk ("%s: dst wait NOT ready after %d\n", __FUNCTION__, i);
 	return 0;
 }
 
-#define DST_I2C_ADDR 0x55
-
 static int write_dst (struct dst_data *dst, u8 *data, u8 len)
 {
 	struct i2c_msg msg = {
-		.addr = DST_I2C_ADDR, .flags = 0, .buf = data, .len = len };
+		.addr = DST_I2C_ADDR,.flags = 0,.buf = data,.len = len
+	};
 	int err;
 	int cnt;
 
@@ -275,14 +252,14 @@
 		}
 		dprintk("\n");
 	}
-	dvb_delay(30);
+	msleep(30);
 	for (cnt = 0; cnt < 4; cnt++) {
-		if ((err = dst->i2c->xfer (dst->i2c, &msg, 1)) < 0) {
+		if ((err = i2c_transfer(dst->i2c, &msg, 1)) < 0) {
 			dprintk ("%s: write_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, data[0]);
 			dst_i2c_disable(dst);
-			dvb_delay(500);
+			msleep(500);
 			dst_i2c_enable(dst);
-			dvb_delay(500);
+			msleep(500);
 			continue;
 		} else
 			break;
@@ -294,13 +271,12 @@
 
 static int read_dst (struct dst_data *dst, u8 *ret, u8 len)
 {
-	struct i2c_msg msg = 
-		{ .addr = DST_I2C_ADDR, .flags = I2C_M_RD, .buf = ret, .len = len };
+	struct i2c_msg msg = {.addr = DST_I2C_ADDR,.flags = I2C_M_RD,.buf = ret,.len = len };
 	int err;
 	int cnt;
 
 	for (cnt = 0; cnt < 4; cnt++) {
-		if ((err = dst->i2c->xfer (dst->i2c, &msg, 1)) < 0) {
+		if ((err = i2c_transfer(dst->i2c, &msg, 1)) < 0) {
 			dprintk ("%s: read_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, ret[0]);
 			dst_i2c_disable(dst);
 			dst_i2c_enable(dst);
@@ -505,7 +480,9 @@
 	{ "DSTFCI",  1,  DST_TYPE_IS_SAT,    DST_TYPE_HAS_NEWTUNE },
 	{ "DCTNEW",  1,  DST_TYPE_IS_CABLE,  DST_TYPE_HAS_NEWTUNE },
 	{ "DCT_CI",  1,  DST_TYPE_IS_CABLE,  DST_TYPE_HAS_NEWTUNE|DST_TYPE_HAS_TS204 },
-	{ "DTTDIG" , 1,  DST_TYPE_IS_TERR,   0} };
+	{"DTTDIG",  1, DST_TYPE_IS_TERR, 0}
+};
+
 /* DCTNEW and DCT-CI are guesses */
 
 static void dst_type_flags_print(u32 type_flags)
@@ -534,8 +511,7 @@
 			otype = "terrestial TV";
 			break;
 		default:
-			printk("%s: invalid dst type %d\n",
-				__FUNCTION__, type);
+		printk("%s: invalid dst type %d\n", __FUNCTION__, type);
 			return -EINVAL;
 	}
 	printk("DST type : %s\n", otype);
@@ -564,7 +540,7 @@
 		dprintk("%s: write not successful, maybe no card?\n", __FUNCTION__);
 		return retval;
 	}
-	dvb_delay(3);
+	msleep(3);
 	retval = read_dst (dst, rxbuf, 1);
 	dst_i2c_disable(dst);
 	if (retval < 0) {
@@ -590,9 +566,7 @@
 	}
 	rxbuf[7] = '\0';
 	for (i = 0, dsp = &dst_tlist[0]; i < sizeof(dst_tlist) / sizeof(dst_tlist[0]); i++, dsp++) {
-		if (!strncmp(&rxbuf[dsp->offs],
-				dsp->mstr,
-				strlen(dsp->mstr))) {
+		if (!strncmp(&rxbuf[dsp->offs], dsp->mstr, strlen(dsp->mstr))) {
 			use_type_flags = dsp->type_flags;
 			use_dst_type = dsp->dst_type;
 			printk("%s: recognize %s\n", __FUNCTION__, dsp->mstr);
@@ -605,26 +579,8 @@
 		use_dst_type = DST_TYPE_IS_SAT;
 		use_type_flags = DST_TYPE_HAS_SYMDIV;
 	}
-	switch (dst_type[dst_cur_no]) {
-		case (-1U):
-			/* not used */
-			break;
-		case DST_TYPE_IS_SAT:
-		case DST_TYPE_IS_TERR:
-		case DST_TYPE_IS_CABLE:
-			use_dst_type = (u8)(dst_type[dst_cur_no]);
-			break;
-		default:
-			printk("%s: invalid user override dst type %d, not used\n",
-				__FUNCTION__, dst_type[dst_cur_no]);
-			break;
-	}
 	dst_type_print(use_dst_type);
-	if (dst_type_flags[dst_cur_no] != (-1U)) {
-		printk("%s: user override dst type flags 0x%x\n",
-				__FUNCTION__, dst_type_flags[dst_cur_no]);
-		use_type_flags = dst_type_flags[dst_cur_no];
-	}
+
 	dst->type_flags = use_type_flags;
 	dst->dst_type= use_dst_type;
 	dst_type_flags_print(dst->type_flags);
@@ -648,7 +604,7 @@
 		dprintk("%s: write not successful\n", __FUNCTION__);
 		return retval;
 	}
-	dvb_delay(33);
+	msleep(33);
 	retval = read_dst (dst, &reply, 1);
 	dst_i2c_disable(dst);
 	if (retval < 0) {
@@ -695,15 +651,11 @@
 		if (retval < 0)
 			return retval;
 		if (dst->dst_type == DST_TYPE_IS_SAT) {
-			dst->decode_lock = ((dst->rxbuffer[6] & 0x10) == 0) ?
-					1 : 0;
+			dst->decode_lock = ((dst->rxbuffer[6] & 0x10) == 0) ? 1 : 0;
 			dst->decode_strength = dst->rxbuffer[5] << 8;
-			dst->decode_snr = dst->rxbuffer[2] << 8 |
-				dst->rxbuffer[3];
-		} else if ((dst->dst_type == DST_TYPE_IS_TERR) ||
-				(dst->dst_type == DST_TYPE_IS_CABLE)) {
-			dst->decode_lock = (dst->rxbuffer[1]) ?
-					1 : 0;
+			dst->decode_snr = dst->rxbuffer[2] << 8 | dst->rxbuffer[3];
+		} else if ((dst->dst_type == DST_TYPE_IS_TERR) || (dst->dst_type == DST_TYPE_IS_CABLE)) {
+			dst->decode_lock = (dst->rxbuffer[1]) ? 1 : 0;
 			dst->decode_strength = dst->rxbuffer[4] << 8;
 			dst->decode_snr = dst->rxbuffer[3] << 8;
 		}
@@ -899,7 +851,7 @@
 		dprintk("%s: write not successful\n", __FUNCTION__);
 		return retval;
 	}
-	dvb_delay(3);
+	msleep(3);
 	retval = read_dst (dst, &reply, 1);
 	dst_i2c_disable(dst);
 	if (retval < 0) {
@@ -933,19 +885,13 @@
 	dst->cur_jiff = jiffies;
 	if (dst->dst_type == DST_TYPE_IS_SAT) {
 		dst->frequency = 950000;
-		memcpy(dst->tx_tuna, ((dst->type_flags &  DST_TYPE_HAS_NEWTUNE )? 
-					ini_satci_tuna : ini_satfta_tuna),
-				sizeof(ini_satfta_tuna));
+		memcpy(dst->tx_tuna, ((dst->type_flags & DST_TYPE_HAS_NEWTUNE) ? ini_satci_tuna : ini_satfta_tuna), sizeof(ini_satfta_tuna));
 	} else if (dst->dst_type == DST_TYPE_IS_TERR) {
 		dst->frequency = 137000000;
-		memcpy(dst->tx_tuna, ((dst->type_flags &  DST_TYPE_HAS_NEWTUNE )? 
-					ini_tvci_tuna : ini_tvfta_tuna),
-				sizeof(ini_tvfta_tuna));
+		memcpy(dst->tx_tuna, ((dst->type_flags & DST_TYPE_HAS_NEWTUNE) ? ini_tvci_tuna : ini_tvfta_tuna), sizeof(ini_tvfta_tuna));
 	} else if (dst->dst_type == DST_TYPE_IS_CABLE) {
 		dst->frequency = 51000000;
-		memcpy(dst->tx_tuna, ((dst->type_flags &  DST_TYPE_HAS_NEWTUNE )? 
-					ini_cabci_tuna : ini_cabfta_tuna),
-				sizeof(ini_cabfta_tuna));
+		memcpy(dst->tx_tuna, ((dst->type_flags & DST_TYPE_HAS_NEWTUNE) ? ini_cabci_tuna : ini_cabfta_tuna), sizeof(ini_cabfta_tuna));
 	}
 }
 
@@ -953,19 +899,19 @@
 	unsigned int cmd;
 	char *desc;
 } looker[] = {
-	{FE_GET_INFO,                "FE_GET_INFO:"},
-	{FE_READ_STATUS,             "FE_READ_STATUS:" },
-	{FE_READ_BER,                "FE_READ_BER:" },
-	{FE_READ_SIGNAL_STRENGTH,    "FE_READ_SIGNAL_STRENGTH:" },
-	{FE_READ_SNR,                "FE_READ_SNR:" },
-	{FE_READ_UNCORRECTED_BLOCKS, "FE_READ_UNCORRECTED_BLOCKS:" },
-	{FE_SET_FRONTEND,            "FE_SET_FRONTEND:" },
-	{FE_GET_FRONTEND,            "FE_GET_FRONTEND:" },
-	{FE_SLEEP,                   "FE_SLEEP:" },
-	{FE_INIT,                    "FE_INIT:" },
-	{FE_SET_TONE,                "FE_SET_TONE:" },
-	{FE_SET_VOLTAGE,             "FE_SET_VOLTAGE:" },
-	};
+	{
+	FE_GET_INFO, "FE_GET_INFO:"}, {
+	FE_READ_STATUS, "FE_READ_STATUS:"}, {
+	FE_READ_BER, "FE_READ_BER:"}, {
+	FE_READ_SIGNAL_STRENGTH, "FE_READ_SIGNAL_STRENGTH:"}, {
+	FE_READ_SNR, "FE_READ_SNR:"}, {
+	FE_READ_UNCORRECTED_BLOCKS, "FE_READ_UNCORRECTED_BLOCKS:"}, {
+	FE_SET_FRONTEND, "FE_SET_FRONTEND:"}, {
+	FE_GET_FRONTEND, "FE_GET_FRONTEND:"}, {
+	FE_SLEEP, "FE_SLEEP:"}, {
+	FE_INIT, "FE_INIT:"}, {
+	FE_SET_TONE, "FE_SET_TONE:"}, {
+FE_SET_VOLTAGE, "FE_SET_VOLTAGE:"},};
 
 static int dst_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
@@ -985,14 +931,14 @@
 	*/
 	// printk("%s: dst %8.8x bt %8.8x i2c %8.8x\n", __FUNCTION__, dst, dst->bt, dst->i2c);
 	/* should be set by attach, but just in case */
-	dst->i2c = fe->i2c;
+
         switch (cmd) {
         case FE_GET_INFO: 
 	{
 	     struct dvb_frontend_info *info;
 		info = &dst_info_sat;
 		if (dst->dst_type == DST_TYPE_IS_TERR)
-			info = &dst_info_tv;
+				info = &dst_info_terr;
 		else if (dst->dst_type == DST_TYPE_IS_CABLE)
 			info = &dst_info_cable;
 		memcpy (arg, info, sizeof(struct dvb_frontend_info));
@@ -1006,11 +952,7 @@
 		if (dst->diseq_flags & HAS_LOCK) {
 			dst_get_signal(dst);
 			if (dst->decode_lock)
-				*status |= FE_HAS_LOCK 
-					| FE_HAS_SIGNAL 
-					| FE_HAS_CARRIER
-					| FE_HAS_SYNC
-					| FE_HAS_VITERBI;
+					*status |= FE_HAS_LOCK | FE_HAS_SIGNAL | FE_HAS_CARRIER | FE_HAS_SYNC | FE_HAS_VITERBI;
 		}
 		break;
 	}
@@ -1115,21 +1057,68 @@
         return 0;
 } 
 
+static ssize_t attr_read_type(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct dst_data *dst = (struct dst_data *) i2c_get_clientdata(client);
+	return sprintf(buf, "0x%02x\n", dst->dst_type);
+}
 
-static int dst_attach (struct dvb_i2c_bus *i2c, void **data)
+static ssize_t attr_write_type(struct device *dev, const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct dst_data *dst = (struct dst_data *) i2c_get_clientdata(client);
+	unsigned long type;
+	type = simple_strtoul(buf, NULL, 0);
+	dst->dst_type = type & 0xff;
+	return strlen(buf) + 1;
+}
+
+/* dst_type, "Type of DST card, 0 Satellite, 1 terrestial, 2 Cable, default driver determined"); */
+static struct device_attribute dev_attr_client_type = {
+	.attr = {.name = "type",.mode = S_IRUGO | S_IWUGO,.owner = THIS_MODULE},
+	.show = &attr_read_type,
+	.store = &attr_write_type,
+};
+
+static ssize_t attr_read_flags(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct dst_data *dst = (struct dst_data *) i2c_get_clientdata(client);
+	return sprintf(buf, "0x%02x\n", dst->type_flags);
+}
+
+static ssize_t attr_write_flags(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct dst_data *dst = (struct dst_data *) i2c_get_clientdata(client);
+	unsigned long flags;
+	flags = simple_strtoul(buf, NULL, 0);
+	dst->type_flags = flags & 0xffffffff;
+	return strlen(buf) + 1;
+}
+
+/* dst_type_flags, "Type flags of DST card, bitfield 1=10 byte tuner, 2=TS is 204, 4=symdiv"); */
+static struct device_attribute dev_attr_client_flags = {
+	.attr = {.name = "flags",.mode = S_IRUGO | S_IWUGO,.owner = THIS_MODULE},
+	.show = &attr_read_flags,
+	.store = &attr_write_flags,
+};
+
+static struct i2c_client client_template;
+
+static int attach_adapter(struct i2c_adapter *adapter)
+{
+	struct i2c_client *client;
 	struct dst_data *dst;
 	struct bt878 *bt;
 	struct dvb_frontend_info *info;
+	int ret;
 
-	dprintk("%s: check ci\n", __FUNCTION__);
-	if (dst_cur_no >= DST_MAX_CARDS) {
-		dprintk("%s: can't have more than %d cards\n", __FUNCTION__, DST_MAX_CARDS);
-		return -ENODEV;
-	}
-	bt = bt878_find_by_dvb_adap(i2c->adapter);
+	bt = bt878_find_by_i2c_adap(adapter);
 	if (!bt)
 		return -ENODEV;
+
 	dst = kmalloc(sizeof(struct dst_data), GFP_KERNEL);
 	if (dst == NULL) {
 		printk(KERN_INFO "%s: Out of memory.\n", __FUNCTION__);
@@ -1135,10 +1124,10 @@
 		printk(KERN_INFO "%s: Out of memory.\n", __FUNCTION__);
 		return -ENOMEM;
 	}
+
 	memset(dst, 0, sizeof(*dst));
-	*data = dst;
 	dst->bt = bt;
-	dst->i2c = i2c;
+	dst->i2c = adapter;
 	if (dst_check_ci(dst) < 0) {
 		kfree(dst);
 		return -ENODEV;
@@ -1143,41 +1132,122 @@
 		kfree(dst);
 		return -ENODEV;
 	}
-
 	dst_init (dst);
-	dprintk("%s: register dst %8.8x bt %8.8x i2c %8.8x\n", __FUNCTION__, 
-			(u32)dst, (u32)(dst->bt), (u32)(dst->i2c));
 
-	info = &dst_info_sat;
-	if (dst->dst_type == DST_TYPE_IS_TERR)
-		info = &dst_info_tv;
-	else if (dst->dst_type == DST_TYPE_IS_CABLE)
+	dprintk("%s: register dst %8.8x bt %8.8x i2c %8.8x\n", __FUNCTION__, (u32) dst, (u32) (dst->bt), (u32) (dst->i2c));
+
+	switch (dst->dst_type) {
+	case DST_TYPE_IS_TERR:
+		info = &dst_info_terr;
+		break;
+	case DST_TYPE_IS_CABLE:
 		info = &dst_info_cable;
+		break;
+	case DST_TYPE_IS_SAT:
+		info = &dst_info_sat;
+		break;
+	default:
+		printk("dst: unknown frontend type. please report to the LinuxTV.org DVB mailinglist.\n");
+		kfree(dst);
+		return -ENODEV;
+	}
+
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		kfree(dst);
+		return -ENOMEM;
+	}
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = DST_I2C_ADDR;
+
+	i2c_set_clientdata(client, (void *) dst);
+
+	ret = i2c_attach_client(client);
+	if (ret) {
+		kfree(client);
+		kfree(dst);
+		return -EFAULT;
+	}
+
+	BUG_ON(!dst->dvb);
+
+	device_create_file(&client->dev, &dev_attr_client_type);
+	device_create_file(&client->dev, &dev_attr_client_flags);
+
+	ret = dvb_register_frontend(dst_ioctl, dst->dvb, dst, info, THIS_MODULE);
+	if (ret) {
+		i2c_detach_client(client);
+		kfree(client);
+		kfree(dst);
+		return -EFAULT;
+	}
 
-	dvb_register_frontend (dst_ioctl, i2c, dst, info);
-	dst_cur_no++;
 	return 0;
 }
 
-static void dst_detach (struct dvb_i2c_bus *i2c, void *data)
+static int detach_client(struct i2c_client *client)
 {
-	dvb_unregister_frontend (dst_ioctl, i2c);
-	dprintk("%s: unregister dst %8.8x\n", __FUNCTION__, (u32)(data));
-	if (data)
-		kfree(data);
+	struct dst_data *state = (struct dst_data *) i2c_get_clientdata(client);
+	
+	dvb_unregister_frontend_new(dst_ioctl, state->dvb);
+
+	device_remove_file(&client->dev, &dev_attr_client_type);
+	device_remove_file(&client->dev, &dev_attr_client_flags);
+
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+
+	kfree(client);
+	kfree(state);
+
+	return 0;
 }
 
+static int command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct dst_data *state = (struct dst_data *) i2c_get_clientdata(client);
+
+	switch (cmd) {
+	case FE_REGISTER:
+		state->dvb = (struct dvb_adapter *) arg;
+		break;
+	case FE_UNREGISTER:
+		state->dvb = NULL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static struct i2c_driver driver = {
+	.owner = THIS_MODULE,
+	.name = "dst",
+	.id = I2C_DRIVERID_DVBFE_DST,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client = detach_client,
+	.command = command,
+};
+
+static struct i2c_client client_template = {
+	I2C_DEVNAME("dst"),
+	.flags = I2C_CLIENT_ALLOW_USE,
+	.driver = &driver,
+};
+
 static int __init init_dst (void)
 {
-	return dvb_register_i2c_device (THIS_MODULE, dst_attach, dst_detach);
+	return i2c_add_driver(&driver);
 }
 
 static void __exit exit_dst (void)
 {
-	dvb_unregister_i2c_device (dst_attach);
+	if (i2c_del_driver(&driver))
+		printk("dst: driver deregistration failed\n");
 }
 
-
 module_init(init_dst);
 module_exit(exit_dst);
 

--------------010405030003040403010805--
