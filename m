Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWDLIWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWDLIWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 04:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWDLIWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 04:22:18 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54967 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932104AbWDLIWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 04:22:16 -0400
Date: Wed, 12 Apr 2006 17:23:05 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, clameter@engr.sgi.com,
       riel@redhat.com, dgc@sgi.com
Subject: Re: [PATCH] support for panic at OOM
Message-Id: <20060412172305.6d5995a5.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060411235907.6a59ecba.akpm@osdl.org>
References: <20060412155301.10d611ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20060411235907.6a59ecba.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This is updated version. thank you for suggestions.

-Kame

==
This patch adds panic_on_oom sysctl under sys.vm.

When sysctl vm.panic_on_oom = 1, the kernel panics intead of killing
rogue processes. And if vm.panic_on_oom is 0 the kernel will do
oom_kill() in the same way as it does today. Of course, the
default value is 0 and only root can modifies it.

In general, oom_killer works well and kill rogue processes. So
the whole system can survive. But there are environments where
panic is preferable rather than kill some processes.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: oom_die-2.6.17-rc1-mm2/mm/oom_kill.c
===================================================================
--- oom_die-2.6.17-rc1-mm2.orig/mm/oom_kill.c
+++ oom_die-2.6.17-rc1-mm2/mm/oom_kill.c
@@ -22,6 +22,7 @@
 #include <linux/jiffies.h>
 #include <linux/cpuset.h>
 
+int sysctl_panic_on_oom;
 /* #define DEBUG */
 
 /**
@@ -330,6 +331,8 @@ void out_of_memory(struct zonelist *zone
 		break;
 
 	case CONSTRAINT_NONE:
+		if (sysctl_panic_on_oom)
+			panic("out of memory. panic_on_oom is selected\n");
 retry:
 		/*
 		 * Rambo mode: Shoot down a process and hope it solves whatever
Index: oom_die-2.6.17-rc1-mm2/include/linux/sysctl.h
===================================================================
--- oom_die-2.6.17-rc1-mm2.orig/include/linux/sysctl.h
+++ oom_die-2.6.17-rc1-mm2/include/linux/sysctl.h
@@ -188,6 +188,7 @@ enum
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
 	VM_SWAP_PREFETCH=33,	/* swap prefetch */
+	VM_PANIC_ON_OOM=34,	/* panic at out-of-memory */
 };
 
 
Index: oom_die-2.6.17-rc1-mm2/kernel/sysctl.c
===================================================================
--- oom_die-2.6.17-rc1-mm2.orig/kernel/sysctl.c
+++ oom_die-2.6.17-rc1-mm2/kernel/sysctl.c
@@ -60,6 +60,7 @@ extern int proc_nr_files(ctl_table *tabl
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
+extern int sysctl_panic_on_oom;
 extern int max_threads;
 extern int sysrq_enabled;
 extern int core_uses_pid;
@@ -718,6 +719,14 @@ static ctl_table vm_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= VM_PANIC_ON_OOM,
+		.procname	= "panic_on_oom",
+		.data		= &sysctl_panic_on_oom,
+		.maxlen		= sizeof(sysctl_panic_on_oom),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
 		.ctl_name	= VM_OVERCOMMIT_RATIO,
 		.procname	= "overcommit_ratio",
 		.data		= &sysctl_overcommit_ratio,
Index: oom_die-2.6.17-rc1-mm2/Documentation/sysctl/vm.txt
===================================================================
--- oom_die-2.6.17-rc1-mm2.orig/Documentation/sysctl/vm.txt
+++ oom_die-2.6.17-rc1-mm2/Documentation/sysctl/vm.txt
@@ -30,6 +30,7 @@ Currently, these files are in /proc/sys/
 - zone_reclaim_mode
 - zone_reclaim_interval
 - swap_prefetch
+- panic_on_oom
 
 ==============================================================
 
@@ -189,3 +190,16 @@ copying back pages from swap into the sw
 practice it can take many minutes before the vm is idle enough.
 
 The default value is 1.
+
+=============================================================
+
+panic_on_oom
+
+This enables or disables panic on out-of-memory feature. If this is set to 1,
+the kernel panics when out-of-memory happens. If this is set to 0, the kernel
+will kill some rogue process, called oom_killer. Usually, oom_killer can kill
+rogue processes and system will survive. If you want to panic the system rather
+than killing rogue processes, set this to 1.
+
+The default value is 0.
+

