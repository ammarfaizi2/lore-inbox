Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270724AbTHGURv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTHGURv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:17:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60656 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270724AbTHGUR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:17:26 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 7 Aug 2003 22:17:24 +0200 (MEST)
Message-Id: <UTC200308072017.h77KHOl02587.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] correct - I hope - check for HPA and LBA48
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember that it is necessary to check whether the words
containing the HPA and LBA48 bits are valid before looking
at these bits. This improves things for at least one disk.
But there is much buggy hardware out there - this may also
break some things. Not to be applied (yet) to stable kernels.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Thu Aug  7 22:08:22 2003
+++ b/drivers/ide/ide-disk.c	Thu Aug  7 22:42:27 2003
@@ -1080,24 +1080,21 @@
 	return (id->capability & 2);
 }
 
-/*
- * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
- * so on non-buggy drives we need test only one.
- * However, we should also check whether these fields are valid.
- */
 static inline int
 idedisk_supports_host_protected_area(const struct hd_driveid *id)
 {
-	return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
+	return (id->command_set_2 & 0xc000) == 0x4000 /* words 82-83 valid */
+		&& (id->command_set_1 & 0x0400)	      /* HPA supported */
+		&& (id->csf_default & 0xc000) == 0x4000 /* wds 85-87 valid */
+		&& (id->cfs_enable_1 & 0x0400);       /* HPA enabled */
 }
 
-/*
- * The same here.
- */
 static inline int
 idedisk_supports_lba48(const struct hd_driveid *id)
 {
-	return (id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400);
+	return (id->command_set_2 & 0xc400) == 0x4400 /* LBA48 supported */
+		&& (id->csf_default & 0xc000) == 0x4000 /* wds 85-87 valid */
+		&& (id->cfs_enable_2 & 0x0400);       /* LBA48 enabled */
 }
 
 static inline unsigned long long
