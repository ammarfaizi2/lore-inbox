Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTJIKvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTJIKvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:51:23 -0400
Received: from mail.convergence.de ([212.84.236.4]:42148 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261970AbTJIKr5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:47:57 -0400
Subject: [PATCH 3/7] Add private data pointer to DVB frontends
In-Reply-To: <10656964753877@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 9 Oct 2003 12:47:55 +0200
Message-Id: <10656964753860@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] allow private data to be associated with dvb frontend devices (Andreas Oberritter)
- [DVB] fixed fe_count countint in nxt6000 frontend driver (Andreas Oberritter)
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/ttusb-dec/dec2000_frontend.c linux-2.6.0-test7-patch/drivers/media/dvb/ttusb-dec/dec2000_frontend.c
--- linux-2.6.0-test7/drivers/media/dvb/ttusb-dec/dec2000_frontend.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/ttusb-dec/dec2000_frontend.c	2003-10-09 10:44:10.000000000 +0200
@@ -140,17 +140,15 @@
 	return 0;
 }
 
-static int dec2000_frontend_attach(struct dvb_i2c_bus *i2c)
+static int dec2000_frontend_attach(struct dvb_i2c_bus *i2c, void **data)
 {
 	dprintk("%s\n", __FUNCTION__);
 
-	dvb_register_frontend(dec2000_frontend_ioctl, i2c, NULL,
+	return dvb_register_frontend(dec2000_frontend_ioctl, i2c, NULL,
 			      &dec2000_frontend_info);
-
-	return 0;
 }
 
-static void dec2000_frontend_detach(struct dvb_i2c_bus *i2c)
+static void dec2000_frontend_detach(struct dvb_i2c_bus *i2c, void *data)
 {
 	dprintk("%s\n", __FUNCTION__);
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/dvb-core/dvb_i2c.c linux-2.6.0-test7-patch/drivers/media/dvb/dvb-core/dvb_i2c.c
--- linux-2.6.0-test7/drivers/media/dvb/dvb-core/dvb_i2c.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/dvb-core/dvb_i2c.c	2003-10-09 10:44:10.000000000 +0200
@@ -32,8 +32,9 @@
 struct dvb_i2c_device {
 	struct list_head list_head;
 	struct module *owner;
-	int (*attach) (struct dvb_i2c_bus *i2c);
-	void (*detach) (struct dvb_i2c_bus *i2c);
+	int (*attach) (struct dvb_i2c_bus *i2c, void **data);
+	void (*detach) (struct dvb_i2c_bus *i2c, void *data);
+	void *data;
 };
 
 LIST_HEAD(dvb_i2c_buslist);
@@ -66,7 +67,7 @@
 			return;
 	}
 
-	if (dev->attach (i2c) == 0) {
+	if (dev->attach (i2c, &dev->data) == 0) {
 		register_i2c_client (i2c, dev);
 	} else {
 		if (dev->owner)
@@ -77,7 +78,7 @@
 
 static void detach_device (struct dvb_i2c_bus *i2c, struct dvb_i2c_device *dev)
 {
-	dev->detach (i2c);
+	dev->detach (i2c, dev->data);
 
 	if (dev->owner)
 		module_put (dev->owner);
@@ -229,8 +230,8 @@
 
 
 int dvb_register_i2c_device (struct module *owner,
-			     int (*attach) (struct dvb_i2c_bus *i2c),
-			     void (*detach) (struct dvb_i2c_bus *i2c))
+			     int (*attach) (struct dvb_i2c_bus *i2c, void **data),
+			     void (*detach) (struct dvb_i2c_bus *i2c, void *data))
 {
 	struct dvb_i2c_device *entry;
 
@@ -256,7 +257,7 @@
 }
 
 
-int dvb_unregister_i2c_device (int (*attach) (struct dvb_i2c_bus *i2c))
+int dvb_unregister_i2c_device (int (*attach) (struct dvb_i2c_bus *i2c, void **data))
 {
 	struct list_head *entry, *n;
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/dvb-core/dvb_i2c.h linux-2.6.0-test7-patch/drivers/media/dvb/dvb-core/dvb_i2c.h
--- linux-2.6.0-test7/drivers/media/dvb/dvb-core/dvb_i2c.h	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/dvb-core/dvb_i2c.h	2003-10-09 10:44:10.000000000 +0200
@@ -54,10 +54,10 @@
 
 
 extern int dvb_register_i2c_device (struct module *owner,
-				    int (*attach) (struct dvb_i2c_bus *i2c),
-				    void (*detach) (struct dvb_i2c_bus *i2c));
+				    int (*attach) (struct dvb_i2c_bus *i2c, void **data),
+				    void (*detach) (struct dvb_i2c_bus *i2c, void *data));
 
-extern int dvb_unregister_i2c_device (int (*attach) (struct dvb_i2c_bus *i2c));
+extern int dvb_unregister_i2c_device (int (*attach) (struct dvb_i2c_bus *i2c, void **data));
 
 #endif
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/alps_tdmb7.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/alps_tdmb7.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/alps_tdmb7.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/alps_tdmb7.c	2003-10-09 10:44:10.000000000 +0200
@@ -402,7 +402,7 @@
 
 
 
-static int tdmb7_attach (struct dvb_i2c_bus *i2c)
+static int tdmb7_attach (struct dvb_i2c_bus *i2c, void **data)
 {
 	struct i2c_msg msg = { .addr = 0x43, .flags = 0, .buf = NULL,. len = 0 };
 
@@ -411,13 +411,11 @@
 	if (i2c->xfer (i2c, &msg, 1) != 1)
                 return -ENODEV;
 
-	dvb_register_frontend (tdmb7_ioctl, i2c, NULL, &tdmb7_info);
-
-	return 0;
+	return dvb_register_frontend (tdmb7_ioctl, i2c, NULL, &tdmb7_info);
 }
 
 
-static void tdmb7_detach (struct dvb_i2c_bus *i2c)
+static void tdmb7_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dprintk ("%s\n", __FUNCTION__);
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/cx24110.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/cx24110.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/cx24110.c	2003-10-09 10:40:18.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/cx24110.c	2003-10-09 10:44:10.000000000 +0200
@@ -643,7 +643,7 @@
 }
 
 
-static int cx24110_attach (struct dvb_i2c_bus *i2c)
+static int cx24110_attach (struct dvb_i2c_bus *i2c, void **data)
 {
 	u8 sig;
 
@@ -651,13 +651,11 @@
 	if ( sig != 0x5a && sig != 0x69 )
 		return -ENODEV;
 
-	dvb_register_frontend (cx24110_ioctl, i2c, NULL, &cx24110_info);
-
-	return 0;
+	return dvb_register_frontend (cx24110_ioctl, i2c, NULL, &cx24110_info);
 }
 
 
-static void cx24110_detach (struct dvb_i2c_bus *i2c)
+static void cx24110_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dvb_unregister_frontend (cx24110_ioctl, i2c);
 }
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/dvb_dummy_fe.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/dvb_dummy_fe.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/dvb_dummy_fe.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/dvb_dummy_fe.c	2003-10-09 10:44:10.000000000 +0200
@@ -173,14 +173,13 @@
 } 
 
 
