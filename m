Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVLHAME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVLHAME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVLHAME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:12:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750735AbVLHAMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:12:02 -0500
Date: Wed, 7 Dec 2005 16:13:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] swap migration: Fix lru drain
Message-Id: <20051207161319.6ada5c33.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> isolate_page()

There's no such function.  You're referring to isolate_lru_page().

btw, lru_add_drain() appears to be identical to lru_drain_cache().

> currently uses an IPI to notify other processors that the lru
> caches need to be drained if the page cannot be found on the LRU. The IPI
> interrupt may interrupt a processor that is just processing lru requests
> and cause a race condition.
> 
> This patch introduces a new function run_on_each_cpu() that uses the keventd()
> to run the LRU draining on each processor. Processors disable preemption
> when dealing the LRU caches (these are per processor) and thus executing
> LRU draining from another process is safe.
> 
> Thanks to Lee Schermerhorn <lee.schermerhorn@hp.com> for finding this race
> condition.
> 
> This makes the 
> 
> preserve-irq-status-in-release_pages-__pagevec_lru_add.patch
> 
> in Andrews tree no longer necessary.

Why not just extend the irq protection into lru_cache_add[_active]() and
lru_add_drain()?

Answer: because
preserve-irq-status-in-release_pages-__pagevec_lru_add.patch sucks, and
extending it in this manner sucks more.

Being able to push everything up to process context as you're proposing
puts all the suckiness into this slowpath, so fine.

> +void schedule_on_each_cpu(void (*func) (void *info), void *info)
> +{
> +	int cpu;
> +	struct work_struct * work = kmalloc(NR_CPUS * sizeof(struct work_struct), GFP_KERNEL);
> +
> +	for_each_online_cpu(cpu) {
> +		INIT_WORK(work + cpu, func, info);
> +		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu), work + cpu);
> +	}
> +	flush_workqueue(keventd_wq);
> +	kfree(work);
> +}

Normally it's poor form for a library function to assume it can use
GFP_KERNEL.  But in this case, the allocation has such a huge upper-bound
that there's no reasonable alternative, so OK.

kmalloc() can return NULL, y'know.

80-col xterms, please.
