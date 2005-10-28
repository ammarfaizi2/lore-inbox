Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVJ1Gp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVJ1Gp6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVJ1Gpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:45:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:21738 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965108AbVJ1GbJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:09 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: use get_unaligned for accesses in ATA id buffer
In-Reply-To: <11304810212914@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:21 -0700
Message-Id: <11304810214168@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe: use get_unaligned for accesses in ATA id buffer

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Use get_unaligned for possibly-unaligned multi-byte accesses to the
ATA device identify response buffer.

---
commit 786fbf6c1eb91e7e70a1ef42ff2523aff0f09850
tree 2a2d7be04f20f9c3a2d133eaa37d33797d7e27da
parent 741b2252a5e14d6c60a913c77a6099abe73a854a
author Ed L. Cashin <ecashin@coraid.com> Thu, 29 Sep 2005 12:47:40 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:47:58 -0700

 drivers/block/aoe/aoecmd.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index b5be4b7..5c9c7c1 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <asm/unaligned.h>
 #include "aoe.h"
 
 #define TIMERTICK (HZ / 10)
@@ -311,16 +312,16 @@ ataid_complete(struct aoedev *d, unsigne
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
@@ -331,12 +332,12 @@ ataid_complete(struct aoedev *d, unsigne
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

