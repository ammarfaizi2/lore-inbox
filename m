Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbUKIFZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUKIFZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUKIFZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:25:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:46750 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261368AbUKIFYv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:51 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778574055@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:17 -0800
Message-Id: <10999778572577@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.23, 2004/11/08 16:45:59-08:00, ben-linux@fluff.org

[PATCH] S3C2410 i2c updates

This patch integrates several fixes to the s3c2410 i2c
driver

Shannon Holland:

	- write IICCON in configuration code
	- add handling for s3c2410 i2c errata
	- fix clock rate divisor calculation

Ben Dooks:

	- s3c2440 detection
	- s3c2440 IICLC register setup
	- add __exit to the module exit
	- remove return from exit code

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Shannon Holland <holland@loser.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-s3c2410.c |   68 +++++++++++++++++++++++++++++++++------
 1 files changed, 59 insertions(+), 9 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c	2004-11-08 18:54:28 -08:00
+++ b/drivers/i2c/busses/i2c-s3c2410.c	2004-11-08 18:54:28 -08:00
@@ -72,7 +72,7 @@
 	struct i2c_adapter	adap;
 };
 
-/* default platform data to use if not supplied in the platfrom_device
+/* default platform data to use if not supplied in the platform_device
 */
 
 static struct s3c2410_platform_i2c s3c24xx_i2c_default_platform = {
@@ -80,8 +80,21 @@
 	.slave_addr	= 0x10,
 	.bus_freq	= 100*1000,
 	.max_freq	= 400*1000,
+	.sda_delay	= S3C2410_IICLC_SDA_DELAY5 | S3C2410_IICLC_FILTER_ON,
 };
 
+/* s3c24xx_i2c_is2440()
+ *
+ * return true is this is an s3c2440
+*/
+
+static inline int s3c24xx_i2c_is2440(struct s3c24xx_i2c *i2c)
+{
+	struct platform_device *pdev = to_platform_device(i2c->dev);
+
+	return !strcmp(pdev->name, "s3c2440-i2c");
+}
+
 
 /* s3c24xx_i2c_get_platformdata
  *
@@ -164,10 +177,9 @@
 {
 	unsigned int addr = (msg->addr & 0x7f) << 1;
 	unsigned long stat;
+	unsigned long iiccon;
 
-	stat = readl(i2c->regs + S3C2410_IICSTAT);
-	stat &= ~S3C2410_IICSTAT_MODEMASK;
-	stat |=  S3C2410_IICSTAT_START;
+	stat = 0;
 	stat |=  S3C2410_IICSTAT_TXRXEN;
 
 	if (msg->flags & I2C_M_RD) {
@@ -179,8 +191,18 @@
 	// todo - check for wether ack wanted or not
 	s3c24xx_i2c_enable_ack(i2c);
 
+	iiccon = readl(i2c->regs + S3C2410_IICCON);
+	writel(stat, i2c->regs + S3C2410_IICSTAT);
+	
 	dev_dbg(i2c->dev, "START: %08lx to IICSTAT, %02x to DS\n", stat, addr);
 	writeb(addr, i2c->regs + S3C2410_IICDS);
+	
+	// delay a bit and reset iiccon before setting start (per samsung)
+	udelay(1);
+	dev_dbg(i2c->dev, "iiccon, %08lx\n", iiccon);
+	writel(iiccon, i2c->regs + S3C2410_IICCON);
+	
+	stat |=  S3C2410_IICSTAT_START;
 	writel(stat, i2c->regs + S3C2410_IICSTAT);
 }
 
@@ -265,6 +287,7 @@
 		    !(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
 			/* ack was not received... */
 
+			dev_err(i2c->dev, "ack was not received\n" );
 			s3c24xx_i2c_stop(i2c, -EREMOTEIO);
 			goto out_ack;
 		}
@@ -408,6 +431,7 @@
 
 	if (status & S3C2410_IICSTAT_ARBITR) {
 		// deal with arbitration loss
+		dev_err(i2c->dev, "deal with arbitration loss\n");
 	}
 
 	if (i2c->state == STATE_IDLE) {
@@ -575,7 +599,7 @@
 	*divs = calc_divs;
 	*div1 = calc_div1;
 
-	return clkin / (calc_divs + calc_div1);
+	return clkin / (calc_divs * calc_div1);
 }
 
 /* freq_acceptable
@@ -683,6 +707,17 @@
 	/* todo - check that the i2c lines aren't being dragged anywhere */
 
 	dev_info(i2c->dev, "bus frequency set to %d KHz\n", freq);
+	dev_dbg(i2c->dev, "S3C2410_IICCON=0x%02lx\n", iicon);
+	
+	writel(iicon, i2c->regs + S3C2410_IICCON);
+
+	/* check for s3c2440 i2c controller  */
+
+	if (s3c24xx_i2c_is2440(i2c)) {
+		dev_dbg(i2c->dev, "S3C2440_IICLC=%08x\n", pdata->sda_delay);
+
+		writel(pdata->sda_delay, i2c->regs + S3C2440_IICLC);
+	}
 
 	return 0;
 }
@@ -850,7 +885,7 @@
 
 /* device driver for platform bus bits */
 
-static struct device_driver s3c24xx_i2c_driver = {
+static struct device_driver s3c2410_i2c_driver = {
 	.name		= "s3c2410-i2c",
 	.bus		= &platform_bus_type,
 	.probe		= s3c24xx_i2c_probe,
@@ -858,14 +893,29 @@
 	.resume		= s3c24xx_i2c_resume,
 };
 
+static struct device_driver s3c2440_i2c_driver = {
+	.name		= "s3c2440-i2c",
+	.bus		= &platform_bus_type,
+	.probe		= s3c24xx_i2c_probe,
+	.remove		= s3c24xx_i2c_remove,
+	.resume		= s3c24xx_i2c_resume,
+};
+
 static int __init i2c_adap_s3c_init(void)
 {
-	return driver_register(&s3c24xx_i2c_driver);
+	int ret;
+
+	ret = driver_register(&s3c2410_i2c_driver);
+	if (ret == 0)
+		ret = driver_register(&s3c2440_i2c_driver); 
+
+	return ret;
 }
 
-static void i2c_adap_s3c_exit(void)
+static void __exit i2c_adap_s3c_exit(void)
 {
-	return driver_unregister(&s3c24xx_i2c_driver);
+	driver_unregister(&s3c2410_i2c_driver);
+	driver_unregister(&s3c2440_i2c_driver);
 }
 
 module_init(i2c_adap_s3c_init);