-static int dvbdummyfe_attach (struct dvb_i2c_bus *i2c)
+static int dvbdummyfe_attach (struct dvb_i2c_bus *i2c, void **data)
 {
-	dvb_register_frontend (dvbdummyfe_ioctl, i2c, NULL, frontend_info());
-	return 0;
+	return dvb_register_frontend (dvbdummyfe_ioctl, i2c, NULL, frontend_info());
 }
 
 
-static void dvbdummyfe_detach (struct dvb_i2c_bus *i2c)
+static void dvbdummyfe_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dvb_unregister_frontend (dvbdummyfe_ioctl, i2c);
 }
@@ -191,14 +190,12 @@
 	return dvb_register_i2c_device (THIS_MODULE,
 					dvbdummyfe_attach, 
 					dvbdummyfe_detach);
-	return 0;
 }
 
 
 static void __exit exit_dvbdummyfe (void)
 {
 	dvb_unregister_i2c_device (dvbdummyfe_attach);
-	return;
 }
 
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/grundig_29504-401.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/grundig_29504-401.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/grundig_29504-401.c	2003-10-09 10:40:18.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/grundig_29504-401.c	2003-10-09 10:44:10.000000000 +0200
@@ -415,7 +416,7 @@
 } 
 
 
-static int l64781_attach (struct dvb_i2c_bus *i2c)
+static int l64781_attach (struct dvb_i2c_bus *i2c, void **data)
 {
 	u8 reg0x3e;
 	u8 b0 [] = { 0x1a };
@@ -465,9 +466,8 @@
 	        goto bailout;
 	}
 
