Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUDIBJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 21:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUDIBJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 21:09:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:17350 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261361AbUDIBJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 21:09:29 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040407234525.4f775c16.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis>
	 <20040407232712.2595ac16.ak@suse.de> <1081374061.9061.26.camel@arrakis>
	 <20040407234525.4f775c16.ak@suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1081472946.12673.310.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 08 Apr 2004 18:09:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 14:45, Andi Kleen wrote:

<snip>

> diff -u linux-2.6.5-mc2-numa/mm/mempolicy.c-o linux-2.6.5-mc2-numa/mm/mempolicy.c
> --- linux-2.6.5-mc2-numa/mm/mempolicy.c-o	2004-04-07 12:07:41.000000000 +0200
> +++ linux-2.6.5-mc2-numa/mm/mempolicy.c	2004-04-07 13:07:02.000000000 +0200

<snip more>

> +/* Ensure all existing pages follow the policy. */
> +static int
> +verify_pages(unsigned long addr, unsigned long end, unsigned long *nodes)
> +{
> +	while (addr < end) {
> +		struct page *p;
> +		pte_t *pte;
> +		pmd_t *pmd;
> +		pgd_t *pgd = pgd_offset_k(addr);
> +		if (pgd_none(*pgd)) {
> +			addr = (addr + PGDIR_SIZE) & PGDIR_MASK;
> +			continue;
> +		}
> +		pmd = pmd_offset(pgd, addr);
> +		if (pmd_none(*pmd)) {
> +			addr = (addr + PMD_SIZE) & PMD_MASK;
> +			continue;
> +		}
> +		p = NULL;
> +		pte = pte_offset_map(pmd, addr);
> +		if (pte_present(*pte))
> +			p = pte_page(*pte);
> +		pte_unmap(pte);
> +		if (p) {
> +			unsigned nid = page_zone(p)->zone_pgdat->node_id;
> +			if (!test_bit(nid, nodes))
> +				return -EIO;
> +		}
> +		addr += PAGE_SIZE;
> +	}
> +	return 0;
> +}

Instead of looking up a page's node number by
page_zone(p)->zone_pgdat->node_id, you can get the same information much
more efficiently by doing some bit-twidling on page->flags.  Use
page_nodenum(struct page *) from include/linux/mm.h.


> +/* Apply policy to a single VMA */
> +static int policy_vma(struct vm_area_struct *vma, struct mempolicy *new)
> +{
> +	int err = 0;
> +	struct mempolicy *old = vma->vm_policy;
> +
> +	PDprintk("vma %lx-%lx/%lx vm_ops %p vm_file %p set_policy %p\n",
> +		 vma->vm_start, vma->vm_end, vma->vm_pgoff,
> +		 vma->vm_ops, vma->vm_file,
> +		 vma->vm_ops ? vma->vm_ops->set_policy : NULL);
> +
> +	if (vma->vm_file)
> +		down(&vma->vm_file->f_mapping->i_shared_sem);
> +	if (vma->vm_ops && vma->vm_ops->set_policy)
> +		err = vma->vm_ops->set_policy(vma, new);
> +	if (!err) {
> +		mpol_get(new);
> +		vma->vm_policy = new;
> +		mpol_free(old);
> +	}
> +	if (vma->vm_file)
> +		up(&vma->vm_file->f_mapping->i_shared_sem);
> +	return err;
> +}

So it looks like you *are* sharing policies, at least for VMA's in the
range of a single mbind() call?  This is a good start! ;)  Looking
further ahead, I'm a bit confused.  It seems despite *sharing* VMA's
belonging to a single mbind() call, you *copy* VMA's during dup_mmap(),
copy_process(), split_vma(), and move_vma().  So in the majority of
cases you duplicate policies instead of sharing them, but you *do* share
them in some instances?  Why the inconsistency?


> +/* Change policy for a memory range */
> +asmlinkage long sys_mbind(unsigned long start, unsigned long len,
> +			  unsigned long mode,
> +			  unsigned long *nmask, unsigned long maxnode,
> +			  unsigned flags)

What would you think about giving sys_mbind() a pid argument, like
sys_sched_setaffinity()?  It would make it much easier for sysadmins to
use the API if they didn't have to rewrite applications to make these
calls on their own.  There's already a plethora of arguments, so one
more might be overkill....  Just a thought.


