Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTJQT5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbTJQT5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:57:41 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:56448 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S263607AbTJQT5C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:57:02 -0400
Message-ID: <3F903C55.5020403@terra.com.br>
Date: Fri, 17 Oct 2003 17:00:37 -0200
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH]  finer-grained locking in wan/lmc driver
References: <3F81B086.9050905@terra.com.br> <3F8C3DFD.1050706@pobox.com>
In-Reply-To: <3F8C3DFD.1050706@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------020001080300020004010000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020001080300020004010000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Jeff,

Jeff Garzik wrote:
> conflicts with a just-applied patch... can you wait a few days, then 
> resend against the latest -bk snapshot?

	Resend against 2.6.0-test7-bk9.

	Please apply,

Felipe

--------------020001080300020004010000
Content-Type: text/plain;
 name="lmc-locking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lmc-locking.patch"

--- linux-2.6.0-test7-bk9/drivers/net/wan/lmc/lmc_main.c.orig	2003-10-17 16:57:28.000000000 -0200
+++ linux-2.6.0-test7-bk9/drivers/net/wan/lmc/lmc_main.c	2003-10-17 16:58:19.000000000 -0200
@@ -132,7 +132,6 @@
     lmc_ctl_t ctl;
     int ret;
     u_int16_t regVal;
-    unsigned long flags;
 
     struct sppp *sp;
 
@@ -142,12 +141,6 @@
 
     lmc_trace(dev, "lmc_ioctl in");
 
-    /*
-     * Most functions mess with the structure
-     * Disable interrupts while we do the polling
-     */
-    spin_lock_irqsave(&sc->lmc_lock, flags);
-
     switch (cmd) {
         /*
          * Return current driver state.  Since we keep this up
@@ -173,7 +166,8 @@
 
         if (copy_from_user(&ctl, ifr->ifr_data, sizeof (lmc_ctl_t)))
             return -EFAULT;
-
+	
+	spin_lock_irq(&sc->lmc_lock);
         sc->lmc_media->set_status (sc, &ctl);
 
         if(ctl.crc_length != sc->ictl.crc_length) {
@@ -188,9 +182,11 @@
             sp->pp_flags &= ~PP_KEEPALIVE;	/* Turn off */
         else
             sp->pp_flags |= PP_KEEPALIVE;	/* Turn on */
+	
+	spin_unlock_irq(&sc->lmc_lock);
 
         ret = 0;
-        break;
+	break;
 
     case LMCIOCIFTYPE: /*fold01*/
         {
@@ -204,14 +200,14 @@
 
 	    if (copy_from_user(&new_type, ifr->ifr_data, sizeof(u_int16_t)))
                 return -EFAULT;
-
-            
+     
 	    if (new_type == old_type)
 	    {
-		ret = 0 ;
+		ret = 0;
 		break;				/* no change */
             }
-            
+
+	    spin_lock_irq(&sc->lmc_lock);
             lmc_proto_close(sc);
             lmc_proto_detach(sc);
 
@@ -219,12 +215,14 @@
 //            lmc_proto_init(sc);
             lmc_proto_attach(sc);
             lmc_proto_open(sc);
+	    spin_unlock_irq(&sc->lmc_lock);
 
 	    ret = 0 ;
 	    break ;
 	}
 
     case LMCIOCGETXINFO: /*fold01*/
+	spin_lock_irq(&sc->lmc_lock);
         sc->lmc_xinfo.Magic0 = 0xBEEFCAFE;
 
         sc->lmc_xinfo.PciCardType = sc->lmc_cardtype;
@@ -240,6 +238,7 @@
 
         sc->lmc_xinfo.Magic1 = 0xDEADBEEF;
 
+	spin_unlock_irq(&sc->lmc_lock);
         if (copy_to_user(ifr->ifr_data, &sc->lmc_xinfo,
                          sizeof (struct lmc_xinfo)))
             return -EFAULT;
@@ -248,6 +247,7 @@
         break;
 
     case LMCIOCGETLMCSTATS: /*fold01*/
+	spin_lock_irq(&sc->lmc_lock);
         if (sc->lmc_cardtype == LMC_CARDTYPE_T1){
             lmc_mii_writereg (sc, 0, 17, T1FRAMER_FERR_LSB);
             sc->stats.framingBitErrorCount +=
@@ -271,6 +271,7 @@
             sc->stats.severelyErroredFrameCount +=
                 regVal & T1FRAMER_SEF_MASK;
         }
+	spin_unlock_irq(&sc->lmc_lock);
 
         if (copy_to_user(ifr->ifr_data, &sc->stats,
                          sizeof (struct lmc_statistics)))
@@ -285,11 +286,13 @@
             break;
         }
 
+	spin_lock_irq(&sc->lmc_lock);
         memset (&sc->stats, 0, sizeof (struct lmc_statistics));
         sc->stats.check = STATCHECK;
         sc->stats.version_size = (DRIVER_VERSION << 16) +
             sizeof (struct lmc_statistics);
         sc->stats.lmc_cardtype = sc->lmc_cardtype;