-	dvb_register_frontend (grundig_29504_401_ioctl, i2c, NULL,
+	return dvb_register_frontend (grundig_29504_401_ioctl, i2c, NULL,
 			       &grundig_29504_401_info);
-	return 0;
 
  bailout:
 	l64781_writereg (i2c, 0x3e, reg0x3e);  /* restore reg 0x3e */
@@ -475,7 +475,8 @@
 }
 
 
-static void l64781_detach (struct dvb_i2c_bus *i2c)
+
+static void l64781_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dvb_unregister_frontend (grundig_29504_401_ioctl, i2c);
 }
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/grundig_29504-491.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/grundig_29504-491.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/grundig_29504-491.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/grundig_29504-491.c	2003-10-09 10:44:10.000000000 +0200
@@ -433,19 +433,17 @@
 } 
 
 
-static int tda8083_attach (struct dvb_i2c_bus *i2c)
+static int tda8083_attach (struct dvb_i2c_bus *i2c, void **data)
 {
 	if ((tda8083_readreg (i2c, 0x00)) != 0x05)
 		return -ENODEV;
 
-	dvb_register_frontend (grundig_29504_491_ioctl, i2c, NULL,
+	return dvb_register_frontend (grundig_29504_491_ioctl, i2c, NULL,
 			       &grundig_29504_491_info);
-
-	return 0;
 }
 
 
-static void tda8083_detach (struct dvb_i2c_bus *i2c)
+static void tda8083_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dvb_unregister_frontend (grundig_29504_491_ioctl, i2c);
 }
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/mt312.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/mt312.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/mt312.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/mt312.c	2003-10-09 10:44:10.000000000 +0200
@@ -714,7 +714,7 @@
 	return 0;
 }
 
-static int mt312_attach(struct dvb_i2c_bus *i2c)
+static int mt312_attach(struct dvb_i2c_bus *i2c, void **data)
 {
 	int ret;
 	u8 id;
@@ -734,7 +734,7 @@
 	return 0;
 }
 
-static void mt312_detach(struct dvb_i2c_bus *i2c)
+static void mt312_detach(struct dvb_i2c_bus *i2c, void *data)
 {
 	dvb_unregister_frontend(mt312_ioctl, i2c);
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/nxt6000.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/nxt6000.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/nxt6000.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/nxt6000.c	2003-10-09 10:44:10.000000000 +0200
@@ -829,7 +829,7 @@
 
 static u8 demod_addr_tbl[] = {0x14, 0x18, 0x24, 0x28};
 
-static int nxt6000_attach(struct dvb_i2c_bus *i2c)
+static int nxt6000_attach(struct dvb_i2c_bus *i2c, void **data)
 {
 
 	u8 addr_nr;
@@ -881,13 +881,14 @@
 	
 		dvb_register_frontend(nxt6000_ioctl, i2c, (void *)(*((u32 *)&nxt)), &nxt6000_info);
 		
+		fe_count++;
 	}
 	
 	return (fe_count > 0) ? 0 : -ENODEV;
 	
 }
 
-static void nxt6000_detach(struct dvb_i2c_bus *i2c)
+static void nxt6000_detach(struct dvb_i2c_bus *i2c, void *data)
 {
 
 	dprintk("nxt6000: detach\n");
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/sp887x.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/sp887x.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/sp887x.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/sp887x.c	2003-10-09 10:44:10.000000000 +0200
@@ -561,7 +561,7 @@
 
 
 static
-int sp887x_attach (struct dvb_i2c_bus *i2c)
+int sp887x_attach (struct dvb_i2c_bus *i2c, void **data)
 {
 	struct i2c_msg msg = { addr: 0x70, flags: 0, buf: NULL, len: 0 };
 
@@ -570,14 +570,12 @@
 	if (i2c->xfer (i2c, &msg, 1) != 1)
                 return -ENODEV;
 
-	dvb_register_frontend (sp887x_ioctl, i2c, NULL, &sp887x_info);
-
-	return 0;
+	return dvb_register_frontend (sp887x_ioctl, i2c, NULL, &sp887x_info);
 }
 
 
 static
-void sp887x_detach (struct dvb_i2c_bus *i2c)
+void sp887x_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dprintk ("%s\n", __FUNCTION__);
 	dvb_unregister_frontend (sp887x_ioctl, i2c);
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/stv0299.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/stv0299.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/stv0299.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/stv0299.c	2003-10-09 10:44:10.000000000 +0200
@@ -910,7 +910,7 @@
 }
 
 
