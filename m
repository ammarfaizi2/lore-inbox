Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269154AbUINCl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269154AbUINCl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269135AbUINCif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:38:35 -0400
Received: from holomorphy.com ([207.189.100.168]:12688 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269143AbUINCgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:36:36 -0400
Date: Mon, 13 Sep 2004 19:36:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>
Subject: [pidhashing] [3/3] enforce PID_MAX_LIMIT in sysctls
Message-ID: <20040914023634.GR9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914022530.GO9106@holomorphy.com> <20040914022827.GP9106@holomorphy.com> <20040914023114.GQ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914023114.GQ9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 07:31:14PM -0700, William Lee Irwin III wrote:
> /proc/ breaks when PID_MAX_LIMIT is elevated on 32-bit, so this patch
> lowers it there. Compiletested on x86-64.

The pid_max sysctl doesn't enforce PID_MAX_LIMIT or sane lower bounds.
RESERVED_PIDS + 1 is the minimum pid_max that won't break alloc_pidmap(),
and PID_MAX_LIMIT may not be aligned to 8*PAGE_SIZE boundaries for
unusual values of PAGE_SIZE, so this also rounds up PID_MAX_LIMIT to it.
Compiletested on x86-64.

Index: mm5-2.6.9-rc1/kernel/pid.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/pid.c	2004-09-13 16:30:21.980111568 -0700
+++ mm5-2.6.9-rc1/kernel/pid.c	2004-09-13 16:33:06.324127480 -0700
@@ -36,7 +36,10 @@
 
 #define RESERVED_PIDS		300
 
-#define PIDMAP_ENTRIES		(PID_MAX_LIMIT/PAGE_SIZE/8)
+int pid_max_min = RESERVED_PIDS + 1;
+int pid_max_max = PID_MAX_LIMIT;
+
+#define PIDMAP_ENTRIES		((PID_MAX_LIMIT + 8*PAGE_SIZE - 1)/PAGE_SIZE/8)
 #define BITS_PER_PAGE		(PAGE_SIZE*8)
 #define BITS_PER_PAGE_MASK	(BITS_PER_PAGE-1)
 #define mk_pid(map, off)	(((map) - pidmap_array)*BITS_PER_PAGE + (off))
Index: mm5-2.6.9-rc1/kernel/sysctl.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/sysctl.c	2004-09-13 16:27:44.621033784 -0700
+++ mm5-2.6.9-rc1/kernel/sysctl.c	2004-09-13 16:40:46.358191672 -0700
@@ -68,6 +68,7 @@
 extern int sched_base_timeslice;
 extern int sched_min_base;
 extern int sched_max_base;
+extern int pid_max_min, pid_max_max;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(__i386__)
 int unknown_nmi_panic;
@@ -577,7 +578,10 @@
 		.data		= &pid_max,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= sysctl_intvec,
+		.extra1		= &pid_max_min,
+		.extra2		= &pid_max_max,
 	},
 	{
 		.ctl_name	= KERN_PANIC_ON_OOPS,
