Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTJZLIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbTJZLIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:08:17 -0500
Received: from hera.cwi.nl ([192.16.191.8]:21922 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263024AbTJZLIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:08:15 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 26 Oct 2003 12:08:08 +0100 (MET)
Message-Id: <UTC200310261108.h9QB88m25135.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@osdl.org
Subject: Re: Linux 2.6.0-test9
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pls forward.

The first FAT entry should have the media byte (0xf0,0xf8,...,0xff)
extended with all 1 bits in the first FAT entry.
Checking this is a good idea, it prevents us from mounting garbage
as FAT - there is no good magic for FAT.
Unfortunately, Windows does not enforce this, and 2.4 doesn't either.
It turns out that there are filesystems around (two reports so far)
that have a zero first FAT entry, and work under Windows and 2.4 but
fail to mount under 2.6.

So, the below weakens the test.

Andries

[one report was with a SmartMedia card, the other with an
Archos Jukebox Recorder 20]

diff -u --recursive --new-file -X /linux/dontdiff a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	Wed Oct 22 23:25:26 2003
+++ b/fs/fat/inode.c	Sun Oct 26 02:31:24 2003
@@ -964,13 +964,17 @@
 		error = first;
 		goto out_fail;
 	}
-	if (FAT_FIRST_ENT(sb, media) != first
-	    && (media != 0xf8 || FAT_FIRST_ENT(sb, 0xfe) != first)) {
-		if (!silent) {
+	if (FAT_FIRST_ENT(sb, media) == first) {
+		/* all is as it should be */
+	} else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xfe) == first) {
+		/* bad, reported on pc9800 */
+	} else if (first == 0) {
+		/* bad, reported with a SmartMedia card */
+	} else {
+		if (!silent)
 			printk(KERN_ERR "FAT: invalid first entry of FAT "
 			       "(0x%x != 0x%x)\n",
 			       FAT_FIRST_ENT(sb, media), first);
-		}
 		goto out_invalid;
 	}
 
