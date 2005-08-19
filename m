Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbVHSVWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVHSVWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVHSVWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:22:23 -0400
Received: from ns1.coraid.com ([65.14.39.133]:15481 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S965173AbVHSVWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:22:22 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.13-rc6] aoe [1/2]: support 16 AoE slot addresses per AoE
 shelf
From: Ed L Cashin <ecashin@coraid.com>
Date: Fri, 19 Aug 2005 16:54:43 -0400
Message-ID: <87fyt5k5po.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the number of supported AoE slot addresses per AoE shelf
address to 16.

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

Index: 2.6.13-rc6-aoe/Documentation/aoe/mkshelf.sh
===================================================================
--- 2.6.13-rc6-aoe.orig/Documentation/aoe/mkshelf.sh	2005-08-19 11:15:21.000000000 -0400
+++ 2.6.13-rc6-aoe/Documentation/aoe/mkshelf.sh	2005-08-19 11:57:04.000000000 -0400
@@ -8,13 +8,15 @@
 n_partitions=${n_partitions:-16}
 dir=$1
 shelf=$2
+nslots=16
+maxslot=`echo $nslots 1 - p | dc`
 MAJOR=152
 
 set -e
 
-minor=`echo 10 \* $shelf \* $n_partitions | bc`
+minor=`echo $nslots \* $shelf \* $n_partitions | bc`
 endp=`echo $n_partitions - 1 | bc`
-for slot in `seq 0 9`; do
+for slot in `seq 0 $maxslot`; do
 	for part in `seq 0 $endp`; do
 		name=e$shelf.$slot
 		test "$part" != "0" && name=${name}p$part
Index: 2.6.13-rc6-aoe/drivers/block/aoe/aoe.h
===================================================================
--- 2.6.13-rc6-aoe.orig/drivers/block/aoe/aoe.h	2005-08-19 11:15:21.000000000 -0400
+++ 2.6.13-rc6-aoe/drivers/block/aoe/aoe.h	2005-08-19 11:57:04.000000000 -0400
@@ -7,12 +7,12 @@
  * default is 16, which is 15 partitions plus the whole disk
  */
 #ifndef AOE_PARTITIONS
-#define AOE_PARTITIONS 16
+#define AOE_PARTITIONS (16)
 #endif
 
-#define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * 10 + (aoeminor))
-#define AOEMAJOR(sysminor) ((sysminor) / 10)
-#define AOEMINOR(sysminor) ((sysminor) % 10)
+#define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * NPERSHELF + (aoeminor))
+#define AOEMAJOR(sysminor) ((sysminor) / NPERSHELF)
+#define AOEMINOR(sysminor) ((sysminor) % NPERSHELF)
 #define WHITESPACE " \t\v\f\n"
 
 enum {
@@ -83,7 +83,7 @@
 
 enum {
 	MAXATADATA = 1024,
-	NPERSHELF = 10,
+	NPERSHELF = 16,		/* number of slots per shelf address */
 	FREETAG = -1,
 	MIN_BUFS = 8,
 };


-- 
  Ed L. Cashin <ecashin@coraid.com>

