Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422714AbWJPSP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbWJPSP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWJPSP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:15:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422714AbWJPSP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:15:27 -0400
Date: Mon, 16 Oct 2006 11:15:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [patch] slab: Fix a cpu hotplug race condition while tuning
 slab cpu caches
Message-Id: <20061016111511.3901be27.akpm@osdl.org>
In-Reply-To: <20061016085439.GA6651@localhost.localdomain>
References: <20061016085439.GA6651@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 01:54:39 -0700
Ravikiran G Thirumalai <kiran@scalex86.org> wrote:

> Fix a cpu hotplug race condition while tuning slab cpu caches.
> 
> CPU online (cpu_up) and tuning slab caches (do_tune_cpucache)
> can race and can lead to a situation where we do not have an 
> arraycache allocated for a newly onlined cpu.

lock_cpu_hotplug() is a noxious thing which should be removed.

> The race can be explained as follows:
> 
> cpu_online_map 00000111
> cpu_up(3)	
>   cpuup_callback CPU_UP_PREPARE:
>     mutex_lock(&cache_chain_mutex);
>     ...						
>     allocate_array_cache for cpu 3
>     ...
>     mutex_unlock(&cache_chain_mutex);
>     ...						slabinfo_write
>     ...						mutex_lock(&cache_chain_mutex);
>     ...						  do_tune_cpucache
>     ...						    allocate new arraycache for cpu0,1,2, NULL rest
>     ...						    ...
>   mutex_lock(&cpu_bitmask_lock);		    ...
>   cpu_online_map 00001111
>   mutex_unlock(&cpu_bitmask_lock);		    ...
> 						  on_each_cpu swap the new array_cache with old
> 						  ^^^^
> 						  CPU 3 gets assigned with a NULL array cache

The problem is obvious: we have some data (the array caches) and we have a
data structure which is used to look up that data (cpu_online_map).  But
we're releasing the lock while these two things are in an inconsistent
state.

So you could have fixed this by taking cache_chain_mutex in CPU_UP_PREPARE
and releasing it in CPU_ONLINE and CPU_UP_CANCELED.

> Hence, when do_ccupdate_local is run on CPU 3, CPU 3 gets a NULL array_cache,
> and caused badness thereon.
> 
> So don't allow cpus to come and go while in do_tune_cpucache.
> The other code path of do_tune_cpucache through kmem_cache_create
> is already protected through lock_cpu_hotplug.
> 
> Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
> Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> Signed-off-by: Shai Fultheim <shai@scalex86.org>
> 
> Index: linux-2.6.19-rc1slab/mm/slab.c
> ===================================================================
> --- linux-2.6.19-rc1slab.orig/mm/slab.c	2006-10-13 12:35:02.578841000 -0700
> +++ linux-2.6.19-rc1slab/mm/slab.c	2006-10-13 12:35:46.848841000 -0700
> @@ -4072,6 +4072,7 @@ ssize_t slabinfo_write(struct file *file
>  		return -EINVAL;
>  
>  	/* Find the cache in the chain of caches. */
> +	lock_cpu_hotplug();
>  	mutex_lock(&cache_chain_mutex);
>  	res = -EINVAL;
>  	list_for_each_entry(cachep, &cache_chain, next) {
> @@ -4087,6 +4088,7 @@ ssize_t slabinfo_write(struct file *file
>  		}
>  	}
>  	mutex_unlock(&cache_chain_mutex);
> +	unlock_cpu_hotplug();
>  	if (res >= 0)
>  		res = count;
>  	return res;

Given that this lock_cpu_hotplug() happens at a high level I guess it'll
avoid the usual lock_cpu_hotplug() horrors and we can live with it.  I
assume lockdep was enabled when you were testing this?

