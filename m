Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVE2LQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVE2LQF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 07:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVE2LQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 07:16:05 -0400
Received: from 97.59.77.83.cust.bluewin.ch ([83.77.59.97]:17494 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261173AbVE2LP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 07:15:26 -0400
Date: Sun, 29 May 2005 13:10:54 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c-parport disappeared from 2.6.11.9
Message-ID: <20050529111054.GA5966@kestrel>
References: <20050528204836.GA20763@kestrel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20050528204836.GA20763@kestrel>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jean,

I am sending the patch where I changed:
1) Rewrote the initialization into zero-terminated lists as you
   suggested
2) Added exact listing of supported adapters into make menuconfig [Help]
   with their numbers.

Please review the patch and possibly test if it still works. Is it
possibly to already introduce the driver into Linux kernel?

The patch has been worked on 2.6.11.9 kernel tree.

Cheers,

CL<

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Description: i2c2p.patch
Content-Disposition: attachment; filename="i2c2p.patch"

diff -Pur linux-2.6.11.9/drivers/i2c/busses/Kconfig linux-2.6.11.9-i2c2p/drivers/i2c/busses/Kconfig
--- linux-2.6.11.9/drivers/i2c/busses/Kconfig	2005-05-12 00:42:53.000000000 +0200
+++ linux-2.6.11.9-i2c2p/drivers/i2c/busses/Kconfig	2005-05-29 12:23:20.000000000 +0200
@@ -246,9 +246,10 @@
 	select I2C_ALGOBIT
 	help
 	  This supports parallel port I2C adapters such as the ones made by
-	  Philips or Velleman, Analog Devices evaluation boards, and more.
-	  Basically any adapter using the parallel port as an I2C bus with
-	  no extra chipset is supported by this driver, or could be.
+	  Philips or Velleman, Analog Devices evaluation boards, Twibright
+	  I2C2P, and more. Basically any adapter using the parallel port as an
+	  I2C bus with no extra chipset is supported by this driver, or could
+	  be.
 
 	  This driver is a replacement for (and was inspired by) an older
 	  driver named i2c-philips-par.  The new driver supports more devices,
@@ -261,6 +262,16 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-parport.
 
+	  Supported adapters
+	  ------------------
+	  0 Philips adapter
+	  1 home brew teletext adapter
+	  2 Velleman K8000 adapter
+	  3 ELV adapter
+	  4 ADM1032 evaluation board
+	  5 ADM1025, ADM1030 and ADM1031 evaluation boards
+	  6 Twibright I2C2P adapter http://i2c2p.twibright.com
+
 config I2C_PARPORT_LIGHT
 	tristate "Parallel port adapter (light)"
 	depends on I2C
diff -Pur linux-2.6.11.9/drivers/i2c/busses/i2c-parport.c linux-2.6.11.9-i2c2p/drivers/i2c/busses/i2c-parport.c
--- linux-2.6.11.9/drivers/i2c/busses/i2c-parport.c	2005-05-12 00:42:10.000000000 +0200
+++ linux-2.6.11.9-i2c2p/drivers/i2c/busses/i2c-parport.c	2005-05-29 12:58:52.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/parport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
@@ -131,7 +132,7 @@
 /* Encapsulate the functions above in the correct structure.
    Note that this is only a template, from which the real structures are
    copied. The attaching code will set getscl to NULL for adapters that
-   cannot read SCL back, and will also make the the data field point to
+   cannot read SCL back, and will also make the data field point to
    the parallel port structure. */
 static struct i2c_algo_bit_data parport_algo_data = {
 	.setsda		= parport_setsda,
@@ -140,7 +141,13 @@
 	.getscl		= parport_getscl,
 	.udelay		= 60,
 	.mdelay		= 60,
-	.timeout	= HZ,
+	.timeout	= (HZ+99)/100,
+			/* This is 10ms rounded upwards.
+			 * Parport adapter of type 6 may be
+			 * powered down which introduces 90sec delay to
+			 * machine boot if the original value "HZ" is used
+			 * here. I think 10ms should be sufficient for
+			 * the parport adapter timeout. --Clock */
 }; 
 
 /* ----- I2c and parallel port call-back functions and structures --------- */
@@ -152,6 +159,19 @@
 	.name		= "Parallel port adapter",
 };
 
