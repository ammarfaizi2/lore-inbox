Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266285AbUBQQWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266288AbUBQQWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:22:25 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:28370 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266285AbUBQQWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:22:19 -0500
Message-ID: <40323FB6.1030208@colorfullife.com>
Date: Tue, 17 Feb 2004 17:22:14 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Hicks <mort@wildopensource.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce TLB flushing during process migration
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:

>diff -Nru a/kernel/sched.c b/kernel/sched.c
>--- a/kernel/sched.c	Tue Feb 17 07:33:59 2004
>+++ b/kernel/sched.c	Tue Feb 17 07:33:59 2004
>@@ -25,6 +25,7 @@
> #include <linux/highmem.h>
> #include <linux/smp_lock.h>
> #include <asm/mmu_context.h>
>+#include <asm/tlbflush.h>
> #include <linux/interrupt.h>
> #include <linux/completion.h>
> #include <linux/kernel_stat.h>
>@@ -1135,6 +1136,14 @@
> 		task_rq_unlock(rq, &flags);
> 		wake_up_process(rq->migration_thread);
> 		wait_for_completion(&req.done);
>+
>+		/*
>+		 * we want a new context here. This eliminates TLB
>+		 * flushes on the cpus where the process executed prior to
>+		 * the migration.
>+		 */
>+		flush_tlb_mm(current->mm);
>+
>  
>
I think flush_tlb_mm() is the wrong function - e.g. for i386, it's a 
wasted flush, because i386 disconnects previous cpus from the tlb flush 
automatically.
And it's always the wrong thing if you've migrated one thread of a task 
that runs on multiple cpus. I think you need a new hook.

--
    Manfred

