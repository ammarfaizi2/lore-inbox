Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUIQPAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUIQPAA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUIQO77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:59:59 -0400
Received: from mail.convergence.de ([212.227.36.84]:49056 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268812AbUIQOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:33:00 -0400
Message-ID: <414AF569.2020803@linuxtv.org>
Date: Fri, 17 Sep 2004 16:32:09 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][7/14] convert frontend drivers to kernel i2c 3/3
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org>
In-Reply-To: <414AF51D.4060308@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------080302080608000807080806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080302080608000807080806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------080302080608000807080806
Content-Type: text/plain;
 name="07-DVB-frontend-conversion3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="07-DVB-frontend-conversion3.diff"

- [DVB] dvb_dummy_fe, grundig_29504-401, grundig_29504-491, mt312: convert from dvb-i2c to kernel-i2c, MODULE_PARM() to module_param(), dvb_delay() to mdelay()
- [DVB] update frontend Kconfig

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/dvb_dummy_fe.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/dvb_dummy_fe.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/dvb_dummy_fe.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/dvb_dummy_fe.c	2004-08-18 19:52:17.000000000 +0200
@@ -20,12 +20,16 @@
  */    
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 
 #include "dvb_frontend.h"
 
-static int sct = 0;
+#define FRONTEND_NAME "dvbfe_dummy"
 
+static int frontend_type;
+module_param(frontend_type, int, 0444);
+MODULE_PARM_DESC(frontend_type, "0 == DVB-S, 1 == DVB-C, 2 == DVB-T");
 
 /* depending on module parameter sct deliver different infos
  */
