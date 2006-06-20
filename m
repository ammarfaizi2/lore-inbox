Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWFTNaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWFTNaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWFTNaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:30:06 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:17848
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750805AbWFTNaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:30:03 -0400
Message-ID: <4497F85B.7010409@ed-soft.at>
Date: Tue, 20 Jun 2006 15:30:03 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Fix boot on efi 32 bit Machines
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------020407060303040605040506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020407060303040605040506
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Fix EFI boot on 32 bit machines with pcie port.
Efi machines does not have an e820 memory map.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

--------------020407060303040605040506
Content-Type: text/x-patch;
 name="efi_e820_all_mapped_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="efi_e820_all_mapped_fix.patch"

--- a/arch/i386/kernel/setup.c	2006-06-19 09:12:09.000000000 +0200
+++ b/arch/i386/kernel/setup.c	2006-06-19 09:12:24.000000000 +0200
@@ -975,24 +975,28 @@
 	u64 start = s;
 	u64 end = e;
 	int i;
-	for (i = 0; i < e820.nr_map; i++) {
-		struct e820entry *ei = &e820.map[i];
-		if (type && ei->type != type)
-			continue;
-		/* is the region (part) in overlap with the current region ?*/
-		if (ei->addr >= end || ei->addr + ei->size <= start)
-			continue;
-		/* if the region is at the beginning of <start,end> we move
-		 * start to the end of the region since it's ok until there
-		 */
-		if (ei->addr <= start)
-			start = ei->addr + ei->size;
-		/* if start is now at or beyond end, we're done, full
-		 * coverage */
-		if (start >= end)
-			return 1; /* we're done */
+	if(!efi_enabled) {
+		for (i = 0; i < e820.nr_map; i++) {
+			struct e820entry *ei = &e820.map[i];
+			if (type && ei->type != type)
+				continue;
+			/* is the region (part) in overlap with the current region ?*/
+			if (ei->addr >= end || ei->addr + ei->size <= start)
+				continue;
+			/* if the region is at the beginning of <start,end> we move
+			 * start to the end of the region since it's ok until there
+			 */
+			if (ei->addr <= start)
+				start = ei->addr + ei->size;
+			/* if start is now at or beyond end, we're done, full
+			 * coverage */
+			if (start >= end)
+				return 1; /* we're done */
+		}
+		return 0;
+	} else {
+		return 1;
 	}
-	return 0;
 }
 
 /*

--------------020407060303040605040506--