-static int uni0299_attach (struct dvb_i2c_bus *i2c)
+static int uni0299_attach (struct dvb_i2c_bus *i2c, void **data)
 {
         long tuner_type;
 	u8 id;
@@ -928,17 +928,14 @@
 	if ((tuner_type = probe_tuner(i2c)) < 0)
 		return -ENODEV;
 
-	dvb_register_frontend (uni0299_ioctl, i2c, (void*) tuner_type, 
+	return dvb_register_frontend (uni0299_ioctl, i2c, (void*) tuner_type, 
 			       &uni0299_info);
-
-	return 0;
 }
 
 
-static void uni0299_detach (struct dvb_i2c_bus *i2c)
+static void uni0299_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dprintk ("%s\n", __FUNCTION__);
-
 	dvb_unregister_frontend (uni0299_ioctl, i2c);
 }
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/tda1004x.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/tda1004x.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/tda1004x.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/tda1004x.c	2003-10-09 10:44:10.000000000 +0200
@@ -1055,7 +1055,7 @@
 }
 
 
-static int tda1004x_attach(struct dvb_i2c_bus *i2c)
+static int tda1004x_attach(struct dvb_i2c_bus *i2c, void **data)
 {
         int tda1004x_address = -1;
 	int tuner_address = -1;
@@ -1113,17 +1113,15 @@
 	// register
         switch(tda_state.tda1004x_address) {
         case TDA10045H_ADDRESS:
-        	dvb_register_frontend(tda1004x_ioctl, i2c, (void *)(*((u32*) &tda_state)), &tda10045h_info);
-                break;
+        	return dvb_register_frontend(tda1004x_ioctl, i2c, (void *)(*((u32*) &tda_state)), &tda10045h_info);
+	default:
+		return -ENODEV;
         }
-
-	// success
-	return 0;
 }
 
 
 static
-void tda1004x_detach(struct dvb_i2c_bus *i2c)
+void tda1004x_detach(struct dvb_i2c_bus *i2c, void *data)
 {
 	dprintk("%s\n", __FUNCTION__);
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/ves1820.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/ves1820.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/ves1820.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/ves1820.c	2003-10-09 10:44:10.000000000 +0200
@@ -507,9 +507,9 @@
 }
 
 
-static int ves1820_attach (struct dvb_i2c_bus *i2c)
+static int ves1820_attach (struct dvb_i2c_bus *i2c, void **data)
 {
-	void *data = NULL;
+	void *priv = NULL;
 	long demod_addr;
 	long tuner_type;
 
@@ -522,21 +522,19 @@
 	if ((i2c->adapter->num < MAX_UNITS) && pwm[i2c->adapter->num] != -1) {
 		printk("DVB: VES1820(%d): pwm=0x%02x (user specified)\n",
 				i2c->adapter->num, pwm[i2c->adapter->num]);
-		SET_PWM(data, pwm[i2c->adapter->num]);
+		SET_PWM(priv, pwm[i2c->adapter->num]);
 	}
 	else
-	SET_PWM(data, read_pwm(i2c));
-	SET_REG0(data, ves1820_inittab[0]);
-	SET_TUNER(data, tuner_type);
-	SET_DEMOD_ADDR(data, demod_addr);
+		SET_PWM(priv, read_pwm(i2c));
+	SET_REG0(priv, ves1820_inittab[0]);
+	SET_TUNER(priv, tuner_type);
+	SET_DEMOD_ADDR(priv, demod_addr);
 
-	dvb_register_frontend (ves1820_ioctl, i2c, data, &ves1820_info);
-
-        return 0;
+	return dvb_register_frontend (ves1820_ioctl, i2c, priv, &ves1820_info);
 }
 
 
-static void ves1820_detach (struct dvb_i2c_bus *i2c)
+static void ves1820_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dvb_unregister_frontend (ves1820_ioctl, i2c);
 }

