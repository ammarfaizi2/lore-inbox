Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUGLOme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUGLOme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266855AbUGLOmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:42:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24839 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266854AbUGLOmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:42:13 -0400
Date: Mon, 12 Jul 2004 15:42:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Update pcips2 driver
Message-ID: <20040712154207.A15469@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use pci_request_regions()/pci_release_regions() instead of
request_region()/release_region()

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/./drivers/input/serio/pcips2.c linux/./drivers/input/serio/pcips2.c
--- orig/./drivers/input/serio/pcips2.c	Thu Sep  4 16:37:05 2003
+++ linux/./drivers/input/serio/pcips2.c	Sat Aug 23 10:10:57 2003
@@ -133,13 +133,11 @@ static int __devinit pcips2_probe(struct
 
 	ret = pci_enable_device(dev);
 	if (ret)
-		return ret;
+		goto out;
 
-	if (!request_region(pci_resource_start(dev, 0),
-			    pci_resource_len(dev, 0), "pcips2")) {
-		ret = -EBUSY;
+	ret = pci_request_regions(dev, "pcips2");
+	if (ret)
 		goto disable;
-	}
 
 	ps2if = kmalloc(sizeof(struct pcips2_data), GFP_KERNEL);
 	if (!ps2if) {
@@ -165,10 +163,10 @@ static int __devinit pcips2_probe(struct
 	return 0;
 
  release:
-	release_region(pci_resource_start(dev, 0),
-		       pci_resource_len(dev, 0));
+	pci_release_regions(dev);
  disable:
 	pci_disable_device(dev);
+ out:
 	return ret;
 }
 
@@ -177,10 +175,9 @@ static void __devexit pcips2_remove(stru
 	struct pcips2_data *ps2if = pci_get_drvdata(dev);
 
 	serio_unregister_port(&ps2if->io);
-	release_region(pci_resource_start(dev, 0),
-		       pci_resource_len(dev, 0));
 	pci_set_drvdata(dev, NULL);
 	kfree(ps2if);
+	pci_release_regions(dev);
 	pci_disable_device(dev);
 }
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
