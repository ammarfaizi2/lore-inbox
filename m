Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268733AbUIQNT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268733AbUIQNT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUIQNT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:19:59 -0400
Received: from dmz.tecosim.com ([195.135.152.162]:5043 "EHLO dmz.tecosim.de")
	by vger.kernel.org with ESMTP id S268734AbUIQNSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:18:37 -0400
Date: Fri, 17 Sep 2004 15:18:30 +0200
From: Utz Lehmann <lkml@de.tecosim.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Utz Lehmann <lkml@de.tecosim.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flexmmap: optimise mmap_base gap for hard limited stack
Message-ID: <20040917131829.GA15000@de.tecosim.com>
References: <20040916165613.GA10825@de.tecosim.com> <20040916174529.GA16439@devserv.devel.redhat.com> <20040916182139.GA21870@de.tecosim.com> <4149E46E.7010804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4149E46E.7010804@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper [drepper@redhat.com] wrote:
> > A check for CAP_SYS_RESOURCE can be added. But i dont think it's worth.
> 
> It is needed.  Otherwise how do you allow increasing the stack size
> again once it has been limited?  I've no problem with using the smallest
> reserved stack region with !CAP_SYS_RESOURCE, but otherwise the existing
> method should be used.

I made that change. The following patch only reduce the gap when the
application can not extend the stack space anyway (hard limited stack &&
!CAP_SYS_RESOURCE). All other cases stay unchanged except for the 1 MB hole
for soft limited stacks >128 MB.

It gave a nice way for making most of the default 128 MB gap usable for
applications. Just run them with a hard stack limit.

Now i can allocate more than 3.8GiB in one chunk on x86 (this patch +
exec-shield + 4g/4g + ulimit -H -s 8192).


Signed-off-by: Utz Lehmann <lkml@de.tecosim.com>

diff -Nrup linux-2.6.9-rc2/arch/i386/mm/mmap.c linux-2.6.9-rc2-gap4/arch/i386/mm/mmap.c
--- linux-2.6.9-rc2/arch/i386/mm/mmap.c	2004-09-16 11:18:15.363366420 +0200
+++ linux-2.6.9-rc2-gap4/arch/i386/mm/mmap.c	2004-09-17 12:14:16.734968291 +0200
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
@@ -43,8 +46,11 @@ static inline unsigned long mmap_base(st
 		gap = MIN_GAP;
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
+	if ((gap > current->rlim[RLIMIT_STACK].rlim_max) &&
+			!capable(CAP_SYS_RESOURCE))
+		gap = current->rlim[RLIMIT_STACK].rlim_max;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return TASK_SIZE - ((gap + MIN_HOLE) & PAGE_MASK);
 }
 
 /*
diff -Nrup linux-2.6.9-rc2/arch/ppc64/mm/mmap.c linux-2.6.9-rc2-gap4/arch/ppc64/mm/mmap.c
--- linux-2.6.9-rc2/arch/ppc64/mm/mmap.c	2004-09-16 11:18:19.760799910 +0200
+++ linux-2.6.9-rc2-gap4/arch/ppc64/mm/mmap.c	2004-09-17 12:15:05.572696938 +0200
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
@@ -43,8 +46,11 @@ static inline unsigned long mmap_base(vo
 		gap = MIN_GAP;
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
+	if ((gap > current->rlim[RLIMIT_STACK].rlim_max) &&
+			!capable(CAP_SYS_RESOURCE))
+		gap = current->rlim[RLIMIT_STACK].rlim_max;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return TASK_SIZE - ((gap + MIN_HOLE) & PAGE_MASK);
 }
 
 static inline int mmap_is_legacy(void)
diff -Nrup linux-2.6.9-rc2/arch/s390/mm/mmap.c linux-2.6.9-rc2-gap4/arch/s390/mm/mmap.c
--- linux-2.6.9-rc2/arch/s390/mm/mmap.c	2004-09-16 11:18:19.855787673 +0200
+++ linux-2.6.9-rc2-gap4/arch/s390/mm/mmap.c	2004-09-17 12:15:23.054452086 +0200
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
@@ -43,8 +46,11 @@ static inline unsigned long mmap_base(vo
 		gap = MIN_GAP;
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
+	if ((gap > current->rlim[RLIMIT_STACK].rlim_max) &&
+			!capable(CAP_SYS_RESOURCE))
+		gap = current->rlim[RLIMIT_STACK].rlim_max;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return TASK_SIZE - ((gap + MIN_HOLE) & PAGE_MASK);
 }
 
 static inline int mmap_is_legacy(void)
