Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTAQOVD>; Fri, 17 Jan 2003 09:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbTAQOVD>; Fri, 17 Jan 2003 09:21:03 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:63431 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267433AbTAQOVC>; Fri, 17 Jan 2003 09:21:02 -0500
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: 2.5.59 fails compile 3c509.c
References: <200301171349.IAA32603@clem.clem-digital.net>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 17 Jan 2003 15:29:12 +0100
Message-ID: <wrp3cnryhmv.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <200301171349.IAA32603@clem.clem-digital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pete" == Pete Clements <clem@clem.clem-digital.net> writes:

Pete> FYI:
Pete>   gcc -Wp,-MD,drivers/net/.3c509.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3c509 -DKBUILD_MODNAME=3c509   -c -o drivers/net/3c509.o drivers/net/3c509.c
Pete> drivers/net/3c509.c: In function `el3_probe':
Pete> drivers/net/3c509.c:584: warning: label `found' defined but not used
Pete> drivers/net/3c509.c: In function `el3_close':
Pete> drivers/net/3c509.c:1083: structure has no member named `edev'
Pete> drivers/net/3c509.c: At top level:
Pete> drivers/net/3c509.c:268: warning: `nopnp' defined but not used
Pete> make[2]: *** [drivers/net/3c509.o] Error 1
Pete> make[1]: *** [drivers/net] Error 2
Pete> make: *** [drivers] Error 2

Could you please try the following patch ?

Thanks,

        M.

===== drivers/net/3c509.c 1.30 vs edited =====
--- 1.30/drivers/net/3c509.c	Wed Jan 15 11:07:35 2003
+++ edited/drivers/net/3c509.c	Fri Jan 17 15:26:30 2003
@@ -319,16 +319,6 @@
 	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->do_ioctl = netdev_ioctl;
 
-#ifdef CONFIG_PM
-	/* register power management */
-	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
-	if (lp->pmdev) {
-		struct pm_dev *p;
-		p = lp->pmdev;
-		p->data = (struct net_device *)dev;
-	}
-#endif
-
 	return 0;
 }
 
@@ -598,6 +588,16 @@
 #endif
 	lp->mca_slot = mca_slot;
 
+#ifdef CONFIG_PM
+	/* register power management */
+	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
+	if (lp->pmdev) {
+		struct pm_dev *p;
+		p = lp->pmdev;
+		p->data = (struct net_device *)dev;
+	}
+#endif
+
 	return el3_common_init (dev);
 }
 
@@ -1080,12 +1080,14 @@
 	free_irq(dev->irq, dev);
 	/* Switching back to window 0 disables the IRQ. */
 	EL3WINDOW(0);
+#ifdef CONFIG_EISA
 	if (!lp->edev) {
 	    /* But we explicitly zero the IRQ line select anyway. Don't do
 	     * it on EISA cards, it prevents the module from getting an
 	     * IRQ after unload+reload... */
 	    outw(0x0f00, ioaddr + WN0_IRQ);
 	}
+#endif
 
 	return 0;
 }

-- 
Places change, faces change. Life is so very strange.
