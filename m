Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277010AbRJID1a>; Mon, 8 Oct 2001 23:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277705AbRJID1T>; Mon, 8 Oct 2001 23:27:19 -0400
Received: from hermes.toad.net ([162.33.130.251]:55448 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S277010AbRJID1I>;
	Mon, 8 Oct 2001 23:27:08 -0400
Subject: [PATCH] PnPBIOS bugfix (last of the first round of cleanups)
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 08 Oct 2001 23:27:06 -0400
Message-Id: <1002598029.953.60.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is required so that we don't use memory that's been
kfree'd.  (Corrects my mistake.)  Also this makes the regionid
a bit more informative (as it appears in /proc/ioports).

--
Thomas

The patch:
--- linux-2.4.10-ac10/drivers/pnp/pnp_bios.c	Mon Oct  8 22:41:14 2001
+++ linux-2.4.10-ac10-fx/drivers/pnp/pnp_bios.c	Mon Oct  8 00:49:58 2001
@@ -686,17 +686,17 @@
 	 * We really shouldn't just reserve these regions, though, since
 	 * that prevents the device drivers from claiming them.
 	 */
-	regionid = pnp_bios_kmalloc(8, GFP_KERNEL);
+	regionid = pnp_bios_kmalloc(16, GFP_KERNEL);
 	if ( regionid == NULL )
 		return;
-	memcpy(regionid,pnpid,8);
+	sprintf(regionid, "PnPBIOS %s", pnpid);
 	res = request_region(io,len,regionid);
 	if ( res == NULL )
 		kfree( regionid );
 	printk(
-		"PnPBIOS: %s: 0x%x-0x%x %s\n",
-		regionid, io, io+len-1,
-		NULL != res ? "reserved" : "was already reserved"
+		"PnPBIOS: %s: 0x%x-0x%x %s reserved\n",
+		pnpid, io, io+len-1,
+		NULL != res ? "has been" : "was already"
 	);
 
 	return;

