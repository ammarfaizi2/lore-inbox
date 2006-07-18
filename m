Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWGRLxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWGRLxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGRLxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:53:01 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:44739 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751319AbWGRLxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:53:00 -0400
Date: Tue, 18 Jul 2006 13:53:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 2/6] s390: xpram module parameter parsing - take 2.
Message-ID: <20060718115306.GB20884@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] xpram module parameter parsing - take 2.

Don't use memparse since the default size modifier is 'k'.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/xpram.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/xpram.c linux-2.6-patched/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	2006-07-18 13:40:28.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/xpram.c	2006-07-18 13:40:43.000000000 +0200
@@ -304,6 +304,7 @@ static int __init xpram_setup_sizes(unsi
 {
 	unsigned long mem_needed;
 	unsigned long mem_auto;
+	unsigned long long size;
 	int mem_auto_no;
 	int i;
 
@@ -321,9 +322,19 @@ static int __init xpram_setup_sizes(unsi
 	mem_needed = 0;
 	mem_auto_no = 0;
 	for (i = 0; i < xpram_devs; i++) {
-		if (sizes[i])
-			xpram_sizes[i] =
-				(memparse(sizes[i], &sizes[i]) + 3) & -4UL;
+		if (sizes[i]) {
+			size = simple_strtoull(sizes[i], &sizes[i], 0);
+			switch (sizes[i][0]) {
+			case 'g':
+			case 'G':
+				size <<= 20;
+				break;
+			case 'm':
+			case 'M':
+				size <<= 10;
+			}
+			xpram_sizes[i] = (size + 3) & -4UL;
+		}
 		if (xpram_sizes[i])
 			mem_needed += xpram_sizes[i];
 		else
