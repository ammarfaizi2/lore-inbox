Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWI0Lis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWI0Lis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWI0Lis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:38:48 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:50403 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030182AbWI0Lir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:38:47 -0400
Date: Wed, 27 Sep 2006 13:37:39 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] x86: Add portable getcpu call
Message-ID: <20060927113739.GB6872@osiris.boeblingen.de.ibm.com>
References: <200609262300.k8QN06dD013707@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609262300.k8QN06dD013707@hera.kernel.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 11:00:06PM +0000, Linux Kernel Mailing List wrote:
> commit 3cfc348bf90ffaa777c188652aa297f04eb94de8
> tree 8908d6a5a61e54ab422ec7f4800d6ac591695423
> parent c08c820508233b424deab3302bc404bbecc6493a
> author Andi Kleen <ak@suse.de> 1159260748 +0200
> committer Andi Kleen <andi@basil.nowhere.org> 1159260748 +0200
> 
> [PATCH] x86: Add portable getcpu call
> 
> For NUMA optimization and some other algorithms it is useful to have a fast
> to get the current CPU and node numbers in user space.

Hmm.. just realized that there is a new system call.

> +asmlinkage long sys_getcpu(unsigned __user *cpup, unsigned __user *nodep,
> +	   		   struct getcpu_cache __user *cache)
> +{
> +	int err = 0;
> +	int cpu = raw_smp_processor_id();
> +	if (cpup)
> +		err |= put_user(cpu, cpup);
> +	if (nodep)
> +		err |= put_user(cpu_to_node(cpu), nodep);
> +	if (cache) {
> +		/*
> +		 * The cache is not needed for this implementation,
> +		 * but make sure user programs pass something
> +		 * valid. vsyscall implementations can instead make
> +		 * good use of the cache. Only use t0 and t1 because
> +		 * these are available in both 32bit and 64bit ABI (no
> +		 * need for a compat_getcpu). 32bit has enough
> +		 * padding
> +		 */
> +		unsigned long t0, t1;
> +		get_user(t0, &cache->t0);
> +		get_user(t1, &cache->t1);
> +		t0++;
> +		t1++;
> +		put_user(t0, &cache->t0);
> +		put_user(t1, &cache->t1);
> +	}
> +	return err ? -EFAULT : 0;
> +}

In include/linux/getcpu.h we have

/* Cache for getcpu() to speed it up. Results might be upto a jiffie
   out of date, but will be faster.
   User programs should not refer to the contents of this structure.
   It is only a cache for vgetcpu(). It might change in future kernels.
   The user program must store this information per thread (__thread)
   If you want 100% accurate information pass NULL instead. */
struct getcpu_cache {
	unsigned long t0;
	unsigned long t1;
	unsigned long res[4];
};


So this means that the contents of getcpu_cache will look completely
different if a process runs in 32bit mode or 64bit mode. Even if you're
saying "user programs should not..." this looks odd to me.
Is this really on purpose and do you really think that no user space
application will ever rely on the format of getcpu_cache?
