Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVBEAee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVBEAee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265104AbVBDWtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:49:43 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:23052 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S264476AbVBDWO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:14:59 -0500
Message-ID: <4203F4A8.4000606@gentoo.org>
Date: Fri, 04 Feb 2005 22:18:16 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: [-mm PATCH] driver model: PM type conversions in drivers/serial
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040402050108030804050008"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CxBj3-000N49-M3*lQBHVVqlFQw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040402050108030804050008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes PM driver model type checking for drivers/serial.
Acked by Pavel Machek.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------040402050108030804050008
Content-Type: text/x-patch;
 name="serial-pm-type-safety.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-pm-type-safety.patch"

diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/serial/amba-pl010.c linux-dsd/drivers/serial/amba-pl010.c
--- linux-2.6.11-rc2-mm2/drivers/serial/amba-pl010.c	2004-12-24 21:34:00.000000000 +0000
+++ linux-dsd/drivers/serial/amba-pl010.c	2005-02-02 20:16:42.000000000 +0000
@@ -772,7 +772,7 @@ static int pl010_remove(struct amba_devi
 	return 0;
 }
 
-static int pl010_suspend(struct amba_device *dev, u32 state)
+static int pl010_suspend(struct amba_device *dev, pm_message_t state)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/serial/imx.c linux-dsd/drivers/serial/imx.c
--- linux-2.6.11-rc2-mm2/drivers/serial/imx.c	2004-12-24 21:35:39.000000000 +0000
+++ linux-dsd/drivers/serial/imx.c	2005-02-02 20:17:08.000000000 +0000
@@ -818,7 +818,7 @@ static struct uart_driver imx_reg = {
 	.cons           = IMX_CONSOLE,
 };
 
-static int serial_imx_suspend(struct device *_dev, u32 state, u32 level)
+static int serial_imx_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
         struct imx_port *sport = dev_get_drvdata(_dev);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/serial/mpc52xx_uart.c linux-dsd/drivers/serial/mpc52xx_uart.c
--- linux-2.6.11-rc2-mm2/drivers/serial/mpc52xx_uart.c	2005-02-02 21:54:20.000000000 +0000
+++ linux-dsd/drivers/serial/mpc52xx_uart.c	2005-02-02 20:17:39.000000000 +0000
@@ -794,7 +794,7 @@ mpc52xx_uart_remove(struct ocp_device *o
 
 #ifdef CONFIG_PM
 static int
-mpc52xx_uart_suspend(struct ocp_device *ocp, u32 state)
+mpc52xx_uart_suspend(struct ocp_device *ocp, pm_message_t state)
 {
 	struct uart_port *port = (struct uart_port *) ocp_get_drvdata(ocp);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/serial/pmac_zilog.c linux-dsd/drivers/serial/pmac_zilog.c
--- linux-2.6.11-rc2-mm2/drivers/serial/pmac_zilog.c	2005-02-02 21:55:28.000000000 +0000
+++ linux-dsd/drivers/serial/pmac_zilog.c	2005-02-02 21:57:44.114230728 +0000
@@ -1590,7 +1590,7 @@ static int pmz_detach(struct macio_dev *
 }
 
 
-static int pmz_suspend(struct macio_dev *mdev, u32 pm_state)
+static int pmz_suspend(struct macio_dev *mdev, pm_message_t pm_state)
 {
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
 	struct uart_state *state;
@@ -1661,7 +1661,7 @@ static int pmz_resume(struct macio_dev *
 	if (uap == NULL)
 		return 0;
 
-	if (mdev->ofdev.dev.power.power_state == 0)
+	if (mdev->ofdev.dev.power.power_state == PMSG_ON)
 		return 0;
 	
 	pmz_debug("resume, switching to state 0\n");
@@ -1714,7 +1714,7 @@ static int pmz_resume(struct macio_dev *
 
 	pmz_debug("resume, switching complete\n");
 
-	mdev->ofdev.dev.power.power_state = 0;
+	mdev->ofdev.dev.power.power_state = PMSG_ON;
 
 	return 0;
 }
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/serial/pxa.c linux-dsd/drivers/serial/pxa.c
--- linux-2.6.11-rc2-mm2/drivers/serial/pxa.c	2004-12-24 21:35:28.000000000 +0000
+++ linux-dsd/drivers/serial/pxa.c	2005-02-02 20:18:54.000000000 +0000
@@ -797,7 +797,7 @@ static struct uart_driver serial_pxa_reg
 	.cons		= PXA_CONSOLE,
 };
 
-static int serial_pxa_suspend(struct device *_dev, u32 state, u32 level)
+static int serial_pxa_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
         struct uart_pxa_port *sport = dev_get_drvdata(_dev);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/serial/s3c2410.c linux-dsd/drivers/serial/s3c2410.c
--- linux-2.6.11-rc2-mm2/drivers/serial/s3c2410.c	2005-02-02 21:55:28.000000000 +0000
+++ linux-dsd/drivers/serial/s3c2410.c	2005-02-02 20:19:20.000000000 +0000
@@ -1135,7 +1135,7 @@ int s3c24xx_serial_remove(struct device 
 
 #ifdef CONFIG_PM
 
-int s3c24xx_serial_suspend(struct device *dev, u32 state, u32 level)
+int s3c24xx_serial_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/serial/sa1100.c linux-dsd/drivers/serial/sa1100.c
--- linux-2.6.11-rc2-mm2/drivers/serial/sa1100.c	2004-12-24 21:34:00.000000000 +0000
+++ linux-dsd/drivers/serial/sa1100.c	2005-02-02 20:20:04.000000000 +0000
@@ -854,7 +854,7 @@ static struct uart_driver sa1100_reg = {
 	.cons			= SA1100_CONSOLE,
 };
 
-static int sa1100_serial_suspend(struct device *_dev, u32 state, u32 level)
+static int sa1100_serial_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
 	struct sa1100_port *sport = dev_get_drvdata(_dev);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/serial/serial_txx9.c linux-dsd/drivers/serial/serial_txx9.c
--- linux-2.6.11-rc2-mm2/drivers/serial/serial_txx9.c	2005-02-02 21:55:28.000000000 +0000
+++ linux-dsd/drivers/serial/serial_txx9.c	2005-02-02 20:21:09.000000000 +0000
@@ -1095,7 +1095,7 @@ static void __devexit pciserial_txx9_rem
 	}
 }
 
-static int pciserial_txx9_suspend_one(struct pci_dev *dev, u32 state)
+static int pciserial_txx9_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	int line = (int)(long)pci_get_drvdata(dev);
 

--------------040402050108030804050008--
