Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbTBCT7a>; Mon, 3 Feb 2003 14:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbTBCT6V>; Mon, 3 Feb 2003 14:58:21 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3844 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267023AbTBCTyz>;
	Mon, 3 Feb 2003 14:54:55 -0500
Date: Mon, 3 Feb 2003 18:31:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: swsusp: do not panic on bad signature with noresume
Message-ID: <20030203173153.GA339@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch makes kernel ignore bad signature on suspend device when
"noresume" is given, and cleans things up a little bit. Please apply,

								Pavel

--- clean/kernel/suspend.c	2003-01-17 23:12:24.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2003-02-03 17:51:25.000000000 +0100
@@ -1085,12 +1087,12 @@
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
@@ -1208,11 +1210,11 @@
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
@@ -1241,7 +1243,7 @@
 
 static int __init resume_setup(char *str)
 {
-	if(resume_status)
+	if (resume_status == NORESUME)
 		return 1;
 
 	strncpy( resume_file, str, 255 );
@@ -1250,16 +1252,13 @@
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
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
