Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbTAKLRm>; Sat, 11 Jan 2003 06:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbTAKLRm>; Sat, 11 Jan 2003 06:17:42 -0500
Received: from mta08bw.bigpond.com ([144.135.24.137]:6637 "EHLO
	mta08bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S267188AbTAKLRi>; Sat, 11 Jan 2003 06:17:38 -0500
Date: Sat, 11 Jan 2003 22:26:04 +1100
From: Michael Still <mikal@stillhq.com>
To: <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [Patch] Fix errors in aironet4500 driver (cli_sti_removal-004)
Message-ID: <Pine.LNX.4.30.0301112221360.8693-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

Linux 2.5.55 includes a trivial patch from me which removed some
references to cli() and sti() from the aironet4500 driver. There were two
errors in the implementation of this patch, as well as the rest of the
files in the driver not having been updated. My apologies for this.

This patch below (which is against 2.5.55) corrects these problems. Please
let me know if you think there are errors I have still made, for future
reference.

Please apply.

Cheers,
Mikal

Binary files linux-2.5.55/drivers/atm/pca200e.bin and linux-2.5.55-cli_sti_removal-002/drivers/atm/pca200e.bin differ
diff -Nur linux-2.5.55/drivers/net/aironet4500.h linux-2.5.55-cli_sti_removal-002/drivers/net/aironet4500.h
--- linux-2.5.55/drivers/net/aironet4500.h	Fri Jan 10 09:21:06 2003
+++ linux-2.5.55-cli_sti_removal-002/drivers/net/aironet4500.h	Thu Jan  9 22:19:56 2003
@@ -1,13 +1,13 @@
 /*
  *	 Aironet 4500 Pcmcia driver
  *
- *		Elmer Joandi, Januar 1999
+ *		Elmer Joandi, January 1999
+ *              Michael Still, January 2003
  *	Copyright:	GPL
  *
  *
  *	Revision 0.1 ,started  30.12.1998
- *      Revision 0.3, Jan 10, 2003
- *              Michael Still (mikal@stillhq.com) - cli / sti conversion
+ *      Revision 0.2, locking tweaks 10 Jan 2003
  *
  *
  */
@@ -15,24 +15,12 @@

 #ifndef AIRONET4500_H
 #define	AIRONET4500_H
-// redefined to avoid PCMCIA includes

- #include <linux/version.h>
-/*#include <linux/module.h>
- #include <linux/kernel.h>
-*/
-
-/*
-#include <linux/types.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/delay.h>
-#include <linux/time.h>
-*/
+#include <linux/version.h>
 #include <linux/802_11.h>
 #include <linux/workqueue.h>

-//damn idiot PCMCIA stuff
+/* Damn idiot PCMCIA stuff */
 #ifndef DEV_NAME_LEN
 	#define DEV_NAME_LEN 32
 #endif
@@ -94,7 +82,7 @@
 #define awc_Select1_register 		0x1A
 #define awc_Offset1_register 		0x1E
 #define awc_Data1_register 		0x38
-//
+
 #define awc_RxFID_register 		0x20
 #define awc_TxAllocFID_register 	0x22
 #define awc_TxComplFID_register 	0x24
@@ -1606,4 +1594,7 @@
 	#define AWC_ENTRY_EXIT_DEBUG(a)
 #endif

+/* This has been changed to a hopefully globally unique name */
+spinlock_t aironet4500_lock = SPIN_LOCK_UNLOCKED;
+
 #endif /* AIRONET4500_H */
diff -Nur linux-2.5.55/drivers/net/aironet4500_card.c linux-2.5.55-cli_sti_removal-002/drivers/net/aironet4500_card.c
--- linux-2.5.55/drivers/net/aironet4500_card.c	Fri Jan 10 09:18:46 2003
+++ linux-2.5.55-cli_sti_removal-002/drivers/net/aironet4500_card.c	Thu Jan  9 22:24:11 2003
@@ -10,13 +10,10 @@
  *	Revision 0.2, Feb 27, 2000
  *		Jeff Garzik - softnet, cleanups
  *
- *      Revision 0.3, Jan 10, 2003
- *              Michael Still (mikal@stillhq.com) - cli / sti conversion
- *
  */
 #ifdef MODULE
 static const char *awc_version =
-"aironet4500_cards.c v0.3  Jan, 2003  Elmer Joandi, elmer@ylenurme.ee and Michael Still (mikal@stillhq.com)\n";
+"aironet4500_cards.c v0.2  Feb 27, 2000  Elmer Joandi, elmer@ylenurme.ee.\n";
 #endif

 #include <linux/delay.h>
@@ -381,14 +378,9 @@
 		};
 		((struct awc_private *)dev->priv)->bus =  logdev;

