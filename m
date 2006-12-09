Return-Path: <linux-kernel-owner+w=401wt.eu-S967119AbWLIJhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967119AbWLIJhK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966263AbWLIJhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:37:10 -0500
Received: from asia.telenet-ops.be ([195.130.137.74]:52136 "EHLO
	asia.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936679AbWLIJhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:37:07 -0500
Date: Sat, 9 Dec 2006 10:37:05 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-scsi@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Sam Creasey <sammy@sammy.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Sun3 SCSI: Make sun3 scsi drivers compile/work again
Message-ID: <Pine.LNX.4.64.0612091036450.12009@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Creasey <sammy@sammy.net>

Make sun3 scsi drivers compile/work again (though with way too many warnings...)

Tested on 3/50, 3/60.

Signed-off-by: Sam Creasey <sammy@sammy.net>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 drivers/scsi/Kconfig         |    2 +-
 drivers/scsi/sun3_NCR5380.c  |    4 ++--
 drivers/scsi/sun3_scsi.c     |    2 +-
 drivers/scsi/sun3_scsi.h     |    2 +-
 drivers/scsi/sun3_scsi_vme.c |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

--- linux-m68k-2.6.19.orig/drivers/scsi/Kconfig
+++ linux-m68k-2.6.19/drivers/scsi/Kconfig
@@ -1692,7 +1692,7 @@ config SCSI_NCR53C7xx_FAST
 
 config SUN3_SCSI
 	tristate "Sun3 NCR5380 SCSI"
-	depends on SUN3 && SCSI && BROKEN
+	depends on SUN3 && SCSI
 	select SCSI_SPI_ATTRS
 	help
 	  This option will enable support for the OBIO (onboard io) NCR5380
--- linux-m68k-2.6.19.orig/drivers/scsi/sun3_NCR5380.c
+++ linux-m68k-2.6.19/drivers/scsi/sun3_NCR5380.c
@@ -1271,7 +1271,7 @@ static irqreturn_t NCR5380_intr (int irq
 	NCR_PRINT(NDEBUG_INTR);
 	if ((NCR5380_read(STATUS_REG) & (SR_SEL|SR_IO)) == (SR_SEL|SR_IO)) {
 	    done = 0;
-	    ENABLE_IRQ();
+//	    ENABLE_IRQ();
 	    INT_PRINTK("scsi%d: SEL interrupt\n", HOSTNO);
 	    NCR5380_reselect(instance);
 	    (void) NCR5380_read(RESET_PARITY_INTERRUPT_REG);
@@ -1304,7 +1304,7 @@ static irqreturn_t NCR5380_intr (int irq
 		INT_PRINTK("scsi%d: PHASE MISM or EOP interrupt\n", HOSTNO);
 		NCR5380_dma_complete( instance );
 		done = 0;
-		ENABLE_IRQ();
+//		ENABLE_IRQ();
 	    } else
 #endif /* REAL_DMA */
 	    {
--- linux-m68k-2.6.19.orig/drivers/scsi/sun3_scsi.c
+++ linux-m68k-2.6.19/drivers/scsi/sun3_scsi.c
@@ -75,9 +75,9 @@
 #define REAL_DMA
 
 #include "scsi.h"
+#include "initio.h"
 #include <scsi/scsi_host.h>
 #include "sun3_scsi.h"
-#include "NCR5380.h"
 
 static void NCR5380_print(struct Scsi_Host *instance);
 
--- linux-m68k-2.6.19.orig/drivers/scsi/sun3_scsi.h
+++ linux-m68k-2.6.19/drivers/scsi/sun3_scsi.h
@@ -221,7 +221,7 @@ struct sun3_udc_regs {
  *
  */
 
-
+#include "NCR5380.h"
 
 #if NDEBUG & NDEBUG_ARBITRATION
 #define ARB_PRINTK(format, args...) \
--- linux-m68k-2.6.19.orig/drivers/scsi/sun3_scsi_vme.c
+++ linux-m68k-2.6.19/drivers/scsi/sun3_scsi_vme.c
@@ -41,9 +41,9 @@
 #define REAL_DMA
 
 #include "scsi.h"
+#include "initio.h"
 #include <scsi/scsi_host.h>
 #include "sun3_scsi.h"
-#include "NCR5380.h"
 
 extern int sun3_map_test(unsigned long, char *);
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
