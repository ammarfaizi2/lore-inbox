Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264771AbUEJPQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264771AbUEJPQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbUEJPQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:16:07 -0400
Received: from gruby.cs.net.pl ([62.233.142.99]:4622 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S264750AbUEJPPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:15:55 -0400
Date: Mon, 10 May 2004 17:15:53 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [2.4 PATCHES] three trivial fixes for 2.4.26
Message-ID: <20040510151552.GD8052@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There are 3 trivial patches attached:
- don't use floating point in amd8111e driver (port from 2.6.x)
- include <asm/io.h> for io functions in farsync driver
- fix typo in drivers/mtd/maps/Config.in


(BTW, MTD_TSUNAMI driver is broken anyway, because it uses
tsunami_tig_{read,write}b functions not defined anywhere in kernel)


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.26-amd8111e-nofp.patch"

Don't use floating point operations in amd8111e driver.
This is port of Linus's changes from 2.6.x.

--- linux-2.4.26/drivers/net/amd8111e.c.orig	2003-08-25 13:44:42.000000000 +0200
+++ linux-2.4.26/drivers/net/amd8111e.c	2004-05-10 14:02:19.000000000 +0200
@@ -1694,7 +1694,7 @@
 	/* Restart ipg timer */
 	if(lp->options & OPTION_DYN_IPG_ENABLE)	        
 		mod_timer(&lp->ipg_data.ipg_timer, 
-				jiffies + (IPG_CONVERGE_TIME * HZ));
+				jiffies + IPG_CONVERGE_JIFFIES);
 	spin_unlock_irq(&lp->lock);
 
 	return 0;
@@ -1768,7 +1768,7 @@
 		writew((u32)tmp_ipg, mmio + IPG); 
 		writew((u32)(tmp_ipg - IFS1_DELTA), mmio + IFS1); 
 	}
-	 mod_timer(&lp->ipg_data.ipg_timer, jiffies + (IPG_CONVERGE_TIME * HZ));
+	 mod_timer(&lp->ipg_data.ipg_timer, jiffies + IPG_CONVERGE_JIFFIES);
 	return;
 
 }
@@ -1905,7 +1905,7 @@
 		lp->ipg_data.ipg_timer.data = (unsigned long) dev;
 		lp->ipg_data.ipg_timer.function = (void *)&amd8111e_config_ipg;
 		lp->ipg_data.ipg_timer.expires = jiffies + 
-						 IPG_CONVERGE_TIME * HZ;
+						 IPG_CONVERGE_JIFFIES;
 		lp->ipg_data.ipg = DEFAULT_IPG;
 		lp->ipg_data.ipg_state = CSTATE;
 	};
--- linux-2.4.26/drivers/net/amd8111e.h.orig	2003-08-25 13:44:42.000000000 +0200
+++ linux-2.4.26/drivers/net/amd8111e.h	2004-05-10 14:01:51.000000000 +0200
@@ -606,7 +606,7 @@
 /* ipg parameters */
 #define DEFAULT_IPG			0x60
 #define IFS1_DELTA			36
-#define	IPG_CONVERGE_TIME 0.5
+#define	IPG_CONVERGE_JIFFIES (HZ/2)
 #define	IPG_STABLE_TIME	5
 #define	MIN_IPG	96
 #define	MAX_IPG	255

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.26-farsync-include.patch"

Include <asm/io.h> for ioremap(), inl() etc.

--- linux-2.4.26/drivers/net/wan/farsync.c.orig	2003-11-28 19:26:20.000000000 +0100
+++ linux-2.4.26/drivers/net/wan/farsync.c	2004-05-10 14:06:35.000000000 +0200
@@ -22,6 +22,7 @@
 #include <asm/uaccess.h>
 #include <linux/if.h>
 #include <linux/hdlc.h>
+#include <asm/io.h>
 
 #include "farsync.h"
 

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.26-mtd-typo.patch"

Fix typo (s/CONFIG_MTD_GENPROBE/CONFIG_MTD_GEN_PROBE/).

--- linux-2.4.26/drivers/mtd/maps/Config.in.orig	2003-06-13 16:51:34.000000000 +0200
+++ linux-2.4.26/drivers/mtd/maps/Config.in	2004-05-10 13:35:11.000000000 +0200
@@ -89,7 +89,7 @@
    dep_tristate '  JEDEC Flash device mapped on Ceiva/Polaroid PhotoMax Digital Picture Frame' CONFIG_MTD_CEIVA $CONFIG_MTD_JEDECPROBE  $CONFIG_ARCH_CEIVA
 fi
 if [ "$CONFIG_ALPHA" = "y" ]; then
-   dep_tristate '  Flash chip mapping on TSUNAMI' CONFIG_MTD_TSUNAMI $CONFIG_MTD_GENPROBE
+   dep_tristate '  Flash chip mapping on TSUNAMI' CONFIG_MTD_TSUNAMI $CONFIG_MTD_GEN_PROBE
 fi
 
 if [ "$CONFIG_UCLINUX" = "y" ]; then

--0F1p//8PRICkK4MW--
