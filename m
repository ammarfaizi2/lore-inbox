Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263296AbTDCGZk>; Thu, 3 Apr 2003 01:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263297AbTDCGZj>; Thu, 3 Apr 2003 01:25:39 -0500
Received: from [12.47.58.55] ([12.47.58.55]:60216 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S263296AbTDCGZi>;
	Thu, 3 Apr 2003 01:25:38 -0500
Date: Wed, 2 Apr 2003 22:37:36 -0800
From: Andrew Morton <akpm@digeo.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, hch@infradead.org,
       zeppegno.paolo@seat.it, ak@muc.de, lse-tech@lists.sourceforge.net
Subject: Re: [rfc][patch] Memory Binding Take 2 (1/1)
Message-Id: <20030402223736.1277755f.akpm@digeo.com>
In-Reply-To: <3E8BCD21.2050307@us.ibm.com>
References: <3E8BCB96.6090908@us.ibm.com>
	<3E8BCD21.2050307@us.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2003 06:36:58.0241 (UTC) FILETIME=[6CF36710:01C2F9AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> +#define __NR_mbind		223

What was wrong with "membind"?

> +/* Translate a cpumask to a nodemask */
> +static inline void cpumask_to_nodemask(bitmap_t cpumask, bitmap_t nodemask)
> +{
> +	int i;
> +
> +	for (i = 0; i < NR_CPUS; i++)
> +		if (test_bit(i, cpumask))

That's a bit weird.  test_bit is only permitted on longs, so why introduce
bitmap_t?

> +/* Top-level function for allocating a binding for a region of memory */
> +static inline struct binding *alloc_binding(bitmap_t nodemask)
> +{
> +	struct binding *binding;
> +	int node, zone_num;
> +
> +	binding = (struct binding *)kmalloc(sizeof(struct binding), GFP_KERNEL);
> +	if (!binding)
> +		return NULL;
> +	memset(binding, 0, sizeof(struct binding));
> +
> +	/* Build binding zonelist */
> +	for (node = 0, zone_num = 0; node < MAX_NUMNODES; node++)
> +		if (test_bit(node, nodemask) && node_online(node))
> +			zone_num = add_node(NODE_DATA(node), 
> +				&binding->zonelist, zone_num);
> +	binding->zonelist.zones[zone_num] = NULL;
> +
> +	if (zone_num == 0) {
> +		/* No zones were added to the zonelist.  Let the caller know. */
> +		kfree(binding);
> +		binding = NULL;
> +	}
> +	return binding;
> +} 

It looks like this function needs to be able to return a real errno (see
below).

> +asmlinkage unsigned long sys_mbind(unsigned long start, unsigned long len, 
> +		unsigned long *mask_ptr, unsigned int mask_len, unsigned long policy)
> +{
> +	DECLARE_BITMAP(cpu_mask, NR_CPUS);
> +	DECLARE_BITMAP(node_mask, MAX_NUMNODES);

Bah.  Who cooked that up?  It should be DEFINE_BITMAP.  Oh well.

> +	struct vm_area_struct *vma = NULL;
> +	struct address_space *mapping;
> +	int copy_len, error = 0;
> +
> +	/* Deal with getting cpu_mask from userspace & translating to node_mask */
> +	copy_len = min(mask_len, (unsigned int)NR_CPUS);
> +	CLEAR_BITMAP(cpu_mask, NR_CPUS);
> +	CLEAR_BITMAP(node_mask, MAX_NUMNODES);
> +	if (copy_from_user(cpu_mask, mask_ptr, (copy_len+7)/8)) {
> +		error = -EFAULT;
> +		goto out;
> +	}
> +	cpumask_to_nodemask(cpu_mask, node_mask);
> +
> +	vma = find_vma(current->mm, start);
> +	if (!(vma && vma->vm_file && vma->vm_ops && 
> +		vma->vm_ops->nopage == shmem_nopage)) {
> +		/* This isn't a shm segment.  For now, we bail. */
> +		error = -EINVAL;
> +		goto out;
> +	}
> +
> +	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
> +	mapping->binding = alloc_binding(node_mask);
> +	if (!mapping->binding)
> +		error = -EFAULT;

It returns EFAULT on memory exhaustion?


btw, can you remind me again why this is only available to tmpfs pagecache?

