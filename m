Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWF0QkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWF0QkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWF0QkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:40:18 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:65486 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1161162AbWF0Qj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:39:59 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jean Delvare <khali@linux-fr.org>
Subject: Regression in -git / [PATCH] i2c-i801.c: don't pci_disable_device() after it was just enabled
Date: Tue, 27 Jun 2006 18:40:54 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606271840.56044.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-04.tornado.cablecom.ch 1378;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yet another small regression in current git...so only 2 left for me:)
rgds
-daniel

-----

[PATCH] i2c-i801.c: don't pci_disable_device() after it was just enabled

Commit 02dd7ae2892e5ceff111d032769c78d3377df970:
	[PATCH] i2c-i801: Merge setup function
has a missing return 0 in the _probe() function. this means the error
path is always executed and pci_disable_device() is called even when
the device just got successfully enabled.

having the SMBus device disabled makes some systems (eg. Fujitsu-Siemens
Lifebook E8010) hang hard during power-off.

Intead of reverting the whole commit this patch fixes it up:
- don't ever call pci_disable_device(), also not in the _remove() function
  to avoid hangs
- fix missing pci_release_region() in error path

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 3e0d04d..8b46ef7 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -488,7 +488,7 @@ static int __devinit i801_probe(struct p
 		dev_err(&dev->dev, "SMBus base address uninitialized, "
 			"upgrade BIOS\n");
 		err = -ENODEV;
-		goto exit_disable;
+		goto exit;
 	}
 
 	err = pci_request_region(dev, SMBBAR, i801_driver.name);
@@ -496,7 +496,7 @@ static int __devinit i801_probe(struct p
 		dev_err(&dev->dev, "Failed to request SMBus region "
 			"0x%lx-0x%lx\n", i801_smba,
 			pci_resource_end(dev, SMBBAR));
-		goto exit_disable;
+		goto exit;
 	}
 
 	pci_read_config_byte(I801_dev, SMBHSTCFG, &temp);
@@ -520,11 +520,12 @@ static int __devinit i801_probe(struct p
 	err = i2c_add_adapter(&i801_adapter);
 	if (err) {
 		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
-		goto exit_disable;
+		goto exit_release;
 	}
+	return 0;
 
-exit_disable:
-	pci_disable_device(dev);
+exit_release:
+	pci_release_region(dev, SMBBAR);
 exit:
 	return err;
 }
@@ -533,7 +534,10 @@ static void __devexit i801_remove(struct
 {
 	i2c_del_adapter(&i801_adapter);
 	pci_release_region(dev, SMBBAR);
-	pci_disable_device(dev);
+	/*
+	 * do not call pci_disable_device(dev) since it can cause hard hangs on
+	 * some systems during power-off (eg. Fujitsu-Siemens Lifebook E8010)
+	 */
 }
 
 static struct pci_driver i801_driver = {
