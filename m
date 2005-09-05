Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVIEV3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVIEV3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVIEV3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:29:04 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:32591 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932547AbVIEV3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:29:03 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 16/24] V4L: Some error treatment implemented at resume
 functions.
Message-ID: <431cb7f8.4gQ+NpMSIC1Crvhc%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.9jc5/yokpOGfoPCsIULjJmeHgvJ/GLEWQEG5zSQrmNG11TU+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.9jc5/yokpOGfoPCsIULjJmeHgvJ/GLEWQEG5zSQrmNG11TU+
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.9jc5/yokpOGfoPCsIULjJmeHgvJ/GLEWQEG5zSQrmNG11TU+
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-16-patch.diff"

- Some error treatment implemented at resume functions.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/bttv-driver.c     |   18 ++++++++++++++++--
 linux/drivers/media/video/cx88/cx88-mpeg.c  |   20 +++++++++++++++++---
 linux/drivers/media/video/cx88/cx88-video.c |   20 ++++++++++++++++++--
 3 files changed, 51 insertions(+), 7 deletions(-)

diff -u /tmp/dst.587 linux/drivers/media/video/bttv-driver.c
--- /tmp/dst.587	2005-09-05 11:43:02.000000000 -0300
+++ linux/drivers/media/video/bttv-driver.c	2005-09-05 11:43:02.000000000 -0300
@@ -4112,15 +4112,29 @@
 {
         struct bttv *btv = pci_get_drvdata(pci_dev);
 	unsigned long flags;
+	int err;
 
 	dprintk("bttv%d: resume\n", btv->c.nr);
 
 	/* restore pci state */
 	if (btv->state.disabled) {
-		pci_enable_device(pci_dev);
+		err=pci_enable_device(pci_dev);
+		if (err) {
+			printk(KERN_WARNING "bttv%d: Can't enable device.\n",
+								btv->c.nr);
+			return err;
+		}
 		btv->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, PCI_D0);
+	err=pci_set_power_state(pci_dev, PCI_D0);
+	if (err) {
+		pci_disable_device(pci_dev);
+		printk(KERN_WARNING "bttv%d: Can't enable device.\n",
+							btv->c.nr);
+		btv->state.disabled = 1;
+		return err;
+	}
+
 	pci_restore_state(pci_dev);
 
 	/* restore bt878 state */
diff -u /tmp/dst.587 linux/drivers/media/video/cx88/cx88-video.c
--- /tmp/dst.587	2005-09-05 11:43:02.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-09-05 11:43:02.000000000 -0300
@@ -2005,12 +2005,28 @@
 {
 	struct cx8800_dev *dev = pci_get_drvdata(pci_dev);
 	struct cx88_core *core = dev->core;
+	int err;
 
 	if (dev->state.disabled) {
-		pci_enable_device(pci_dev);
+		err=pci_enable_device(pci_dev);
+		if (err) {
+			printk(KERN_ERR "%s: can't enable device\n",
+						       core->name);
+			return err;
+		}
+
 		dev->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, PCI_D0);
+	err= pci_set_power_state(pci_dev, PCI_D0);
+	if (err) {
+		printk(KERN_ERR "%s: can't enable device\n",
+				       core->name);
+
+		pci_disable_device(pci_dev);
+		dev->state.disabled = 1;
+	
+		return err;
+	}
 	pci_restore_state(pci_dev);
 
 	/* FIXME: re-initialize hardware */
diff -u /tmp/dst.587 linux/drivers/media/video/cx88/cx88-mpeg.c
--- /tmp/dst.587	2005-09-05 11:43:02.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-mpeg.c	2005-09-05 11:43:02.000000000 -0300
@@ -455,14 +455,28 @@
 
 int cx8802_resume_common(struct pci_dev *pci_dev)
 {
-        struct cx8802_dev *dev = pci_get_drvdata(pci_dev);
+	struct cx8802_dev *dev = pci_get_drvdata(pci_dev);
 	struct cx88_core *core = dev->core;
+	int err;
 
 	if (dev->state.disabled) {
-		pci_enable_device(pci_dev);
+		err=pci_enable_device(pci_dev);
+		if (err) {
+			printk(KERN_ERR "%s: can't enable device\n",
+					       dev->core->name);
+			return err;
+		}
 		dev->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, PCI_D0);
+	err=pci_set_power_state(pci_dev, PCI_D0);
+	if (err) {
+		printk(KERN_ERR "%s: can't enable device\n",
+					       dev->core->name);
+		pci_disable_device(pci_dev);
+		dev->state.disabled = 1;
+
+		return err;
+	}
 	pci_restore_state(pci_dev);
 
 	/* FIXME: re-initialize hardware */

--=_431cb7f8.9jc5/yokpOGfoPCsIULjJmeHgvJ/GLEWQEG5zSQrmNG11TU+--
