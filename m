Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVFNTbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVFNTbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 15:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVFNTbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 15:31:20 -0400
Received: from cms101.neoplus.adsl.tpnet.pl ([83.31.146.101]:5899 "EHLO
	cne142.neoplus.adsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S261305AbVFNTa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 15:30:57 -0400
Date: Tue, 14 Jun 2005 21:38:26 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2.6][PPC32] RESEND: don't recursively crash in die() on CHRP/PReP machines
Message-ID: <20050614193826.GE13702@fngna.oyu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids recursive crash (leading to kernel stack overflow) in
die() on CHRP/PReP machines when CONFIG_PMAC_BACKLIGHT=y.
set_backlight_* functions are placed in pmac section, which is discarded
when _machine != _MACH_Pmac.

I already posted this patch to LKML few months ago:
http://www.ussg.iu.edu/hypermail/linux/kernel/0412.0/0300.html
and it has been applied to linux-2.4 tree, but still not 2.6.
(patch was made against 2.4.27, but still applies cleanly against
kernels up to 2.6.11.12)

Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.4.27/arch/ppc/kernel/traps.c.orig	Wed Apr 14 15:05:27 2004
+++ linux-2.4.27/arch/ppc/kernel/traps.c	Mon Nov 29 19:05:28 2004
@@ -88,8 +88,10 @@
 	console_verbose();
 	spin_lock_irq(&die_lock);
 #ifdef CONFIG_PMAC_BACKLIGHT
-	set_backlight_enable(1);
-	set_backlight_level(BACKLIGHT_MAX);
+	if (_machine == _MACH_Pmac) {
+		set_backlight_enable(1);
+		set_backlight_level(BACKLIGHT_MAX);
+	}
 #endif
 	printk("Oops: %s, sig: %ld\n", str, err);
 	show_regs(fp);


-- 
Jakub Bogusz    http://qboosh.cs.net.pl/
