Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263529AbUELXvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUELXvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUELXvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:51:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7892 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263529AbUELXvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:51:18 -0400
Date: Thu, 13 May 2004 01:51:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: chessman@tux.org
Cc: tlan-devel@lists.sourceforge.net, jgarzik@pobox.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix tlan.c for !PCI
Message-ID: <20040512235115.GE21408@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.6-mm1 (but it's not specific to 
-mm) with CONFIG_PCI=n:

<--  snip  -->

...
  CC      drivers/net/tlan.o
drivers/net/tlan.c: In function `tlan_remove_one':
drivers/net/tlan.c:449: warning: implicit declaration of function `pci_release_regions'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x135183): In function `tlan_remove_one':
: undefined reference to `pci_release_regions'
drivers/built-in.o(.text+0x13541f): In function `TLan_probe1':
: undefined reference to `pci_release_regions'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

The patch below fixes this issue.

Please apply
Adrian

--- linux-2.6.6-mm1-full/drivers/net/tlan.c.old	2004-05-13 01:19:33.000000000 +0200
+++ linux-2.6.6-mm1-full/drivers/net/tlan.c	2004-05-13 01:22:15.000000000 +0200
@@ -446,7 +446,9 @@
 		pci_free_consistent(priv->pciDev, priv->dmaSize, priv->dmaStorage, priv->dmaStorageDMA );
 	}
 
+#ifdef CONFIG_PCI
 	pci_release_regions(pdev);
+#endif
 	
 	free_netdev( dev );
 		
@@ -673,8 +675,10 @@
 err_out_free_dev:
 	free_netdev(dev);
 err_out_regions:
+#ifdef CONFIG_PCI
 	if (pdev)
 		pci_release_regions(pdev);
+#endif
 err_out:
 	if (pdev)
 		pci_disable_device(pdev);
