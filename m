Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWJKQ3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWJKQ3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWJKQ2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:28:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51364 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161114AbWJKQ2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:28:38 -0400
To: torvalds@osdl.org
Subject: [PATCH] amiga_floppy_init() in non-modular case
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1GXgwf-0005hW-Ac@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:28:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It used to be called directly, but that got lost in 2.1.87-pre1.
Similar breakage in ataflop got fixed 3 years ago, this one
had gone unnoticed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/block/amiflop.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 5d254b7..5d65621 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1709,10 +1709,13 @@ static struct kobject *floppy_find(dev_t
 	return get_disk(unit[drive].gendisk);
 }
 
-int __init amiga_floppy_init(void)
+static int __init amiga_floppy_init(void)
 {
 	int i, ret;
 
+	if (!MACH_IS_AMIGA)
+		return -ENXIO;
+
 	if (!AMIGAHW_PRESENT(AMI_FLOPPY))
 		return -ENXIO;
 
@@ -1809,15 +1812,9 @@ out_blkdev:
 	return ret;
 }
 
+module_init(amiga_floppy_init);
 #ifdef MODULE
 
-int init_module(void)
-{
-	if (!MACH_IS_AMIGA)
-		return -ENXIO;
-	return amiga_floppy_init();
-}
-
 #if 0 /* not safe to unload */
 void cleanup_module(void)
 {
-- 
1.4.2.GIT


