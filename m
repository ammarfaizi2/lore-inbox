Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVDUSFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVDUSFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDUSFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:05:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49901 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261584AbVDUSEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:04:51 -0400
Date: Thu, 21 Apr 2005 19:04:59 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jan Dittmer <jdittmer@ppp0.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421180459.GC13052@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be> <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	m68k thread_info - part 4

The rest:
	a) added embedded thread_info [m68k processor.h]
	b) added missing symbols in asm-offsets.c
	c) task_thread_info() and freinds in asm-m68k/thread_info.h
	d) made m68k thread_info.h included by m68k processor.h, not the
other way round.

At that point thread_info mess is resolved - m68k builds and the rest of
the stuff to merge consists of normal driver patches.

IMO that's the least intrusive way to merge that sucker...

Comments?

diff -urN RC12-rc3-includes/arch/m68k/kernel/asm-offsets.c RC12-rc3-m68k/arch/m68k/kernel/asm-offsets.c
--- RC12-rc3-includes/arch/m68k/kernel/asm-offsets.c	Thu Feb 26 02:23:09 2004
+++ RC12-rc3-m68k/arch/m68k/kernel/asm-offsets.c	Wed Apr 20 22:51:18 2005
@@ -31,6 +31,7 @@
 	DEFINE(TASK_SIGPENDING, offsetof(struct task_struct, thread.work.sigpending));
 	DEFINE(TASK_NOTIFY_RESUME, offsetof(struct task_struct, thread.work.notify_resume));
 	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
+	DEFINE(TASK_INFO, offsetof(struct task_struct, thread.info));
 	DEFINE(TASK_MM, offsetof(struct task_struct, mm));
 	DEFINE(TASK_ACTIVE_MM, offsetof(struct task_struct, active_mm));
 
@@ -44,6 +45,10 @@
 	DEFINE(THREAD_FPREG, offsetof(struct thread_struct, fp));
 	DEFINE(THREAD_FPCNTL, offsetof(struct thread_struct, fpcntl));
 	DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct, fpstate));
+
+	/* offsets into the thread_info struct */
+	DEFINE(TINFO_PREEMPT, offsetof(struct thread_info, preempt_count));
+	DEFINE(HARDIRQ_SHIFT, HARDIRQ_SHIFT);
 
 	/* offsets into the pt_regs */
 	DEFINE(PT_D0, offsetof(struct pt_regs, d0));
diff -urN RC12-rc3-includes/include/asm-m68k/processor.h RC12-rc3-m68k/include/asm-m68k/processor.h
--- RC12-rc3-includes/include/asm-m68k/processor.h	Wed Apr 20 21:25:51 2005
+++ RC12-rc3-m68k/include/asm-m68k/processor.h	Wed Apr 20 22:51:19 2005
@@ -14,6 +14,7 @@
 #define current_text_addr() ({ __label__ _l; _l: &&_l;})
 
 #include <linux/config.h>
+#include <linux/thread_info.h>
 #include <asm/segment.h>
 #include <asm/fpu.h>
 #include <asm/ptrace.h>
@@ -79,6 +80,7 @@
 	unsigned long  fpcntl[3];	/* fp control regs */
 	unsigned char  fpstate[FPSTATESIZE];  /* floating point state */
 	struct task_work work;
+	struct thread_info info;
 };
 
 #define INIT_THREAD  {							\
diff -urN RC12-rc3-includes/include/asm-m68k/thread_info.h RC12-rc3-m68k/include/asm-m68k/thread_info.h
--- RC12-rc3-includes/include/asm-m68k/thread_info.h	Wed Apr 20 21:25:51 2005
+++ RC12-rc3-m68k/include/asm-m68k/thread_info.h	Wed Apr 20 22:51:19 2005
@@ -2,7 +2,6 @@
 #define _ASM_M68K_THREAD_INFO_H
 
 #include <asm/types.h>
-#include <asm/processor.h>
 #include <asm/page.h>
 
 struct thread_info {
@@ -36,10 +35,11 @@
 #endif /* PAGE_SHIFT == 13 */
 
 //#define init_thread_info	(init_task.thread.info)
-#define init_stack		(init_thread_union.stack)
-
-#define current_thread_info()	(current->thread_info)
+#define init_thread_info	(init_thread_union.thread_info)
+#define init_stack	(init_thread_union.stack)
 
+#define task_thread_info(tsk)   (&(tsk)->thread.info)
+#define current_thread_info()	task_thread_info(current)
 
 #define __HAVE_THREAD_FUNCTIONS
 
@@ -51,6 +51,10 @@
 #define TIF_MEMDIE		5
 
 extern int thread_flag_fixme(void);
+
+#define setup_thread_info(p, ti) do (ti)->task = p; while(0)
+
+#define end_of_stack(p) ((unsigned long *)(p)->thread_info + 1)
 
 /*
  * flag set/clear/test wrappers
