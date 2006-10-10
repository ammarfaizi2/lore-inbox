Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWJJNsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWJJNsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWJJNsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:48:55 -0400
Received: from havoc.gtf.org ([69.61.125.42]:62614 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750772AbWJJNsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:48:54 -0400
Date: Tue, 10 Oct 2006 09:48:49 -0400
From: Jeff Garzik <jeff@garzik.org>
To: dmitry.torokhov@gmail.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [INPUT] input drivers: handle sysfs errors
Message-ID: <20061010134849.GA10884@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/input/gameport/fm801-gp.c   |   29 ++++++++++++++++-------
 drivers/input/mouse/logips2pp.c     |    5 ++--
 drivers/input/touchscreen/ads7846.c |   45 ++++++++++++++++++++++++------------
 3 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
index 90de5af..2a2de81 100644
--- a/drivers/input/gameport/fm801-gp.c
+++ b/drivers/input/gameport/fm801-gp.c
@@ -82,17 +82,22 @@ static int __devinit fm801_gp_probe(stru
 {
 	struct fm801_gp *gp;
 	struct gameport *port;
+	int rc = -ENOMEM;
 
 	gp = kzalloc(sizeof(struct fm801_gp), GFP_KERNEL);
+	if (!gp) {
+		printk(KERN_ERR "fm801-gp: Memory allocation failed\n");
+		goto err_out;
+	}
 	port = gameport_allocate_port();
-	if (!gp || !port) {
+	if (!port) {
 		printk(KERN_ERR "fm801-gp: Memory allocation failed\n");
-		kfree(gp);
-		gameport_free_port(port);
-		return -ENOMEM;
+		goto err_out_gp;
 	}
 
-	pci_enable_device(pci);
+	rc = pci_enable_device(pci);
+	if (rc)
+		goto err_out_port;
 
 	port->open = fm801_gp_open;
 #ifdef HAVE_COOKED
@@ -108,9 +113,8 @@ #endif
 	if (!gp->res_port) {
 		printk(KERN_DEBUG "fm801-gp: unable to grab region 0x%x-0x%x\n",
 			port->io, port->io + 0x0f);
-		gameport_free_port(port);
-		kfree(gp);
-		return -EBUSY;
+		rc = -EBUSY;
+		goto err_out_enabledev;
 	}
 
 	pci_set_drvdata(pci, gp);
@@ -119,6 +123,15 @@ #endif
 	gameport_register_port(port);
 
 	return 0;
+
+err_out_enabledev:
+	pci_disable_device(pci);
+err_out_port:
+	gameport_free_port(port);
+err_out_gp:
+	kfree(gp);
+err_out:
+	return rc;
 }
 
 static void __devexit fm801_gp_remove(struct pci_dev *pci)
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index 8a4f862..fe78923 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -393,8 +393,9 @@ int ps2pp_init(struct psmouse *psmouse, 
 				psmouse->set_resolution = ps2pp_set_resolution;
 				psmouse->disconnect = ps2pp_disconnect;
 
-				device_create_file(&psmouse->ps2dev.serio->dev,
-						   &psmouse_attr_smartscroll.dattr);
+				if (device_create_file(&psmouse->ps2dev.serio->dev,
+						       &psmouse_attr_smartscroll.dattr))
+					return -1;
 			}
 		}
 
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f56d6a0..db11b23 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -792,34 +792,49 @@ static int __devinit ads7846_probe(struc
 	 * use the other sensors a bit differently too
 	 */
 	if (ts->model == 7846) {
-		device_create_file(&spi->dev, &dev_attr_temp0);
-		device_create_file(&spi->dev, &dev_attr_temp1);
+		err = device_create_file(&spi->dev, &dev_attr_temp0);
+		if (err)
+			goto err_irq;
+		err = device_create_file(&spi->dev, &dev_attr_temp1);
+		if (err)
+			goto err_temp0;
 	}
-	if (ts->model != 7845)
-		device_create_file(&spi->dev, &dev_attr_vbatt);
-	device_create_file(&spi->dev, &dev_attr_vaux);
+	if (ts->model != 7845) {
+		err = device_create_file(&spi->dev, &dev_attr_vbatt);
+		if (err)
+			goto err_temp1;
+	}
+	err = device_create_file(&spi->dev, &dev_attr_vaux);
+	if (err) goto err_vbatt;
 
-	device_create_file(&spi->dev, &dev_attr_pen_down);
+	err = device_create_file(&spi->dev, &dev_attr_pen_down);
+	if (err) goto err_vaux;
 
-	device_create_file(&spi->dev, &dev_attr_disable);
+	err = device_create_file(&spi->dev, &dev_attr_disable);
+	if (err) goto err_pen;
 
 	err = input_register_device(input_dev);
 	if (err)
-		goto err_remove_attr;
+		goto err_disable;
 
 	return 0;
 
- err_remove_attr:
+ err_disable:
 	device_remove_file(&spi->dev, &dev_attr_disable);
+ err_pen:
 	device_remove_file(&spi->dev, &dev_attr_pen_down);
-	if (ts->model == 7846) {
-		device_remove_file(&spi->dev, &dev_attr_temp1);
-		device_remove_file(&spi->dev, &dev_attr_temp0);
-	}
+ err_vaux:
+	device_remove_file(&spi->dev, &dev_attr_vaux);
+ err_vbatt:
 	if (ts->model != 7845)
 		device_remove_file(&spi->dev, &dev_attr_vbatt);
-	device_remove_file(&spi->dev, &dev_attr_vaux);
-
+ err_temp1:
+	if (ts->model == 7846)
+		device_remove_file(&spi->dev, &dev_attr_temp1);
+ err_temp0:
+	if (ts->model == 7846)
+		device_remove_file(&spi->dev, &dev_attr_temp0);
+ err_irq:
 	free_irq(spi->irq, ts);
  err_free_mem:
 	input_free_device(input_dev);
