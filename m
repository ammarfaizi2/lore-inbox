Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTJRUzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJRUzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:55:35 -0400
Received: from 72.dom-sp.ru ([212.57.164.72]:18440 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S261827AbTJRUzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:55:31 -0400
Date: Sun, 19 Oct 2003 02:55:20 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: gibbs@scsiguy.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH TRIVIAL] Compile error in 2.4.22 without PCI
Message-ID: <20031019025520.B26563@natasha.ward.six>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have these warnings when I'm compiling 2.4.22 for a 486 EISA system:

aic7xxx_osm.c: In function `ahc_softc_comp':
aic7xxx_osm.c:1560: warning: implicit declaration of function `ahc_get_pci_bus'
aic7xxx_osm.c:1568: warning: implicit declaration of function `ahc_get_pci_slot'

And then the make finishes with an error, because these functions
really exist only if the PCI support is turned on.

The patch below fixes this.  And the same patch fits for the 2.6
kernels.  Please, apply it.


--- drivers/scsi/aic7xxx/aic7xxx_osm.c.orig	2003-09-15 01:56:14.000000000 +0600
+++ drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-10-15 00:23:37.000000000 +0600
@@ -1552,6 +1552,7 @@ ahc_softc_comp(struct ahc_softc *lahc, s
 
 	/* Still equal.  Sort by BIOS address, ioport, or bus/slot/func. */
 	switch (rvalue) {
+#ifdef CONFIG_PCI
 	case AHC_PCI:
 	{
 		char primary_channel;
@@ -1584,6 +1585,8 @@ ahc_softc_comp(struct ahc_softc *lahc, s
 			value = 1;
 		break;
 	}
+#endif
+#ifdef CONFIG_EISA
 	case AHC_EISA:
 		if ((rahc->flags & AHC_BIOS_ENABLED) != 0) {
 			value = rahc->platform_data->bios_address
@@ -1593,6 +1596,7 @@ ahc_softc_comp(struct ahc_softc *lahc, s
 			      - lahc->bsh.ioport; 
 		}
 		break;
+#endif
 	default:
 		panic("ahc_softc_sort: invalid bus type");
 	}
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
