Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVCGOu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVCGOu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 09:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVCGOu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 09:50:28 -0500
Received: from colino.net ([213.41.131.56]:45565 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261208AbVCGOuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 09:50:19 -0500
Date: Mon, 7 Mar 2005 15:49:26 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make therm_adt746x handle latest powerbooks
Message-ID: <20050307154926.2706085b@jack.colino.net>
X-Mailer: Sylpheed-Claws 1.0.1cvs22.2 (GTK+ 2.6.1; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch lets therm_adt746x handle the latest powerbooks. In these
ones, Apple doesn't put the i2c bus number in the "reg" property of
the fan node. Instead, we can get the bus number from the fan node
path, which looks like "/proc/device-tree/.../i2c-bus@1/.../fan". 
Here's a patch that handles both old and new form.

Please apply :)

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/drivers/macintosh/therm_adt746x.c	2005-03-07
09:03:58.000000000 +0100
+++ b/drivers/macintosh/therm_adt746x.c	2005-03-07
09:04:35.000000000 +0100
@@ -548,7 +548,15 @@
 	prop = (u32 *)get_property(np, "reg", NULL);
 	if (!prop)
 		return -ENODEV;
-	therm_bus = ((*prop) >> 8) & 0x0f;
+	
+	/* look for bus either by path or using "reg" */
+	if (strstr(np->full_name, "/i2c-bus@") != NULL) {
+		const char *tmp_bus = (strstr(np->full_name, "/i2c-bus@") + 9);
+		therm_bus = tmp_bus[0]-'0';
+	} else {
+		therm_bus = ((*prop) >> 8) & 0x0f;
+	}
+	
 	therm_address = ((*prop) & 0xff) >> 1;
 
 	printk(KERN_INFO "adt746x: Thermostat bus: %d, address: 0x%02x, "
