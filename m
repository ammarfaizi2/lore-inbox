Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWBJECh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWBJECh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWBJECh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:02:37 -0500
Received: from cpcq911r.usace.army.mil ([140.194.193.30]:19035 "EHLO
	eis-ml2itl.eis.ds.usace.army.mil") by vger.kernel.org with ESMTP
	id S1751044AbWBJECg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:02:36 -0500
From: Steve Briggs <s-briggs@cecer.army.mil>
To: linux-ns83820@kvack.org
Subject: [PATCH] drivers/net/ns83820.c: add paramter to disable auto negotiation
Date: Thu, 9 Feb 2006 22:03:26 -0600
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602092203.28290.s-briggs@cecer.army.mil>
X-OriginalArrivalTime: 10 Feb 2006 04:02:32.0382 (UTC) FILETIME=[D15485E0:01C62DF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Briggs <zzybaloobah@yahoo.com>

This patch adds a module paramter, "auto_neg" which is
by default =1.  If it's set to zero, the auto negotiation
code in ns83820_init_one() is skipped and the interface is
set to 1000F.  This only applies to optical transceivers.

This is to allow this driver to work with partners that
don't support auto negotiation (the DGS-3204, for example).

This is for ns83820.c ver 0.22, kernel ver 2.6.15.3

Signed-off-by: Steve Briggs <zzybaloobah@yahoo.com>

---

I use the the Netgear GA621 cards (with optical Xcvrs) and
have always had problems with autonegotiation.  Specifically,
if I have 2 cards connected together and the link goes down
(either one machine goes down or the fiber gets disconnected),
the link doesn't come back up until I reboot both machines.

I've also got a Dlink DGS-3204 fiber switch that doesn't
support autonegotiation, it's 1000F only.  In the
autonegotiation code in the current ns83820.c, it shows
up as
   tanlpar & (TANAR_FULL_DUP | TANAR_HALF_DUP) = 0
so the determination of full/half duplex in phy_intr()
falls through entirely.

I haven't done testing beyond with the Netgear GA621 cards;
on the other hand, if you do nothing, auto_neg = 1 and the
code works as before.


--- linux-2.6.15.3/drivers/net/ns83820.c.orig   2006-02-06 17:36:47.000000000 -0600
+++ linux-2.6.15.3/drivers/net/ns83820.c        2006-02-09 21:46:57.000000000 -0600
@@ -126,6 +126,7 @@
 static int ihr = 2;
 static int reset_phy = 0;
 static int lnksts = 0;         /* CFG_LNKSTS bit polarity */
+static int auto_neg = 1;       /* with an optical Xcvr, set = 0 to force to 1000F */

 /* Dprintk is used for more interesting debug events */
 #undef Dprintk
@@ -695,6 +696,8 @@ static void fastcall phy_intr(struct net
                        writel(readl(dev->base + GPIOR) & ~GPIOR_GP1_OUT,
                               dev->base + GPIOR);
                }
+               else /* partner doesn't autonegotiate, assume 1000F */
+                       fullduplex=1;

                speed = 4; /* 1000F */

@@ -1967,18 +1970,28 @@ static int __devinit ns83820_init_one(st
                        ndev->name);
                writel(readl(dev->base + GPIOR) | 0x3e8, dev->base + GPIOR);

-               /* setup auto negotiation feature advertisement */
-               writel(readl(dev->base + TANAR)
-                      | TANAR_HALF_DUP | TANAR_FULL_DUP,
-                      dev->base + TANAR);
-
-               /* start auto negotiation */
-               writel(TBICR_MR_AN_ENABLE | TBICR_MR_RESTART_AN,
-                      dev->base + TBICR);
-               writel(TBICR_MR_AN_ENABLE, dev->base + TBICR);
-               dev->linkstate = LINK_AUTONEGOTIATE;
-
-               dev->CFG_cache |= CFG_MODE_1000;
+               if (auto_neg == 0) {    /* don't advertise it, and set 1000F */
+                       writel(readl(dev->base + TANAR) & !TANAR_HALF_DUP &
+                              !TANAR_FULL_DUP, dev->base + TANAR);
+                       writel(readl(dev->base + TXCFG) | TXCFG_CSI | TXCFG_HBI,
+                              dev->base + TXCFG);
+                       writel(readl(dev->base + RXCFG) | RXCFG_RX_FD,
+                              dev->base + RXCFG);
+                       dev->linkstate = LINK_UP;
+               } else {
+                       /* setup auto negotiation feature advertisement */
+                       writel(readl(dev->base + TANAR)
+                              | TANAR_HALF_DUP | TANAR_FULL_DUP,
+                              dev->base + TANAR);
+
+                       /* start auto negotiation */
+                       writel(TBICR_MR_AN_ENABLE | TBICR_MR_RESTART_AN,
+                              dev->base + TBICR);
+                       writel(TBICR_MR_AN_ENABLE, dev->base + TBICR);
+                       dev->linkstate = LINK_AUTONEGOTIATE;
+               }
+
+                       dev->CFG_cache |= CFG_MODE_1000;
        }

        writel(dev->CFG_cache, dev->base + CFG);
@@ -2198,5 +2211,8 @@ MODULE_PARM_DESC(ihr, "Time in 100 us in
 module_param(reset_phy, int, 0);
 MODULE_PARM_DESC(reset_phy, "Set to 1 to reset the PHY on startup");

+module_param(auto_neg, int, 1);
+MODULE_PARM_DESC(auto_neg, "Set = 0 to disable auto negotiate and force 1000F (Optical only)");
+
 module_init(ns83820_init);
 module_exit(ns83820_exit);

