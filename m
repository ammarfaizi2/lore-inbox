Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264082AbUEHKxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUEHKxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUEHKxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:53:24 -0400
Received: from ns.suse.de ([195.135.220.2]:18095 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264082AbUEHKxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:53:12 -0400
Date: Sat, 8 May 2004 12:53:11 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: how long does it take to init the scheduler?
Message-ID: <20040508105311.GA15577@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

the patch below looks wrong to me. Why did you move it to the very end
of the boot process, instead to the very end of start_kernel()?

Now drivers will find an empty rootfs. A few of them do want to read
files from there. They cant currently use the call_usermodehelper
interface because this one checks for system_state. So they have to use
sys_open(). But either way, they will not get anything with 2.6.6.

populate_rootfs() should run before do_initcalls().



#date: 2004-04-21
#id: 1.1371.737.7
#tag: via-mm
#time: 07:42:18
#title: Call populate_rootfs later in boot
#who: akpm@osdl.org[torvalds]
#
# ChangeSet
#   1.1371.737.7 04/04/21 07:42:18 akpm@osdl.org[torvalds] +1 -0
#   [PATCH] Call populate_rootfs later in boot
#   
#   populate_rootfs() is called rather early - before we've called init_idle().
#   
#   But populate_rootfs() does file I/O, which involves calls to cond_resched(),
#   and downing of semaphores, etc.  If it scheules, the scheduler emits
#   scheduling-while-atomic warnings and sometimes oopses.
#   
#   So run populate_rootfs() later, after the scheduler is all set up.
#
# init/main.c +10 -11
#
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Wed Apr 28 10:54:47 2004
+++ b/init/main.c	Wed Apr 28 10:54:48 2004
@@ -89,6 +89,7 @@
 extern void free_initmem(void);
 extern void populate_rootfs(void);
 extern void driver_init(void);
+extern void prepare_namespace(void);
 
 #ifdef CONFIG_TC
 extern void tc_init(void);
@@ -471,7 +472,6 @@
 	signals_init();
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
-	populate_rootfs();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
@@ -577,8 +577,6 @@
 	execve(init_filename, argv_init, envp_init);
 }
 
-extern void prepare_namespace(void);
-
 static int init(void * unused)
 {
 	lock_kernel();
@@ -600,14 +598,15 @@
 	smp_init();
 	do_basic_setup();
 
-       /*
-        * check if there is an early userspace init, if yes
-        * let it do all the work
-        */
-       if (sys_access("/init", 0) == 0)
-               execute_command = "/init";
-       else
-	prepare_namespace();
+	populate_rootfs();
+	/*
+	 * check if there is an early userspace init.  If yes, let it do all
+	 * the work
+	 */
+	if (sys_access("/init", 0) == 0)
+		execute_command = "/init";
+	else
+		prepare_namespace();
 
 	/*
 	 * Ok, we have completed the initial bootup, and
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
