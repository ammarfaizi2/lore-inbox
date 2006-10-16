Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbWJPIwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWJPIwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbWJPIwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:52:37 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:25234 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1161226AbWJPIwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:52:36 -0400
Date: Mon, 16 Oct 2006 01:54:39 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: [patch] slab: Fix a cpu hotplug race condition while tuning slab cpu caches
Message-ID: <20061016085439.GA6651@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a cpu hotplug race condition while tuning slab cpu caches.

CPU online (cpu_up) and tuning slab caches (do_tune_cpucache)
can race and can lead to a situation where we do not have an 
arraycache allocated for a newly onlined cpu.

The race can be explained as follows:

cpu_online_map 00000111
cpu_up(3)	
  cpuup_callback CPU_UP_PREPARE:
    mutex_lock(&cache_chain_mutex);
    ...						
    allocate_array_cache for cpu 3
    ...
    mutex_unlock(&cache_chain_mutex);
    ...						slabinfo_write
    ...						mutex_lock(&cache_chain_mutex);
    ...						  do_tune_cpucache
    ...						    allocate new arraycache for cpu0,1,2, NULL rest
    ...						    ...
  mutex_lock(&cpu_bitmask_lock);		    ...
  cpu_online_map 00001111
  mutex_unlock(&cpu_bitmask_lock);		    ...
						  on_each_cpu swap the new array_cache with old
						  ^^^^
						  CPU 3 gets assigned with a NULL array cache

Hence, when do_ccupdate_local is run on CPU 3, CPU 3 gets a NULL array_cache,
and caused badness thereon.

So don't allow cpus to come and go while in do_tune_cpucache.
The other code path of do_tune_cpucache through kmem_cache_create
is already protected through lock_cpu_hotplug.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.19-rc1slab/mm/slab.c
===================================================================
--- linux-2.6.19-rc1slab.orig/mm/slab.c	2006-10-13 12:35:02.578841000 -0700
+++ linux-2.6.19-rc1slab/mm/slab.c	2006-10-13 12:35:46.848841000 -0700
@@ -4072,6 +4072,7 @@ ssize_t slabinfo_write(struct file *file
 		return -EINVAL;
 
 	/* Find the cache in the chain of caches. */
+	lock_cpu_hotplug();
 	mutex_lock(&cache_chain_mutex);
 	res = -EINVAL;
 	list_for_each_entry(cachep, &cache_chain, next) {
@@ -4087,6 +4088,7 @@ ssize_t slabinfo_write(struct file *file
 		}
 	}
 	mutex_unlock(&cache_chain_mutex);
+	unlock_cpu_hotplug();
 	if (res >= 0)
 		res = count;
 	return res;
