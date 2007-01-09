Return-Path: <linux-kernel-owner+w=401wt.eu-S1751210AbXAIJCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbXAIJCa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbXAIJC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:02:26 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:35402 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbXAIJBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:01:53 -0500
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH 5/5] fixing errors handling during pci_driver resume stage [serial]
From: Dmitriy Monakhov <dmonakhov@openvz.org>
Date: Tue, 09 Jan 2007 12:01:58 +0300
Message-ID: <87ps9omv3t.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

serial pci drivers have to return correct error code during resume stage in
case of errors.
Signed-off-by: Dmitriy Monakhov <dmonakhov@openvz.org>
-----

--=-=-=
Content-Disposition: inline; filename=diff-pci-serial

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 78c0a26..1e14906 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -392,6 +392,7 @@ static int parport_serial_pci_suspend(st
 static int parport_serial_pci_resume(struct pci_dev *dev)
 {
 	struct parport_serial_private *priv = pci_get_drvdata(dev);
+	int err;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -399,7 +400,11 @@ static int parport_serial_pci_resume(str
 	/*
 	 * The device may have been disabled.  Re-enable it.
 	 */
-	pci_enable_device(dev);
+	err = pci_enable_device(dev);
+	if (err) {
+		dev_err(&dev->dev, "Cannot enable PCI device, aborting.\n");
+		return err;
+	}
 
 	if (priv->serial)
 		pciserial_resume_ports(priv->serial);
diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 52e2e64..e26e4a6 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -1805,6 +1805,7 @@ static int pciserial_suspend_one(struct
 static int pciserial_resume_one(struct pci_dev *dev)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
+	int err;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -1813,7 +1814,12 @@ static int pciserial_resume_one(struct p
 		/*
 		 * The device may have been disabled.  Re-enable it.
 		 */
-		pci_enable_device(dev);
+		err = pci_enable_device(dev);
+		if (err) {
+			dev_err(&dev->dev, "Cannot enable PCI device, "
+				"aborting.\n");
+			return err;
+		}
 
 		pciserial_resume_ports(priv);
 	}
diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index 7186a82..583cdc8 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -1132,12 +1132,19 @@ static int pciserial_txx9_suspend_one(st
 static int pciserial_txx9_resume_one(struct pci_dev *dev)
 {
 	int line = (int)(long)pci_get_drvdata(dev);
+	int err;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
 
 	if (line) {
-		pci_enable_device(dev);
+		err = pci_enable_device(dev);
+		if (err) {
+			dev_err(&dev->dev, "Cannot enable PCI device, "
+				"aborting.\n");
+			return err;
+		}
+
 		serial_txx9_resume_port(line);
 	}
 	return 0;

--=-=-=--

