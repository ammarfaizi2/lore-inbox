Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbTIRTrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 15:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTIRTrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 15:47:05 -0400
Received: from web14205.mail.yahoo.com ([216.136.172.151]:36215 "HELO
	web14205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262046AbTIRTrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 15:47:02 -0400
Message-ID: <20030918194701.25323.qmail@web14205.mail.yahoo.com>
X-RocketYMMF: cregentin
Date: Thu, 18 Sep 2003 12:47:01 -0700 (PDT)
From: Curtis Regentin <cregentin@penguincomputing.com>
Reply-To: cregentin@penguincomputing.com
Subject: [PATCH] 2.4.23 Failure to reload partitions past 1TB
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parted fails when creating partitions > 1TB.

If anyone doesn't like my assumption of 32bit long,
feel free to fix it, or tell me the apropriate method.
 Enough assumptions are made about that in this code
that I don't feel too bad, and no MAXULONG seems
defined in the kernel tree.

Please CC me on replies.

 --- SNIP ---
--- linux-2.4.22.old/drivers/block/blkpg.c	2003-09-18
11:48:04.000000000 -0700
+++ linux-2.4.22/drivers/block/blkpg.c	2003-09-18
12:19:25.000000000 -0700
@@ -63,21 +63,20 @@
  *                 or has the same number as an
existing one
  *          0: all OK.
  */
+
 int add_partition(kdev_t dev, struct blkpg_partition
*p) {
 	struct gendisk *g;
-	long long ppstart, pplength;
-	long pstart, plength;
+	unsigned long long pstart, plength;
 	int i, drive, first_minor, end_minor, minor;
+	unsigned long maxblock = 0xffffffffUL;
 
 	/* convert bytes to sectors, check for fit in a
hd_struct */
-	ppstart = (p->start >> 9);
-	pplength = (p->length >> 9);
-	pstart = ppstart;
-	plength = pplength;
-	if (pstart != ppstart || plength != pplength
-	    || pstart < 0 || plength < 0)
+	pstart = (p->start >> 9);
+	plength = (p->length >> 9);
+	if (pstart > maxblock || plength > maxblock ||
(pstart+plength) > maxblock)
 		return -EINVAL;
 
+
 	/* find the drive major */
 	g = get_gendisk(dev);
 	if (!g)

