Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269020AbUIYCxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbUIYCxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 22:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269198AbUIYCxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 22:53:31 -0400
Received: from holomorphy.com ([207.189.100.168]:37604 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264389AbUIYCxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 22:53:10 -0400
Date: Fri, 24 Sep 2004 19:53:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched.h 2/8] nuke CT_TO_SECS() and CT_TO_USECS()
Message-ID: <20040925025304.GN9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com> <20040925024917.GM9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925024917.GM9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 07:49:17PM -0700, William Lee Irwin III wrote:
> Remove itimer_next and itimer_ticks; they are nowhere defined and
> referenced nowhere else.

CT_TO_SECS() and CT_TO_USECS() are used where jiffies_to_timeval()
should be; this patch teaches their sole caller to use that instead and
by so doing removes them from the kernel entirely.


Index: mm3-2.6.9-rc2/arch/mips/kernel/irixelf.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/mips/kernel/irixelf.c	2004-09-12 22:33:39.000000000 -0700
+++ mm3-2.6.9-rc2/arch/mips/kernel/irixelf.c	2004-09-24 18:45:21.055503104 -0700
@@ -29,6 +29,7 @@
 #include <linux/personality.h>
 #include <linux/elfcore.h>
 #include <linux/smp_lock.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
 #include <asm/mipsregs.h>
@@ -1131,14 +1132,10 @@
 	psinfo.pr_ppid = prstatus.pr_ppid = current->parent->pid;
 	psinfo.pr_pgrp = prstatus.pr_pgrp = process_group(current);
 	psinfo.pr_sid = prstatus.pr_sid = current->signal->session;
-	prstatus.pr_utime.tv_sec = CT_TO_SECS(current->utime);
-	prstatus.pr_utime.tv_usec = CT_TO_USECS(current->utime);
-	prstatus.pr_stime.tv_sec = CT_TO_SECS(current->stime);
-	prstatus.pr_stime.tv_usec = CT_TO_USECS(current->stime);
-	prstatus.pr_cutime.tv_sec = CT_TO_SECS(current->cutime);
-	prstatus.pr_cutime.tv_usec = CT_TO_USECS(current->cutime);
-	prstatus.pr_cstime.tv_sec = CT_TO_SECS(current->cstime);
-	prstatus.pr_cstime.tv_usec = CT_TO_USECS(current->cstime);
+	jiffies_to_timeval(current->utime, &prstatus.pr_utime);
+	jiffies_to_timeval(current->stime, &prstatus.pr_stime);
+	jiffies_to_timeval(current->cutime, &prstatus.pr_cutime);
+	jiffies_to_timeval(current->cstime, &prstatus.pr_cstime);
 	if (sizeof(elf_gregset_t) != sizeof(struct pt_regs)) {
 		printk("sizeof(elf_gregset_t) (%d) != sizeof(struct pt_regs) "
 		       "(%d)\n", sizeof(elf_gregset_t), sizeof(struct pt_regs));
Index: mm3-2.6.9-rc2/include/linux/sched.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/sched.h	2004-09-24 18:38:02.935107528 -0700
+++ mm3-2.6.9-rc2/include/linux/sched.h	2004-09-24 18:45:29.052287408 -0700
@@ -85,9 +85,6 @@
 	load += n*(FIXED_1-exp); \
 	load >>= FSHIFT;
 
-#define CT_TO_SECS(x)	((x) / HZ)
-#define CT_TO_USECS(x)	(((x) % HZ) * 1000000/HZ)
-
 extern int nr_threads;
 extern int last_pid;
 DECLARE_PER_CPU(unsigned long, process_counts);
