Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKKWLE>; Sat, 11 Nov 2000 17:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKKWKy>; Sat, 11 Nov 2000 17:10:54 -0500
Received: from vchurch.erols.com ([216.164.68.84]:13558 "EHLO
	crossbreed.mbhs.edu") by vger.kernel.org with ESMTP
	id <S129136AbQKKWKk>; Sat, 11 Nov 2000 17:10:40 -0500
Date: Sat, 11 Nov 2000 17:11:20 -0500 (EST)
From: Daniel M Church <dchurch@crossbreed.mbhs.edu>
To: linux-kernel@vger.kernel.org
Subject: [patch] SB Legacy/PnP in 2.4.0-test9
Message-ID: <Pine.LNX.4.21.0011111706200.27247-100000@crossbreed.mbhs.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a small patch to the SoundBlaster driver to allow use of a legacy
(non-PnP) card along with any PnP SB cards you may have, using an extra
insmod option.  If the option is not specified, the driver works as
without the patch.  The patch is created off the 2.4.0test9 kernel.  
Please tell me if something is out of place, either with the patch itself
or with my posting of it.

	-- Dan Church
	   dchurch@mbhs.edu

____pnplegacy.diff____

--- linux/Documentation/sound/Soundblaster.old	Mon Oct 29 00:54:12 2001
+++ linux/Documentation/sound/Soundblaster	Mon Oct 29 00:56:57 2001
@@ -24,6 +24,9 @@
 multiple=0	Set to disable detection of multiple Soundblaster cards.
 		Consider it a bug if this option is needed, and send in a
 		report.
+pnplegacy=1	Set this to be able to use a PnP card(s) along with a single
+		non-PnP (legacy) card.  Above options for io, irq, etc. are
+		needed, and will apply only to the legacy card.
 reverse=1	Reverses the order of the search in the PnP table.
 uart401=1	Set to enable detection of mpu devices on some clones.
 isapnpjump=n	Jumps to slot n in the driver's PnP table. Use the source,
--- linux/drivers/sound/sb_card.old.c	Sun Oct 28 21:35:20 2001
+++ linux/drivers/sound/sb_card.c	Mon Oct 29 01:28:58 2001
@@ -50,6 +50,9 @@
  *
  * 21-09-2000 Got rid of attach_sbmpu
  * 	Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ *
+ * 28-10-2000 Added pnplegacy support
+ * 	Daniel Church <dchurch@mbhs.edu>
  */
 
 #include <linux/config.h>
@@ -64,7 +67,7 @@
 #include "sb.h"
 
 #if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
-#define SB_CARDS_MAX 4
+#define SB_CARDS_MAX 5
 #else
 #define SB_CARDS_MAX 1
 #endif
@@ -194,6 +197,7 @@
 static int isapnp	= 1;
 static int isapnpjump	= 0;
 static int multiple	= 1;
+static int pnplegacy	= 0;
 static int reverse	= 0;
 static int uart401	= 0;
 
@@ -203,6 +207,7 @@
 #else
 static int isapnp	= 0;
 static int multiple	= 0;
+static int pnplegacy	= 0;
 #endif
 
 MODULE_DESCRIPTION("Soundblaster driver");
@@ -221,11 +226,13 @@
 MODULE_PARM(isapnp,	"i");
 MODULE_PARM(isapnpjump,	"i");
 MODULE_PARM(multiple,	"i");
+MODULE_PARM(pnplegacy,	"i");
 MODULE_PARM(reverse,	"i");
 MODULE_PARM(uart401,	"i");
 MODULE_PARM_DESC(isapnp,	"When set to 0, Plug & Play support will be disabled");
 MODULE_PARM_DESC(isapnpjump,	"Jumps to a specific slot in the driver's PnP table. Use the source, Luke.");
 MODULE_PARM_DESC(multiple,	"When set to 0, will not search for multiple cards");
+MODULE_PARM_DESC(pnplegacy,	"When set to 1, will search for a legacy SB card along with any PnP cards.");
 MODULE_PARM_DESC(reverse,	"When set to 1, will reverse ISAPnP search order");
 MODULE_PARM_DESC(uart401,	"When set to 1, will attempt to detect and enable the mpu on some clones");
 #endif
@@ -659,7 +666,7 @@
 		/* Please remember that even with CONFIG_ISAPNP defined one
 		 * should still be able to disable PNP support for this 
 		 * single driver! */
-		if(isapnp && (sb_isapnp_probe(&cfg[card], &cfg_mpu[card], card) < 0) ) {
+		if((!pnplegacy||card>0) && isapnp && (sb_isapnp_probe(&cfg[card], &cfg_mpu[card], card) < 0) ) {
 			if(!sb_cards_num) {
 				/* Found no ISAPnP cards, so check for a non-pnp
 				 * card and set the detection loop for 1 cycle
@@ -674,7 +681,7 @@
 		}
 #endif
 
-		if(!isapnp) {
+		if(!isapnp || (pnplegacy&&card==0)) {
 			cfg[card].io_base	= io;
 			cfg[card].irq		= irq;
 			cfg[card].dma		= dma;
@@ -695,15 +702,29 @@
 				card--;
 				sb_cards_num--;
 				continue;
+			} else if(pnplegacy && isapnp) {
+				printk(KERN_NOTICE "sb: No legacy SoundBlaster cards " \
+				  "found.  Continuing with PnP detection.\n");
+				pnplegacy=0;
+				card--;
+				continue;
 			} else
 				return -ENODEV;
 		}
 		attach_sb_card(&cfg[card]);
 
-		if(cfg[card].slots[0]==-1)
-			return -ENODEV;
+		if(cfg[card].slots[0]==-1) {
+			if(card==0 && pnplegacy && isapnp) {
+				printk(KERN_NOTICE "sb: No legacy SoundBlaster cards " \
+				  "found.  Continuing with PnP detection.\n");
+				pnplegacy=0;
+				card--;
+				continue;
+			} else
+				return -ENODEV;
+		}
 		
-		if (!isapnp)
+		if (!isapnp||(pnplegacy&&card==0))
 			cfg_mpu[card].io_base = mpu_io;
 		if (probe_sbmpu(&cfg_mpu[card], THIS_MODULE))
 			sbmpu[card] = 1;



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
