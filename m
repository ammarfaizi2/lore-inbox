Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267776AbSLTKXF>; Fri, 20 Dec 2002 05:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbSLTKXF>; Fri, 20 Dec 2002 05:23:05 -0500
Received: from holomorphy.com ([66.224.33.161]:24517 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267776AbSLTKXE>;
	Fri, 20 Dec 2002 05:23:04 -0500
Date: Fri, 20 Dec 2002 02:30:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, bjorn_helgaas@hp.com
Subject: Re: [PATCH] Fix CPU bitmask truncation
Message-ID: <20021220103028.GB9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	bjorn_helgaas@hp.com
References: <200212161213.29230.bjorn_helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212161213.29230.bjorn_helgaas@hp.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:13:29PM -0700, Bjorn Helgaas wrote:
> This patch fixes some obviously incorrect bitmask truncations in 2.4.20.

Linus, this is the 2.5.x version of the same patch originally by Bjorn
for 2.4.x. This fixes an entire class of critical 64-bit bugs.

Against 2.5.52-bk as of 2:25AM 20 Dec 2002. Please apply.


Thanks,
Bill

Fix task->cpus_allowed bitmask truncations. Originally due to
Bjorn Helgaas for 2.4.x.

 include/linux/init_task.h |    2 +-
 kernel/module.c           |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


===== include/linux/init_task.h 1.19 vs edited =====
--- 1.19/include/linux/init_task.h	Sun Sep 29 07:02:55 2002
+++ edited/include/linux/init_task.h	Fri Dec 20 02:22:04 2002
@@ -63,7 +63,7 @@
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\
-	.cpus_allowed	= -1,						\
+	.cpus_allowed	= ~0UL,						\
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
===== kernel/module.c 1.31 vs edited =====
--- 1.31/kernel/module.c	Sun Dec  1 22:44:11 2002
+++ edited/kernel/module.c	Fri Dec 20 02:19:53 2002
@@ -210,7 +210,7 @@
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 	setscheduler(current->pid, SCHED_FIFO, &param);
 #endif
-	set_cpus_allowed(current, 1 << (unsigned long)cpu);
+	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
 
 	/* Ack: we are alive */
 	atomic_inc(&stopref_thread_ack);
@@ -271,7 +271,7 @@
 
 	/* FIXME: racy with set_cpus_allowed. */
 	old_allowed = current->cpus_allowed;
-	set_cpus_allowed(current, 1 << (unsigned long)cpu);
+	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
 
 	atomic_set(&stopref_thread_ack, 0);
 	stopref_num_threads = 0;
