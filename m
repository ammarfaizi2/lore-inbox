Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262947AbTDBIGB>; Wed, 2 Apr 2003 03:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262948AbTDBIGB>; Wed, 2 Apr 2003 03:06:01 -0500
Received: from ns.suse.de ([213.95.15.193]:4365 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262947AbTDBIF6>;
	Wed, 2 Apr 2003 03:05:58 -0500
Subject: Re: [Lse-tech] Re: [patch][rfc] Memory Binding (1/1)
From: Andi Kleen <ak@suse.de>
To: colpatch@us.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <3E8A151A.1040800@us.ibm.com>
References: <3E8A135B.3030106@us.ibm.com>  <3E8A151A.1040800@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Apr 2003 10:17:16 +0200
Message-Id: <1049271440.30759.183.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 00:39, Matthew Dobson wrote:

I'm not sure why you do this on shm segments only. Why not directly on
vmas ? 

I'm considering to add a similar thing to the mm_struct to allow
processes to allocate on their "homenode" only. But I could also live
with it being per VMA.

In case of a large number of such bindings or nodes it may make sense
to cache and share the zone lists, but that can be probably left for a
future patch.

> +static inline struct page *__page_cache_alloc(struct address_space *x, int cold)
> +{
> +	int gfp_mask;
> +	struct zonelist *zonelist;
> +
> +	gfp_mask = x->gfp_mask;
> +	if (cold)
> +		gfp_mask |= __GFP_COLD;
> +	if (!x->binding)
> +		zonelist = get_zonelist(gfp_mask);
> +	else
> +		zonelist = &x->binding->zonelist;
> +
> +	return __alloc_pages(gfp_mask, 0, zonelist);
> +}

I would move a function of this size out of line. In fact i think it
should even in the non NUMA case be a simple function call with zonelist
getting evaluated out-of-line.




> +asmlinkage unsigned long sys_membind(unsigned long start, unsigned long len, 
> +		unsigned long *mask_ptr, unsigned int mask_len, unsigned long policy)
> +{
> +	DECLARE_BITMAP(cpu_mask, NR_CPUS);
> +	DECLARE_BITMAP(node_mask, MAX_NUMNODES);
> +	struct vm_area_struct *vma = NULL;
> +	struct address_space *mapping;
> +	int error = 0;
> +
> +	/* Deal with getting cpu_mask from userspace & translating to node_mask */
> +	if (mask_len > NR_CPUS) {
> +		error = -EINVAL;
> +		goto out;
> +	}

I don't like that check. It requires hardcoding NR_CPUs (which can be
variable!) in the application. It would be better to allow arbitary
length arguments, but only error when there is a bit set outside
NR_CPUS. Of course arbitary would be hard regarding the copy from user,
so perhaps use some very big limit (e.g. one page worth of bitmap) 


> +	CLEAR_BITMAP(cpu_mask, NR_CPUS);
> +	CLEAR_BITMAP(node_mask, MAX_NUMNODES);
> +	if (copy_from_user(cpu_mask, mask_ptr, (mask_len+7)/8)) {
> +		error = -EFAULT;
> +		goto out;
> +	}
> +	cpumask_to_nodemask(cpu_mask, node_mask);
> +
> +	vma = find_vma(current->mm, start);
> +	if (!(vma && vma->vm_file && vma->vm_ops && 
> +		vma->vm_ops->nopage == shmem_nopage)) {
> +		/* This isn't a shm segment.  For now, we bail. */
> +		printk("%s: Can only bind shm(em) segments for now!\n", __FUNCTION__);

Instead of __FUNCTION__ i would use current->comm here. 

Or better perhaps just remove the error printks.

-Andi


