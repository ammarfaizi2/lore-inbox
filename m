Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbUK3Wpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUK3Wpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUK3Wns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:43:48 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:39853 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S262383AbUK3Wkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:40:31 -0500
Date: Tue, 30 Nov 2004 23:40:14 +0100
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Ruzicka <pavouk@pavouk.org>
Subject: [PATCH 2.6] via-rhine: WOL band-aid
Message-ID: <20041130224014.GD29947@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.10-rc2-bk11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I disabled legacy WOL (i.e. controlled by EEPROM rather than
driver) in 2.6.9, several people reported regressions. Legacy WOL had
worked for them, but now it didn't anymore. The Right Way (TM) to fix
this will get the driver to set up working WOL for all hardware, but a
simpler solution will have to do for the time being: If a user requests
magic packet WOL, the driver re-enables legacy WOL. Yeah, I know it's
cheating.

This version applies against -mm. I suggest to put it there for testing
and into 2.6.11 if feedback is good.

Thanks to Pavel Ruzicka for testing.

Roger

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- 2.6-mm/drivers/net/via-rhine.c.orig	2004-11-30 23:28:46.663676720 +0100
+++ 2.6-mm/drivers/net/via-rhine.c	2004-11-30 23:32:00.928144032 +0100
@@ -654,7 +654,7 @@ static void __devinit rhine_reload_eepro
 
 	/* Turn off EEPROM-controlled wake-up (magic packet) */
 	if (rp->quirks & rqWOL)
-		iowrite8(ioread8(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
+		iowrite8(ioread8(ioaddr + ConfigA) & 0xFC, ioaddr + ConfigA);
 
 }
 
@@ -1905,8 +1905,14 @@ static void rhine_shutdown (struct devic
 	if (rp->quirks & rq6patterns)
 		iowrite8(0x04, ioaddr + 0xA7);
 
-	if (rp->wolopts & WAKE_MAGIC)
+	if (rp->wolopts & WAKE_MAGIC) {
 		iowrite8(WOLmagic, ioaddr + WOLcrSet);
+		/*
+		 * Turn EEPROM-controlled wake-up back on -- some hardware may
+		 * not cooperate otherwise.
+		 */
+		iowrite8(ioread8(ioaddr + ConfigA) | 0x03, ioaddr + ConfigA);
+	}
 
 	if (rp->wolopts & (WAKE_BCAST|WAKE_MCAST))
 		iowrite8(WOLbmcast, ioaddr + WOLcgSet);
@@ -1917,9 +1923,11 @@ static void rhine_shutdown (struct devic
 	if (rp->wolopts & WAKE_UCAST)
 		iowrite8(WOLucast, ioaddr + WOLcrSet);
 
-	/* Enable legacy WOL (for old motherboards) */
-	iowrite8(0x01, ioaddr + PwcfgSet);
-	iowrite8(ioread8(ioaddr + StickyHW) | 0x04, ioaddr + StickyHW);
+	if (rp->wolopts) {
+		/* Enable legacy WOL (for old motherboards) */
+		iowrite8(0x01, ioaddr + PwcfgSet);
+		iowrite8(ioread8(ioaddr + StickyHW) | 0x04, ioaddr + StickyHW);
+	}
 
 	/* Hit power state D3 (sleep) */
 	iowrite8(ioread8(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);
