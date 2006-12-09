Return-Path: <linux-kernel-owner+w=401wt.eu-S937659AbWLIUbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937659AbWLIUbp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937668AbWLIUbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:31:45 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:46877 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937659AbWLIUbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:31:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=Ip7e40uAxZmU+a4pFrNwXmRV03lYglHEGuMM3pglHpMesa5rVB4rKSLFVKkEpvl86Qf2hmOEMP+tMZ5zGpkGyCNzs9fpWThLRpU+zLxGH3HUqhqI+6lDluI6a+cyjFdmLoB1zsSoJPkfrvoN+bJJIlS/j3Fseqn2PLj8/eCVVVk=  ;
X-YMail-OSG: e4AiN.wVM1lGWc4tU0RnYQmDkhZ42nfWs37W1bgF9V5eDhcaAFp_Lbwta4G6xyVShQxsHDEZLMI6BbLkIVpWrUNECM53q6VR4q1GmfH5w4aFX6Er.AJVb6ly3ZuoMd5slzTAvpB9Bt8AcYk-
Date: Sat, 09 Dec 2006 12:31:34 -0800
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.19-git] fix more workqueue build breakage (tps65010)
Cc: tony@atomide.com, khali@linux-fr.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061209203134.4DFF81EC631@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More fixes to build breakage from the work_struct changes ... this
updates the tps65010 driver.  Plus, fix some dependencies related
to the way it's used on the OMAP OSK:  force static linking there,
since the resulting kernel can't link.

NOTE that until the i2c core gets fixed to work without SMBUS_QUICK,
kernels needing this driver must still use "tps65010.force=0,0x48"
on the command line.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: osk/drivers/i2c/chips/tps65010.c
===================================================================
--- osk.orig/drivers/i2c/chips/tps65010.c	2006-12-08 02:14:57.000000000 -0800
+++ osk/drivers/i2c/chips/tps65010.c	2006-12-09 11:37:13.000000000 -0800
@@ -82,7 +82,7 @@ struct tps65010 {
 	struct i2c_client	client;
 	struct mutex		lock;
 	int			irq;
-	struct work_struct	work;
+	struct delayed_work	work;
 	struct dentry		*file;
 	unsigned		charging:1;
 	unsigned		por:1;
@@ -328,7 +328,7 @@ static void tps65010_interrupt(struct tp
 {
 	u8 tmp = 0, mask, poll;
 
-	/* IRQs won't trigger irqs for certain events, but we can get
+	/* IRQs won't trigger for certain events, but we can get
 	 * others by polling (normally, with external power applied).
 	 */
 	poll = 0;
@@ -411,10 +411,11 @@ static void tps65010_interrupt(struct tp
 }
 
 /* handle IRQs and polling using keventd for now */
-static void tps65010_work(void *_tps)
+static void tps65010_work(struct work_struct *work)
 {
-	struct tps65010		*tps = _tps;
+	struct tps65010		*tps;
 
+	tps = container_of(work, struct tps65010, work.work);
 	mutex_lock(&tps->lock);
 
 	tps65010_interrupt(tps);
@@ -452,7 +453,7 @@ static irqreturn_t tps65010_irq(int irq,
 
 	disable_irq_nosync(irq);
 	set_bit(FLAG_IRQ_ENABLE, &tps->flags);
-	(void) schedule_work(&tps->work);
+	(void) schedule_work(&tps->work.work);
 	return IRQ_HANDLED;
 }
 
@@ -465,13 +466,15 @@ static int __exit tps65010_detach_client
 	struct tps65010		*tps;
 
 	tps = container_of(client, struct tps65010, client);
+	free_irq(tps->irq, tps);
 #ifdef	CONFIG_ARM
 	if (machine_is_omap_h2())
 		omap_free_gpio(58);
 	if (machine_is_omap_osk())
 		omap_free_gpio(OMAP_MPUIO(1));
 #endif
-	free_irq(tps->irq, tps);
+	cancel_delayed_work(&tps->work);
+	flush_scheduled_work();
 	debugfs_remove(tps->file);
 	if (i2c_detach_client(client) == 0)
 		kfree(tps);
@@ -505,7 +508,7 @@ tps65010_probe(struct i2c_adapter *bus, 
 		return 0;
 
 	mutex_init(&tps->lock);
-	INIT_WORK(&tps->work, tps65010_work, tps);
+	INIT_DELAYED_WORK(&tps->work, tps65010_work);
 	tps->irq = -1;
 	tps->client.addr = address;
 	tps->client.adapter = bus;
@@ -620,7 +623,7 @@ tps65010_probe(struct i2c_adapter *bus, 
 	(void) i2c_smbus_write_byte_data(&tps->client, TPS_MASK3, 0x0f
 		| i2c_smbus_read_byte_data(&tps->client, TPS_MASK3));
 
-	tps65010_work(tps);
+	tps65010_work(&tps->work.work);
 
 	tps->file = debugfs_create_file(DRIVER_NAME, S_IRUGO, NULL,
 				tps, DEBUG_FOPS);
@@ -672,7 +675,7 @@ int tps65010_set_vbus_draw(unsigned mA)
 			&& test_and_set_bit(
 				FLAG_VBUS_CHANGED, &the_tps->flags)) {
 		/* gadget drivers call this in_irq() */
-		(void) schedule_work(&the_tps->work);
+		(void) schedule_work(&the_tps->work.work);
 	}
 	local_irq_restore(flags);
 
Index: osk/arch/arm/mach-omap1/Kconfig
===================================================================
--- osk.orig/arch/arm/mach-omap1/Kconfig	2006-11-16 09:10:45.000000000 -0800
+++ osk/arch/arm/mach-omap1/Kconfig	2006-12-09 11:57:46.000000000 -0800
@@ -43,6 +43,7 @@ config MACH_OMAP_H3
 config MACH_OMAP_OSK
 	bool "TI OSK Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
+	select TPS65010
     	help
 	  TI OMAP 5912 OSK (OMAP Starter Kit) board support. Say Y here
           if you have such a board.
