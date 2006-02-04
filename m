Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWBDXuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWBDXuq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWBDXuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:50:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964879AbWBDXup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:50:45 -0500
Date: Sat, 4 Feb 2006 15:49:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, pj@sgi.com, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060204154944.36387a86.akpm@osdl.org>
In-Reply-To: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> From: Paul Jackson <pj@sgi.com>
> 
> This patch provides the implementation and cpuset interface for
> an alternative memory allocation policy that can be applied to
> certain kinds of memory allocations, such as the page cache (file
> system buffers) and some slab caches (such as inode caches).
> 
> ...
>
> A new per-cpuset file, "memory_spread", is defined.  This is
> a boolean flag file, containing a "0" (off) or "1" (on).
> By default it is off, and the kernel allocation placement
> is unchanged.  If it is turned on for a given cpuset (write a
> "1" to that cpusets memory_spread file) then the alternative
> policy applies to all tasks in that cpuset.

I'd have thought it would be saner to split these things apart:
"slab_spread", "pagecache_spread", etc.

> +static inline int cpuset_mem_spread_check(void)
> +{
> +	return current->flags & PF_MEM_SPREAD;
> +}

That's not a terribly assertive name.  cpuset_mem_spread_needed()?

> +		if (is_mem_spread(cs))
> +			tsk->flags |= PF_MEM_SPREAD;
> +		else
> +			tsk->flags &= ~PF_MEM_SPREAD;
>  		task_unlock(tsk);

OT: do we ever set PF_foo on a task other than `current'?  I have a feeling
that we do...

> +	case FILE_MEM_SPREAD:
> +		retval = update_flag(CS_MEM_SPREAD, cs, buffer);
> +		atomic_inc(&cpuset_mems_generation);
> +		cs->mems_generation = atomic_read(&cpuset_mems_generation);

atomic_inc_return()

> +int cpuset_mem_spread_node(void)
> +{
> +	int node;
> +
> +	node = next_node(current->cpuset_mem_spread_rotor, current->mems_allowed);
> +	if (node == MAX_NUMNODES)
> +		node = first_node(current->mems_allowed);
> +	current->cpuset_mem_spread_rotor = node;
> +	return node;
> +}

hm.  What guarantees that a node which is in current->mems_allowed is still
online?

