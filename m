Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263580AbUELX4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUELX4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUELX4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:56:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46291 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263580AbUELXz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:55:57 -0400
Date: Thu, 13 May 2004 01:55:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix aic7xxx_old.c for !PCI
Message-ID: <20040512235555.GF21408@fs.tum.de>
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
  CC      drivers/scsi/aic7xxx_old.o
drivers/scsi/aic7xxx_old.c: In function `aic7xxx_release':
drivers/scsi/aic7xxx_old.c:10971: warning: implicit declaration of function `pci_release_regions'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x2bf0ff): In function `aic7xxx_release':
: undefined reference to `pci_release_regions'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

The patch below fixes this issue.

Please apply
Adrian

--- linux-2.6.6-mm1-full/drivers/scsi/aic7xxx_old.c.old	2004-05-13 01:23:42.000000000 +0200
+++ linux-2.6.6-mm1-full/drivers/scsi/aic7xxx_old.c	2004-05-13 01:25:05.000000000 +0200
@@ -9675,7 +9675,9 @@
           found++;
 	  continue;
 skip_pci_controller:
+#ifdef CONFIG_PCI
 	  pci_release_regions(temp_p->pdev);
+#endif
 	  kfree(temp_p);
         }  /* Found an Adaptec PCI device. */
         else /* Well, we found one, but we couldn't get any memory */
@@ -10967,8 +10969,10 @@
 #endif /* MMAPIO */
   if(!p->pdev)
     release_region(p->base, MAXREG - MINREG);
+#ifdef CONFIG_PCI
   else
     pci_release_regions(p->pdev);
+#endif
   prev = NULL;
   next = first_aic7xxx;
   while(next != NULL)
