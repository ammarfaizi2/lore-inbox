Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbSJRJOp>; Fri, 18 Oct 2002 05:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSJRJOo>; Fri, 18 Oct 2002 05:14:44 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:62181 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263152AbSJRJOn>;
	Fri, 18 Oct 2002 05:14:43 -0400
Date: Fri, 18 Oct 2002 14:54:56 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Allow for profile_buf size = kernel text size
Message-ID: <20021018145456.A2749@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
The following patch enables the kernel profiler to set up profiling
buffer equal to the kernel text size.  It is particularly useful
while doing insn level profiling on archs with variable sized instructions.
There is a better possiblity of ticks being attributed to the right
instructions if the profiling granularity is better. Patch applies neatly on
2.5.43 and 2.5.43-mm2. Tested well on PIII 4way.  Please apply.

-Kiran


diff -X dontdiff -ruN linux-2.5.43/fs/proc/proc_misc.c readprofile-2.5.43/fs/proc/proc_misc.c
--- linux-2.5.43/fs/proc/proc_misc.c	Wed Oct 16 08:57:18 2002
+++ readprofile-2.5.43/fs/proc/proc_misc.c	Fri Oct 18 10:13:44 2002
@@ -648,7 +648,7 @@
 		proc_root_kcore->size =
 				(size_t)high_memory - PAGE_OFFSET + PAGE_SIZE;
 	}
-	if (prof_shift) {
+	if (prof_on) {
 		entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL);
 		if (entry) {
 			entry->proc_fops = &proc_profile_operations;
diff -X dontdiff -ruN linux-2.5.43/include/linux/profile.h readprofile-2.5.43/include/linux/profile.h
--- linux-2.5.43/include/linux/profile.h	Wed Oct 16 08:58:20 2002
+++ readprofile-2.5.43/include/linux/profile.h	Thu Oct 17 16:58:56 2002
@@ -17,6 +17,7 @@
 extern unsigned int * prof_buffer;
 extern unsigned long prof_len;
 extern unsigned long prof_shift;
+extern int prof_on;
 
 
 enum profile_type {
diff -X dontdiff -ruN linux-2.5.43/kernel/profile.c readprofile-2.5.43/kernel/profile.c
--- linux-2.5.43/kernel/profile.c	Wed Oct 16 08:59:04 2002
+++ readprofile-2.5.43/kernel/profile.c	Thu Oct 17 17:00:27 2002
@@ -14,12 +14,15 @@
 unsigned int * prof_buffer;
 unsigned long prof_len;
 unsigned long prof_shift;
+int prof_on;
 
 int __init profile_setup(char * str)
 {
 	int par;
-	if (get_option(&str,&par))
+	if (get_option(&str,&par)) {
 		prof_shift = par;
+		prof_on = 1;
+	}
 	return 1;
 }
 
@@ -28,7 +31,7 @@
 {
 	unsigned int size;
  
-	if (!prof_shift) 
+	if (!prof_on) 
 		return;
  
 	/* only text is profiled */
