Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVHJKct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVHJKct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVHJKct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:32:49 -0400
Received: from relay.rost.ru ([80.254.111.11]:8853 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S932543AbVHJKct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:32:49 -0400
Subject: [PATCH 0/5] 2.6.13-rc5-mm1, remove uneeded function
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 10 Aug 2005 14:32:46 +0400
Message-Id: <11236699661419@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After elimination of central DMI blacklist dmi_scan_machine() function
became a wrapper for dmi_iterate(). This patch moves some code around to
kill unneeded function.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |   85 ++++++++++++++++++++------------------------
 1 files changed, 40 insertions(+), 45 deletions(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.13-rc5-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.13-rc5-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.13-rc5-mm1.vanilla/arch/i386/kernel/dmi_scan.c	2005-06-12 23:07:37.000000000 +0400
+++ linux-2.6.13-rc5-mm1/arch/i386/kernel/dmi_scan.c	2005-06-14 23:18:18.000000000 +0400
@@ -84,49 +84,6 @@ static int __init dmi_checksum(u8 *buf)
 	return sum == 0;
 }
 
-static int __init dmi_iterate(void (*decode)(struct dmi_header *))
-{
-	u8 buf[15];
-	char __iomem *p, *q;
-
-	/*
-	 * no iounmap() for that ioremap(); it would be a no-op, but it's
-	 * so early in setup that sucker gets confused into doing what
-	 * it shouldn't if we actually call it.
-	 */
-	p = ioremap(0xF0000, 0x10000);
-	if (p == NULL)
-		return -1;
-
-	for (q = p; q < p + 0x10000; q += 16) {
-		memcpy_fromio(buf, q, 15);
-		if ((memcmp(buf, "_DMI_", 5) == 0) && dmi_checksum(buf)) {
-			u16 num = (buf[13] << 8) | buf[12];
-			u16 len = (buf[7] << 8) | buf[6];
-			u32 base = (buf[11] << 24) | (buf[10] << 16) |
-				   (buf[9] << 8) | buf[8];
-
-			/*
-			 * DMI version 0.0 means that the real version is taken from
-			 * the SMBIOS version, which we don't know at this point.
-			 */
-			if (buf[14] != 0)
-				printk(KERN_INFO "DMI %d.%d present.\n",
-					buf[14] >> 4, buf[14] & 0xF);
-			else
-				printk(KERN_INFO "DMI present.\n");
-
-			dmi_printk((KERN_INFO "%d structures occupying %d bytes.\n",
-				num, len));
-			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n", base));
-
-			if (dmi_table(base,len, num, decode) == 0)
-				return 0;
-		}
-	}
-	return -1;
-}
-
 static char *dmi_ident[DMI_STRING_MAX];
 
 /*
@@ -190,8 +147,46 @@ static void __init dmi_decode(struct dmi
 
 void __init dmi_scan_machine(void)
 {
-	if (dmi_iterate(dmi_decode))
-		printk(KERN_INFO "DMI not present.\n");
+	u8 buf[15];
+	char __iomem *p, *q;
+
+	/*
+	 * no iounmap() for that ioremap(); it would be a no-op, but it's
+	 * so early in setup that sucker gets confused into doing what
+	 * it shouldn't if we actually call it.
+	 */
+	p = ioremap(0xF0000, 0x10000);
+	if (p == NULL)
+		goto out;
+
+	for (q = p; q < p + 0x10000; q += 16) {
+		memcpy_fromio(buf, q, 15);
+		if ((memcmp(buf, "_DMI_", 5) == 0) && dmi_checksum(buf)) {
+			u16 num = (buf[13] << 8) | buf[12];
+			u16 len = (buf[7] << 8) | buf[6];
+			u32 base = (buf[11] << 24) | (buf[10] << 16) |
+				   (buf[9] << 8) | buf[8];
+
+			/*
+			 * DMI version 0.0 means that the real version is taken from
+			 * the SMBIOS version, which we don't know at this point.
+			 */
+			if (buf[14] != 0)
+				printk(KERN_INFO "DMI %d.%d present.\n",
+					buf[14] >> 4, buf[14] & 0xF);
+			else
+				printk(KERN_INFO "DMI present.\n");
+
+			dmi_printk((KERN_INFO "%d structures occupying %d bytes.\n",
+				num, len));
+			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n", base));
+
+			if (dmi_table(base,len, num, dmi_decode) == 0)
+				return;
+		}
+	}
+
+out:	printk(KERN_INFO "DMI not present.\n");
 }
 
 

