Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVADVvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVADVvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVADVsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:48:09 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:26839 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262274AbVADVkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:40:42 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104214101.21749.2512.96532@localhost.localdomain>
In-Reply-To: <20050104214048.21749.85722.89116@localhost.localdomain>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
Subject: [PATCH 2/7] ppc: remove cli()/sti() in arch/ppc/8xx_io/cs4218_tdm.c
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 15:40:41 -0600
Date: Tue, 4 Jan 2005 15:40:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/8xx_io/cs4218_tdm.c linux-2.6.10-mm1/arch/ppc/8xx_io/cs4218_tdm.c
--- linux-2.6.10-mm1-original/arch/ppc/8xx_io/cs4218_tdm.c	2004-12-24 16:33:51.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/8xx_io/cs4218_tdm.c	2005-01-03 19:58:01.881032015 -0500
@@ -1206,7 +1206,7 @@
 	volatile cbd_t	*bdp;
 	volatile cpm8xx_t *cp;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 #if 0
 	if (awacs_beep_state) {
 		/* sound takes precedence over beeps */
@@ -1263,7 +1263,7 @@
 
 		++sq.active;
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -1275,7 +1275,7 @@
 	if (read_sq.active)
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	/* This is all we have to do......Just start it up.
 	*/
@@ -1284,7 +1284,7 @@
 
 	read_sq.active = 1;
 
-        restore_flags(flags);
+        local_irq_restore(flags);
 }
 
 
@@ -1365,14 +1365,14 @@
 {
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (beep_playing) {
 #if 0
 		st_le16(&beep_dbdma_cmd->command, DBDMA_STOP);
 #endif
 		beep_playing = 0;
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static struct timer_list beep_timer = TIMER_INITIALIZER(cs_nosound, 0, 0);
@@ -1401,21 +1401,21 @@
 		return;
 #endif
 	}
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	del_timer(&beep_timer);
 	if (ticks) {
 		beep_timer.expires = jiffies + ticks;
 		add_timer(&beep_timer);
 	}
 	if (beep_playing || sq.active || beep_buf == NULL) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;		/* too hard, sorry :-( */
 	}
 	beep_playing = 1;
 #if 0
 	st_le16(&beep_dbdma_cmd->command, OUTPUT_MORE + BR_ALWAYS);
 #endif
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (hz == beep_hz_cache && beep_volume == beep_volume_cache) {
 		nsamples = beep_nsamples_cache;
@@ -1442,7 +1442,7 @@
 	st_le32(&beep_dbdma_cmd->phy_addr, virt_to_bus(beep_buf));
 	awacs_beep_state = 1;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (beep_playing) {	/* i.e. haven't been terminated already */
 		out_le32(&awacs_txdma->control, (RUN|WAKE|FLUSH|PAUSE) << 16);
 		out_le32(&awacs->control,
@@ -1453,7 +1453,7 @@
 		out_le32(&awacs_txdma->control, RUN | (RUN << 16));
 	}
 #endif
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static MACHINE mach_cs4218 = {