> +{
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm = current->mm;
> +	struct mempolicy *new;
> +	unsigned long end;
> +	DECLARE_BITMAP(nodes, MAX_NUMNODES);
> +	int err;
> +
> +	if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
> +		return -EINVAL;
> +	if (start & ~PAGE_MASK)
> +		return -EINVAL;
> +	if (mode == MPOL_DEFAULT)
> +		flags &= ~MPOL_MF_STRICT;
> +	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
> +	end = start + len;
> +	if (end < start)
> +		return -EINVAL;
> +	if (end == start)
> +		return 0;
> +
> +	err = get_nodes(nodes, nmask, maxnode, mode);
> +	if (err)
> +		return err;
> +
> +	new = new_policy(mode, nodes);
> +	if (IS_ERR(new))
> +		return PTR_ERR(new);
> +
> +	PDprintk("mbind %lx-%lx mode:%ld nodes:%lx\n",start,start+len,
> +			mode,nodes[0]);
> +
> +	down_write(&mm->mmap_sem);
> +	vma = check_range(mm, start, end, nodes, flags);
> +	err = PTR_ERR(vma);
> +	if (!IS_ERR(vma))
> +		err = mbind_range(vma, start, end, new);
> +	up_write(&mm->mmap_sem);
> +	mpol_free(new);
> +	return err;
> +}
> +
> +/* Set the process memory policy */
> +asmlinkage long sys_set_mempolicy(int mode, unsigned long *nmask,
> +				   unsigned long maxnode)
> +{
> +	int err;
> +	struct mempolicy *new;
> +	DECLARE_BITMAP(nodes, MAX_NUMNODES);
> +
> +	if (mode > MPOL_MAX)
> +		return -EINVAL;
> +	err = get_nodes(nodes, nmask, maxnode, mode);
> +	if (err)
> +		return err;
> +	new = new_policy(mode, nodes);
> +	if (IS_ERR(new))
> +		return PTR_ERR(new);
> +	mpol_free(current->mempolicy);
> +	current->mempolicy = new;
> +	if (new && new->policy == MPOL_INTERLEAVE)
> +		current->il_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
> +	return 0;
> +}

Why not condense both the sys_mbind() & sys_set_mempolicy() into a
single call?  The functionality of these calls (and even their code) is
very similar.  The main difference is there is no need for looking up
VMA's and doing locking in the sys_set_mempolicy() case.  You overload
the output side (sys_get_mempolicy()) to handle both whole process and
memory range options, but you don't do the same on the input
(sys_mbind() and sys_set_mempolicy()).  Saving one syscall and having
them behave more symmetrically would be a nice addition...


> +/* Fill a zone bitmap for a policy */
> +static void get_zonemask(struct mempolicy *p, unsigned long *nodes)
> +{
> +	int i;
> +	bitmap_clear(nodes, MAX_NUMNODES);
> +	switch (p->policy) {
> +	case MPOL_BIND:
> +		for (i = 0; p->v.zonelist->zones[i]; i++)
> +			__set_bit(p->v.zonelist->zones[i]->zone_pgdat->node_id, nodes);
> +		break;
> +	case MPOL_DEFAULT:
> +		break;
> +	case MPOL_INTERLEAVE:
> +		bitmap_copy(nodes, p->v.nodes, MAX_NUMNODES);
> +		break;
> +	case MPOL_PREFERRED:
> +		/* or use current node instead of online map? */
> +		if (p->v.preferred_node < 0)
> +			bitmap_copy(nodes, node_online_map, MAX_NUMNODES);
> +		else	
> +			__set_bit(p->v.preferred_node, nodes);
> +		break;
> +	default:
> +		BUG();
> +	}	
> +}

Shouldn't this be called get_nodemask()?  You're setting a bit in a
bitmask called 'nodes' for each node the policy is using, so you're
getting a nodemask, not a zonemask...


> +static int lookup_node(struct mm_struct *mm, unsigned long addr)
> +{
> +	struct page *p;
> +	int err;
> +	err = get_user_pages(current, mm, addr & PAGE_MASK, 1, 0, 0, &p, NULL);
> +	if (err >= 0) {
> +		err = page_zone(p)->zone_pgdat->node_id;
> +		put_page(p);
> +	}	
> +	return err;
> +}

Again, you can save some pointer dereferences if you call
page_nodenum(p) instead of looking it up through the pgdat.


> +/* Retrieve NUMA policy */
> +asmlinkage long sys_get_mempolicy(int *policy,
> +				  unsigned long *nmask, unsigned long maxnode,
> +				  unsigned long addr, unsigned long flags)	

I had a thought...  Shouldn't all your user pointers be marked as such
with __user?  Ie:
asmlinkage long sys_get_mempolicy(int __user *policy, 
			unsigned long __user *nmask,
			unsigned long maxnode, unsigned long addr,
			unsigned long flags)	

This would apply to the other 2 syscalls as well.


> +{
> +	int err, pval;
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma = NULL; 	
> +	struct mempolicy *pol = current->mempolicy;
> +
> +	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
> +		return -EINVAL;
> +	if (nmask != NULL && maxnode < numnodes)
> +		return -EINVAL;

Did you mean: if (nmask == NULL || maxnode < numnodes) ?


<snip>

> +/* Do static interleaving for a VMA with known offset. */
> +static unsigned
> +offset_il_node(struct mempolicy *pol, struct vm_area_struct *vma, unsigned long off)
> +{
> +	unsigned target = (unsigned)off % (unsigned)numnodes;
> +	int c;
> +	int nid = -1;
> +	c = 0;
> +	do {
> +		nid = find_next_bit(pol->v.nodes, MAX_NUMNODES, nid+1);
> +		if (nid >= MAX_NUMNODES) {
> +			nid = -1; 		
> +			continue;
> +		}
> +		c++;
> +	} while (c <= target);
> +	BUG_ON(nid >= MAX_NUMNODES);
> +	return nid;
> +}

I think that BUG_ON should be BUG_ON(nid < 0), since it *shouldn't* be
possible to get through that loop with nid >= MAX_NUMNODES.  The only
line that could set nid >= MAX_NUMNODES is nid = find_next_bit(...); and
the very next line ensures that if nid is in fact >= MAX_NUMNODES it
will be set to -1.  It actually looks pretty redundant altogether,
but...

More comments to follow...

-Matt

