Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSIWBFo>; Sun, 22 Sep 2002 21:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSIWBFo>; Sun, 22 Sep 2002 21:05:44 -0400
Received: from dp.samba.org ([66.70.73.150]:18923 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264654AbSIWBFm>;
	Sun, 22 Sep 2002 21:05:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, ingo@redhat.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [PATCH] de-xchg fork.c
Date: Mon, 23 Sep 2002 11:06:14 +1000
Message-Id: <20020923011053.436B22C12D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know who put this in for 2.5.38.

I realize that using xchg() makes you 'leet.  But doing an atomic op
where none is required is suboptimal and confusing.

Hey, at least it wasn't:
	if (likely(tsk = xchg(task_cache + cpu, tsk))) {

Cheers,
Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.38/kernel/fork.c working-2.5.38-unxchg/kernel/fork.c
--- linux-2.5.38/kernel/fork.c	2002-09-21 13:55:19.000000000 +1000
+++ working-2.5.38-unxchg/kernel/fork.c	2002-09-23 11:00:31.000000000 +1000
@@ -64,11 +64,12 @@ void __put_task_struct(struct task_struc
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
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
