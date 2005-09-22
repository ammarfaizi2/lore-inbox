Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbVIVGAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbVIVGAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVIVGAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:00:10 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:24263 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S964976AbVIVGAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:00:09 -0400
Date: Thu, 22 Sep 2005 08:00:30 +0200
From: Borislav Petkov <petkov@uni-muenster.de>
To: netdev@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remove check_region from PnPWakeUp routine of Eepro ISA driver
Message-ID: <20050922060030.GB19049@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

 The following patch removes the check_region call in the PnPWakeUp
 path in the Eepro /10 ISA driver. Instead, now it calls request_region
 for the PnP wake up routine and, after succeeding, it calls release_region
 for the actual reservation of I/O ports takes place in the eepro_probe1() 
 function straight afterwards.

 Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>


--- drivers/net/eepro.c.orig	2005-09-22 06:20:28.000000000 +0200
+++ drivers/net/eepro.c	2005-09-22 07:20:16.000000000 +0200
@@ -552,7 +552,7 @@ static int __init do_eepro_probe(struct 
 	{
 		unsigned short int WS[32]=WakeupSeq;
 
-		if (check_region(WakeupPort, 2)==0) {
+		if (request_region(WakeupPort, 2, DRV_NAME)) {
 
 			if (net_debug>5)
 				printk(KERN_DEBUG "Waking UP\n");
@@ -563,6 +563,8 @@ static int __init do_eepro_probe(struct 
 				outb_p(WS[i],WakeupPort);
 				if (net_debug>5) printk(KERN_DEBUG ": %#x ",WS[i]);
 			}
+			release_region(WakeupPort, 2);
+
 		} else printk(KERN_WARNING "Checkregion Failed!\n");
 	}
 #endif
