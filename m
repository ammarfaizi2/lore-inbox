Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUGQUHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUGQUHO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 16:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUGQUHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 16:07:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12534 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261474AbUGQUHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 16:07:12 -0400
Date: Sat, 17 Jul 2004 22:07:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Krzysztof Rusocki <kszysiu@iceberg.elsat.net.pl>, cltien@cmedia.com.tw,
       linux-kernel@vger.kernel.org
Subject: [2.4 patch] cmpci oops on rmmod + fix
Message-ID: <20040717200704.GD14733@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch originally sent against 2.6 by
Krzysztof Rusocki <kszysiu@iceberg.elsat.net.pl> (and already included 
in 2.6.8-rc1).

His explanation of the patch was:

<--  snip  -->

The cmpci driver included in Linux 2.6.7 causes an oops on rmmod,
I believe cm_remove should be marked __devexit rather than __devinit.

<--  snip  -->


This is an obvious bug, and below is my backport of his fix to 2.4 .
While I was editing struct cm_driver, I've also converted it to C99 
initializers (as already done in 2.6).


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.27-rc3-full/drivers/sound/cmpci.c.old	2004-07-17 21:56:28.000000000 +0200
+++ linux-2.4.27-rc3-full/drivers/sound/cmpci.c	2004-07-17 21:57:22.000000000 +0200
@@ -3595,7 +3595,7 @@
 MODULE_DESCRIPTION("CM8x38 Audio Driver");
 MODULE_LICENSE("GPL");
 
-static void __devinit cm_remove(struct pci_dev *dev)
+static void __devexit cm_remove(struct pci_dev *dev)
 {
 	struct cm_state *s = pci_get_drvdata(dev);
 
@@ -3643,10 +3643,10 @@
 MODULE_DEVICE_TABLE(pci, id_table);
 
 static struct pci_driver cm_driver = {
-       name: "cmpci",
-       id_table: id_table,
-       probe: cm_probe,
-       remove: cm_remove
+	.name		= "cmpci",
+	.id_table	= id_table,
+	.probe		= cm_probe,
+	.remove		= __devexit_p(cm_remove)
 };
  
 static int __init init_cmpci(void)

