Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262105AbSIYUOk>; Wed, 25 Sep 2002 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262109AbSIYUOf>; Wed, 25 Sep 2002 16:14:35 -0400
Received: from [195.39.17.254] ([195.39.17.254]:3588 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262105AbSIYUOc>;
	Wed, 25 Sep 2002 16:14:32 -0400
Date: Wed, 25 Sep 2002 21:06:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: pcnet32 #ifdef hell cleanup
Message-ID: <20020925190617.GA795@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Not sure if it is trivial enough for trivial, anyway:

							Pavel

--- clean/drivers/net/pcnet32.c	2002-08-28 22:38:50.000000000 +0200
+++ linux-swsusp/drivers/net/pcnet32.c	2002-08-28 23:12:18.000000000 +0200
@@ -22,8 +22,8 @@
  *************************************************************************/
 
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.27a"
-#define DRV_RELDATE	"10.02.2002"
+#define DRV_VERSION	"1.28"
+#define DRV_RELDATE	"04.03.2002"
 #define PFX		DRV_NAME ": "
 
 static const char *version =
@@ -211,6 +211,7 @@
  *	   fix pci probe not increment cards_found
  *	   FD auto negotiate error workaround for xSeries250
  *	   clean up and using new mii module
+ * v1.28   Small cleanups - Pavel Machek <pavel@suse.cz>
  */
 
 
@@ -582,12 +583,6 @@
 	 */
 	/* switch to home wiring mode */
 	media = a->read_bcr(ioaddr, 49);
-#if 0
-	if (pcnet32_debug > 2)
-	    printk(KERN_DEBUG PFX "media value %#x.\n",  media);
-	media &= ~3;
-	media |= 1;
-#endif
 	if (pcnet32_debug > 2)
 	    printk(KERN_DEBUG PFX "media reset to %#x.\n",  media);
 	a->write_bcr(ioaddr, 49, media);
@@ -1174,19 +1169,12 @@
 		    if (err_status & 0x04000000) lp->stats.tx_aborted_errors++;
 		    if (err_status & 0x08000000) lp->stats.tx_carrier_errors++;
 		    if (err_status & 0x10000000) lp->stats.tx_window_errors++;
-#ifndef DO_DXSUFLO
 		    if (err_status & 0x40000000) {
 			lp->stats.tx_fifo_errors++;
-			/* Ackk!  On FIFO errors the Tx unit is turned off! */
-			/* Remove this verbosity later! */
-			printk(KERN_ERR "%s: Tx FIFO error! CSR0=%4.4x\n",
-			       dev->name, csr0);
-			must_restart = 1;
-		    }
-#else
-		    if (err_status & 0x40000000) {
-			lp->stats.tx_fifo_errors++;
-			if (! lp->dxsuflo) {  /* If controller doesn't recover ... */
+#ifdef DO_DXSUFLO
+			if (! lp->dxsuflo) 
+#endif
+			{  /* If controller doesn't recover ... */
 			    /* Ackk!  On FIFO errors the Tx unit is turned off! */
 			    /* Remove this verbosity later! */
 			    printk(KERN_ERR "%s: Tx FIFO error! CSR0=%4.4x\n",
@@ -1194,7 +1182,6 @@
 			    must_restart = 1;
 			}
 		    }
-#endif
 		} else {
 		    if (status & 0x1800)
 			lp->stats.collisions++;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