-	//	ether_setup(dev);
-
-	//	dev->tx_queue_len = tx_queue_len;

 		dev->hard_start_xmit = 		&awc_start_xmit;
-	//	dev->set_config = 		&awc_config_misiganes,aga mitte awc_config;
 		dev->get_stats = 		&awc_get_stats;
-	//	dev->set_multicast_list = 	&awc_set_multicast_list;
 		dev->change_mtu		=	awc_change_mtu;
 		dev->init = &awc_init;
 		dev->open = &awc_open;
@@ -406,18 +398,18 @@

 		((struct awc_private *)dev->priv)->bus =  logdev;

-		cli();
+		spin_lock_irq(&aironet4500_lock);
 		if ( awc_init(dev) ){
 			printk("card not found at irq %x io %lx\n",dev->irq, dev->base_addr);
 			if (card==0){
-				sti();
+				spin_unlock_irq(&aironet4500_lock);
 				return -1;
 			}
-			sti();
+			spin_unlock_irq(&aironet4500_lock);
 			break;
 		}
 		udelay(10);
-		sti();
+		spin_unlock_irq(&aironet4500_lock);
 		i=0;
 		while (aironet4500_devices[i] && i < MAX_AWCS-1) i++;
 		if (!aironet4500_devices[i] && i < MAX_AWCS-1 ){
diff -Nur linux-2.5.55/drivers/net/aironet4500_core.c linux-2.5.55-cli_sti_removal-002/drivers/net/aironet4500_core.c
--- linux-2.5.55/drivers/net/aironet4500_core.c	Fri Jan 10 09:20:35 2003
+++ linux-2.5.55-cli_sti_removal-002/drivers/net/aironet4500_core.c	Thu Jan  9 23:08:29 2003
@@ -6,19 +6,16 @@
  *
  *
  *	Revision 0.1 ,started  30.12.1998
- *      Revision 0.3, Jan 10, 2003
- *              Michael Still (mikal@stillhq.com) - cli / sti conversion
  *
  *
  */
  /* CHANGELOG:
- 	   03.99, stable version 2.0
- 	   08.99, stable version 2.2
- 	   11.99, integration with 2.3
-	17.12.99, finally, got SMP near-correct.
-		  timing issues remain- on SMP box its 15% slower on tcp
-	10.03.00, looks like softnet take us back to normal on SMP
-	10.01.03, cli / sti removal
+ 	march 99, stable version 2.0
+ 	august 99, stable version 2.2
+ 	november 99, integration with 2.3
+	17.12.99: finally, got SMP near-correct.
+		timing issues remain- on SMP box its 15% slower on tcp
+	10.03.00 looks like softnet take us back to normal on SMP
  */

 #include <linux/delay.h>
@@ -427,14 +424,11 @@
 	  	//	AWC_OUT(cmd->bap->offset, 0x800);
 	  }

-	  save_flags(flags);
-	  cli();
-
+	  spin_lock_irqsave(&aironet4500_lock, flags);
           AWC_OUT(cmd->bap->select, cmd->rid);
 	  WAIT61x3;
           AWC_OUT(cmd->bap->offset, cmd->offset);
