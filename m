Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVAHRF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVAHRF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVAHRFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:05:24 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:14023 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261220AbVAHREH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:04:07 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050108170424.32690.35671.32729@localhost.localdomain>
In-Reply-To: <20050108170406.32690.36989.11853@localhost.localdomain>
References: <20050108170406.32690.36989.11853@localhost.localdomain>
Subject: [RESEND] [PATCH 2/7] ppc: remove cli()/sti() in arch/ppc/8xx_io/cs4218_tdm.c
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.220.243] at Sat, 8 Jan 2005 11:04:04 -0600
Date: Sat, 8 Jan 2005 11:04:07 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace save_flags()/resore_flags() with spin_lock_irqsave()/spin_unlock_irqrestore()
and document reasons for locking.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/8xx_io/cs4218_tdm.c linux-2.6.10-mm1/arch/ppc/8xx_io/cs4218_tdm.c
--- linux-2.6.10-mm1-original/arch/ppc/8xx_io/cs4218_tdm.c	2004-12-24 16:33:51.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/8xx_io/cs4218_tdm.c	2005-01-07 19:46:23.267111848 -0500
@@ -55,6 +55,8 @@
 static char **sound_buffers = NULL;
 static char **sound_read_buffers = NULL;
 
+static spinlock_t cs4218_lock = SPIN_LOCK_UNLOCKED;
+
 /* Local copies of things we put in the control register.  Output
  * volume, like most codecs is really attenuation.
  */
@@ -1206,7 +1208,8 @@
 	volatile cbd_t	*bdp;
 	volatile cpm8xx_t *cp;
 
-	save_flags(flags); cli();
+	/* Protect buffer */
+	spin_lock_irqsave(&cs4218_lock, flags);
 #if 0
 	if (awacs_beep_state) {
 		/* sound takes precedence over beeps */
@@ -1263,7 +1266,7 @@
 
 		++sq.active;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cs4218_lock, flags);
 }
 
 
@@ -1275,7 +1278,8 @@
 	if (read_sq.active)
 		return;
 
-	save_flags(flags); cli();
+	/* Protect buffer */
+	spin_lock_irqsave(&cs4218_lock, flags);
 
 	/* This is all we have to do......Just start it up.
 	*/
@@ -1284,7 +1288,7 @@
 
 	read_sq.active = 1;
 
-        restore_flags(flags);
+        spin_unlock_irqrestore(&cs4218_lock, flags);
 }
 
 
@@ -1365,14 +1369,15 @@
 {
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	/* not sure if this is needed, since hardware command is #if 0'd */
+	spin_lock_irqsave(&cs4218_lock, flags);
 	if (beep_playing) {
 #if 0
 		st_le16(&beep_dbdma_cmd->command, DBDMA_STOP);
 #endif
 		beep_playing = 0;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cs4218_lock, flags);
 }
 
 static struct timer_list beep_timer = TIMER_INITIALIZER(cs_nosound, 0, 0);
@@ -1401,21 +1406,22 @@
 		return;
 #endif
 	}
-	save_flags(flags); cli();
+	/* lock while modifying beep_timer */
+	spin_lock_irqsave(&cs4218_lock, flags);
 	del_timer(&beep_timer);
 	if (ticks) {
 		beep_timer.expires = jiffies + ticks;
 		add_timer(&beep_timer);
 	}
 	if (beep_playing || sq.active || beep_buf == NULL) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&cs4218_lock, flags);
 		return;		/* too hard, sorry :-( */
 	}
 	beep_playing = 1;
 #if 0
 	st_le16(&beep_dbdma_cmd->command, OUTPUT_MORE + BR_ALWAYS);
 #endif
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cs4218_lock, flags);
 
 	if (hz == beep_hz_cache && beep_volume == beep_volume_cache) {
 		nsamples = beep_nsamples_cache;
@@ -1442,7 +1448,7 @@
 	st_le32(&beep_dbdma_cmd->phy_addr, virt_to_bus(beep_buf));
 	awacs_beep_state = 1;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&cs4218_lock, flags);
 	if (beep_playing) {	/* i.e. haven't been terminated already */
 		out_le32(&awacs_txdma->control, (RUN|WAKE|FLUSH|PAUSE) << 16);
 		out_le32(&awacs->control,
@@ -1452,8 +1458,8 @@
 		out_le32(&awacs_txdma->cmdptr, virt_to_bus(beep_dbdma_cmd));
 		out_le32(&awacs_txdma->control, RUN | (RUN << 16));
 	}
+	spin_unlock_irqrestore(&cs4218_lock, flags);
 #endif
-	restore_flags(flags);
 }
 
 static MACHINE mach_cs4218 = {
