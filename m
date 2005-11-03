Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbVKCPT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbVKCPT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVKCPT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:19:29 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:35017 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030330AbVKCPT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:19:28 -0500
Date: Thu, 3 Nov 2005 16:19:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: don't modify journaled volume
Message-ID: <Pine.LNX.4.61.0511031617090.12843@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Until support for HFS+ journaling is supported and the journal can be 
replayed, don't modify a journaled volume.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 fs/hfsplus/hfsplus_raw.h |   12 +++++++-----
 fs/hfsplus/super.c       |    8 ++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

Index: linux-2.6/fs/hfsplus/hfsplus_raw.h
===================================================================
--- linux-2.6.orig/fs/hfsplus/hfsplus_raw.h	2005-11-03 16:15:40.000000000 +0100
+++ linux-2.6/fs/hfsplus/hfsplus_raw.h	2005-11-03 16:15:44.000000000 +0100
@@ -123,11 +123,13 @@ struct hfsplus_vh {
 } __packed;
 
 /* HFS+ volume attributes */
-#define HFSPLUS_VOL_UNMNT     (1 << 8)
-#define HFSPLUS_VOL_SPARE_BLK (1 << 9)
-#define HFSPLUS_VOL_NOCACHE   (1 << 10)
-#define HFSPLUS_VOL_INCNSTNT  (1 << 11)
-#define HFSPLUS_VOL_SOFTLOCK  (1 << 15)
+#define HFSPLUS_VOL_UNMNT		(1 << 8)
+#define HFSPLUS_VOL_SPARE_BLK		(1 << 9)
+#define HFSPLUS_VOL_NOCACHE		(1 << 10)
+#define HFSPLUS_VOL_INCNSTNT		(1 << 11)
+#define HFSPLUS_VOL_NODEID_REUSED	(1 << 12)
+#define HFSPLUS_VOL_JOURNALED		(1 << 13)
+#define HFSPLUS_VOL_SOFTLOCK		(1 << 15)
 
 /* HFS+ BTree node descriptor */
 struct hfs_bnode_desc {
Index: linux-2.6/fs/hfsplus/super.c
===================================================================
--- linux-2.6.orig/fs/hfsplus/super.c	2005-11-03 16:15:40.000000000 +0100
+++ linux-2.6/fs/hfsplus/super.c	2005-11-03 16:15:44.000000000 +0100
@@ -262,6 +262,10 @@ static int hfsplus_remount(struct super_
 			printk("HFS+-fs: Filesystem is marked locked, leaving read-only.\n");
 			sb->s_flags |= MS_RDONLY;
 			*flags |= MS_RDONLY;
+		} else if (vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_JOURNALED)) {
+			printk("HFS+-fs: Filesystem is marked journaled, leaving read-only.\n");
+			sb->s_flags |= MS_RDONLY;
+			*flags |= MS_RDONLY;
 		}
 	}
 	return 0;
@@ -357,6 +361,10 @@ static int hfsplus_fill_super(struct sup
 		if (!silent)
 			printk("HFS+-fs: Filesystem is marked locked, mounting read-only.\n");
 		sb->s_flags |= MS_RDONLY;
+	} else if (vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_JOURNALED)) {
+		if (!silent)
+			printk("HFS+-fs: Filesystem is marked journaled, mounting read-only.\n");
+		sb->s_flags |= MS_RDONLY;
 	}
 
 	/* Load metadata objects (B*Trees) */
