Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965371AbWI0GDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965371AbWI0GDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965370AbWI0GDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:03:41 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:50149 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965364AbWI0GDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:03:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 4/5] swsusp: Add resume_offset command line parameter (rev. 2)
Date: Wed, 27 Sep 2006 07:34:54 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200609270720.28131.rjw@sisk.pl>
In-Reply-To: <200609270720.28131.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609270734.54590.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the kernel command line parameter "resume_offset=" allowing us to specify
the offset, in <PAGE_SIZE> units, from the beginning of the partition pointed
to by the "resume=" parameter at which the swap header is located.

This offset can be determined, for example, by an application using the FIBMAP
ioctl to obtain the swap header's block number for given file.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
  kernel/power/disk.c  |   15 +++++++++++++++
 kernel/power/power.h |    1 +
 kernel/power/swap.c  |   15 ++++++++++-----
 3 files changed, 26 insertions(+), 5 deletions(-)

Index: linux-2.6.18-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/power/disk.c
+++ linux-2.6.18-mm1/kernel/power/disk.c
@@ -27,6 +27,7 @@
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
+sector_t swsusp_resume_block;
 
 /**
  *	power_down - Shut machine down for hibernate.
@@ -404,6 +405,19 @@ static int __init resume_setup(char *str
 	return 1;
 }
 
+static int __init resume_offset_setup(char *str)
+{
+	sector_t offset;
+
+	if (noresume)
+		return 1;
+
+	if (sscanf(str, "%llu", &offset) == 1)
+		swsusp_resume_block = offset;
+
+	return 1;
+}
+
 static int __init noresume_setup(char *str)
 {
 	noresume = 1;
@@ -411,4 +425,5 @@ static int __init noresume_setup(char *s
 }
 
 __setup("noresume", noresume_setup);
+__setup("resume_offset=", resume_offset_setup);
 __setup("resume=", resume_setup);
Index: linux-2.6.18-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.18-mm1.orig/kernel/power/power.h
+++ linux-2.6.18-mm1/kernel/power/power.h
@@ -42,6 +42,7 @@ extern const void __nosave_begin, __nosa
 extern unsigned long image_size;
 extern int in_suspend;
 extern dev_t swsusp_resume_device;
+extern sector_t swsusp_resume_block;
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
Index: linux-2.6.18-mm1/kernel/power/swap.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/power/swap.c
+++ linux-2.6.18-mm1/kernel/power/swap.c
@@ -160,13 +160,14 @@ static int mark_swapfiles(sector_t start
 {
 	int error;
 
-	bio_read_page(0, &swsusp_header, NULL);
+	bio_read_page(swsusp_resume_block, &swsusp_header, NULL);
 	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
 	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
 		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
 		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
 		swsusp_header.image = start;
-		error = bio_write_page(0, &swsusp_header, NULL);
+		error = bio_write_page(swsusp_resume_block,
+					&swsusp_header, NULL);
 	} else {
 		printk(KERN_ERR "swsusp: Swap header not found!\n");
 		error = -ENODEV;
@@ -183,7 +184,7 @@ static int swsusp_swap_check(void) /* Th
 {
 	int res;
 
-	res = swap_type_of(swsusp_resume_device, 0);
+	res = swap_type_of(swsusp_resume_device, swsusp_resume_block);
 	if (res < 0)
 		return res;
 
@@ -609,12 +610,16 @@ int swsusp_check(void)
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
 		memset(&swsusp_header, 0, sizeof(swsusp_header));
-		if ((error = bio_read_page(0, &swsusp_header, NULL)))
+		error = bio_read_page(swsusp_resume_block,
+					&swsusp_header, NULL);
+		if (error)
 			return error;
+
 		if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
 			memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
 			/* Reset swap signature now */
-			error = bio_write_page(0, &swsusp_header, NULL);
+			error = bio_write_page(swsusp_resume_block,
+						&swsusp_header, NULL);
 		} else {
 			return -EINVAL;
 		}

