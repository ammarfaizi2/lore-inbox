Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUIWPBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUIWPBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUIWPBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:01:17 -0400
Received: from styx.suse.cz ([82.119.242.94]:14209 "EHLO shadow.suse.cz")
	by vger.kernel.org with ESMTP id S266910AbUIWO7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 10:59:46 -0400
Date: Thu, 23 Sep 2004 17:00:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: [patch] Fix too stricts sanity checks in FATfs
Message-ID: <20040923150016.GA3167@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a too strict sanity check in the FAT code, allowing
to mount the flash memory in Nokia phones, as well as in several
other devices.

The FAT standard allows for the first entries to be -1 to -8 in the
n-bit encoding, however Linux currently insists on -1 only.

--- linus/fs/fat/inode.c	2004-08-25 11:34:17.665758665 +0200
+++ input/fs/fat/inode.c	2004-08-25 11:23:47.000000000 +0200
@@ -999,11 +999,12 @@
 		error = first;
 		goto out_fail;
 	}
-	if (FAT_FIRST_ENT(sb, media) == first) {
-		/* all is as it should be */
-	} else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xfe) == first) {
+
+	if ((FAT_FIRST_ENT(sb, media) | 0x03) == first) {
+		/* all is as it should be: -1 to -8 */
+	} else if (media == 0xf8 && (FAT_FIRST_ENT(sb, 0xfe) | 0x03) == first) {
 		/* bad, reported on pc9800 */
-	} else if (media == 0xf0 && FAT_FIRST_ENT(sb, 0xf8) == first) {
+	} else if (media == 0xf0 && (FAT_FIRST_ENT(sb, 0xf8) | 0x03) == first) {
 		/* bad, reported with a MO disk on win95/me */
 	} else if (first == 0) {
 		/* bad, reported with a SmartMedia card */

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
