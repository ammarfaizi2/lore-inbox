Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUHSXFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUHSXFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267510AbUHSXFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:05:41 -0400
Received: from holomorphy.com ([207.189.100.168]:40643 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267509AbUHSXDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:03:20 -0400
Date: Thu, 19 Aug 2004 16:03:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernbench on 512p
Message-ID: <20040819230315.GE11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
References: <200408191216.33667.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408191216.33667.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 12:16:33PM -0400, Jesse Barnes wrote:
> This is a 64p profile only.  If I set the prof_cpu_mask to include all 512 
> CPUs, the system livelocks.  I reset the counter right after the warmup run, 
> partly through the half load run, and collected it after a few runs were 
> complete.

Not tremendously intelligent, as concurrent readers of /proc/profile
can render each other's results gibberish, however, this should
mitigate some of the cacheline bouncing of prof_buffer.

Some kind of proper IO should be possible given sufficient effort, but
I gave up immediately when my first attempt didn't work, and this
should be enough for getting /proc/profile to stop bouncing madly for
users that can tolerate the concurrent IO constraint. I suppose that
in principle one could hackishly guard collation and copying of
prof_buffer with a semaphore in the per-cpu case. I'll work on fixing
this eventually.

Use perpcu_profile on the kernel command line to activate the feature.


Index: mm2-2.6.8.1/kernel/profile.c
===================================================================
--- mm2-2.6.8.1.orig/kernel/profile.c	2004-08-19 13:22:11.000000000 -0700
+++ mm2-2.6.8.1/kernel/profile.c	2004-08-19 15:11:40.000000000 -0700
@@ -10,12 +10,14 @@
 #include <linux/mm.h>
 #include <linux/cpumask.h>
 #include <linux/profile.h>
+#include <linux/percpu.h>
 #include <asm/sections.h>
 
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
-static int prof_on;
+static int prof_on, percpu_profile;
 static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
+static DEFINE_PER_CPU(atomic_t *, cpu_prof_buffer);
 
 static int __init profile_setup(char * str)
 {
@@ -37,15 +39,35 @@
 }
 __setup("profile=", profile_setup);
 
+static int __init profile_setup_percpu(char *str)
+{
+	percpu_profile = 1;
+	return 1;
+}
+__setup("percpu_profile", profile_setup_percpu);
+
 
 void __init profile_init(void)
 {
+	size_t len;
+	int cpu;
+
 	if (!prof_on) 
 		return;
  
 	/* only text is profiled */
 	prof_len = (_etext - _stext) >> prof_shift;
-	prof_buffer = alloc_bootmem(prof_len*sizeof(atomic_t));
+	len = prof_len * sizeof(atomic_t);
+	prof_buffer = alloc_bootmem(len);
+	for_each_cpu(cpu) {
+		if (!percpu_profile)
+			per_cpu(cpu_prof_buffer, cpu) = prof_buffer;
+		else {
+			pg_data_t *pgdat = NODE_DATA(cpu_to_node(cpu));
+			per_cpu(cpu_prof_buffer, cpu)
+				= alloc_bootmem_node(pgdat, len);
+		}
+	}
 }
 
 /* Profile event notifications */
@@ -165,11 +187,15 @@
 void profile_hit(int type, void *__pc)
 {
 	unsigned long pc;
+	atomic_t *buf;
 
-	if (prof_on != type || !prof_buffer)
+	if (prof_on != type)
 		return;
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
-	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
+	buf = per_cpu(cpu_prof_buffer, get_cpu());
+	if (buf)
+		atomic_inc(&buf[min(pc, prof_len - 1)]);
+	put_cpu();
 }
 
 void profile_tick(int type, struct pt_regs *regs)
@@ -223,6 +249,21 @@
 	entry->write_proc = prof_cpu_mask_write_proc;
 }
 
+static void collate_per_cpu_profiles(void)
+{
+	unsigned long i;
+
+	for (i = 0; i < prof_len; ++i)  {
+		int cpu;
+
+		atomic_set(&prof_buffer[i], 0);
+		for_each_online_cpu(cpu) {
+			atomic_t *buf = per_cpu(cpu_prof_buffer, cpu);
+			atomic_add(atomic_read(&buf[i]), &prof_buffer[i]);
+		}
+	}
+}
+
 /*
  * This function accesses profiling information. The returned data is
  * binary: the sampling step and the actual contents of the profile
@@ -247,6 +288,8 @@
 		put_user(*((char *)(&sample_step)+p),buf);
 		buf++; p++; count--; read++;
 	}
+	if (percpu_profile)
+		collate_per_cpu_profiles();
 	pnt = (char *)prof_buffer + p - sizeof(atomic_t);
 	if (copy_to_user(buf,(void *)pnt,count))
 		return -EFAULT;
@@ -278,7 +321,15 @@
 	}
 #endif
 
-	memset(prof_buffer, 0, prof_len * sizeof(atomic_t));
+	if (percpu_profile) {
+		int cpu;
+
+		for_each_online_cpu(cpu) {
+			atomic_t *buf = per_cpu(cpu_prof_buffer, cpu);
+			memset(buf, 0, prof_len * sizeof(atomic_t));
+		}
+	} else
+		memset(prof_buffer, 0, prof_len * sizeof(atomic_t));
 	return count;
 }
 