-
-          restore_flags(flags);
+	  spin_unlock_irqrestore(&aironet4500_lock, flags);

 	  WAIT61x3;

@@ -454,48 +448,47 @@
 	      };
               status = AWC_IN(cmd->bap->offset);
               if (status & AWC_BAP_BUSY) {
-                 if (cycles % 100 == 99 ) {
-                      save_flags(flags);
-                      cli();
-                      if (!cleared){
-                      	AWC_IN(cmd->dev->base_addr + 0x26);
-                      	AWC_OUT(cmd->dev->base_addr + 0x26, 0);
-                      	WAIT61x3;
-                      	cleared = 1;
-                      }
-                      AWC_OUT(cmd->bap->select, cmd->rid);
-                      WAIT61x3;
-                      AWC_OUT(cmd->bap->offset, cmd->offset);
-                      restore_flags(flags);
-                	#ifdef AWC_DEBUG
-	  			printk("B");
-	  		#endif
-
-                      if ( cmd->priv->sleeping_bap)
-         		udelay(bap_sleep);
-         	      else udelay(30);
-                      //restart_timeout();
-                  }
-                  if (jiffies - jiff > 1 ) {
-                  	AWC_ENTRY_EXIT_DEBUG(" BAD BUSY  exit \n");
-                  	awc_dump_registers(cmd->dev);
-                  	goto return_AWC_ERROR;
-                  }
-                  continue;
+		      if (cycles % 100 == 99 ) {
+			      spin_lock_irqsave(&aironet4500_lock, flags);
+			      if (!cleared){
+				      AWC_IN(cmd->dev->base_addr + 0x26);
+				      AWC_OUT(cmd->dev->base_addr + 0x26, 0);
+				      WAIT61x3;
+				      cleared = 1;
+			      }
+			      AWC_OUT(cmd->bap->select, cmd->rid);
+			      WAIT61x3;
+			      AWC_OUT(cmd->bap->offset, cmd->offset);
+			      spin_unlock_irqrestore(&aironet4500_lock, flags);
+#ifdef AWC_DEBUG
+			      printk("B");
+#endif
+
+			      if ( cmd->priv->sleeping_bap)
+				      udelay(bap_sleep);
+			      else udelay(30);
+			      //restart_timeout();
+		      }
+		      if (jiffies - jiff > 1 ) {
+			      AWC_ENTRY_EXIT_DEBUG(" BAD BUSY  exit \n");
+			      awc_dump_registers(cmd->dev);
+			      goto return_AWC_ERROR;
+		      }
+		      continue;
               }
-             if (status & AWC_BAP_DONE) {
-                  WAIT61x3; WAIT61x3; WAIT61x3;
-
-                //  if ((status & 0xfff) != cmd->offset)
-                //  	printk(KERN_ERR "awcPBD %x ",status);
-                   AWC_ENTRY_EXIT_DEBUG(" exit \n");
-                  if (cmd->priv->sleeping_bap)
-                  	udelay(bap_sleep_after_setup);
-
-                  // success
-                  goto return_AWC_SUCCESS;
+	      if (status & AWC_BAP_DONE) {
+		      WAIT61x3; WAIT61x3; WAIT61x3;
+
+		      //  if ((status & 0xfff) != cmd->offset)
+		      //  	printk(KERN_ERR "awcPBD %x ",status);
+		      AWC_ENTRY_EXIT_DEBUG(" exit \n");
+		      if (cmd->priv->sleeping_bap)
+			      udelay(bap_sleep_after_setup);
+
+		      // success
+		      goto return_AWC_SUCCESS;
               }
-
+
               if (status & AWC_BAP_ERR) {
              	  AWC_ENTRY_EXIT_DEBUG(" BAD  exit \n");
                   // invalid rid or offse

-- 

Michael Still (mikal@stillhq.com) | Stage 1: Steal underpants
http://www.stillhq.com            | Stage 2: ????
UTC + 11                          | Stage 3: Profit


