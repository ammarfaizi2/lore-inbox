Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbTBJBiS>; Sun, 9 Feb 2003 20:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbTBJBhH>; Sun, 9 Feb 2003 20:37:07 -0500
Received: from dp.samba.org ([66.70.73.150]:55213 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267507AbTBJBg5>;
	Sun, 9 Feb 2003 20:36:57 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] swsusp: do not panic on bad signature with noresume
Date: Mon, 10 Feb 2003 12:41:10 +1100
Message-Id: <20030210014642.45B902C2AA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Pavel Machek <pavel@ucw.cz>

  Hi!
  
  This patch makes kernel ignore bad signature on suspend device when
  "noresume" is given, and cleans things up a little bit. Please apply,
  
  								Pavel
  

--- trivial-2.5.59-bk3/kernel/suspend.c.orig	2003-02-10 12:29:57.000000000 +1100
+++ trivial-2.5.59-bk3/kernel/suspend.c	2003-02-10 12:29:57.000000000 +1100
@@ -1084,12 +1084,12 @@
 	else if (!memcmp("S2",cur->swh.magic.magic,2))
 		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 	else {
+		if (noresume)
+			return -EINVAL;
 		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
 			name_resume, cur->swh.magic.magic);
-		/* We want to panic even with noresume -- we certainly don't want to add
-		   out signature into your ext2 filesystem ;-) */
 	}
-	if(noresume) {
+	if (noresume) {
 		/* We don't do a sanity check here: we want to restore the swap
 		   whatever version of kernel made the suspend image;
 		   We need to write swap, but swap is *not* enabled so
@@ -1207,11 +1207,11 @@
 	/* We enable the possibility of machine suspend */
 	software_suspend_enabled = 1;
 #endif
-	if(!resume_status)
+	if (!resume_status)
 		return;
 
 	printk( "%s", name_resume );
-	if(resume_status == NORESUME) {
+	if (resume_status == NORESUME) {
 		if(resume_file[0])
 			read_suspend_image(resume_file, 1);
 		printk( "disabled\n" );
@@ -1240,7 +1240,7 @@
 
 static int __init resume_setup(char *str)
 {
-	if(resume_status)
+	if (resume_status == NORESUME)
 		return 1;
 
 	strncpy( resume_file, str, 255 );
@@ -1249,16 +1249,13 @@
 	return 1;
 }
 
-static int __init software_noresume(char *str)
+static int __init noresume_setup(char *str)
 {
-	if(!resume_status)
-		printk(KERN_WARNING "noresume option lacks a resume= option\n");
 	resume_status = NORESUME;
-	
 	return 1;
 }
 
-__setup("noresume", software_noresume);
+__setup("noresume", noresume_setup);
 __setup("resume=", resume_setup);
 
 EXPORT_SYMBOL(software_suspend);
-- 
  Don't blame me: the Monkey is driving
  File: Pavel Machek <pavel@ucw.cz>: swsusp: do not panic on bad signature with noresume