+/* up=1 means start and up=0 stop. Also does a wait after init (and no wait
+ * on deinit). */
+static void start_stop_adapter(struct parport *port,
+		struct adapter_parm* adap, int up)
+{
+	struct lineop *p=adap->init;
+	if (p) while (p->val){
+		line_set(port, up, p);
+		p++;
+	}
+	if (up&&adap->msleep) msleep_interruptible(adap->msleep);
+}
+
 static void i2c_parport_attach (struct parport *port)
 {
 	struct i2c_par *adapter;
@@ -188,8 +208,7 @@
 	parport_setsda(port, 1);
 	parport_setscl(port, 1);
 	/* Other init if needed (power on...) */
-	if (adapter_parm[type].init.val)
-		line_set(port, 1, &adapter_parm[type].init);
+	start_stop_adapter(port,adapter_parm+type,1);
 
 	parport_release(adapter->pdev);
 
@@ -218,8 +237,7 @@
 	     prev = adapter, adapter = adapter->next) {
 		if (adapter->pdev->port == port) {
 			/* Un-init if needed (power off...) */
-			if (adapter_parm[type].init.val)
-				line_set(port, 0, &adapter_parm[type].init);
+			start_stop_adapter(port, adapter_parm+type,0);
 				
 			i2c_bit_del_bus(&adapter->adapter);
 			parport_unregister_device(adapter->pdev);
diff -Pur linux-2.6.11.9/drivers/i2c/busses/i2c-parport.h linux-2.6.11.9-i2c2p/drivers/i2c/busses/i2c-parport.h
--- linux-2.6.11.9/drivers/i2c/busses/i2c-parport.h	2005-05-12 00:43:48.000000000 +0200
+++ linux-2.6.11.9-i2c2p/drivers/i2c/busses/i2c-parport.h	2005-05-29 12:48:39.000000000 +0200
@@ -37,28 +37,47 @@
 	struct lineop setscl;
 	struct lineop getsda;
 	struct lineop getscl;
-	struct lineop init;
+	int msleep;		/* Milliseconds to wait after init */
+	struct lineop* init;	/* Zero-terminated list, where an entry with
+				   zero .val serves as terminator. */
 };
 
+static struct lineop adm1032_init[]= {
+				{ 0xf0, DATA, 0},
+				{ 0, 0, 0}, /* End */
+			  };
+static struct lineop i2c2p_init[]= {
+				{ 0xff, DATA, 0},
+				{ 0x04, CTRL, 0},
+				{ 0x02, CTRL, 1},
+				{ 0, 0, 0 } /* End */
+			  };
+
 static struct adapter_parm adapter_parm[] = {
 	/* type 0: Philips adapter */
 	{
-		.setsda	= { 0x80, DATA, 1 },
-		.setscl	= { 0x08, CTRL, 0 },
-		.getsda	= { 0x80, STAT, 0 },
-		.getscl	= { 0x08, STAT, 0 },
+		.setsda = { 0x80, DATA, 1 },
+		.setscl = { 0x08, CTRL, 0 },
+		.getsda = { 0x80, STAT, 0 },
+		.getscl = { 0x08, STAT, 0 },
+		.msleep = 0,
+		.init=NULL,
 	},
 	/* type 1: home brew teletext adapter */
 	{
 		.setsda	= { 0x02, DATA, 0 },
 		.setscl	= { 0x01, DATA, 0 },
 		.getsda	= { 0x80, STAT, 1 },
+		.msleep = 0,
+		.init	= NULL,
 	},
 	/* type 2: Velleman K8000 adapter */
 	{
 		.setsda	= { 0x02, CTRL, 1 },
 		.setscl	= { 0x08, CTRL, 1 },
 		.getsda	= { 0x10, STAT, 0 },
+		.msleep = 0,
+		.init	= NULL,
 	},
 	/* type 3: ELV adapter */
 	{
@@ -66,19 +85,33 @@
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x40, STAT, 1 },
 		.getscl	= { 0x08, STAT, 1 },
+		.msleep = 0,
+		.init	= NULL,
 	},
 	/* type 4: ADM1032 evaluation board */
 	{
 		.setsda	= { 0x02, DATA, 1 },
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
-		.init	= { 0xf0, DATA, 0 },
+		.msleep = 0,
+		.init	= adm1032_init,
 	},
 	/* type 5: ADM1025, ADM1030 and ADM1031 evaluation boards */
 	{
 		.setsda	= { 0x02, DATA, 1 },
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
+		.msleep = 0,
+		.init	= NULL,
+	},
+	/* type 6: Twibright I2C2P adapter */
+	{
+		.setsda = { 0x01, CTRL, 1},
+		.getsda = { 0x80, STAT, 1},
+		.setscl = { 0x08, CTRL, 1},
+		.getscl = { 0x40, STAT, 0},
+		.msleep = 100,
+		.init	= i2c2p_init,
 	},
 };
 
@@ -91,4 +124,6 @@
 	" 2 = Velleman K8000 adapter\n"
 	" 3 = ELV adapter\n"
 	" 4 = ADM1032 evaluation board\n"
-	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n");
+	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
+	" 6 = Twibright I2C2P adapter\n"
+	"See [Help] in make menuconfig for more info.");

--k+w/mQv8wyuph6w0--
