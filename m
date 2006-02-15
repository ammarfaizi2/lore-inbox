Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945935AbWBOOmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945935AbWBOOmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945919AbWBOOlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:41:52 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:34432 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932458AbWBOOlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:41:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 2/2] swsusp: fix writing progress meter
Date: Wed, 15 Feb 2006 14:51:17 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200602151434.03575.rjw@sisk.pl>
In-Reply-To: <200602151434.03575.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151451.17591.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the wrong value passed to load_image() in swap.c the writing progress
meter could run over 100%.  Fix it.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/swap.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

Index: linux-2.6.16-rc3-mm1/kernel/power/swap.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/kernel/power/swap.c	2006-02-14 23:08:49.000000000 +0100
+++ linux-2.6.16-rc3-mm1/kernel/power/swap.c	2006-02-14 23:09:26.000000000 +0100
@@ -467,7 +467,6 @@ int swsusp_read(void)
 	struct swap_map_handle handle;
 	struct snapshot_handle snapshot;
 	struct swsusp_info *header;
-	unsigned int nr_pages;
 
 	if (IS_ERR(resume_bdev)) {
 		pr_debug("swsusp: block device not initialised\n");
@@ -482,10 +481,8 @@ int swsusp_read(void)
 	error = get_swap_reader(&handle, swsusp_header.image);
 	if (!error)
 		error = swap_read_page(&handle, header);
-	if (!error) {
-		nr_pages = header->image_pages;
-		error = load_image(&handle, &snapshot, nr_pages);
-	}
+	if (!error)
+		error = load_image(&handle, &snapshot, header->pages - 1);
 	release_swap_reader(&handle);
 
 	blkdev_put(resume_bdev);