+	spin_unlock_irq(&sc->lmc_lock);
         ret = 0;
         break;
 
@@ -306,8 +309,11 @@
 
         if (copy_from_user(&ctl, ifr->ifr_data, sizeof (lmc_ctl_t)))
             return -EFAULT;
-        sc->lmc_media->set_circuit_type(sc, ctl.circuit_type);
+	
+	spin_lock_irq(&sc->lmc_lock);
+	sc->lmc_media->set_circuit_type(sc, ctl.circuit_type);
         sc->ictl.circuit_type = ctl.circuit_type;
+	spin_unlock_irq(&sc->lmc_lock);
         ret = 0;
 
         break;
@@ -319,9 +325,11 @@
         }
 
         /* Reset driver and bring back to current state */
+	spin_lock_irq(&sc->lmc_lock);
         printk (" REG16 before reset +%04x\n", lmc_mii_readreg (sc, 0, 16));
         lmc_running_reset (dev);
         printk (" REG16 after reset +%04x\n", lmc_mii_readreg (sc, 0, 16));
+	spin_unlock_irq(&sc->lmc_lock);
 
         LMC_EVENT_LOG(LMC_EVENT_FORCEDRESET, LMC_CSR_READ (sc, csr_status), lmc_mii_readreg (sc, 0, 16));
 
@@ -364,6 +372,8 @@
             case lmc_xilinx_reset: /*fold02*/
                 {
                     u16 mii;
+		    
+		    spin_lock_irq(&sc->lmc_lock);
                     mii = lmc_mii_readreg (sc, 0, 16);
 
                     /*
@@ -422,11 +432,8 @@
                             lmc_led_off(sc, LMC_DS3_LED2);
                         }
                     }
-                    
-                    
-
                     ret = 0x0;
-
+		    spin_unlock_irq(&sc->lmc_lock);
                 }
 
                 break;
@@ -434,6 +441,7 @@
                 {
                     u16 mii;
                     int timeout = 500000;
+		    spin_lock_irq(&sc->lmc_lock);
                     mii = lmc_mii_readreg (sc, 0, 16);
 
                     /*
@@ -476,12 +484,10 @@
                      * stop driving Xilinx-related signals
                      */
                     lmc_gpio_mkinput(sc, 0xff);
-
                     ret = 0x0;
-                    
 
+		    spin_unlock_irq(&sc->lmc_lock);
                     break;
-
                 }
 
             case lmc_xilinx_load: /*fold02*/
@@ -505,12 +511,13 @@
                     if(copy_from_user(data, xc.data, xc.len))
                     {
                     	kfree(data);
-                    	ret = -ENOMEM;
+                    	ret = -EFAULT;
                     	break;
                     }
 
                     printk("%s: Starting load of data Len: %d at 0x%p == 0x%p\n", dev->name, xc.len, xc.data, data);
 
+		    spin_lock_irq(&sc->lmc_lock);
                     lmc_gpio_mkinput(sc, 0xff);
 
                     /*
@@ -609,8 +616,8 @@
 
                     kfree(data);
                     
+		    spin_unlock_irq(&sc->lmc_lock);
                     ret = 0;
-                    
                     break;
                 }
             default: /*fold02*/
@@ -619,7 +626,9 @@
             }
 
             netif_wake_queue(dev);
-            sc->lmc_txfull = 0;
+            spin_lock_irq(&sc->lmc_lock);
+	    sc->lmc_txfull = 0;
+            spin_unlock_irq(&sc->lmc_lock);
 
         }
         break;
@@ -629,8 +638,6 @@
         break;
     }
 
-    spin_unlock_irqrestore(&sc->lmc_lock, flags); /*fold01*/
-
     lmc_trace(dev, "lmc_ioctl out");
 
     return ret;
@@ -930,7 +937,10 @@
      * later on, no one else will take our card away from
      * us.
      */
-    request_region (ioaddr, LMC_REG_RANGE, dev->name);
+    if (!request_region (ioaddr, LMC_REG_RANGE, dev->name)) {
+	    printk (KERN_WARNING "io port %3lX is busy", ioaddr);
+	    return NULL;
+    }
 
     sc->lmc_cardtype = LMC_CARDTYPE_UNKNOWN;
     sc->lmc_timing = LMC_CTL_CLOCK_SOURCE_EXT;
@@ -1060,8 +1070,7 @@
          * Fix the two variables
          *
          */
-        if (!(check_region (pci_ioaddr, LMC_REG_RANGE)) &&
-            (vendor == CORRECT_VENDOR_ID) &&
+        if ((vendor == CORRECT_VENDOR_ID) &&
             (device == CORRECT_DEV_ID) &&
             ((subvendor == PCI_VENDOR_LMC)  || (subdevice == PCI_VENDOR_LMC))){
             struct net_device *cur, *prev = NULL;

--------------020001080300020004010000--

