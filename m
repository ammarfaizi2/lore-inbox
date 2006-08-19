Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWHSGPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWHSGPV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 02:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWHSGPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 02:15:21 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:26828 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S1751309AbWHSGPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 02:15:21 -0400
Date: Sat, 19 Aug 2006 08:15:08 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Prakash Punnoor <prakash@punnoor.de>, Jiri Benc <jbenc@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-ID: <20060819061507.GB8571@ojjektum.uhulinux.hu>
References: <20050427124911.6212670f@griffin.suse.cz> <20060816191139.5d13fda8@griffin.suse.cz> <20060816174329.GC17650@ojjektum.uhulinux.hu> <200608162002.06793.prakash@punnoor.de> <20060816195345.GA12868@ojjektum.uhulinux.hu> <20060819001640.GE20111@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819001640.GE20111@goober>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 05:16:41PM -0700, Valerie Henson wrote:
> On Wed, Aug 16, 2006 at 09:53:45PM +0200, Pozsar Balazs wrote:
> > On Wed, Aug 16, 2006 at 08:02:02PM +0200, Prakash Punnoor wrote:
> > > Am Mittwoch 16 August 2006 19:43 schrieb Pozsar Balazs:
> > > 
> > > > So, just to make it clear: if you boot without cable plugged in, let
> > > > the driver load, and then plug the cable in, do you have link?
> > > > For me, it does not have link until I rmmod the module.
> > > 
> > > Same here.
> > 
> > The most weird thing is that, when I _rmmod_ the module, the link leds 
> > will show a link, _before_ I even re-modprobe it! So somehow the removal 
> > (or even an unbind via the sysfs interface) "resets" it.
> 
> Hey folks,
> 
> Added to my to-do list.  Let me know if you figure out anything else.

Actually, I managed to fix it, here's the patch:

Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>

--- a/drivers/net/tulip/uli526x.c	2006-07-15 21:00:43.000000000 +0200
+++ a/drivers/net/tulip/uli526x.c	2006-08-18 15:41:00.000000000 +0200
@@ -515,7 +515,8 @@
 	phy_reg_reset = phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id);
 	phy_reg_reset = (phy_reg_reset | 0x8000);
 	phy_write(db->ioaddr, db->phy_addr, 0, phy_reg_reset, db->chip_id);
-	udelay(500);
+	while (phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id) & 0x8000)
+		udelay(500);
 
 	/* Process Phyxcer Media Mode */
 	uli526x_set_phyxcer(db);


-- 
pozsy
