Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSIWSsi>; Mon, 23 Sep 2002 14:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSIWSsJ>; Mon, 23 Sep 2002 14:48:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46504 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261300AbSIWSmm>;
	Mon, 23 Sep 2002 14:42:42 -0400
Date: Mon, 23 Sep 2002 20:56:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>, <ingo@redhat.com>,
       <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>
Subject: Re: [PATCH] de-xchg fork.c
In-Reply-To: <1032805833.25756.17.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209232054140.32763-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Sep 2002, Robert Love wrote:

> > +		task_cache[cpu] = current;
> >  	}
> >  }
> 
> I think you need get/put_cpu() here, too?

you are right - new patch attached.

	Ingo

--- linux/kernel/fork.c.orig	Mon Sep 23 20:28:36 2002
+++ linux/kernel/fork.c	Mon Sep 23 20:55:08 2002
@@ -62,13 +62,15 @@
 		free_thread_info(tsk->thread_info);
 		kmem_cache_free(task_struct_cachep,tsk);
 	} else {
-		int cpu = smp_processor_id();
+		int cpu = get_cpu();
 
-		tsk = xchg(task_cache + cpu, tsk);
+		tsk = task_cache[cpu];
 		if (tsk) {
 			free_thread_info(tsk->thread_info);
 			kmem_cache_free(task_struct_cachep,tsk);
 		}
+		task_cache[cpu] = current;
+		put_cpu();
 	}
 }
 
@@ -126,8 +128,11 @@
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

