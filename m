Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTEJWJG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 18:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264520AbTEJWJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 18:09:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40944 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264519AbTEJWJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 18:09:04 -0400
Date: Sun, 11 May 2003 00:21:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.21-rc2: fix sound/kahlua.c .text.exit error
Message-ID: <20030510222138.GT1107@fs.tum.de>
References: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/sound/kahlua.c in 2.4.21-rc2 causes a .text.exit error at the 
final linking when compiled statically into a kernel with CONFIG_HOTPLUG 
enabled. The pointer to remove_one is __devexit_p and not discarded but 
the __exit remove_one is discarded.

The following patch is needed:


--- linux-2.4.21-rc2-full/drivers/sound/kahlua.c.old	2003-05-10 19:03:12.000000000 +0200
+++ linux-2.4.21-rc2-full/drivers/sound/kahlua.c	2003-05-10 19:03:41.000000000 +0200
@@ -182,7 +182,7 @@
 	return 0;
 }
 
-static void __exit remove_one(struct pci_dev *pdev)
+static void __devexit remove_one(struct pci_dev *pdev)
 {
 	struct address_info *hw_config = pci_get_drvdata(pdev);
 	sb_dsp_unload(hw_config, 0);
@@ -219,7 +219,7 @@
 	return pci_module_init(&kahlua_driver);
 }
 
-static void __exit kahlua_cleanup_module(void)
+static void __devexit kahlua_cleanup_module(void)
 {
 	return pci_unregister_driver(&kahlua_driver);
 }


Please apply for -rc3
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

