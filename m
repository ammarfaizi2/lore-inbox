Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265168AbUGCRmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUGCRmc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 13:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUGCRmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 13:42:32 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:13787 "EHLO
	mailfe08.swip.net") by vger.kernel.org with ESMTP id S265168AbUGCRma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 13:42:30 -0400
X-T2-Posting-ID: mzHRUpvOlCbvaGn327Befg==
Date: Sat, 3 Jul 2004 19:28:43 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: linux-kernel@vger.kernel.org
Cc: pavel@suse.cz
Subject: [PATCH] kernel/power/swsusp.c
Message-ID: <20040703172843.GA7274@linux.nu>
Reply-To: erik@rigtorp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Swsusp allocates a vt before it nows if it will need it. This interferes
with bootsplash. Here is a patch that moves the pm_prepare_console() call
so that its only executed if swsusp finds a valid image to resume.

diff -Nru linux-2.6.7/kernel/power/swsusp.c linux-2.6.7-swsusp/kernel/power/swsusp.c
--- linux-2.6.7/kernel/power/swsusp.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.7-swsusp/kernel/power/swsusp.c	2004-07-03 19:01:28.000000000 +0200
@@ -1067,6 +1069,9 @@
 	printk( "%sSignature found, resuming\n", name_resume );
 	MDELAY(1000);
 
+   	if (pm_prepare_console())
+		printk("swsusp: Can't allocate a console... proceeding\n");
+   
 	if (bdev_read_page(bdev, next.val, cur)) return -EIO;
 	if (sanity_check(&cur->sh)) 	/* Is this same machine? */	
 		return -EPERM;
@@ -1190,9 +1195,6 @@
 	}
 	MDELAY(1000);
 
-	if (pm_prepare_console())
-		printk("swsusp: Can't allocate a console... proceeding\n");
-
 	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
 		printk( "suspension device unspecified\n" );
 		return -EINVAL;
@@ -1206,7 +1208,6 @@
 	panic("This never returns");
 
 read_failure:
-	pm_restore_console();
 	return 0;
 }
