Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVFALsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVFALsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVFALsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:48:37 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:17166 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261334AbVFALsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:48:20 -0400
Date: Wed, 1 Jun 2005 12:48:18 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, oprofile-list@lists.sf.net
Subject: [PATCH] oprofile: report anonymous region samples
Message-ID: <20050601114818.GA52052@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-UoM: Scanned by the University Mail System. See http://www.mcc.ac.uk/cos/email/scanning for details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The below patch passes samples from anonymous regions to userspace
instead of just dropping them. This provides the support needed for
reporting anonymous-region code samples (today: basic accumulated
results; later: Java and other dynamically compiled code).

As this changes the format, an upgrade to the just-released 0.9 release
of the userspace tools is required.

This patch is based upon an earlier one by Will Cohen <wcohen@redhat.com>

thanks,
john

Signed-off-by: John Levon <levon@movementarian.org>

Index: linux-cvs/drivers/oprofile/buffer_sync.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/buffer_sync.c,v
retrieving revision 1.30
diff -u -a -p -u -r1.30 buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	14 Mar 2005 00:32:33 -0000	1.30
+++ linux-cvs/drivers/oprofile/buffer_sync.c	26 Apr 2005 13:20:24 -0000
@@ -206,7 +206,7 @@ static inline unsigned long fast_get_dco
  */
 static unsigned long get_exec_dcookie(struct mm_struct * mm)
 {
-	unsigned long cookie = 0;
+	unsigned long cookie = NO_COOKIE;
 	struct vm_area_struct * vma;
  
 	if (!mm)
@@ -234,35 +234,42 @@ out:
  */
 static unsigned long lookup_dcookie(struct mm_struct * mm, unsigned long addr, off_t * offset)
 {
-	unsigned long cookie = 0;
+	unsigned long cookie = NO_COOKIE;
 	struct vm_area_struct * vma;
 
 	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
  
-		if (!vma->vm_file)
-			continue;
-
 		if (addr < vma->vm_start || addr >= vma->vm_end)
 			continue;
 
-		cookie = fast_get_dcookie(vma->vm_file->f_dentry,
-			vma->vm_file->f_vfsmnt);
-		*offset = (vma->vm_pgoff << PAGE_SHIFT) + addr - vma->vm_start; 
+		if (vma->vm_file) {
+			cookie = fast_get_dcookie(vma->vm_file->f_dentry,
+				vma->vm_file->f_vfsmnt);
+			*offset = (vma->vm_pgoff << PAGE_SHIFT) + addr -
+				vma->vm_start; 
+		} else {
+			/* must be an anonymous map */
+			*offset = addr;
+		}
+
 		break;
 	}
 
+	if (!vma)
+		cookie = INVALID_COOKIE;
+
 	return cookie;
 }
 
 
-static unsigned long last_cookie = ~0UL;
+static unsigned long last_cookie = INVALID_COOKIE;
  
 static void add_cpu_switch(int i)
 {
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(CPU_SWITCH_CODE);
 	add_event_entry(i);
-	last_cookie = ~0UL;
+	last_cookie = INVALID_COOKIE;
 }
 
 static void add_kernel_ctx_switch(unsigned int in_kernel)
@@ -317,7 +324,7 @@ static int add_us_sample(struct mm_struc
  
  	cookie = lookup_dcookie(mm, s->eip, &offset);
  
-	if (!cookie) {
+	if (cookie == INVALID_COOKIE) {
 		atomic_inc(&oprofile_stats.sample_lost_no_mapping);
 		return 0;
 	}
Index: linux-cvs/drivers/oprofile/event_buffer.h
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/event_buffer.h,v
retrieving revision 1.7
diff -u -a -p -u -r1.7 event_buffer.h
--- linux-cvs/drivers/oprofile/event_buffer.h	5 Jan 2005 05:41:45 -0000	1.7
+++ linux-cvs/drivers/oprofile/event_buffer.h	23 Apr 2005 22:19:30 -0000
@@ -35,6 +35,9 @@ void wake_up_buffer_waiter(void);
 #define TRACE_BEGIN_CODE		8
 #define TRACE_END_CODE			9
  
+#define INVALID_COOKIE ~0UL
+#define NO_COOKIE 0UL
+
 /* add data to the event buffer */
 void add_event_entry(unsigned long data);
  
Index: linux-cvs/Documentation/Changes
===================================================================
RCS file: /home/moz/cvs//linux-2.5/Documentation/Changes,v
retrieving revision 1.54
diff -u -a -p -u -r1.54 Changes
--- linux-cvs/Documentation/Changes	7 Mar 2005 01:04:35 -0000	1.54
+++ linux-cvs/Documentation/Changes	2 May 2005 20:36:02 -0000
@@ -63,7 +63,7 @@ o  PPP                    2.4.0         
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
 o  nfs-utils              1.0.5                   # showmount --version
 o  procps                 3.2.0                   # ps --version
-o  oprofile               0.5.3                   # oprofiled --version
+o  oprofile               0.9                     # oprofiled --version
 
 Kernel compilation
 ==================
Index: linux-cvs/Documentation/basic_profiling.txt
===================================================================
RCS file: /home/moz/cvs//linux-2.5/Documentation/basic_profiling.txt,v
retrieving revision 1.3
diff -u -a -p -u -r1.3 basic_profiling.txt
--- linux-cvs/Documentation/basic_profiling.txt	24 Jun 2004 16:21:46 -0000	1.3
+++ linux-cvs/Documentation/basic_profiling.txt	2 May 2005 20:35:52 -0000
@@ -27,9 +27,13 @@ dump output	readprofile -m /boot/System.
 
 Oprofile
 --------
-Get the source (I use 0.8) from http://oprofile.sourceforge.net/
-and add "idle=poll" to the kernel command line
+
+Get the source (see Changes for required version) from
+http://oprofile.sourceforge.net/ and add "idle=poll" to the kernel command
+line.
+
 Configure with CONFIG_PROFILING=y and CONFIG_OPROFILE=y & reboot on new kernel
+
 ./configure --with-kernel-support
 make install
 
@@ -46,7 +50,7 @@ start		opcontrol --start
 stop		opcontrol --stop
 dump output	opreport >  output_file
 
-To only report on the kernel, run opreport /boot/vmlinux > output_file
+To only report on the kernel, run opreport -l /boot/vmlinux > output_file
 
 A reset is needed to clear old statistics, which survive a reboot.
 
