Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbVIZRBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbVIZRBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbVIZRBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:01:39 -0400
Received: from ns1.coraid.com ([65.14.39.133]:30884 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751686AbVIZRBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:01:39 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>,
       Jim MacBaine <jmacbaine@gmail.com>
Subject: [PATCH 2.6.14-rc2] aoe [2/2]: use get_unaligned for possibly
 unaligned accesses in ATA id buffer
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <87oe6fhj8y.fsf@coraid.com>
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Sep 2005 12:45:34 -0400
Message-ID: <87ll1jg4lt.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Use get_unaligned for possibly-unaligned multi-byte accesses to the
ATA device identify response buffer.

Index: 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c
===================================================================
--- 2.6.14-rc2-aoe.orig/drivers/block/aoe/aoecmd.c	2005-09-26 12:27:49.000000000 -0400
+++ 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c	2005-09-26 12:27:49.000000000 -0400
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <asm/unaligned.h>
 #include "aoe.h"
 
 #define TIMERTICK (HZ / 10)
@@ -314,16 +315,16 @@
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
@@ -334,12 +335,12 @@
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

