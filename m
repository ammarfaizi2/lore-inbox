Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWGaWED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWGaWED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWGaWED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:04:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24788 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751384AbWGaWEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:04:01 -0400
Message-ID: <44CE7E4A.3050602@sgi.com>
Date: Mon, 31 Jul 2006 15:03:54 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 2/3] add CSA accounting to taskstats
References: <44CE5847.8050706@sgi.com> <44CE6A82.4060709@watson.ibm.com>
In-Reply-To: <44CE6A82.4060709@watson.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
> 
>>This patch add CSA accounting fields to the taskstats struct
>>and a kernel/csa.c to fill the data on exit.
>>
>>
>>Signed-off-by:  Jay Lan <jlan@sgi.com>
>>
>>
>>------------------------------------------------------------------------
>>
>>Index: linux/include/linux/taskstats.h
>>===================================================================
>>--- linux.orig/include/linux/taskstats.h	2006-07-31 11:42:10.000000000 -0700
>>+++ linux/include/linux/taskstats.h	2006-07-31 11:50:00.412433042 -0700
>>@@ -107,6 +107,21 @@ struct taskstats {
>> 	__u64	ac_utime;		/* User CPU time [usec] */
>> 	__u64	ac_stime;		/* SYstem CPU time [usec] */
>> 	/* Basic Accounting Fields end */
>>+
>>+ 	/* CSA accounting fields start */
>>+ 	__u16	csa_revision;		/* CSA Revision */
> 
> 
> May be helpful to add a note here that every time csa_revision is changed,
> TASKSTATS_VERSION also needs to be bumped up.

Certainly! Thanks!

> 
> 
>>+ 	__u16	csa_pad[3];		/* Unused */
> 
> 
> 
>>+ 	__u64	acct_rss_mem1;		/* accumulated rss usage */
>>+ 	__u64	acct_vm_mem1;		/* accumulated virtual memory usage */
>>+ 	__u64	hiwater_rss;		/* High-watermark of RSS usage */
>>+ 	__u64	hiwater_vm;		/* High-water virtual memory usage */
> 
> 
> 
>>+ 	__u64	ac_minflt;		/* Minor Page Fault */
>>+ 	__u64	ac_majflt;		/* Major Page Fault */
> 
> 
> Can the number of prefixes be reduced ? In the space of a few fields, we have
> ac_*, csa_*, acct_* and plain (for hiwater_rss/vm)


Will do better in next round. I will see if people like to do away
the pre_ completely. Otherwise, i will keep ac_ for basic and plain
for CSA specific fields.

> 
> 
> 
>>+ 	__u64	ac_chr;			/* bytes read */
>>+ 	__u64	ac_chw;			/* bytes written */
>>+ 	__u64	ac_scr;			/* read syscalls */
>>+ 	__u64	ac_scw;			/* write syscalls */
> 
> 
> read_char,
> write_char,
> read_syscalls,
> write_syscalls,

Mmm, those are from task_struct.

Regards,
  - jay


> 
> perhaps (esp. if you're dropping the ac_ prefix) ?
> 
> 
>>+ 	/* CSA accounting fields end */
>> };
> 
> 
> 
>> 
>> 
>>Index: linux/init/Kconfig
>>===================================================================
>>--- linux.orig/init/Kconfig	2006-07-31 11:38:21.000000000 -0700
>>+++ linux/init/Kconfig	2006-07-31 11:47:23.214410140 -0700
>>@@ -182,6 +182,31 @@ config TASK_DELAY_ACCT
>> 
>> 	  Say N if unsure.
>> 
>>+config CSA_ACCT
>>+	bool "Enable CSA Job Accounting (EXPERIMENTAL)"
>>+	depends on TASKSTATS
>>+	help
>>+	  Comprehensive System Accounting (CSA) provides job level
>>+	  accounting of resource usage.  The accounting records are
>>+	  written by the kernel into a file.  CSA user level scripts
>>+	  and commands process the binary accounting records and
>>+	  combine them by job identifier within system boot uptime
>>+	  periods.  These accounting records are then used to produce
>>+	  reports and charge fees to users.
>>+
>>+	  Say Y here if you want job level accounting to be compiled
>>+	  into the kernel.  Say M here if you want the writing of
>>+	  accounting records portion of this feature to be a loadable
>>+	  module.  Say N here if you do not want job level accounting
>>+	  (the default).
> 
> 
> The description above is tied to jobs which don't exist in the kernel.
> There's no dependency of CSA on kernel-visible jobs anymore, right ?
> Perhaps the blurb can clarify that jobs are defined in user space.
> 
> 
>>+
>>+	  The CSA commands and scripts package needs to be installed
>>+	  to process the CSA accounting records.  See
>>+	  http://oss.sgi.com/projects/csa for further information
>>+	  about CSA and download instructions for the CSA commands
>>+	  package and documentation.
>>+
>>+
>> config SYSCTL
>> 	bool "Sysctl support" if EMBEDDED
>> 	default y
>>Index: linux/kernel/Makefile
>>===================================================================
>>--- linux.orig/kernel/Makefile	2006-07-31 11:38:21.000000000 -0700
>>+++ linux/kernel/Makefile	2006-07-31 11:47:23.218410191 -0700
>>@@ -50,6 +50,7 @@ obj-$(CONFIG_RCU_TORTURE_TEST) += rcutor
>> obj-$(CONFIG_RELAY) += relay.o
>> obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
>> obj-$(CONFIG_TASKSTATS) += taskstats.o
>>+obj-$(CONFIG_CSA_ACCT) += csa.o
>> 
>> ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
>> # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
>>Index: linux/kernel/csa.c
>>===================================================================
>>--- /dev/null	1970-01-01 00:00:00.000000000 +0000
>>+++ linux/kernel/csa.c	2006-07-31 11:47:23.218410191 -0700
>>@@ -0,0 +1,46 @@
>>+/*
>>+ * This file is subject to the terms and conditions of the GNU General Public
>>+ * License.  See the file "COPYING" in the main directory of this archive
>>+ * for more details.
>>+ *
>>+ * Copyright (c) 2006 Silicon Graphics, Inc All Rights Reserved.
>>+ */
>>+
>>+
>>+/*
>>+ *  CSA (Comprehensive System Accounting)
>>+ *  Job Accounting for Linux
>>+ *
>>+ *  This header file contains the definitions needed for job
>>+ *  accounting. The kernel CSA accounting module code and all
>>+ *  user-level programs that try to write or process the binary job
>>+ *  accounting data must include this file.
> 
> 
> Again, job dependency might need some clarification.
> 
> 
>>+ *
>>+ *  This kernel header file and the csa.h in the csa userland source
>>+ *  rpm share same data struct declaration and #define's. Do not modify
>>+ *  one without modify the other one as well. The compatibility between
>>+ *  userland and the kernel is ensured by using the 'ah_revision' field
>>+ *  of struct achead.
> 
> 
> Leftover from older documentation ?
> 
> 
>>+ *
>>+ */
>>+
>>+#include <linux/taskstats.h>
>>+#include <linux/csa_kern.h>
>>+#include <linux/sched.h>
>>+
>>+void csa_add_tsk(struct taskstats *stats, struct task_struct *p)
>>+{
>>+	stats->csa_revision = REV_CSA;
>>+	stats->acct_rss_mem1 = p->acct_rss_mem1;
>>+	stats->acct_vm_mem1  = p->acct_vm_mem1;
>>+	if (p->mm) {
>>+		stats->hiwater_rss   = p->mm->hiwater_rss;
>>+		stats->hiwater_vm    = p->mm->hiwater_vm;
>>+	}
>>+	stats->ac_minflt = p->min_flt;
>>+	stats->ac_majflt = p->maj_flt;
>>+	stats->ac_chr	= p->rchar;
>>+	stats->ac_chw	= p->wchar;
>>+	stats->ac_scr	= p->syscr;
>>+	stats->ac_scw	= p->syscw;
>>+}
>>Index: linux/kernel/taskstats.c
>>===================================================================
>>--- linux.orig/kernel/taskstats.c	2006-07-31 11:44:54.000000000 -0700
>>+++ linux/kernel/taskstats.c	2006-07-31 11:47:23.218410191 -0700
>>@@ -21,6 +21,7 @@
>> #include <linux/taskstats_kern.h>
>> #include <linux/acct.h>
>> #include <linux/delayacct.h>
>>+#include <linux/csa_kern.h>
>> #include <linux/cpumask.h>
>> #include <linux/percpu.h>
>> #include <net/genetlink.h>
>>@@ -252,6 +253,9 @@ static int fill_pid(pid_t pid, struct ta
>> 	/* fill in basic acct fields */
>> 	bacct_add_tsk(stats, tsk);
>> 
>>+	/* fill in csa fields */
>>+	csa_add_tsk(stats, tsk);
>>+
>> 	/* Define err: label here if needed */
>> 	put_task_struct(tsk);
>> 	return rc;
>>Index: linux/include/linux/csa_kern.h
>>===================================================================
>>--- /dev/null	1970-01-01 00:00:00.000000000 +0000
>>+++ linux/include/linux/csa_kern.h	2006-07-31 11:47:23.218410191 -0700
>>@@ -0,0 +1,31 @@
>>+/*
>>+ * This file is subject to the terms and conditions of the GNU General Public
>>+ * License.  See the file "COPYING" in the main directory of this archive
>>+ * for more details.
>>+ *
>>+ * Copyright (c) 2006 Silicon Graphics, Inc All Rights Reserved.
>>+ */
>>+
>>+#ifndef _CSA_KERN_H
>>+#define _CSA_KERN_H
>>+
>>+#ifdef CONFIG_CSA_ACCT
>>+extern void csa_add_tsk(struct taskstats *, struct task_struct *);
>>+#else
>>+#define csa_add_tsk(x)		do { } while (0)
> 
> 
> This won't compile right...number of args differ.
> 
> 
>>+#endif
>>+
>>+/*
>>+ * Record revision levels.
>>+ *
>>+ * These are incremented to indicate that a record's format has changed since
>>+ * a previous release.
>>+ *
>>+ * History:     05000   The first rev in Linux
>>+ *              06000   Major rework to clean up unused fields and features.
>>+ *                      No binary compatibility with earlier rev.
>>+ *		07000	Convert to taskstats interface
>>+ */
>>+#define REV_CSA		07000	/* Kernel: CSA base record */
>>+
>>+#endif	/* _CSA_KERN_H */
>>
> 
> 

