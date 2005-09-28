Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVI1VDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVI1VDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVI1VDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:03:12 -0400
Received: from serv01.siteground.net ([70.85.91.68]:2269 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750900AbVI1VDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:03:10 -0400
Date: Wed, 28 Sep 2005 14:02:45 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@engr.sgi.com>,
       alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       ananth@in.ibm.com, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-ID: <20050928210245.GA3760@localhost.localdomain>
References: <20050916023005.4146e499.akpm@osdl.org> <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org> <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org> <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com> <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com> <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43301578.8040305@vc.cvut.cz>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 03:58:16PM +0200, Petr Vandrovec wrote:
> Andrew Morton wrote:
> >Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> >...
> >They do.  I don't believe that preemption is the source of this BUG. 
> >(Petr, does CONFIG_PREEMPT=n fix it?)
> 
> No, it does not.  I've even added printks here and there to show node 
> number,
> and everything works as it should.  Maybe there are some problems with
> numa_node_id() and migrating between processors when memory gets released,
> I do not know.
> 
> Only thing I know that if I'll add WARN_ON below to the free_block(), it
> triggers...
> 
> @free_block
>   slabp = GET_PAGE_SLAB(virt_to_page(objp));
>   nodeid = slabp->nodeid;
> +  WARN_ON(nodeid != numa_node_id());             <<<<<
>   l3 = cachep->nodelist[nodeid];
>   list_del(&slabp->list);
>   objnr = (objp - slabp->s_mem) / cachep->objsize;
>   check_spinlock_acquired_node(cachep, nodeid);
>   check_slabp(cachep, slabp);
> 
> ... saying that keventd/0 tries to operate on
> slab belonging to node#1, while having acquired lock for cachep belonging
  ^^^^^^^^^^^^^^^^^^^^^^^^^
> to node #0
  ^^^^^^^^^^

Just might be relevant here, I found a bug with the recent
x86_64 changes to 2.6.14-rc* which causes the node_to_cpumask[] to go bad for
the boot processor.  This happens on both amd and em64t boxes. I guess the
kevent/0 cpus_allowed mask might be changed by the bad node_to_cpumask[]
here?

On a opteron box (courtesy Ananth M)
# cat /sys/devices/system/node/node0/cpumap
00000000

# cat /sys/devices/system/node/node1/cpumap
00000003

On our em64t IBM x460 NUMA,

# cat /sys/devices/system/node/node0/cpumap
0000000e

# cat /sys/devices/system/node/node1/cpumap
000000f1

Here is a fix for that, I have sounded out Andi Kleen on this and waiting
for his comments.  Maybe somebody can test the patch below on amds?

Thanks,
Kiran

---
Patch to fix the BP node_to_cpumask.  2.6.14-rc* broke the boot cpu bit as
the cpu_to_node(0) is now not setup early enough for numa_init_array.
cpu_to_node[] is setup much later at srat_detect_node on acpi srat based
em64t machines.  This seems like a problem on amd machines too,  Tested on
em64t though. /sys/devices/system/node/node0/cpumap shows up sanely after
this patch.

Signed off by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>


Index: linux-2.6.14-rc1/arch/x86_64/mm/numa.c
===================================================================
--- linux-2.6.14-rc1.orig/arch/x86_64/mm/numa.c	2005-09-19 17:58:10.000000000 -0700
+++ linux-2.6.14-rc1/arch/x86_64/mm/numa.c	2005-09-27 01:34:20.000000000 -0700
@@ -178,7 +178,6 @@
 		rr++; 
 	}
 
-	set_bit(0, &node_to_cpumask[cpu_to_node(0)]);
 }
 
 #ifdef CONFIG_NUMA_EMU
@@ -266,9 +265,7 @@
 
 __cpuinit void numa_add_cpu(int cpu)
 {
-	/* BP is initialized elsewhere */
-	if (cpu) 
-		set_bit(cpu, &node_to_cpumask[cpu_to_node(cpu)]);
+	set_bit(cpu, &node_to_cpumask[cpu_to_node(cpu)]);
 } 
 
 unsigned long __init numa_free_all_bootmem(void) 