@@ -87,8 +91,7 @@
 
 struct dvb_frontend_info *frontend_info(void)
 {
-	switch(sct)
-	{
+	switch(frontend_type) {
 	case 2:
 		return &dvb_t_dummyfe_info;
 	case 1:
@@ -168,30 +171,89 @@
         return 0;
 } 
 
+static struct i2c_client client_template;
 
-static int dvbdummyfe_attach (struct dvb_i2c_bus *i2c, void **data)
+static int dvbdummyfe_attach_adapter(struct i2c_adapter *adapter)
 {
-	return dvb_register_frontend (dvbdummyfe_ioctl, i2c, NULL, frontend_info());
+	struct dvb_adapter *dvb;
+	struct i2c_client *client;
+	int ret;
+
+	if ((client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+
+	if ((ret = i2c_attach_client(client))) {
+		kfree(client);
+		return ret;
 }
 
+	dvb = i2c_get_clientdata(client);
+	BUG_ON(!dvb);
 
-static void dvbdummyfe_detach (struct dvb_i2c_bus *i2c, void *data)
+	if ((ret = dvb_register_frontend(dvbdummyfe_ioctl, dvb, NULL,
+					     frontend_info(), THIS_MODULE))) {
+		kfree(client);
+		return ret;
+	}
+
+	return 0;
+}
+
+
+static int dvbdummyfe_detach_client(struct i2c_client *client)
 {
-	dvb_unregister_frontend (dvbdummyfe_ioctl, i2c);
+	struct dvb_adapter *dvb = i2c_get_clientdata(client);
+
+	dvb_unregister_frontend_new(dvbdummyfe_ioctl, dvb);
+	i2c_detach_client(client);
+	kfree(client);
+	return 0;
 }
 
+static int dvbdummyfe_command(struct i2c_client *client,
+			      unsigned int cmd, void *arg)
+{
+	switch(cmd) {
+	case FE_REGISTER:
+		i2c_set_clientdata(client, arg);
+		break;
+	case FE_UNREGISTER:
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
+	.id		= I2C_DRIVERID_DVBFE_DUMMY,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= dvbdummyfe_attach_adapter,
+	.detach_client	= dvbdummyfe_detach_client,
+	.command	= dvbdummyfe_command,
+};
+
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags		= I2C_CLIENT_ALLOW_USE,
+	.driver		= &driver,
+};
 
 static int __init init_dvbdummyfe (void)
 {
-	return dvb_register_i2c_device (THIS_MODULE,
-					dvbdummyfe_attach, 
-					dvbdummyfe_detach);
+	return i2c_add_driver(&driver);
 }
 
-
 static void __exit exit_dvbdummyfe (void)
 {
-	dvb_unregister_i2c_device (dvbdummyfe_attach);
+	if (i2c_del_driver(&driver))
+		printk(KERN_ERR "dummyfe: driver deregistration failed.\n");
 }
 
 
@@ -202,4 +263,4 @@
 MODULE_DESCRIPTION("DVB DUMMY Frontend");
 MODULE_AUTHOR("Emard");
 MODULE_LICENSE("GPL");
-MODULE_PARM(sct, "i");
+
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/grundig_29504-401.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/grundig_29504-401.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/grundig_29504-401.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/grundig_29504-401.c	2004-08-18 19:52:17.000000000 +0200
@@ -25,22 +25,35 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
-static int debug = 0;
+#define FRONTEND_NAME "dvbfe_l64781"
 
-#define dprintk	if (debug) printk
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
+
+static int debug;
+static int old_set_tv_freq;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
+module_param(old_set_tv_freq, int, 0644);
+MODULE_PARM_DESC(old_set_tv_freq, "Use old tsa5060_set_tv_freq calculations.");
 
-struct grundig_state {
+struct l64781_state {
 	int first:1;
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
 };
 
-struct dvb_frontend_info grundig_29504_401_info = {
-	.name = "Grundig 29504-401",
+struct dvb_frontend_info l64781_info = {
+	.name = "Grundig 29504-401 (LSI L64781 Based)",
 	.type = FE_OFDM,
 /*	.frequency_min = ???,*/
 /*	.frequency_max = ???,*/
@@ -55,13 +68,13 @@
 };
 
 
-static int l64781_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
+static int l64781_writereg (struct i2c_adapter *i2c, u8 reg, u8 data)
 {
 	int ret;
 	u8 buf [] = { reg, data };
 	struct i2c_msg msg = { .addr = 0x55, .flags = 0, .buf = buf, .len = 2 };
 
-	if ((ret = i2c->xfer (i2c, &msg, 1)) != 1)
+	if ((ret = i2c_transfer(i2c, &msg, 1)) != 1)
 		dprintk ("%s: write_reg error (reg == %02x) = %02x!\n",
 			 __FUNCTION__, reg, ret);
 
@@ -69,7 +82,7 @@
 }
 
 
-static u8 l64781_readreg (struct dvb_i2c_bus *i2c, u8 reg)
+static u8 l64781_readreg (struct i2c_adapter *i2c, u8 reg)
 {
 	int ret;
 	u8 b0 [] = { reg };
@@ -77,7 +90,7 @@
 	struct i2c_msg msg [] = { { .addr = 0x55, .flags = 0, .buf = b0, .len = 1 },
 			   { .addr = 0x55, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
 
-	ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer(i2c, msg, 2);
 
 	if (ret != 2)
 		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
@@ -86,12 +99,12 @@
 }
 
 
-static int tsa5060_write (struct dvb_i2c_bus *i2c, u8 data [4])
+static int tsa5060_write (struct i2c_adapter *i2c, u8 data [4])
 {
 	int ret;
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = 4 };
 
-	if ((ret = i2c->xfer (i2c, &msg, 1)) != 1)
+	if ((ret = i2c_transfer(i2c, &msg, 1)) != 1)
 		dprintk ("%s: write_reg error == %02x!\n", __FUNCTION__, ret);
 
 	return (ret != 1) ? -1 : 0;
@@ -103,14 +116,17 @@
  *   reference clock comparision frequency of 166666 Hz.
  *   frequency offset is 36125000 Hz.
  */
-static int tsa5060_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
+static int tsa5060_set_tv_freq (struct i2c_adapter *i2c, u32 freq)
 {
-#if 1
 	u32 div;
 	u8 buf [4];
 	u8 cfg, cpump, band_select;
 
+	if (old_set_tv_freq)
+	        div = (36000000 + freq) / 166666;
+	else
 	div = (36125000 + freq) / 166666;
+
 	cfg = 0x88;
 
 	cpump = freq < 175000000 ? 2 : freq < 390000000 ? 1 :
@@ -121,27 +137,18 @@
 	buf [0] = (div >> 8) & 0x7f;
 	buf [1] = div & 0xff;
 	buf [2] = ((div >> 10) & 0x60) | cfg;
-	buf [3] = (cpump << 6) | band_select;
-#else
-	/* old code which seems to work better for at least one person */
-        u32 div;
-        u8 buf [4];
-        u8 cfg;
-
-        div = (36000000 + freq) / 166666;
-        cfg = 0x88;
 
-        buf [0] = (div >> 8) & 0x7f;
-        buf [1] = div & 0xff;
-        buf [2] = ((div >> 10) & 0x60) | cfg;
+	if (old_set_tv_freq)
         buf [3] = 0xc0;
-#endif
+	else
+		buf [3] = (cpump << 6) | band_select;
 
 	return tsa5060_write (i2c, buf);
 }
 
 
-static void apply_tps (struct dvb_i2c_bus *i2c)
+
+static void apply_tps (struct i2c_adapter *i2c)
 {
 	l64781_writereg (i2c, 0x2a, 0x00);
 	l64781_writereg (i2c, 0x2a, 0x01);
@@ -155,7 +162,7 @@
 }
 
 
-static void reset_afc (struct dvb_i2c_bus *i2c)
+static void reset_afc (struct i2c_adapter *i2c)
 {
 	/* Set AFC stall for the AFC_INIT_FRQ setting, TIM_STALL for
 	   timing offset */
@@ -173,7 +180,7 @@
 }
 
 
-static int apply_frontend_param (struct dvb_i2c_bus *i2c,
+static int apply_frontend_param (struct i2c_adapter *i2c,
 			  struct dvb_frontend_parameters *param)
 {
 	/* The coderates for FEC_NONE, FEC_4_5 and FEC_FEC_6_7 are arbitrary */
@@ -285,16 +292,16 @@
 }
 
 
-static int reset_and_configure (struct dvb_i2c_bus *i2c)
+static int reset_and_configure (struct i2c_adapter *i2c)
 {
 	u8 buf [] = { 0x06 };
 	struct i2c_msg msg = { .addr = 0x00, .flags = 0, .buf = buf, .len = 1 };
 
-	return (i2c->xfer (i2c, &msg, 1) == 1) ? 0 : -ENODEV;
+	return (i2c_transfer(i2c, &msg, 1) == 1) ? 0 : -ENODEV;
 }
 
 
-static int get_frontend(struct dvb_i2c_bus* i2c, struct dvb_frontend_parameters* param)
+static int get_frontend(struct i2c_adapter* i2c, struct dvb_frontend_parameters* param)
 {
 	int tmp;
 
@@ -412,7 +419,7 @@
 }
 
 
-static int init (struct dvb_i2c_bus *i2c)
+static int init (struct i2c_adapter *i2c)
 {
         reset_and_configure (i2c);
 
@@ -449,16 +456,16 @@
 
 
 static 
-int grundig_29504_401_ioctl (struct dvb_frontend *fe,
+int l64781_ioctl (struct dvb_frontend *fe,
 			     unsigned int cmd, void *arg)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct l64781_state* state = fe->data;
+	struct i2c_adapter *i2c = state->i2c;
 	int res;
-	struct grundig_state* state = (struct grundig_state*) fe->data;
 
         switch (cmd) {
         case FE_GET_INFO:
-		memcpy (arg, &grundig_29504_401_info,
+		memcpy (arg, &l64781_info,
 			sizeof(struct dvb_frontend_info));
                 break;
 
@@ -546,7 +553,7 @@
 		res = init (i2c);
 		if ((res == 0) && (state->first)) {
 			state->first = 0;
-			dvb_delay(200);
+			msleep(200);
 		}
 		return res;
 
@@ -567,28 +574,26 @@
         return 0;
 } 
 
-
-static int l64781_attach (struct dvb_i2c_bus *i2c, void **data)
+static int l64781_probe(struct i2c_adapter *i2c)
 {
 	u8 reg0x3e;
 	u8 b0 [] = { 0x1a };
 	u8 b1 [] = { 0x00 };
 	struct i2c_msg msg [] = { { .addr = 0x55, .flags = 0, .buf = b0, .len = 1 },
 			   { .addr = 0x55, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
-	struct grundig_state* state;
 
 	/**
 	 *  the L64781 won't show up before we send the reset_and_configure()
 	 *  broadcast. If nothing responds there is no L64781 on the bus...
 	 */
 	if (reset_and_configure(i2c) < 0) {
-		dprintk("no response on reset_and_configure() broadcast, bailing out...\n");
+		dprintk("No response to reset and configure broadcast...\n");
 		return -ENODEV;
 	}
 
 	/* The chip always responds to reads */
-	if (i2c->xfer(i2c, msg, 2) != 2) {  
-	        dprintk("no response to read on I2C bus\n");
+	if (i2c_transfer(i2c, msg, 2) != 2) {  
+	        dprintk("No response to read on I2C bus\n");
 		return -ENODEV;
 	}
 
@@ -607,7 +612,7 @@
 	/* Responds to all reads with 0 */
 	if (l64781_readreg(i2c, 0x1a) != 0) {
  	        dprintk("Read 1 returned unexpcted value\n");
-	        goto bailout;
+	        goto out;
 	}	  
 
 	/* Turn the chip on */
@@ -616,49 +621,129 @@
 	/* Responds with register default value */
 	if (l64781_readreg(i2c, 0x1a) != 0xa1) { 
  	        dprintk("Read 2 returned unexpcted value\n");
-	        goto bailout;
+	        goto out;
+	}
+
+	return 0;
+out:
+	l64781_writereg (i2c, 0x3e, reg0x3e);  /* restore reg 0x3e */
+	return -ENODEV;
 	}
 
-	state = kmalloc(sizeof(struct grundig_state), GFP_KERNEL);
-	if (state == NULL) goto bailout;
-	*data = state;
+static struct i2c_client client_template;
+
+static int l64781_attach_adapter(struct i2c_adapter *adapter)
+{
+	struct l64781_state *state;
+	struct i2c_client *client;
+	int ret;
+
+	dprintk("Trying to attach to adapter 0x%x:%s.\n",
+		adapter->id, adapter->name);
+
+	if ((ret = l64781_probe(adapter)))
+		return ret;
+
+	if ( !(state = kmalloc(sizeof(struct l64781_state), GFP_KERNEL)) )
+		return -ENOMEM;
+
+	memset(state, 0, sizeof(struct l64781_state));
+	state->i2c = adapter;
 	state->first = 1;
 
-	return dvb_register_frontend (grundig_29504_401_ioctl, i2c, state,
-			       &grundig_29504_401_info);
+	if ( !(client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)) ) {
+		kfree(state);
+		return -ENOMEM;
+	}
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = 0; //XXX
+	i2c_set_clientdata(client, state);
+
+	if ((ret = i2c_attach_client(client))) {
+		kfree(state);
+		kfree(client);
+		return ret;
+	}
+
+	BUG_ON(!state->dvb);
+
+	if ((ret = dvb_register_frontend(l64781_ioctl, state->dvb, state,
+					     &l64781_info, THIS_MODULE))) {
+		i2c_detach_client(client);
+		kfree(state);
+		kfree(client);
+		return ret;
+	}
 
- bailout:
-	l64781_writereg (i2c, 0x3e, reg0x3e);  /* restore reg 0x3e */
-	return -ENODEV;
+	return 0;
 }
 
+static int l64781_detach_client(struct i2c_client *client)
+{
+	struct l64781_state *state = i2c_get_clientdata(client);
 
+	dvb_unregister_frontend_new(l64781_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
+}
 
-static void l64781_detach (struct dvb_i2c_bus *i2c, void *data)
+static int l64781_command(struct i2c_client *client,
+			  unsigned int cmd, void *arg)
 {
-	kfree(data);
-	dvb_unregister_frontend (grundig_29504_401_ioctl, i2c);
+	struct l64781_state *data = i2c_get_clientdata(client);
+	dprintk ("%s\n", __FUNCTION__);
+
+	switch (cmd) {
+	case FE_REGISTER: {
+		data->dvb = arg;
+		break;
+	}
+	case FE_UNREGISTER: {
+		data->dvb = NULL;
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
 }
 
+static struct i2c_driver driver = {
+	.owner 		= THIS_MODULE,
+	.name 		= FRONTEND_NAME,
+	.id 		= I2C_DRIVERID_DVBFE_L64781,
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = l64781_attach_adapter,
+	.detach_client 	= l64781_detach_client,
+	.command 	= l64781_command,
+};
 
-static int __init init_grundig_29504_401 (void)
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags 		= I2C_CLIENT_ALLOW_USE,
+	.driver  	= &driver,
+};
+
+static int __init init_l64781 (void)
 {
-	return dvb_register_i2c_device (THIS_MODULE,
-					l64781_attach, l64781_detach);
+	return i2c_add_driver(&driver);
 }
 
-
-static void __exit exit_grundig_29504_401 (void)
+static void __exit exit_l64781 (void)
 {
-	dvb_unregister_i2c_device (l64781_attach);
+	if (i2c_del_driver(&driver))
+		printk(KERN_ERR "l64781: driver deregistration failed\n");
 }
 
-module_init(init_grundig_29504_401);
-module_exit(exit_grundig_29504_401);
+module_init(init_l64781);
+module_exit(exit_l64781);
 
-MODULE_PARM(debug,"i");
-MODULE_PARM_DESC(debug, "enable verbose debug messages");
-MODULE_DESCRIPTION("Grundig 29504-401 DVB-T Frontend");
+MODULE_DESCRIPTION("Grundig 29504-401 DVB-T Frontend (LSI L64781 Based)");
 MODULE_AUTHOR("Holger Waechtler, Marko Kohtala");
 MODULE_LICENSE("GPL");
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/grundig_29504-491.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/grundig_29504-491.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/grundig_29504-491.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/grundig_29504-491.c	2004-08-18 19:52:17.000000000 +0200
@@ -27,17 +27,31 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
-static int debug = 0;
-#define dprintk	if (debug) printk
+#define FRONTEND_NAME "dvbfe_tda8083"
 
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
 
-static struct dvb_frontend_info grundig_29504_491_info = {
+static int debug;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
+
+
+struct tda8083_state {
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+};
+
+static struct dvb_frontend_info tda8083_info = {
 	.name			= "Grundig 29504-491, (TDA8083 based)",
 	.type			= FE_QPSK,
 	.frequency_min		= 950000,     /* FIXME: guessed! */
@@ -67,14 +79,13 @@
 };
 
 
-
-static int tda8083_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
+static int tda8083_writereg (struct i2c_adapter *i2c, u8 reg, u8 data)
 {
 	int ret;
 	u8 buf [] = { reg, data };
 	struct i2c_msg msg = { .addr = 0x68, .flags = 0, .buf = buf, .len = 2 };
 
-        ret = i2c->xfer (i2c, &msg, 1);
+        ret = i2c_transfer(i2c, &msg, 1);
 
         if (ret != 1)
                 dprintk ("%s: writereg error (reg %02x, ret == %i)\n",
@@ -84,13 +95,13 @@
 }
 
 
-static int tda8083_readregs (struct dvb_i2c_bus *i2c, u8 reg1, u8 *b, u8 len)
+static int tda8083_readregs (struct i2c_adapter *i2c, u8 reg1, u8 *b, u8 len)
 {
 	int ret;
 	struct i2c_msg msg [] = { { .addr = 0x68, .flags = 0, .buf = &reg1, .len = 1 },
 			   { .addr = 0x68, .flags = I2C_M_RD, .buf = b, .len = len } };
 
-	ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer(i2c, msg, 2);
 
 	if (ret != 2)
 		dprintk ("%s: readreg error (reg %02x, ret == %i)\n",
@@ -100,7 +111,7 @@
 }
 
 
-static inline u8 tda8083_readreg (struct dvb_i2c_bus *i2c, u8 reg)
+static inline u8 tda8083_readreg (struct i2c_adapter *i2c, u8 reg)
 {
 	u8 val;
 
@@ -110,12 +121,12 @@
 }
 
 
-static int tsa5522_write (struct dvb_i2c_bus *i2c, u8 data [4])
+static int tsa5522_write (struct i2c_adapter *i2c, u8 data [4])
 {
 	int ret;
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = 4 };
 
-	ret = i2c->xfer (i2c, &msg, 1);
+	ret = i2c_transfer(i2c, &msg, 1);
 
 	if (ret != 1)
 		dprintk("%s: i/o error (ret == %i)\n", __FUNCTION__, ret);
@@ -128,7 +139,7 @@
  *   set up the downconverter frequency divisor for a
  *   reference clock comparision frequency of 125 kHz.
  */
-static int tsa5522_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
+static int tsa5522_set_tv_freq (struct i2c_adapter *i2c, u32 freq)
 {
 	u32 div = freq / 125;
 	u8 buf [4] = { (div >> 8) & 0x7f, div & 0xff, 0x8e, 0x00 };
@@ -137,7 +148,7 @@
 }
 
 
-static int tda8083_init (struct dvb_i2c_bus *i2c)
+static int tda8083_init (struct i2c_adapter *i2c)
 {
 	int i;
 	
@@ -150,7 +161,7 @@
 }
 
 
-static int tda8083_set_inversion (struct dvb_i2c_bus *i2c, fe_spectral_inversion_t inversion)
+static int tda8083_set_inversion (struct i2c_adapter *i2c, fe_spectral_inversion_t inversion)
 {
 	/*  XXX FIXME: implement other modes than FEC_AUTO */
 	if (inversion == INVERSION_AUTO)
@@ -160,7 +171,7 @@
 }
 
 
-static int tda8083_set_fec (struct dvb_i2c_bus *i2c, fe_code_rate_t fec)
+static int tda8083_set_fec (struct i2c_adapter *i2c, fe_code_rate_t fec)
 {
 	if (fec == FEC_AUTO)
 		return tda8083_writereg (i2c, 0x07, 0xff);
@@ -172,7 +183,7 @@
 }
 
 
-static fe_code_rate_t tda8083_get_fec (struct dvb_i2c_bus *i2c)
+static fe_code_rate_t tda8083_get_fec (struct i2c_adapter *i2c)
 {
 	u8 index;
 	static fe_code_rate_t fec_tab [] = { FEC_8_9, FEC_1_2, FEC_2_3, FEC_3_4,
@@ -184,7 +195,7 @@
 }
 
 
-static int tda8083_set_symbolrate (struct dvb_i2c_bus *i2c, u32 srate)
+static int tda8083_set_symbolrate (struct i2c_adapter *i2c, u32 srate)
 {
         u32 ratio;
 	u32 tmp;
@@ -224,19 +235,19 @@
 }
 
 
-static void tda8083_wait_diseqc_fifo (struct dvb_i2c_bus *i2c, int timeout)
+static void tda8083_wait_diseqc_fifo (struct i2c_adapter *i2c, int timeout)
 {
 	unsigned long start = jiffies;
 
 	while (jiffies - start < timeout &&
                !(tda8083_readreg(i2c, 0x02) & 0x80))
 	{
-		dvb_delay(50);
+		msleep(50);
 	};
 }
 
 
-static int tda8083_send_diseqc_msg (struct dvb_i2c_bus *i2c,
+static int tda8083_send_diseqc_msg (struct i2c_adapter *i2c,
 			     struct dvb_diseqc_master_cmd *m)
 {
 	int i;
@@ -254,7 +265,7 @@
 }
 
 
-static int tda8083_send_diseqc_burst (struct dvb_i2c_bus *i2c, fe_sec_mini_cmd_t burst)
+static int tda8083_send_diseqc_burst (struct i2c_adapter *i2c, fe_sec_mini_cmd_t burst)
 {
 	switch (burst) {
 	case SEC_MINI_A:
@@ -273,7 +284,7 @@
 }
 
 
-static int tda8083_set_tone (struct dvb_i2c_bus *i2c, fe_sec_tone_mode_t tone)
+static int tda8083_set_tone (struct i2c_adapter *i2c, fe_sec_tone_mode_t tone)
 {
 	tda8083_writereg (i2c, 0x26, 0xf1);
 
@@ -288,7 +299,7 @@
 }
 
 
-static int tda8083_set_voltage (struct dvb_i2c_bus *i2c, fe_sec_voltage_t voltage)
+static int tda8083_set_voltage (struct i2c_adapter *i2c, fe_sec_voltage_t voltage)
 {
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
@@ -301,15 +312,15 @@
 }
 
 
-static int grundig_29504_491_ioctl (struct dvb_frontend *fe, unsigned int cmd,
+static int tda8083_ioctl(struct dvb_frontend *fe, unsigned int cmd,
 			     void *arg)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct tda8083_state *state = fe->data;
+	struct i2c_adapter *i2c = state->i2c;
 
         switch (cmd) {
 	case FE_GET_INFO:
-		memcpy (arg, &grundig_29504_491_info, 
-			sizeof(struct dvb_frontend_info));
+		memcpy (arg, &tda8083_info, sizeof(struct dvb_frontend_info));
                 break;
 
         case FE_READ_STATUS:
@@ -426,40 +437,119 @@
 	return 0;
 } 
 
+static struct i2c_client client_template;
 
-static int tda8083_attach (struct dvb_i2c_bus *i2c, void **data)
+static int tda8083_attach_adapter(struct i2c_adapter *adapter)
 {
-	if ((tda8083_readreg (i2c, 0x00)) != 0x05)
+	struct tda8083_state *state;
+	struct i2c_client *client;
+	int ret;
+
+	dprintk("Trying to attach to adapter 0x%x:%s.\n",
+		adapter->id, adapter->name);
+
+	if ((tda8083_readreg (adapter, 0x00)) != 0x05)
 		return -ENODEV;
 
-	return dvb_register_frontend (grundig_29504_491_ioctl, i2c, NULL,
-			       &grundig_29504_491_info);
+	if ( !(state = kmalloc(sizeof(struct tda8083_state), GFP_KERNEL)) )
+		return -ENOMEM;
+
+	if ( !(client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)) ) {
+		kfree(state);
+		return -ENOMEM;
+	}
+
+	memset(state, 0, sizeof(struct tda8083_state));
+	state->i2c = adapter;
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = 0; //XXX
+	i2c_set_clientdata(client, state);
+
+	if ((ret = i2c_attach_client(client))) {
+		kfree(state);
+		kfree(client);
+		return ret;
 }
 
+	BUG_ON(!state->dvb);
+
+	if ((ret = dvb_register_frontend(tda8083_ioctl, state->dvb, state,
+					     &tda8083_info, THIS_MODULE))) {
+		i2c_detach_client(client);
+		kfree(state);
+		kfree(client);
+		return ret;
+	}
+
+	return 0;
+}
 
-static void tda8083_detach (struct dvb_i2c_bus *i2c, void *data)
+static int tda8083_detach_client(struct i2c_client *client)
 {
-	dvb_unregister_frontend (grundig_29504_491_ioctl, i2c);
+	struct tda8083_state *state = i2c_get_clientdata(client);
+
+	dvb_unregister_frontend_new (tda8083_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
+}
+
+static int tda8083_command (struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct tda8083_state *data = i2c_get_clientdata(client);
+	dprintk ("%s\n", __FUNCTION__);
+
+	switch (cmd) {
+	case FE_REGISTER: {
+		data->dvb = arg;
+		break;
+	}
+	case FE_UNREGISTER: {
+		data->dvb = NULL;
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 
+static struct i2c_driver driver = {
+	.owner 		= THIS_MODULE,
+	.name 		= FRONTEND_NAME,
+	.id 		= I2C_DRIVERID_DVBFE_TDA8083,
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = tda8083_attach_adapter,
+	.detach_client 	= tda8083_detach_client,
+	.command 	= tda8083_command,
+};
+
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags 		= I2C_CLIENT_ALLOW_USE,
+	.driver  	= &driver,
+};
 
 static int __init init_tda8083 (void)
 {
-	return dvb_register_i2c_device (THIS_MODULE,
-					tda8083_attach, tda8083_detach);
+	return i2c_add_driver(&driver);
 }
 
-
 static void __exit exit_tda8083 (void)
 {
-	dvb_unregister_i2c_device (tda8083_attach);
+	if (i2c_del_driver(&driver))
+		printk("grundig_29504_401: driver deregistration failed\n");
 }
 
 module_init(init_tda8083);
 module_exit(exit_tda8083);
 
-MODULE_PARM(debug,"i");
-MODULE_DESCRIPTION("Grundig 29504-491 DVB frontend driver");
+MODULE_DESCRIPTION("Grundig 29504-491 DVB frontend driver (TDA8083 Based)");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler");
 MODULE_LICENSE("GPL");
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/Kconfig linux-2.6.8.1-patched/drivers/media/dvb/frontends/Kconfig
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/Kconfig	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/Kconfig	2004-06-22 15:49:15.000000000 +0200
@@ -1,24 +1,11 @@
-comment "Supported Frontend Modules"
-	depends on DVB
-
-config DVB_TWINHAN_DST
-	tristate "TWINHAN DST based DVB-S frontend (QPSK)"
-	depends on DVB_CORE && DVB_BT8XX
-	help
-	  Used in such cards as the VP-1020/1030, Twinhan DST,
-	  VVmer TV@SAT. Say Y when you want to support frontends 
-	  using this asic.
-
-	  This module requires the dvb-bt8xx driver and dvb bt878
-	  module.
+comment "DVB-S (satellite) frontends"
+	depends on DVB_CORE
 
 config DVB_STV0299
-	tristate "STV0299 based DVB-S frontend (QPSK)"
+	tristate "ST STV0299 based"
 	depends on DVB_CORE
 	help
-	  The stv0299 by ST is used in many DVB-S tuner modules, 
-	  say Y when you want to support frontends based on this 
-	  DVB-S demodulator.
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 	  Some examples are the Alps BSRU6, the Philips SU1278 and
 	  the LG TDQB-S00x.
@@ -27,92 +14,83 @@
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
-config DVB_SP887X
- 	tristate "Frontends with sp887x demodulators, e.g. Microtune DTF7072"
+config DVB_CX24110
+	tristate "Connexant CX24110 based"
  	depends on DVB_CORE
  	help
- 	  A DVB-T demodulator driver. Say Y when you want to support the sp887x.
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
  
  	  If you don't know what tuner module is soldered on your
  	  DVB adapter simply enable all supported frontends, the
  	  right one will get autodetected.
 
-
-config DVB_SP887X_FIRMWARE_FILE
-        string "Full pathname of sp887x firmware file"
-        depends on DVB_SP887X
-        default "/usr/lib/hotplug/firmware/sc_main.mc"
-        help
-          This driver needs a copy of the Avermedia firmware. The version tested
-	  is part of the Avermedia DVB-T 1.3.26.3 Application. This can be downloaded
-	  from the Avermedia web site.
-	  If the software is installed in Windows the file will be in the
-	  /Program Files/AVerTV DVB-T/ directory and is called sc_main.mc.
-	  Alternatively it can "extracted" from the install cab files but this will have
-	  to be done in windows as I don't know of a linux version of extract.exe.
-	  Copy this file to /usr/lib/hotplug/firmware/sc_main.mc.
-	  With this version of the file the first 10 bytes are discarded and the next
-	  0x4000 loaded. This may change in future versions.
-
-config DVB_ALPS_TDLB7
-	tristate "Alps TDLB7 (OFDM)"
+config DVB_GRUNDIG_29504_491
+	tristate "Grundig 29504-491 based"
 	depends on DVB_CORE
 	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
-
-	  This tuner module needs some microcode located in a file called
-	  "Sc_main.mc" in the windows driver. Please pass the module parameter
-	  mcfile="/PATH/FILENAME" when loading alps_tdlb7.o.
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 	  If you don't know what tuner module is soldered on your
 	  DVB adapter simply enable all supported frontends, the
 	  right one will get autodetected.
 
-
-config DVB_ALPS_TDMB7
-	tristate "Alps TDMB7 (OFDM)"
+config DVB_MT312
+	tristate "Zarlink MT312 based"
 	depends on DVB_CORE
 	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 	  If you don't know what tuner module is soldered on your
 	  DVB adapter simply enable all supported frontends, the
 	  right one will get autodetected.
 
-config DVB_ATMEL_AT76C651
-	tristate "Atmel AT76C651 (QAM)"
+config DVB_VES1X93
+	tristate "VLSI VES1893 or VES1993 based"
 	depends on DVB_CORE
 	help
-	  The AT76C651 Demodulator is used in some DVB-C SetTopBoxes. Say Y
-	  when you see this demodulator chip near your tuner module.
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 	  If you don't know what tuner module is soldered on your
 	  DVB adapter simply enable all supported frontends, the
 	  right one will get autodetected.
 
-config DVB_CX24110
-	tristate "Frontends with Connexant CX24110 demodulator (QPSK)"
+comment "DVB-T (terrestrial) frontends"
+	depends on DVB_CORE
+
+config DVB_SP887X
+ 	tristate "Microtune sp887x based (i.e. Microtune DTF7072)"
 	depends on DVB_CORE
 	help
-	  The CX24110 Demodulator is used in some DVB-S frontends. 
-	  Say Y if you want support for this chip in your kernel.
+ 	  A DVB-T tuner module. Say Y when you want to support this frontend.
+
+	  This driver needs a copy of the Avermedia firmware. The version tested
+	  is part of the Avermedia DVB-T 1.3.26.3 Application. If the software is
+	  installed in Windoze the file will be in the /Program Files/AVerTV DVB-T/
+	  directory and is called sc_main.mc. Alternatively it can "extracted" from
+	  the install cab files.
+   
+   	  Copy this file to '/usr/lib/hotplug/firmware/dvb-fe-sp887x.fw'.
 
 	  If you don't know what tuner module is soldered on your 
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
-config DVB_GRUNDIG_29504_491
-	tristate "Grundig 29504-491 (QPSK)"
+config DVB_ALPS_TDLB7
+	tristate "Alps TDLB7 based"
 	depends on DVB_CORE
 	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
+
+	  This driver needs a copy of the firmware file from the Haupauge
+	  Windoze driver. Copy 'Sc_main.mc' to
+	  '/usr/lib/hotplug/firmware/dvb-fe-tdlb7.fw'.
 
 	  If you don't know what tuner module is soldered on your 
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
-config DVB_GRUNDIG_29504_401
-	tristate "Grundig 29504-401 (OFDM)"
+config DVB_ALPS_TDMB7
+	tristate "Alps TDMB7 based"
 	depends on DVB_CORE
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
@@ -121,40 +99,38 @@
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
-config DVB_MT312
-	tristate "Zarlink MT312 Satellite Channel Decoder (QPSK)"
+config DVB_GRUNDIG_29504_401
+	tristate "Grundig 29504-401 based"
 	depends on DVB_CORE
 	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 	  If you don't know what tuner module is soldered on your 
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
-config DVB_VES1820
-	tristate "Frontends with external VES1820 demodulator (QAM)"
+config DVB_TDA1004X
+	tristate "Philips TDA10045H/TDA10046H based"
 	depends on DVB_CORE
 	help
-	  The VES1820 Demodulator is used on many DVB-C PCI cards and in some
-	  DVB-C SetTopBoxes. Say Y when you see this demodulator chip near your
-	  tuner module.
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 	  If you don't know what tuner module is soldered on your 
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
-config DVB_VES1X93
-	tristate "Frontends with VES1893 or VES1993 demodulator (QPSK)"
+config DVB_NXT6000
+	tristate "NxtWave Communications NXT6000 based"
 	depends on DVB_CORE
 	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 	  If you don't know what tuner module is soldered on your 
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
-config DVB_TDA1004X
-	tristate "Frontends with external TDA10045H or TDA10046H demodulators (OFDM)"
+config DVB_MT352
+	tristate "Zarlink MT352 based"
 	depends on DVB_CORE
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
@@ -163,25 +139,36 @@
 	  DVB adapter simply enable all supported frontends, the
 	  right one will get autodetected.
 
-config DVB_TDA1004X_FIRMWARE_FILE
-        string "Full pathname of tda1004x.bin firmware file"
-        depends on DVB_TDA1004X
-        default "/usr/lib/hotplug/firmware/tda1004x.bin"
+comment "DVB-C (cable) frontends"
+	depends on DVB_CORE
+
+config DVB_ATMEL_AT76C651
+	tristate "Atmel AT76C651 based"
+	depends on DVB_CORE
         help
-          The TDA1004X requires additional firmware in order to function.
-          The firmware file can obtained as follows:
-            wget http://www.technotrend.de/new/215/TTweb_215a_budget_20_05_2003.zip
-            unzip -j TTweb_215a_budget_20_05_2003.zip Software/Oem/PCI/App/ttlcdacc.dll
-            mv ttlcdacc.dll /usr/lib/hotplug/firmware/tda1004x.bin
-	  Note: even if you're using a USB device, you MUST get the file from the
-	  TechnoTrend PCI drivers.
+ 	  A DVB-C tuner module. Say Y when you want to support this frontend.
 
-config DVB_NXT6000
-	tristate "Frontends with NxtWave Communications NXT6000 demodulator (OFDM)"
+	  If you don't know what tuner module is soldered on your
+	  DVB adapter simply enable all supported frontends, the
+	  right one will get autodetected.
+
+config DVB_VES1820
+	tristate "VLSI VES1820 based"
 	depends on DVB_CORE
 	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
+ 	  A DVB-C tuner module. Say Y when you want to support this frontend.
 
 	  If you don't know what tuner module is soldered on your
 	  DVB adapter simply enable all supported frontends, the
 	  right one will get autodetected.
+
+comment "Misc. Frontend Modules"
+	depends on DVB_CORE
+
+config DVB_TWINHAN_DST
+	tristate "Twinhan DST based DVB-S/-T frontend"
+	depends on DVB_CORE && DVB_BT8XX
+	help
+	  Used in such cards as the VP-1020/1030, Twinhan DST,
+	  VVmer TV@SAT. Say Y when you want to support frontends
+	  using this asic.
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/mt312.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt312.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/mt312.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt312.c	2004-08-18 19:52:17.000000000 +0200
@@ -28,30 +28,32 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 
 #include "dvb_frontend.h"
 #include "mt312.h"
 
+#define FRONTEND_NAME "dvbfe_mt312"
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
+
+
 #define I2C_ADDR_MT312		0x0e
 #define I2C_ADDR_SL1935		0x61
 #define I2C_ADDR_TSA5059	0x61
 
-#define MT312_DEBUG		0
-
 #define MT312_SYS_CLK		90000000UL	/* 90 MHz */
 #define MT312_LPOWER_SYS_CLK	60000000UL	/* 60 MHz */
 #define MT312_PLL_CLK		10000000UL	/* 10 MHz */
 
-/* number of active frontends */
-static int mt312_count = 0;
-
-#if MT312_DEBUG == 0
-#define dprintk(x...)
-#else
-static int debug = 0;
-#define dprintk if(debug == 1) printk
-#endif
-
 static struct dvb_frontend_info mt312_info = {
 	.name = "Zarlink MT312",
 	.type = FE_QPSK,
@@ -70,7 +72,13 @@
             FE_CAN_RECOVER
 };
 
-static int mt312_read(struct dvb_i2c_bus *i2c,
+struct mt312_state {
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+	int id;
+};
+
+static int mt312_read(struct i2c_adapter *i2c,
 		      const enum mt312_reg_addr reg, void *buf,
 		      const size_t count)
 {
@@ -87,26 +95,25 @@
 	msg[1].buf = buf;
 	msg[1].len = count;
 
-	ret = i2c->xfer(i2c, msg, 2);
+	ret = i2c_transfer(i2c, msg, 2);
 
-	if ((ret != 2) && (mt312_count != 0)) {
+	if (ret != 2) {
 		printk(KERN_ERR "%s: ret == %d\n", __FUNCTION__, ret);
 		return -EREMOTEIO;
 	}
-#if MT312_DEBUG
+
 	if(debug) {
 		int i;
-		printk(KERN_INFO "R(%d):", reg & 0x7f);
+		dprintk("R(%d):", reg & 0x7f);
 		for (i = 0; i < count; i++)
 			printk(" %02x", ((const u8 *) buf)[i]);
 		printk("\n");
 	}
-#endif
 
 	return 0;
 }
 
-static int mt312_write(struct dvb_i2c_bus *i2c,
+static int mt312_write(struct i2c_adapter *i2c,
 		       const enum mt312_reg_addr reg, const void *src,
 		       const size_t count)
 {
@@ -114,15 +121,13 @@
 	u8 buf[count + 1];
 	struct i2c_msg msg;
 
-#if MT312_DEBUG
 	if(debug) {
 		int i;
-		printk(KERN_INFO "W(%d):", reg & 0x7f);
+		dprintk("W(%d):", reg & 0x7f);
 		for (i = 0; i < count; i++)
 			printk(" %02x", ((const u8 *) src)[i]);
 		printk("\n");
 	}
-#endif
 
 	buf[0] = reg;
 	memcpy(&buf[1], src, count);
@@ -132,29 +137,29 @@
 	msg.buf = buf;
 	msg.len = count + 1;
 
-	ret = i2c->xfer(i2c, &msg, 1);
+	ret = i2c_transfer(i2c, &msg, 1);
 
 	if (ret != 1) {
-		printk(KERN_ERR "%s: ret == %d\n", __FUNCTION__, ret);
+		dprintk("%s: ret == %d\n", __FUNCTION__, ret);
 		return -EREMOTEIO;
 	}
 
 	return 0;
 }
 
-static inline int mt312_readreg(struct dvb_i2c_bus *i2c,
+static inline int mt312_readreg(struct i2c_adapter *i2c,
 				const enum mt312_reg_addr reg, u8 * val)
 {
 	return mt312_read(i2c, reg, val, 1);
 }
 
-static inline int mt312_writereg(struct dvb_i2c_bus *i2c,
+static inline int mt312_writereg(struct i2c_adapter *i2c,
 				 const enum mt312_reg_addr reg, const u8 val)
 {
 	return mt312_write(i2c, reg, &val, 1);
 }
 
-static int mt312_pll_write(struct dvb_i2c_bus *i2c, const u8 addr,
+static int mt312_pll_write(struct i2c_adapter *i2c, const u8 addr,
 			   u8 * buf, const u8 len)
 {
 	int ret;
@@ -168,7 +173,7 @@
 	if ((ret = mt312_writereg(i2c, GPP_CTRL, 0x40)) < 0)
 		return ret;
 
-	if ((ret = i2c->xfer(i2c, &msg, 1)) != 1)
+	if ((ret = i2c_transfer(i2c, &msg, 1)) != 1)
 		printk(KERN_ERR "%s: i/o error (ret == %d)\n", __FUNCTION__, ret);
 
 	if ((ret = mt312_writereg(i2c, GPP_CTRL, 0x00)) < 0)
@@ -182,7 +187,7 @@
 	return (a + (b / 2)) / b;
 }
 
-static int sl1935_set_tv_freq(struct dvb_i2c_bus *i2c, u32 freq, u32 sr)
+static int sl1935_set_tv_freq(struct i2c_adapter *i2c, u32 freq, u32 sr)
 {
 	/* 155 uA, Baseband Path B */
 	u8 buf[4] = { 0x00, 0x00, 0x80, 0x00 };
@@ -219,7 +224,7 @@
 	return mt312_pll_write(i2c, I2C_ADDR_SL1935, buf, sizeof(buf));
 }
 
-static int tsa5059_set_tv_freq(struct dvb_i2c_bus *i2c, u32 freq, u32 sr)
+static int tsa5059_set_tv_freq(struct i2c_adapter *i2c, u32 freq, u32 sr)
 {
 	u8 buf[4];
 
@@ -239,13 +244,14 @@
 	return mt312_pll_write(i2c, I2C_ADDR_TSA5059, buf, sizeof(buf));
 }
 
-static int mt312_reset(struct dvb_i2c_bus *i2c, const u8 full)
+static int mt312_reset(struct i2c_adapter *i2c, const u8 full)
 {
 	return mt312_writereg(i2c, RESET, full ? 0x80 : 0x40);
 }
 
-static int mt312_init(struct dvb_i2c_bus *i2c, const long id, u8 pll)
+static int mt312_initfe(struct mt312_state *state, u8 pll)
 {
+	struct i2c_adapter *i2c = state->i2c;
 	int ret;
 	u8 buf[2];
 
@@ -297,7 +303,7 @@
 	return 0;
 }
 
-static int mt312_send_master_cmd(struct dvb_i2c_bus *i2c,
+static int mt312_send_master_cmd(struct i2c_adapter *i2c,
 				 const struct dvb_diseqc_master_cmd *c)
 {
 	int ret;
@@ -328,14 +334,14 @@
 	return 0;
 }
 
-static int mt312_recv_slave_reply(struct dvb_i2c_bus *i2c,
+static int mt312_recv_slave_reply(struct i2c_adapter *i2c,
 				  struct dvb_diseqc_slave_reply *r)
 {
 	/* TODO */
 	return -EOPNOTSUPP;
 }
 
-static int mt312_send_burst(struct dvb_i2c_bus *i2c, const fe_sec_mini_cmd_t c)
+static int mt312_send_burst(struct i2c_adapter *i2c, const fe_sec_mini_cmd_t c)
 {
 	const u8 mini_tab[2] = { 0x02, 0x03 };
 
@@ -356,7 +362,7 @@
 	return 0;
 }
 
-static int mt312_set_tone(struct dvb_i2c_bus *i2c, const fe_sec_tone_mode_t t)
+static int mt312_set_tone(struct i2c_adapter *i2c, const fe_sec_tone_mode_t t)
 {
 	const u8 tone_tab[2] = { 0x01, 0x00 };
 
@@ -377,7 +383,7 @@
 	return 0;
 }
 
-static int mt312_set_voltage(struct dvb_i2c_bus *i2c, const fe_sec_voltage_t v)
+static int mt312_set_voltage(struct i2c_adapter *i2c, const fe_sec_voltage_t v)
 {
 	const u8 volt_tab[3] = { 0x00, 0x40, 0x00 };
 
@@ -387,8 +393,9 @@
 	return mt312_writereg(i2c, DISEQC_MODE, volt_tab[v]);
 }
 
-static int mt312_read_status(struct dvb_i2c_bus *i2c, fe_status_t *s, const long id)
+static int mt312_read_status(struct mt312_state *state, fe_status_t *s)
 {
+	struct i2c_adapter *i2c = state->i2c;
 	int ret;
 	u8 status[3], vit_mode;
 
@@ -409,8 +416,9 @@
 		*s |= FE_HAS_SYNC;	/* byte align lock */
 	if (status[0] & 0x01)
 		*s |= FE_HAS_LOCK;	/* qpsk lock */
+
 	// VP310 doesn't have AUTO, so we "implement it here" ACCJr
-	if ((id == ID_VP310) && !(status[0] & 0x01)) {
+	if ((state->id == ID_VP310) && !(status[0] & 0x01)) {
 		if ((ret = mt312_readreg(i2c, VIT_MODE, &vit_mode)) < 0)
 			return ret;
 		vit_mode ^= 0x40;
@@ -423,7 +431,7 @@
 	return 0;
 }
 
-static int mt312_read_bercnt(struct dvb_i2c_bus *i2c, u32 * ber)
+static int mt312_read_bercnt(struct i2c_adapter *i2c, u32 *ber)
 {
 	int ret;
 	u8 buf[3];
@@ -436,7 +444,7 @@
 	return 0;
 }
 
-static int mt312_read_agc(struct dvb_i2c_bus *i2c, u16 * signal_strength)
+static int mt312_read_agc(struct i2c_adapter *i2c, u16 *signal_strength)
 {
 	int ret;
 	u8 buf[3];
@@ -456,7 +464,7 @@
 	return 0;
 }
 
-static int mt312_read_snr(struct dvb_i2c_bus *i2c, u16 * snr)
+static int mt312_read_snr(struct i2c_adapter *i2c, u16 *snr)
 {
 	int ret;
 	u8 buf[2];
@@ -469,7 +477,7 @@
 	return 0;
 }
 
-static int mt312_read_ubc(struct dvb_i2c_bus *i2c, u32 * ubc)
+static int mt312_read_ubc(struct i2c_adapter *i2c, u32 *ubc)
 {
 	int ret;
 	u8 buf[2];
@@ -482,10 +490,10 @@
 	return 0;
 }
 
-static int mt312_set_frontend(struct dvb_i2c_bus *i2c,
-			      const struct dvb_frontend_parameters *p,
-			      const long id)
+static int mt312_set_frontend(struct mt312_state *state,
+			      const struct dvb_frontend_parameters *p)
 {
+	struct i2c_adapter *i2c = state->i2c;
 	int ret;
 	u8 buf[5], config_val;
 	u16 sr;
@@ -494,7 +502,7 @@
 	    { 0x00, 0x01, 0x02, 0x04, 0x3f, 0x08, 0x10, 0x20, 0x3f, 0x3f };
 	const u8 inv_tab[3] = { 0x00, 0x40, 0x80 };
 
-	int (*set_tv_freq)(struct dvb_i2c_bus *i2c, u32 freq, u32 sr);
+	int (*set_tv_freq)(struct i2c_adapter *i2c, u32 freq, u32 sr);
 
 	dprintk("%s: Freq %d\n", __FUNCTION__, p->frequency);
 
@@ -518,7 +526,7 @@
 	    || (p->u.qpsk.fec_inner == FEC_8_9))
 		return -EINVAL;
 
-	switch (id) {
+	switch (state->id) {
 	case ID_VP310:
 	// For now we will do this only for the VP310.
 	// It should be better for the mt312 as well, but tunning will be slower. ACCJr 09/29/03
@@ -527,13 +535,13 @@
 		if (p->u.qpsk.symbol_rate >= 30000000) //Note that 30MS/s should use 90MHz
 		{
 			if ((config_val & 0x0c) == 0x08) //We are running 60MHz
-				if ((ret = mt312_init(i2c, id, (u8) 90)) < 0)
+				if ((ret = mt312_initfe(state, (u8) 90)) < 0)
 					return ret;
 		}
 		else
 		{
 			if ((config_val & 0x0c) == 0x0C) //We are running 90MHz
-				if ((ret = mt312_init(i2c, id, (u8) 60)) < 0)
+				if ((ret = mt312_initfe(state, (u8) 60)) < 0)
 					return ret;
 		}
 		set_tv_freq = tsa5059_set_tv_freq;
@@ -575,7 +583,7 @@
 	return 0;
 }
 
-static int mt312_get_inversion(struct dvb_i2c_bus *i2c,
+static int mt312_get_inversion(struct i2c_adapter *i2c,
 			       fe_spectral_inversion_t * i)
 {
 	int ret;
@@ -590,7 +598,7 @@
 	return 0;
 }
 
-static int mt312_get_symbol_rate(struct dvb_i2c_bus *i2c, u32 * sr)
+static int mt312_get_symbol_rate(struct i2c_adapter *i2c, u32 *sr)
 {
 	int ret;
 	u8 sym_rate_h;
@@ -637,7 +645,7 @@
 	return 0;
 }
 
-static int mt312_get_code_rate(struct dvb_i2c_bus *i2c, fe_code_rate_t * cr)
+static int mt312_get_code_rate(struct i2c_adapter *i2c, fe_code_rate_t *cr)
 {
 	const fe_code_rate_t fec_tab[8] =
 	    { FEC_1_2, FEC_2_3, FEC_3_4, FEC_5_6, FEC_6_7, FEC_7_8,
@@ -654,7 +662,7 @@
 	return 0;
 }
 
-static int mt312_get_frontend(struct dvb_i2c_bus *i2c,
+static int mt312_get_frontend(struct i2c_adapter *i2c,
 			      struct dvb_frontend_parameters *p)
 {
 	int ret;
@@ -671,7 +679,7 @@
 	return 0;
 }
 
-static int mt312_sleep(struct dvb_i2c_bus *i2c)
+static int mt312_sleep(struct i2c_adapter *i2c)
 {
 	int ret;
 	u8 config;
@@ -692,7 +700,8 @@
 
 static int mt312_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct mt312_state *state = fe->data;
+	struct i2c_adapter *i2c = state->i2c;
 
 	switch (cmd) {
 	case FE_GET_INFO:
@@ -706,7 +715,7 @@
 		return mt312_send_master_cmd(i2c, arg);
 
 	case FE_DISEQC_RECV_SLAVE_REPLY:
-		if ((long) fe->data == ID_MT312)
+		if (state->id == ID_MT312)
 			return mt312_recv_slave_reply(i2c, arg);
 		else
 			return -EOPNOTSUPP;
@@ -724,7 +733,7 @@
 		return -EOPNOTSUPP;
 
 	case FE_READ_STATUS:
-		return mt312_read_status(i2c, arg, (long) fe->data);
+		return mt312_read_status(state, arg);
 
 	case FE_READ_BER:
 		return mt312_read_bercnt(i2c, arg);
@@ -739,7 +748,7 @@
 		return mt312_read_ubc(i2c, arg);
 
 	case FE_SET_FRONTEND:
-		return mt312_set_frontend(i2c, arg, (long) fe->data);
+		return mt312_set_frontend(state, arg);
 
 	case FE_GET_FRONTEND:
 		return mt312_get_frontend(i2c, arg);
@@ -751,12 +760,14 @@
 		return mt312_sleep(i2c);
 
 	case FE_INIT:
-	//For the VP310 we should run at 60MHz when ever possible.
-	//It should be better to run the mt312 ar lower speed when ever possible, but tunning will be slower. ACCJr 09/29/03
-		if ((long)fe->data == ID_MT312)
-			return mt312_init(i2c, (long) fe->data, (u8) 90);
+		/* For the VP310 we should run at 60MHz when ever possible.
+		 * It should be better to run the mt312 ar lower speed when
+		 * ever possible, but tunning will be slower. ACCJr 09/29/03
+		 */
+		if (state->id == ID_MT312)
+			return mt312_initfe(state, (u8) 90);
 		else
-			return mt312_init(i2c, (long) fe->data, (u8) 60);
+			return mt312_initfe(state, (u8) 60);
 
 	case FE_GET_TUNE_SETTINGS:
 	{
@@ -774,52 +785,123 @@
 	return 0;
 }
 
-static int mt312_attach(struct dvb_i2c_bus *i2c, void **data)
+static struct i2c_client client_template;
+
+static int mt312_attach_adapter(struct i2c_adapter *adapter)
 {
+	struct mt312_state *state;
+	struct i2c_client *client;
 	int ret;
 	u8 id;
 
-	if ((ret = mt312_readreg(i2c, ID, &id)) < 0)
-		return ret;
+	dprintk("Trying to attach to adapter 0x%x:%s.\n",
+		adapter->id, adapter->name);
+
+	if (mt312_readreg(adapter, ID, &id) < 0)
+		return -ENODEV;
 
 	if ((id != ID_VP310) && (id != ID_MT312))
 		return -ENODEV;
 
-	if ((ret = dvb_register_frontend(mt312_ioctl, i2c,
-				(void *)(long)id, &mt312_info)) < 0)
+	if ( !(state = kmalloc(sizeof(struct mt312_state), GFP_KERNEL)) )
+		return -ENOMEM;
+
+	memset(state, 0, sizeof(struct mt312_state));
+	state->i2c = adapter;
+	state->id = id;
+
+	if ( !(client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)) ) {
+		kfree(state);
+		return -ENOMEM;
+	}
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = I2C_ADDR_MT312;
+	i2c_set_clientdata(client, state);
+
+	if ((ret = i2c_attach_client(client))) {
+		kfree(client);
+		kfree(state);
+		return ret;
+	}
+
+	BUG_ON(!state->dvb);
+
+	if ((ret = dvb_register_frontend(mt312_ioctl, state->dvb, state,
+					     &mt312_info, THIS_MODULE))) {
+		i2c_detach_client(client);
+		kfree(client);
+		kfree(state);
 		return ret;
+	}
+
+	return 0;
+}
+
+static int mt312_detach_client(struct i2c_client *client)
+{
+	struct mt312_state *state = i2c_get_clientdata(client);
 
-	mt312_count++;
+	dprintk ("%s\n", __FUNCTION__);
 
+	dvb_unregister_frontend_new (mt312_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
 	return 0;
 }
 
-static void mt312_detach(struct dvb_i2c_bus *i2c, void *data)
+static int mt312_command (struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	dvb_unregister_frontend(mt312_ioctl, i2c);
+	struct mt312_state *state = i2c_get_clientdata(client);
 
-	if (mt312_count)
-		mt312_count--;
+	dprintk ("%s\n", __FUNCTION__);
+
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
 
+static struct i2c_driver driver = {
+	.owner 		= THIS_MODULE,
+	.name 		= FRONTEND_NAME,
+	.id 		= I2C_DRIVERID_DVBFE_MT312,
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = mt312_attach_adapter,
+	.detach_client 	= mt312_detach_client,
+	.command 	= mt312_command,
+};
+
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags 		= I2C_CLIENT_ALLOW_USE,
+	.driver  	= &driver,
+};
+
 static int __init mt312_module_init(void)
 {
-	return dvb_register_i2c_device(THIS_MODULE, mt312_attach, mt312_detach);
+	return i2c_add_driver(&driver);
 }
 
 static void __exit mt312_module_exit(void)
 {
-	dvb_unregister_i2c_device(mt312_attach);
+	if (i2c_del_driver(&driver))
+		printk(KERN_ERR "mt312: driver deregistration failed.\n");
 }
 
 module_init(mt312_module_init);
 module_exit(mt312_module_exit);
 
-#if MT312_DEBUG != 0
-MODULE_PARM(debug,"i");
-MODULE_PARM_DESC(debug, "enable verbose debug messages");
-#endif
-
 MODULE_DESCRIPTION("MT312 Satellite Channel Decoder Driver");
 MODULE_AUTHOR("Andreas Oberritter <obi@linuxtv.org>");
 MODULE_LICENSE("GPL");

--------------080302080608000807080806--
