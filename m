Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161299AbWI2G2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161299AbWI2G2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161436AbWI2G2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:28:14 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:35946 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161299AbWI2G2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:28:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=tWnl4vJqqlWSTk27VkVhEhfDqntTysv/UkKeYIXklCiHE3fYEZu84coFCECJ/+JPfWeRtDDfrZA6S2+zfp7dUNatVSqoVywb4lPXbR/aVoRl/nLPu2/YS9mjZmAoV+ffFeLVoHPzoytqn/qFgQKlAzQ4LeBiTOOoYbpbADLdNFw=  ;
From: David Brownell <david-b@pacbell.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: [patch 2.6.18-git] i2c/tps65010, update for current i2c-omap
Date: Thu, 28 Sep 2006 23:28:09 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609282328.09871.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the TPS6501x driver to stop trying to use the faked-out
I2C probe protocol (never guaranteed to work), since the OMAP I2C
driver merged to kernel.org no longer tries to support it.

Until the I2C stack is updated to offer full driver model support from
static board-specific device tables, and is able to pass things like
IRQ resources and chip IDs, the only way to address this type of issue
is for drivers to have board-specific info kick in before registering
the driver (for addressing), and in the probe code (for other resources).
So that's what this patch adds.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

------
please merge for 2.6.18-rc ...

--- osk.orig/drivers/i2c/chips/tps65010.c	2006-09-28 19:27:51.000000000 -0700
+++ osk/drivers/i2c/chips/tps65010.c	2006-09-28 21:06:10.000000000 -0700
@@ -42,15 +42,38 @@
 
 /*-------------------------------------------------------------------------*/
 
-#define	DRIVER_VERSION	"2 May 2005"
+#define	DRIVER_VERSION	"28 Sept 2006"
 #define	DRIVER_NAME	(tps65010_driver.driver.name)
 
 MODULE_DESCRIPTION("TPS6501x Power Management Driver");
 MODULE_LICENSE("GPL");
 
-static unsigned short normal_i2c[] = { 0x48, /* 0x49, */ I2C_CLIENT_END };
 
-I2C_CLIENT_INSMOD;
+/* The i2c-omap driver doesn't support the i2c request used to fake probes,
+ * so we need board-specific tables saying what devices exist.
+ *
+ * Until the I2C stack doesn't support such tables, we need to fake them
+ * in the module initialization code (and in driver init for IRQs etc).
+ *
+ * Note we expect only ONE tps chip per board; no point in having more.
+ */
+
+static unsigned short force[3] __devinitdata = {
+	0, 0x48,		/* default address */
+	I2C_CLIENT_END,
+};
+static unsigned short *forces[] __devinitdata = { force, NULL, };
+
+static unsigned short ignore[] __devinitdata = {
+	I2C_CLIENT_END, I2C_CLIENT_END,
+};
+
+static struct i2c_client_address_data addr_data __devinitdata = {
+	.forces		= forces,
+	.probe		= ignore,
+	.normal_i2c	= ignore,
+	.ignore		= ignore,
+};
 
 static struct i2c_driver tps65010_driver;
 
@@ -990,6 +1013,15 @@ static int __init tps_init(void)
 	u32	tries = 3;
 	int	status = -ENODEV;
 
+#ifdef	CONFIG_ARM
+	if (machine_is_omap_osk()
+			|| machine_is_omap_h2()
+			|| machine_is_omap_h3())
+		/* ok */ ;
+	else
+		return status;
+#endif
+
 	printk(KERN_INFO "%s: version %s\n", DRIVER_NAME, DRIVER_VERSION);
 
 	/* some boards have startup glitches */
