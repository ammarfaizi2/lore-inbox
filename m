Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTABPgr>; Thu, 2 Jan 2003 10:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbTABPgr>; Thu, 2 Jan 2003 10:36:47 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:10734 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262201AbTABPgp>;
	Thu, 2 Jan 2003 10:36:45 -0500
Date: Fri, 3 Jan 2003 02:45:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apm.c redclares savesegment
Message-Id: <20030103024501.1957ac1e.sfr@canb.auug.org.au>
In-Reply-To: <20021230125907.A16745@lst.de>
References: <20021230125907.A16745@lst.de>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris, Linus,

On Mon, 30 Dec 2002 12:59:07 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> .. but it could just use the generic version

But asm/elf.h seems a strange place for it to be.  And there was
another one.


How about this?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54/arch/i386/kernel/apm.c 2.5.54-saveseg/arch/i386/kernel/apm.c
--- 2.5.54/arch/i386/kernel/apm.c	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.54-saveseg/arch/i386/kernel/apm.c	2003-01-03 02:20:57.000000000 +1100
@@ -331,12 +331,6 @@
 #define DEFAULT_BOUNCE_INTERVAL		(3 * HZ)
 
 /*
- * Save a segment register away
- */
-#define savesegment(seg, where) \
-		__asm__ __volatile__("movl %%" #seg ",%0" : "=m" (where))
-
-/*
  * Maximum number of events stored
  */
 #define APM_MAX_EVENTS		20
diff -ruN 2.5.54/arch/i386/kernel/process.c 2.5.54-saveseg/arch/i386/kernel/process.c
--- 2.5.54/arch/i386/kernel/process.c	2003-01-02 15:13:45.000000000 +1100
+++ 2.5.54-saveseg/arch/i386/kernel/process.c	2003-01-03 02:21:40.000000000 +1100
@@ -274,12 +274,6 @@
 	release_x86_irqs(dead_task);
 }
 
-/*
- * Save a segment.
- */
-#define savesegment(seg,value) \
-	asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
-
 int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
 	unsigned long unused,
 	struct task_struct * p, struct pt_regs * regs)
diff -ruN 2.5.54/include/asm-i386/elf.h 2.5.54-saveseg/include/asm-i386/elf.h
--- 2.5.54/include/asm-i386/elf.h	2002-12-27 15:15:57.000000000 +1100
+++ 2.5.54-saveseg/include/asm-i386/elf.h	2003-01-03 02:22:48.000000000 +1100
@@ -8,6 +8,7 @@
 #include <asm/ptrace.h>
 #include <asm/user.h>
 #include <asm/processor.h>
+#include <asm/system.h>		/* for savesegment */
 
 #include <linux/utsname.h>
 
@@ -58,11 +59,6 @@
 
 #define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
 
-/* Wow, the "main" arch needs arch dependent functions too.. :) */
-
-#define savesegment(seg,value) \
-	asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
-
 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
    now struct_user_regs, they are different) */
 
diff -ruN 2.5.54/include/asm-i386/system.h 2.5.54-saveseg/include/asm-i386/system.h
--- 2.5.54/include/asm-i386/system.h	2003-01-02 15:13:49.000000000 +1100
+++ 2.5.54-saveseg/include/asm-i386/system.h	2003-01-03 02:25:14.000000000 +1100
@@ -95,6 +95,12 @@
 		: :"m" (*(unsigned int *)&(value)))
 
 /*
+ * Save a segment register away
+ */
+#define savesegment(seg, value) \
+	asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
+
+/*
  * Clear and set 'TS' bit respectively
  */
 #define clts() __asm__ __volatile__ ("clts")
