Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUILCs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUILCs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 22:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUILCs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 22:48:28 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:1488 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S268410AbUILCsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 22:48:17 -0400
Date: Sat, 11 Sep 2004 19:48:10 -0700
Message-Id: <200409120248.i8C2mAeW025899@magilla.sf.frob.com>
From: Roland McGrath <roland@frob.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] BSD disklabel: handle more than 8 partitions
Emacs: because editing your files should be a traumatic experience.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NetBSD allows 16 partitions, not just 8.  This patch both ups the number,
and makes the recognition code tell you if the count in the disklabel
exceeds the number supported by the kernel.


Thanks,
Roland


Index: linux-2.6/include/linux/genhd.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/genhd.h,v
retrieving revision 1.51
diff -b -p -u -r1.51 genhd.h
--- linux-2.6/include/linux/genhd.h 24 Aug 2004 18:28:31 -0000 1.51
+++ linux-2.6/include/linux/genhd.h 12 Sep 2004 01:25:58 -0000
@@ -249,7 +249,7 @@ struct solaris_x86_vtoc {
 /* check against BSD src/sys/sys/disklabel.h for consistency */
 
 #define BSD_DISKMAGIC	(0x82564557UL)	/* The disk magic number */
-#define BSD_MAXPARTITIONS	8
+#define BSD_MAXPARTITIONS	16
 #define OPENBSD_MAXPARTITIONS	16
 #define BSD_FS_UNUSED		0	/* disklabel unused partition entry ID */
 struct bsd_disklabel {
Index: linux-2.6/fs/partitions/msdos.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/partitions/msdos.c,v
retrieving revision 1.25
diff -b -p -u -r1.25 msdos.c
--- linux-2.6/fs/partitions/msdos.c 24 Jun 2004 16:50:56 -0000 1.25
+++ linux-2.6/fs/partitions/msdos.c 12 Sep 2004 01:34:35 -0000
@@ -246,6 +246,9 @@ parse_bsd(struct parsed_partitions *stat
 		put_partition(state, state->next++, bsd_start, bsd_size);
 	}
 	put_dev_sector(sect);
+	if (le16_to_cpu(l->d_npartitions) > max_partitions)
+		printk(" (ignored %d more)",
+		       le16_to_cpu(l->d_npartitions) - max_partitions);
 	printk(" >\n");
 }
 #endif
