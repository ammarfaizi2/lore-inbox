Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbTGMMYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 08:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTGMMYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 08:24:40 -0400
Received: from holomorphy.com ([66.224.33.161]:455 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265955AbTGMMYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 08:24:38 -0400
Date: Sun, 13 Jul 2003 05:40:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH, RFC] remove task_cache entirely
Message-ID: <20030713124046.GE15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <3F114935.2000409@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F114935.2000409@colorfullife.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 01:57:41PM +0200, Manfred Spraul wrote:
> kernel/fork.c contains a disabled cache for task stuctures. task 
> structures are placed into the task cache only if "tsk==current", and 
> "tsk==current" is impossible. There is even a WARN_ON against that in 
> __put_task_struct().
> What should we do with it? I would remove it entirely - it's dead code. 
> Any objections?
> One problem is that order-1 allocations are not cached per-cpu - what 
> about using kmem_cache_alloc for the stack?

I've been slab allocating the stack on i386 for some time, and it has
gone without incident in pgcl, -wli, -mjb (?), and so on. kmalloc() is
fine; there isn't any particularly compelling reason for a dedicated
slab as there's no preconstruction to do, though it can be arranged.

Basically, it works, there's no obvious reason not to, and (even better)
it's not totally invisible to the VM and even makes overhead reportable.

akpm, this is a two line change with almost no effect apart from
theoretically improved SMP efficiency and more accurate reporting.
Shall we?

-- wli


diff -prauN mm1-2.5.75-1/include/asm-i386/thread_info.h mm1-2.5.75-stack-1/include/asm-i386/thread_info.h
--- mm1-2.5.75-1/include/asm-i386/thread_info.h	2003-07-10 13:05:26.000000000 -0700
+++ mm1-2.5.75-stack-1/include/asm-i386/thread_info.h	2003-07-13 05:35:08.000000000 -0700
@@ -87,8 +87,8 @@ static inline struct thread_info *curren
 
 /* thread information allocation */
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info(tsk) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+#define alloc_thread_info(task) ((struct thread_info *)kmalloc(THREAD_SIZE, GFP_KERNEL))
+#define free_thread_info(info)	kfree(info)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
