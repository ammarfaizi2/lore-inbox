Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbTIJSK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265406AbTIJSK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:10:58 -0400
Received: from gprs145-173.eurotel.cz ([160.218.145.173]:8322 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265405AbTIJSKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:10:53 -0400
Date: Wed, 10 Sep 2003 20:10:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
Message-ID: <20030910181019.GD2589@elf.ucw.cz>
References: <Pine.LNX.4.44.0309091726050.695-100000@cherise>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309091726050.695-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> <mochel@osdl.org> (03/09/09 1.1217.3.31)
>    [power] Revert swsusp to 2.6.0-test3 state.
>    
>    - From Pavel (mostly, though with some fixups).
>    - Note that I would never publically admit to putting such code into the 
>      kernel. 
>    - Someone ought to really review this patch some day. 

@@ -6,11 +6,12 @@
 #include <asm/desc.h>
 #include <asm/i387.h>

-static inline void
+static inline int
 arch_prepare_suspend(void)
 {
        if (!cpu_has_pse)
-               panic("pse required");
+               return -EPERM;
+       return 0;
 }

 /* image of the saved processor state */

You still want to do some printk(), otherwise we'll get very ugly bug
reports ("it does not suspend and I don't know why"). Also without
check in swsusp.c, this could corrupt data (page table accessed bits
might flip something during copy).

--- /usr/src/tmp/linux/kernel/power/swsusp.c	2003-09-10 19:58:08.000000000 +0200
+++ /usr/src/linux/kernel/power/swsusp.c	2003-09-10 19:57:16.000000000 +0200
@@ -697,7 +697,8 @@
 static void do_software_suspend(void)
 {
 	printk("Doing software_suspend()\n");
-	arch_prepare_suspend();
+	if (arch_prepare_suspend())
+		return;
 	if (pm_prepare_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {


Minor nits:

--- linux-2.5-virgin/kernel/power/pmdisk.c      Wed Dec 31 16:00:00 1969
+++ linux-2.5-power/kernel/power/pmdisk.c       Tue Sep  9 13:54:33 2003
@@ -0,0 +1,942 @@
+/*
+ * kernel/power/pmdisk.c - Suspend-to-disk implmentation
                                                ~ missing 'e'


+                               /* we ignore all swap devices that are
not the resume_file */
+                               if (1) {
+// FIXME                               if(resume_device ==
swap_info[i].swap_device) {
+                                       swapfile_used[i] =
SWAPFILE_SUSPEND;

If you want this FIXME fixed, I got patch from Aristeu Sergio Rozanski
Filho <aris@cathedrallabs.org>. Not yet tested, that's why I was
holding it. (attached).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="delme_swsusp-swap_name.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1291  -> 1.1292 
#	kernel/power/swsusp.c	1.58    -> 1.59   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/28	aris@cathedrallabs.org	1.1292
# o only use swap device specified in resume= option
# --------------------------------------------
#
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	Thu Aug 28 21:07:20 2003
+++ b/kernel/power/swsusp.c	Thu Aug 28 21:07:20 2003
@@ -216,6 +216,7 @@
 static void read_swapfiles(void) /* This is called before saving image */
 {
 	int i, len;
+	char buff[sizeof(resume_file)], *sname;
 	
 	len=strlen(resume_file);
 	root_swap = 0xFFFF;
@@ -234,8 +235,11 @@
 					swapfile_used[i] = SWAPFILE_IGNORED;				  
 			} else {
 	  			/* we ignore all swap devices that are not the resume_file */
-				if (1) {
-// FIXME				if(resume_device == swap_info[i].swap_device) {
+				sname = d_path(swap_info[i].swap_file->f_dentry,
+					       swap_info[i].swap_file->f_vfsmnt,
+					       buff,
+					       sizeof(buff));
+				if (!strcmp(sname, resume_file)) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
 				} else {

--jRHKVT23PllUwdXP--
