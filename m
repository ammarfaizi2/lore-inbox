Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVI2RDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVI2RDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVI2RDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:03:07 -0400
Received: from ns1.coraid.com ([65.14.39.133]:43096 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932259AbVI2RDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:03:05 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2.6.14-rc2] aoe [2/3]: use get_unaligned for accesses in ATA
 id buffer
References: <87wtkzbz5z.fsf@coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Sep 2005 12:47:40 -0400
Message-ID: <87mzlvakib.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Use get_unaligned for possibly-unaligned multi-byte accesses to the
ATA device identify response buffer.

Index: 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c
===================================================================
--- 2.6.14-rc2-aoe.orig/drivers/block/aoe/aoecmd.c	2005-09-29 12:01:56.000000000 -0400
+++ 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c	2005-09-29 12:01:56.000000000 -0400
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <asm/unaligned.h>
 #include "aoe.h"
 
 #define TIMERTICK (HZ / 10)
@@ -315,16 +316,16 @@
 	u16 n;
 
 	/* word 83: command set supported */
-	n = le16_to_cpup((__le16 *) &id[83<<1]);
+	n = le16_to_cpu(get_unaligned((__le16 *) &id[83<<1]));
 
 	/* word 86: command set/feature enabled */
-	n |= le16_to_cpup((__le16 *) &id[86<<1]);
+	n |= le16_to_cpu(get_unaligned((__le16 *) &id[86<<1]));
 
 	if (n & (1<<10)) {	/* bit 10: LBA 48 */
 		d->flags |= DEVFL_EXT;
 
 		/* word 100: number lba48 sectors */
-		ssize = le64_to_cpup((__le64 *) &id[100<<1]);
+		ssize = le64_to_cpu(get_unaligned((__le64 *) &id[100<<1]));
 
 		/* set as in ide-disk.c:init_idedisk_capacity */
 		d->geo.cylinders = ssize;
@@ -335,12 +336,12 @@
 		d->flags &= ~DEVFL_EXT;
 
 		/* number lba28 sectors */
-		ssize = le32_to_cpup((__le32 *) &id[60<<1]);
+		ssize = le32_to_cpu(get_unaligned((__le32 *) &id[60<<1]));
 
 		/* NOTE: obsolete in ATA 6 */
-		d->geo.cylinders = le16_to_cpup((__le16 *) &id[54<<1]);
-		d->geo.heads = le16_to_cpup((__le16 *) &id[55<<1]);
-		d->geo.sectors = le16_to_cpup((__le16 *) &id[56<<1]);
+		d->geo.cylinders = le16_to_cpu(get_unaligned((__le16 *) &id[54<<1]));
+		d->geo.heads = le16_to_cpu(get_unaligned((__le16 *) &id[55<<1]));
+		d->geo.sectors = le16_to_cpu(get_unaligned((__le16 *) &id[56<<1]));
 	}
 	d->ssize = ssize;
 	d->geo.start = 0;


-- 
  Ed L. Cashin <ecashin@coraid.com>

