Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbUJXNM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUJXNM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUJXNM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:12:26 -0400
Received: from verein.lst.de ([213.95.11.210]:63653 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261474AbUJXNLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:11:52 -0400
Date: Sun, 24 Oct 2004 15:11:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: peter.hettkamp@t-online.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill useless exports and bookkeeping in bt878.c
Message-ID: <20041024131149.GB19567@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - no point in exporting bt878_init_module and bt878_cleanup_module,
   they are always called on module load/removal
 - bt878_find_audio_dma and the registered bookeeping is utterly
   pointless as a registration always heppens on load anyway


--- 1.6/drivers/media/dvb/bt8xx/bt878.c	2004-10-21 10:39:27 +02:00
+++ edited/drivers/media/dvb/bt8xx/bt878.c	2004-10-23 14:29:35 +02:00
@@ -557,52 +557,24 @@
       .remove 	= __devexit_p(bt878_remove),
 };
 
-static int bt878_pci_driver_registered = 0;
-
-/* This will be used later by dvb-bt8xx to only use the audio
- * dma of certain cards */
-int bt878_find_audio_dma(void)
-{
-	// pci_register_driver(&bt878_pci_driver);
-	bt878_pci_driver_registered = 1;
-	return 0;
-}
-
-EXPORT_SYMBOL(bt878_find_audio_dma);
-
 /*******************************/
 /* Module management functions */
 /*******************************/
 
-int bt878_init_module(void)
+static int bt878_init_module(void)
 {
-	bt878_num = 0;
-	bt878_pci_driver_registered = 0;
-
 	printk(KERN_INFO "bt878: AUDIO driver version %d.%d.%d loaded\n",
 	       (BT878_VERSION_CODE >> 16) & 0xff,
 	       (BT878_VERSION_CODE >> 8) & 0xff,
 	       BT878_VERSION_CODE & 0xff);
-/*
-        bt878_check_chipset();
-*/
-	/* later we register inside of bt878_find_audio_dma
-	 * because we may want to ignore certain cards */
-	bt878_pci_driver_registered = 1;
 	return pci_module_init(&bt878_pci_driver);
 }
 
-void bt878_cleanup_module(void)
+static void bt878_cleanup_module(void)
 {
-	if (bt878_pci_driver_registered) {
-		bt878_pci_driver_registered = 0;
-		pci_unregister_driver(&bt878_pci_driver);
-	}
-	return;
+	pci_unregister_driver(&bt878_pci_driver);
 }
 
-EXPORT_SYMBOL(bt878_init_module);
-EXPORT_SYMBOL(bt878_cleanup_module);
 module_init(bt878_init_module);
 module_exit(bt878_cleanup_module);
 
===== drivers/media/video/v4l2-common.c 1.4 vs edited =====
