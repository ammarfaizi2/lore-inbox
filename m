Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWA1RyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWA1RyI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 12:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWA1RyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 12:54:07 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:59628 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751601AbWA1RyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 12:54:07 -0500
Date: Sun, 29 Jan 2006 02:53:42 +0900 (JST)
Message-Id: <20060129.025342.89066868.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org, akpm@osdl.org
Subject: [PATCH] [MTD] cmdlinepart: allow zero offset value
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current cmdlinepart.c uses offset value 0 to specify a continuous
partition.  This prevents creating a second partition starting at 0.

For example, I can split 4MB device using "mtdparts=id:2M,2M", but I
can not do "mtdparts=id:2M@2M,2M@0" to swap mtd0 and mtd1.

This patch introduces special OFFSET_CONTINUOUS value for a continuous
partition and allows 0 for offset value.

Also this patch replaces 0xffffffff with ULONG_MAX for SIZE_REMAINING.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/mtd/cmdlinepart.c b/drivers/mtd/cmdlinepart.c
index 6b8bb2e..e719883 100644
--- a/drivers/mtd/cmdlinepart.c
+++ b/drivers/mtd/cmdlinepart.c
@@ -42,7 +42,8 @@
 
 
 /* special size referring to all the remaining space in a partition */
-#define SIZE_REMAINING 0xffffffff
+#define SIZE_REMAINING ULONG_MAX
+#define OFFSET_CONTINUOUS ULONG_MAX
 
 struct cmdline_mtd_partition {
 	struct cmdline_mtd_partition *next;
@@ -75,7 +76,7 @@ static struct mtd_partition * newpart(ch
 {
 	struct mtd_partition *parts;
 	unsigned long size;
-	unsigned long offset = 0;
+	unsigned long offset = OFFSET_CONTINUOUS;
 	char *name;
 	int name_len;
 	unsigned char *extra_mem;
@@ -314,7 +315,7 @@ static int parse_cmdline_partitions(stru
 		{
 			for(i = 0, offset = 0; i < part->num_parts; i++)
 			{
-				if (!part->parts[i].offset)
+				if (part->parts[i].offset == OFFSET_CONTINUOUS)
 				  part->parts[i].offset = offset;
 				else
 				  offset = part->parts[i].offset;
