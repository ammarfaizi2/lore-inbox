Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbVIAV7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbVIAV7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbVIAV7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:59:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60295 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030420AbVIAV7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:59:41 -0400
Date: Thu, 1 Sep 2005 23:59:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 4/10] m68k: m68k specific thread_info changes
Message-ID: <Pine.LNX.4.61.0509012359210.9712@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

a) added embedded thread_info [m68k processor.h]
b) added missing symbols in asm-offsets.c
c) task_thread_info() and friends in asm-m68k/thread_info.h
d) made m68k thread_info.h included by m68k processor.h, not the other
way round.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/asm-offsets.c |    5 +++++
 include/asm-m68k/processor.h   |    2 ++
 include/asm-m68k/thread_info.h |   14 ++++++++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

Index: linux-2.6-mm/arch/m68k/kernel/asm-offsets.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/kernel/asm-offsets.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/m68k/kernel/asm-offsets.c	2005-09-01 21:04:36.173703799 +0200
@@ -31,6 +31,7 @@ int main(void)
 	DEFINE(TASK_SIGPENDING, offsetof(struct task_struct, thread.work.sigpending));
 	DEFINE(TASK_NOTIFY_RESUME, offsetof(struct task_struct, thread.work.notify_resume));
 	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
+	DEFINE(TASK_INFO, offsetof(struct task_struct, thread.info));
 	DEFINE(TASK_MM, offsetof(struct task_struct, mm));
 	DEFINE(TASK_ACTIVE_MM, offsetof(struct task_struct, active_mm));
 
@@ -45,6 +46,10 @@ int main(void)
 	DEFINE(THREAD_FPCNTL, offsetof(struct thread_struct, fpcntl));
 	DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct, fpstate));
 
+	/* offsets into the thread_info struct */
+	DEFINE(TINFO_PREEMPT, offsetof(struct thread_info, preempt_count));
+	DEFINE(TINFO_FLAGS, offsetof(struct thread_info, flags));
+
 	/* offsets into the pt_regs */
 	DEFINE(PT_D0, offsetof(struct pt_regs, d0));
 	DEFINE(PT_ORIG_D0, offsetof(struct pt_regs, orig_d0));
Index: linux-2.6-mm/include/asm-m68k/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/processor.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-m68k/processor.h	2005-09-01 21:04:36.184701909 +0200
@@ -14,6 +14,7 @@
 #define current_text_addr() ({ __label__ _l; _l: &&_l;})
 
 #include <linux/config.h>
+#include <linux/thread_info.h>
 #include <asm/segment.h>
 #include <asm/fpu.h>
 #include <asm/ptrace.h>
@@ -79,6 +80,7 @@ struct thread_struct {
 	unsigned long  fpcntl[3];	/* fp control regs */
 	unsigned char  fpstate[FPSTATESIZE];  /* floating point state */
 	struct task_work work;
+	struct thread_info info;
 };
 
 #define INIT_THREAD  {							\
Index: linux-2.6-mm/include/asm-m68k/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-m68k/thread_info.h	2005-09-01 21:04:36.216696412 +0200
@@ -2,7 +2,6 @@
 #define _ASM_M68K_THREAD_INFO_H
 
 #include <asm/types.h>
-#include <asm/processor.h>
 #include <asm/page.h>
 
 struct thread_info {
@@ -35,14 +34,21 @@ struct thread_info {
 #define free_thread_info(ti)  free_pages((unsigned long)(ti),1)
 #endif /* PAGE_SHIFT == 13 */
 
-//#define init_thread_info	(init_task.thread.info)
+#define init_thread_info	(init_task.thread.info)
 #define init_stack		(init_thread_union.stack)
 
-#define current_thread_info()	(current->thread_info)
-
+#define task_thread_info(tsk)	(&(tsk)->thread.info)
+#define current_thread_info()	task_thread_info(current)
 
 #define __HAVE_THREAD_FUNCTIONS
 
+#define setup_thread_stack(p, org) ({			\
+	*(struct task_struct **)(p)->thread_info = (p);	\
+	task_thread_info(p)->task = (p);		\
+})
+
+#define end_of_stack(p) ((unsigned long *)(p)->thread_info + 1)
+
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_DELAYED_TRACE	1	/* single step a syscall */
 #define TIF_NOTIFY_RESUME	2	/* resumption notification requested */
