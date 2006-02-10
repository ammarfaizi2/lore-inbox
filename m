Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWBJJt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWBJJt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 04:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWBJJt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 04:49:26 -0500
Received: from exsmtp01.exserver.dk ([195.69.129.176]:30185 "EHLO
	exsmtp01.exserver.dk") by vger.kernel.org with ESMTP
	id S1751204AbWBJJt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 04:49:26 -0500
Subject: Re: [PATCH] drivers/net/ns83820.c: add paramter to disable auto
	negotiation
From: Dan Faerch <dan@scannet.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Steve Briggs <s-briggs@cecer.army.mil>, linux-ns83820@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060209201716.0c6d1fea.akpm@osdl.org>
References: <200602092203.28290.s-briggs@cecer.army.mil>
	 <20060209201716.0c6d1fea.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Feb 2006 10:49:23 +0100
Message-Id: <1139564963.15033.40.camel@dan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-OriginalArrivalTime: 10 Feb 2006 09:47:25.0365 (UTC) FILETIME=[FF4F2650:01C62E26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 20:17 -0800, Andrew Morton wrote: 
> Steve Briggs <s-briggs@cecer.army.mil> wrote:
> >
> > This patch adds a module paramter, "auto_neg" which is
> >  by default =1.  If it's set to zero, the auto negotiation
> >  code in ns83820_init_one() is skipped and the interface is
> >  set to 1000F.
> 
> Better to do this via `ethtool autoneg off'.

Actually I did somewhat the same patch about a year ago and got the same
response:

"This functionality should likelz be done via ethtool..." - Benjamin
LaHaise[1]

So i went back and spend about a week redoing the whole thing to enable
ethtool support and reposted a patch[2], but didnt receive any response
to this whatsoever. I even wrote the maintainer later on personally to
ask if something was wrong with the patch, bad coding, anything, since
there was no reply or reaction. I never received a reply.

So. There IS an ethtool patch and it works for me, though i dont know
how well its made (there must be SOME reason i didnt get a response :)).
It supports autoneg, duplex and speed if i recall correctly.
If you try it out, id love to hear comments (since this was/is the first
time i messed around in kernel stuff).


[1] http://www.kvack.org/~ftp/archives/linux-ns83820/linux-ns83820.0503
    search for "Subject: Autoneg patch"

[2] http://www.kvack.org/~ftp/archives/linux-ns83820/linux-ns83820.0504
    search for "Subject: Re: Autoneg patch"

- Dan Faerch

----------------------------------------------------

diff -Nru ../linux-2.6.11.4/drivers/net/ns83820.c drivers/net/ns83820.c
--- ../linux-2.6.11.4/drivers/net/ns83820.c     Tue Mar 29 13:46:10 2005
+++ drivers/net/ns83820.c       Tue Apr 19 11:47:34 2005
@@ -1,4 +1,4 @@
-#define _VERSION "0.20"
+#define _VERSION "0.22"
 /* ns83820.c by Benjamin LaHaise with contributions.
  *
  * Questions/comments/discussion to linux-ns83820@kvack.org.
@@ -66,6 +66,9 @@
  *
  *     20040828        0.21 -  add hardware vlan accleration
  *                             by Neil Horman <nhorman@redhat.com>
+ *     20050321        0.22 -  Ethtool cmd support functions.
+ *                          -  set autoneg&duplex via ethtool
+ *                             by Dan Faerch <dan@hacker.dk>
  * Driver Overview
  * ===============
  *
@@ -124,6 +127,7 @@
 static int ihr = 2;
 static int reset_phy = 0;
 static int lnksts = 0;         /* CFG_LNKSTS bit polarity */
+static int disable_autoneg  = 0;
 
 /* Dprintk is used for more interesting debug events */
 #undef Dprintk
@@ -1273,6 +1277,177 @@
        return &dev->stats;
 }
 
+/*  Dan Faerch: ethtool get/set support.
+ *  This isnt perfect, but it does the job for me. I only own fiber, so copper support is "less-than-not-perfect". 
+ *  ive NEVER worked with drivers or hardware before (or programmed c for that matter), so please feel free to double check anything!! 
+*/
+
+/* Let ethtool retrieve info */
+static int ns83820_get_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
+{        struct ns83820 *dev = PRIV(ndev);  
+         u32 cfg,tanar, tbicr;
+        int have_optical = 0;
+        int fullduplex   = 0;           
+/*
+    Heres what other drivers show:
+        cmd->advertising = 
+        cmd->speed = 
+        cmd->duplex = 
+        cmd->port = 0;
+        cmd->phy_address = 
+        cmd->transceiver = 0;
+        cmd->autoneg = 
+        cmd->maxtxpkt = 0;
+        cmd->maxrxpkt = 0;
+
+   Feel free to implement any of theese that are missing.
+*/
+
+        /*read current configuration*/
+        cfg   = readl(dev->base + CFG) ^ SPDSTS_POLARITY;
+        tanar = readl(dev->base + TANAR);
+        tbicr = readl(dev->base + TBICR);
+
+       /*we have optical thingie-majiggy*/
+        if (dev->CFG_cache & CFG_TBI_EN) {
+               have_optical = 1;
+               //fullduplex   = (tanar & TANAR_FULL_DUP);
+               fullduplex = (cfg & CFG_DUPSTS) ? 1 : 0;
+
+
+       } else { /*We have a copper wire (or a couple of copperwires at least.... hopefully)*/
+               fullduplex = (cfg & CFG_DUPSTS) ? 1 : 0;
+        }
+
+
+                   printk(KERN_INFO "%s: T:%d-%d-%d -  \n",
+                                       ndev->name,
+                                       (tanar & TANAR_FULL_DUP),
+                                       (cfg & CFG_DUPSTS),
+                                       tanar
+                                       );
+
+
+
+        cmd->supported = (SUPPORTED_Autoneg);
+
+        /*we have optical thingie-majiggy*/
+        if (dev->CFG_cache & CFG_TBI_EN) {
+           cmd->supported |= (SUPPORTED_1000baseT_Half |
+                              SUPPORTED_1000baseT_Full);
+           cmd->supported |= SUPPORTED_FIBRE;
+           cmd->port       = PORT_FIBRE; 
+        } /*TODO: else show copper related thingies*/
+
+        cmd->duplex    = ((fullduplex) ? DUPLEX_FULL : DUPLEX_HALF);
+        cmd->speed      = (
+                              ((cfg / CFG_SPDSTS0) & 3) >= 2 ? SPEED_1000 : 
+                             (((cfg / CFG_SPDSTS0) & 3) == 1 ? SPEED_100  : SPEED_10 )
+                          );
+        //cmd->autoneg    = !disable_autoneg;
+        cmd->autoneg      = (tbicr & TBICR_MR_AN_ENABLE) ? 1: 0;
+        
+        return 0;
+}
+
+/* Let ethool change settings*/
+static int ns83820_set_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
+{       struct ns83820 *dev = PRIV(ndev);
+        u32 cfg,tanar;
+       int have_optical = 0;
+       int fullduplex   = 0;
+
+       /*read current configuration*/
+        cfg = readl(dev->base + CFG) ^ SPDSTS_POLARITY;
+       tanar = readl(dev->base + TANAR); 
+
+       /*we have optical*/
+        if (dev->CFG_cache & CFG_TBI_EN) {
+               have_optical = 1;
+               fullduplex   = (tanar & TANAR_FULL_DUP);
+       //      fullduplex   = (cfg & CFG_DUPSTS);
+
+       } else { /*We have a copper*/
+               fullduplex = (cfg & CFG_DUPSTS);
+       }
+
+        spin_lock_irq(&dev->misc_lock);
+        spin_lock(&dev->tx_lock);
+      
+        //Set Duplex
+        if ( cmd->duplex != fullduplex) {       //If ethtool-setting is different than current setting
+              /*we have optical*/
+              if (have_optical) {
+                     /*set full duplex*/
+                  if (cmd->duplex==DUPLEX_FULL) {
+                         ndev->name,
+                         RXCFG,
+                         RXCFG | RXCFG_RX_FD,
+                         DUPLEX_FULL,
+                         readl(dev->base + RXCFG),
+                         readl(dev->base + RXCFG) | RXCFG_RX_FD,
+                         readl(dev->base + RXCFG) | ~RXCFG_RX_FD
+                         
+                         );                  
+                       /* force full duplex */
+                       writel(readl(dev->base + TXCFG)
+                              | TXCFG_CSI | TXCFG_HBI | TXCFG_ATP,
+                              dev->base + TXCFG);
+                       writel(readl(dev->base + RXCFG) | RXCFG_RX_FD,
+                              dev->base + RXCFG);
+                       /* Light up full duplex LED */
+                       writel(readl(dev->base + GPIOR) | GPIOR_GP1_OUT,
+                              dev->base + GPIOR);                           
+                           //writel(readl(dev->base + TANAR) | TANAR_FULL_DUP, dev->base + TANAR);
+                      } else {
+                      
+                      
+                      }
+ 
+              } else {
+                  /*we have copper*/
+                  
+              }
+                         printk(KERN_INFO "%s: Duplex set via ethtool\n",
+                         ndev->name);
+        }
+
+        //Set Autoneg
+        if (cmd->autoneg != ((disable_autoneg) ? AUTONEG_DISABLE : AUTONEG_ENABLE )) { //If ethtool-setting is different than current setting
+            if (cmd->autoneg == AUTONEG_ENABLE) {
+                   disable_autoneg=0;
+                   
+                   /* restart auto negotiation */
+                   writel(TBICR_MR_AN_ENABLE | TBICR_MR_RESTART_AN,
+                          dev->base + TBICR);
+                   writel(TBICR_MR_AN_ENABLE, dev->base + TBICR);
+                          dev->linkstate = LINK_AUTONEGOTIATE;
+                   
+                   printk(KERN_INFO "%s: autoneg enabled via ethtool\n",
+                                       ndev->name);
+            } else {
+                   disable_autoneg=1;
+                   
+                   /* disable auto negotiation */
+                   writel(0x00000000,
+                          dev->base + TBICR);              
+                   //dev->linkstate = LINK_UP;
+            }
+            printk(KERN_INFO "%s: autoneg %s via ethtool\n",
+                            ndev->name,
+                            (cmd->autoneg) ? "ENABLED" : "DISABLED"
+                            );            
+        }
+
+         phy_intr(ndev);
+   
+          spin_unlock(&dev->tx_lock);
+          spin_unlock_irq(&dev->misc_lock);
+  
+        return 0;
+}
+/* end ethtool get/set support -df */
+
 static void ns83820_get_drvinfo(struct net_device *ndev, struct ethtool_drvinfo *info)
 {
        struct ns83820 *dev = PRIV(ndev);
@@ -1289,8 +1464,10 @@
 }
 
 static struct ethtool_ops ops = {
-       .get_drvinfo = ns83820_get_drvinfo,
-       .get_link = ns83820_get_link
+        .get_settings    = ns83820_get_settings, 
+        .set_settings    = ns83820_set_settings,
+       .get_drvinfo     = ns83820_get_drvinfo,
+       .get_link        = ns83820_get_link
 };
 
 static void ns83820_mib_isr(struct ns83820 *dev)
@@ -1983,23 +2160,28 @@
 
        /* setup optical transceiver if we have one */
        if (dev->CFG_cache & CFG_TBI_EN) {
-               printk(KERN_INFO "%s: enabling optical transceiver\n",
+               printk(KERqN_INFO "%s: enabling optical transceiver\n",
                        ndev->name);
                writel(readl(dev->base + GPIOR) | 0x3e8, dev->base + GPIOR);
 
                /* setup auto negotiation feature advertisement */
-               writel(readl(dev->base + TANAR)
-//                    | TANAR_HALF_DUP | TANAR_FULL_DUP,
-                      | TANAR_FULL_DUP,
+               writel(readl(dev->base + TANAR)
+                      | TANAR_HALF_DUP | TANAR_FULL_DUP,
                       dev->base + TANAR);
 
-               /* start auto negotiation */
-               /*
-               writel(TBICR_MR_AN_ENABLE | TBICR_MR_RESTART_AN,
-                      dev->base + TBICR);
-               writel(TBICR_MR_AN_ENABLE, dev->base + TBICR);
-               dev->linkstate = LINK_AUTONEGOTIATE;
-               */
+               /* Dan Faerch : Allow disabling of autonegotiation on module param*/
+               if (!disable_autoneg) {
+                       /* start auto negotiation */
+                       writel(TBICR_MR_AN_ENABLE | TBICR_MR_RESTART_AN,
+                              dev->base + TBICR);
+                       writel(TBICR_MR_AN_ENABLE, dev->base + TBICR);
+                              dev->linkstate = LINK_AUTONEGOTIATE;
+               }
+               else
+               printk(KERN_INFO "%s: Skipping autonegotiation\n",
+                       ndev->name);
+               
+               
                dev->CFG_cache |= CFG_MODE_1000;
        }
 
@@ -2220,6 +2402,9 @@
 
 module_param(reset_phy, int, 0);
 MODULE_PARM_DESC(reset_phy, "Set to 1 to reset the PHY on startup");
+
+module_param(disable_autoneg, int, 0); 
+MODULE_PARM_DESC(autoneg, "Set to 1 to disable autoneg");
 
 module_init(ns83820_init);
 module_exit(ns83820_exit);

