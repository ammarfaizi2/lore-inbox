Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbUK3IWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbUK3IWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUK3IWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:22:00 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:57031 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262016AbUK3IT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:19:59 -0500
Date: Tue, 30 Nov 2004 09:19:56 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       castet.matthieu@free.fr
Subject: [WATCHDOG] v2.6.10-rc2 i8xx_tco.c-request_region-patch
Message-ID: <20041130081956.GA3789@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/i8xx_tco.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

through these ChangeSets:

<castet.matthieu@free.fr> (04/10/29 1.2026.42.1)
   [WATCHDOG] i8xx_tco.c-request_region-patch
   
   Fix: in i8xx_tco.c, during the initialisation, the driver accesses io
   without checking if the port is free.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
--- a/drivers/char/watchdog/i8xx_tco.c	2004-11-30 09:08:10 +01:00
+++ b/drivers/char/watchdog/i8xx_tco.c	2004-11-30 09:08:10 +01:00
@@ -415,12 +415,15 @@
 			}
 		}
 		/* Set the TCO_EN bit in SMI_EN register */
+		if (!request_region (SMI_EN + 1, 1, "i8xx TCO")) {
+			printk (KERN_ERR PFX "I/O address 0x%04x already in use\n",
+				SMI_EN + 1);
+			return 0;
+		}
 		val1 = inb (SMI_EN + 1);
 		val1 &= 0xdf;
 		outb (val1, SMI_EN + 1);
-		/* Clear out the (probably old) status */
-		outb (0, TCO1_STS);
-		outb (3, TCO2_STS);
+		release_region (SMI_EN + 1, 1);
 		return 1;
 	}
 	return 0;
@@ -442,6 +445,10 @@
 		ret = -EIO;
 		goto out;
 	}
+
+	/* Clear out the (probably old) status */
+	outb (0, TCO1_STS);
+	outb (3, TCO2_STS);
 
 	/* Check that the heartbeat value is within it's range ; if not reset to the default */
 	if (tco_timer_set_heartbeat (heartbeat)) {
