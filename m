Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWHUJD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWHUJD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWHUJD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:03:56 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:42198 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S1750790AbWHUJDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:03:55 -0400
Date: Mon, 21 Aug 2006 11:03:51 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Valerie Henson <val_henson@linux.intel.com>,
       Prakash Punnoor <prakash@punnoor.de>, Jiri Benc <jbenc@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-ID: <20060821090351.GB19425@ojjektum.uhulinux.hu>
References: <20050427124911.6212670f@griffin.suse.cz> <20060816191139.5d13fda8@griffin.suse.cz> <20060816174329.GC17650@ojjektum.uhulinux.hu> <200608162002.06793.prakash@punnoor.de> <20060816195345.GA12868@ojjektum.uhulinux.hu> <20060819001640.GE20111@goober> <20060819061507.GB8571@ojjektum.uhulinux.hu> <44E721E1.2030203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E721E1.2030203@pobox.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 10:36:17AM -0400, Jeff Garzik wrote:
> Pozsar Balazs wrote:
> >--- a/drivers/net/tulip/uli526x.c	2006-07-15 21:00:43.000000000 +0200
> >+++ a/drivers/net/tulip/uli526x.c	2006-08-18 15:41:00.000000000 +0200
> >@@ -515,7 +515,8 @@
> > 	phy_reg_reset = phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id);
> > 	phy_reg_reset = (phy_reg_reset | 0x8000);
> > 	phy_write(db->ioaddr, db->phy_addr, 0, phy_reg_reset, db->chip_id);
> >-	udelay(500);
> >+	while (phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id) & 0x8000)
> >+		udelay(500);
> 
> You never want an infinite loop in a driver.  If, for example, the 
> hardware is wedged or removed, registers will return all 1's, leading 
> this loop to never end.

Does this seem better?

Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>

Fix uli526x initialization


--- a/drivers/net/tulip/uli526x.c	2006-08-21 10:57:43.000000000 +0200
+++ a/drivers/net/tulip/uli526x.c	2006-08-21 11:01:37.000000000 +0200
@@ -486,6 +486,7 @@
 	u8	phy_tmp;
 	u16	phy_value;
 	u16 phy_reg_reset;
+	int resetwait = 10;
 
 	ULI526X_DBUG(0, "uli526x_init()", 0);
 
@@ -515,7 +516,11 @@
 	phy_reg_reset = phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id);
 	phy_reg_reset = (phy_reg_reset | 0x8000);
 	phy_write(db->ioaddr, db->phy_addr, 0, phy_reg_reset, db->chip_id);
-	udelay(500);
+	while (resetwait-- > 0) {
+		if (!(phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id) & 0x8000))
+			break;
+		udelay(500);
+	}
 
 	/* Process Phyxcer Media Mode */
 	uli526x_set_phyxcer(db);



-- 
pozsy
