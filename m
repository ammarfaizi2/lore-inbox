Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSIBIRW>; Mon, 2 Sep 2002 04:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSIBIRW>; Mon, 2 Sep 2002 04:17:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12432 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318229AbSIBIRT>;
	Mon, 2 Sep 2002 04:17:19 -0400
Date: Mon, 2 Sep 2002 13:47:19 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Enable kernel profiling with stepping of 1
Message-ID: <20020902134718.A21466@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the builtin profiler doesn't work with profile=0. The following
patch fixes it.

Details:
The "profile" kernel parameter is used to determine the profile step
of the builtin profiler.  Value passed denotes the 'prof_shift' that is 
used to allocate the profiling buffer. If param profile=1, prof_shift=1 
and the profiling buffer is half the size of kernel text; 2 insns hash on to
the same bucket and the profiling step is 2.
(bufsize = kernel_text_size >> prof_shift; step = 1 << prof_shift)
The foll patch enables profiling even when prof_shift=0.  If profile
parameter is missing at boot time, profiling is turned off.

Patch applies on 2.5.33, tested on PIII 8way.  Works fine and doesn't 
break userspace readprofile. Should work for all archs. 

Profiling with step=1 will help us do insn level profiling with better
granularity using readprofile hacks (like the one by tridge).  Pls apply.

-Kiran


diff -ruN -X /home/kiran/dontdiff linux-2.5.33/fs/proc/proc_misc.c readprofile-2.5.33/fs/proc/proc_misc.c
--- linux-2.5.33/fs/proc/proc_misc.c	Sat Aug 31 15:04:50 2002
+++ readprofile-2.5.33/fs/proc/proc_misc.c	Mon Sep  2 00:06:08 2002
@@ -634,7 +634,7 @@
 		proc_root_kcore->size =
 				(size_t)high_memory - PAGE_OFFSET + PAGE_SIZE;
 	}
-	if (prof_shift) {
+	if (prof_on) {
 		entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL);
 		if (entry) {
 			entry->proc_fops = &proc_profile_operations;
diff -ruN -X /home/kiran/dontdiff linux-2.5.33/include/linux/sched.h readprofile-2.5.33/include/linux/sched.h
--- linux-2.5.33/include/linux/sched.h	Sat Aug 31 15:04:49 2002
+++ readprofile-2.5.33/include/linux/sched.h	Mon Sep  2 00:06:08 2002
@@ -500,6 +500,7 @@
 extern unsigned int * prof_buffer;
 extern unsigned long prof_len;
 extern unsigned long prof_shift;
+extern int prof_on;
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
diff -ruN -X /home/kiran/dontdiff linux-2.5.33/init/main.c readprofile-2.5.33/init/main.c
--- linux-2.5.33/init/main.c	Sat Aug 31 15:04:51 2002
+++ readprofile-2.5.33/init/main.c	Mon Sep  2 00:06:08 2002
@@ -135,8 +135,11 @@
 
 static int __init profile_setup(char *str)
 {
-    int par;
-    if (get_option(&str,&par)) prof_shift = par;
+	int par;
+	if (get_option(&str,&par)) {
+		prof_shift = par;
+		prof_on = 1;
+	}
 	return 1;
 }
 
@@ -413,7 +416,7 @@
 #ifdef CONFIG_MODULES
 	init_modules();
 #endif
-	if (prof_shift) {
+	if (prof_on) {
 		unsigned int size;
 		/* only text is profiled */
 		prof_len = (unsigned long) &_etext - (unsigned long) &_stext;
diff -ruN -X /home/kiran/dontdiff linux-2.5.33/kernel/timer.c readprofile-2.5.33/kernel/timer.c
--- linux-2.5.33/kernel/timer.c	Sat Aug 31 15:04:54 2002
+++ readprofile-2.5.33/kernel/timer.c	Mon Sep  2 00:06:08 2002
@@ -79,6 +79,7 @@
 unsigned int * prof_buffer;
 unsigned long prof_len;
 unsigned long prof_shift;
+int prof_on;
 
 /*
  * Event timer code
