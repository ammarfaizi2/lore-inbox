Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUIPRBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUIPRBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUIPRAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:00:49 -0400
Received: from dmz.tecosim.com ([195.135.152.162]:8369 "EHLO dmz.tecosim.de")
	by vger.kernel.org with ESMTP id S268592AbUIPQ4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:56:21 -0400
Date: Thu, 16 Sep 2004 18:56:13 +0200
From: Utz Lehmann <lkml@de.tecosim.com>
To: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: [PATCH] flexmmap: optimise mmap_base gap for hard limited stack
Message-ID: <20040916165613.GA10825@de.tecosim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

With the flexmmap memory layout there is at least a 128 MB gap between
mmap_base and TASK_SIZE. I think this is for the case that a running process
can expand it's stack soft rlimit.

If there is a hard limit for the stack this minium gap is just a waste of
space. This patch reduce the gap to the hard limit + 1 MB hole. If a process
has a 8192 KB hard limit it have additional 119 MB space available over the
current behavior.

And the current implemention has a problem. If the stack soft limit is
128+ MB there is no hole between the stack and mmap_base. If there is a
mapping at mmap_base stack overflows are not detected. The patch made a
1MB hole between them.

Tested only on x86.


Signed-off-by: Utz Lehmann <lkml@de.tecosim.com>

diff -Nrup linux-2.6.9-rc2/arch/i386/mm/mmap.c linux-2.6.9-rc2-gap/arch/i386/mm/mmap.c
--- linux-2.6.9-rc2/arch/i386/mm/mmap.c	2004-09-16 11:18:15.363366420 +0200
+++ linux-2.6.9-rc2-gap/arch/i386/mm/mmap.c	2004-09-16 16:01:13.197508592 +0200
@@ -30,10 +30,13 @@
 /*
  * Top of mmap area (just below the process stack).
  *
- * Leave an at least ~128 MB hole.
+ * Leave an at least 1 MB hole between stack and mmap_base.
+ * Leave an at least 128 MB gap between TASK_SIZE and mmap_base with a
+ * soft rlimit stack.
  */
-#define MIN_GAP (128*1024*1024)
-#define MAX_GAP (TASK_SIZE/6*5)
+#define MIN_HOLE (1*1024*1024)
+#define MIN_GAP (128*1024*1024 - MIN_HOLE)
+#define MAX_GAP (TASK_SIZE/6*5 - MIN_HOLE)
 
 static inline unsigned long mmap_base(struct mm_struct *mm)
 {
@@ -43,8 +46,10 @@ static inline unsigned long mmap_base(st
 		gap = MIN_GAP;
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
+	if (gap > current->rlim[RLIMIT_STACK].rlim_max)
+		gap = current->rlim[RLIMIT_STACK].rlim_max;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return TASK_SIZE - ((gap + MIN_HOLE) & PAGE_MASK);
 }
 
 /*
diff -Nrup linux-2.6.9-rc2/arch/ppc64/mm/mmap.c linux-2.6.9-rc2-gap/arch/ppc64/mm/mmap.c
--- linux-2.6.9-rc2/arch/ppc64/mm/mmap.c	2004-09-16 11:18:19.760799910 +0200
+++ linux-2.6.9-rc2-gap/arch/ppc64/mm/mmap.c	2004-09-16 16:37:44.995858703 +0200
@@ -30,10 +30,13 @@
 /*
  * Top of mmap area (just below the process stack).
  *
- * Leave an at least ~128 MB hole.
+ * Leave an at least 1 MB hole between stack and mmap_base.
+ * Leave an at least 128 MB gap between TASK_SIZE and mmap_base with a
+ * soft rlimit stack.
  */
-#define MIN_GAP (128*1024*1024)
-#define MAX_GAP (TASK_SIZE/6*5)
+#define MIN_HOLE (1*1024*1024)
+#define MIN_GAP (128*1024*1024 - MIN_HOLE)
+#define MAX_GAP (TASK_SIZE/6*5 - MIN_HOLE)
 
 static inline unsigned long mmap_base(void)
 {
@@ -43,8 +46,10 @@ static inline unsigned long mmap_base(vo
 		gap = MIN_GAP;
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
+	if (gap > current->rlim[RLIMIT_STACK].rlim_max)
+		gap = current->rlim[RLIMIT_STACK].rlim_max;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return TASK_SIZE - ((gap + MIN_HOLE) & PAGE_MASK);
 }
 
 static inline int mmap_is_legacy(void)
diff -Nrup linux-2.6.9-rc2/arch/s390/mm/mmap.c linux-2.6.9-rc2-gap/arch/s390/mm/mmap.c
--- linux-2.6.9-rc2/arch/s390/mm/mmap.c	2004-09-16 11:18:19.855787673 +0200
+++ linux-2.6.9-rc2-gap/arch/s390/mm/mmap.c	2004-09-16 16:37:59.459999725 +0200
@@ -30,10 +30,13 @@
 /*
  * Top of mmap area (just below the process stack).
  *
- * Leave an at least ~128 MB hole.
+ * Leave an at least 1 MB hole between stack and mmap_base.
+ * Leave an at least 128 MB gap between TASK_SIZE and mmap_base with a
+ * soft rlimit stack.
  */
-#define MIN_GAP (128*1024*1024)
-#define MAX_GAP (TASK_SIZE/6*5)
+#define MIN_HOLE (1*1024*1024)
+#define MIN_GAP (128*1024*1024 - MIN_HOLE)
+#define MAX_GAP (TASK_SIZE/6*5 - MIN_HOLE)
 
 static inline unsigned long mmap_base(void)
 {
@@ -43,8 +46,10 @@ static inline unsigned long mmap_base(vo
 		gap = MIN_GAP;
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
+	if (gap > current->rlim[RLIMIT_STACK].rlim_max)
+		gap = current->rlim[RLIMIT_STACK].rlim_max;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return TASK_SIZE - ((gap + MIN_HOLE) & PAGE_MASK);
 }
 
 static inline int mmap_is_legacy(void)
