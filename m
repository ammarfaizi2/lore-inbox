Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbSIWSSZ>; Mon, 23 Sep 2002 14:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSIWSSY>; Mon, 23 Sep 2002 14:18:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49872 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261319AbSIWSSX>;
	Mon, 23 Sep 2002 14:18:23 -0400
Date: Mon, 23 Sep 2002 20:31:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, <akpm@zip.com.au>, <ingo@redhat.com>,
       <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>
Subject: Re: [PATCH] de-xchg fork.c
In-Reply-To: <20020923011053.436B22C12D@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209232026320.28863-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Rusty Russell wrote:

> -		tsk = xchg(task_cache + cpu, tsk);
> +		tsk = task_cache[cpu];

this was me - i forgot that this are per-CPU fields. (hey and i wrote the
original task_cache code so there's no excuse :-)

the attached patch (against BK-curr) fixes all xchg()'s and a preemption
bug.

	Ingo

--- linux/kernel/fork.c.orig	Mon Sep 23 20:28:36 2002
+++ linux/kernel/fork.c	Mon Sep 23 20:30:02 2002
@@ -64,11 +64,12 @@
 	} else {
 		int cpu = smp_processor_id();
 
-		tsk = xchg(task_cache + cpu, tsk);
+		tsk = task_cache[cpu];
 		if (tsk) {
 			free_thread_info(tsk->thread_info);
 			kmem_cache_free(task_struct_cachep,tsk);
 		}
+		task_cache[cpu] = current;
 	}
 }
 
@@ -126,8 +127,11 @@
 {
 	struct task_struct *tsk;
 	struct thread_info *ti;
+	int cpu = get_cpu();
 
-	tsk = xchg(task_cache + smp_processor_id(), NULL);
+	tsk = task_cache[cpu];
+	task_cache[cpu] = NULL;
+	put_cpu();
 	if (!tsk) {
 		ti = alloc_thread_info();
 		if (!ti)

