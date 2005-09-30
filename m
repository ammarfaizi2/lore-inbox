Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVI3GHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVI3GHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVI3GHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:07:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932561AbVI3GHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:07:06 -0400
Date: Thu, 29 Sep 2005 23:05:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: vandrove@vc.cvut.cz, clameter@engr.sgi.com, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       shai@scalex86.org, ananth@in.ibm.com, ak@suse.de
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-Id: <20050929230540.6a8651fa.akpm@osdl.org>
In-Reply-To: <20050930054556.GA3599@localhost.localdomain>
References: <20050916230809.789d6b0b.akpm@osdl.org>
	<432EE103.5020105@vc.cvut.cz>
	<20050919112912.18daf2eb.akpm@osdl.org>
	<Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
	<20050919122847.4322df95.akpm@osdl.org>
	<Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
	<20050919221614.6c01c2d1.akpm@osdl.org>
	<43301578.8040305@vc.cvut.cz>
	<20050928210245.GA3760@localhost.localdomain>
	<433C1999.2060201@vc.cvut.cz>
	<20050930054556.GA3599@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Thu, Sep 29, 2005 at 06:43:05PM +0200, Petr Vandrovec wrote:
> > Ravikiran G Thirumalai wrote:
> > 
> > Unfortunately I must confirm that it does not fix problem.  But it pointed
> > out to me another thing - proc_inode_cache stuff is put into caches
> > BEFORE this code is executed.  So if anything in mm/slab.c relies
> > on node_to_mask[] being valid (and if it relies on some other things
> > which are set this late), it probably won't work.
> 
> The tests Alok carried out on Petr's box confirmed that cpu_to_node[BP] 
> is not setup early enough by numa_init_array due to the x86_64 changes in
>  2.6.14-rc*, and unfortunately set wrongly by the work around code in 
> numa_init_array(). cpu_to_node[0] gets set with 1 early and later gets set 
> properly to 0 during identify_cpu() when all cpus are brought up, but 
> confusing the numa slab in the process.
> 
> Here is a quick fix for this.  The right fix obviously is to have
> cpu_to_node[bsp] setup early for numa_init_array().  The following patch
> will fix the problem now, and the code can stay on even when cpu_to_node{BP] 
> gets fixed early correctly.
> 
> Thanks to Petr for access to his box.
> 
> Signed off by: Ravikiran Thirumalai <kiran@scalex86.org>
> Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
> 
> Index: slab-x86_64-fix-2.6.14-rc2/arch/x86_64/mm/numa.c
> ===================================================================
> --- slab-x86_64-fix-2.6.14-rc2.orig/arch/x86_64/mm/numa.c	2005-09-29 20:39:25.000000000 -0700
> +++ slab-x86_64-fix-2.6.14-rc2/arch/x86_64/mm/numa.c	2005-09-29 21:38:05.000000000 -0700
> @@ -167,15 +167,14 @@
>  	   mapping. To avoid this fill in the mapping for all possible
>  	   CPUs, as the number of CPUs is not known yet. 
>  	   We round robin the existing nodes. */
> -	rr = 0;
> +	rr = first_node(node_online_map);
>  	for (i = 0; i < NR_CPUS; i++) {
>  		if (cpu_to_node[i] != NUMA_NO_NODE)
>  			continue;
> +		cpu_to_node[i] = rr;
>  		rr = next_node(rr, node_online_map);
>  		if (rr == MAX_NUMNODES)
>  			rr = first_node(node_online_map);
> -		cpu_to_node[i] = rr;
> -		rr++; 
>  	}
>  
>  }

Is this fix independent from
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/broken-out/x86_64-fix-the-bp-node_to_cpumask.patch
?


