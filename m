Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbTDCX4j (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 18:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTDCX4j (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 18:56:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:45565 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263576AbTDCX4e (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 18:56:34 -0500
Message-ID: <3E8CCA73.5050006@us.ibm.com>
Date: Thu, 03 Apr 2003 15:57:39 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       Paolo Zeppegno <zeppegno.paolo@seat.it>, Andi Kleen <ak@muc.de>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [rfc][patch] Memory Binding Take 2 (1/1)
References: <Pine.LNX.4.44.0304031317290.1718-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 2 Apr 2003, Matthew Dobson wrote:
> +/*
> + * membind -  Bind a range of a process' VM space to a set of memory blocks according to
> 
> membind or mbind?  Me, I like mbind (modulo remarks below), but you may
> find Linus does not (he was rather caustic when I suggested that fremap
> should be mseek, and it ended up as remap_file_pages instead).

I'm a fan of mbind.  s/mbind/whatever_linus_wants/ should be easy enough 
if necessary. ;)

> + *            a predefined policy.
> + * @start:    beginning address of memory region to bind
> + * @len:      length of memory region to bind
> 
> Oh really? len is unused in the code below.  If you were to use it,
> you'd need to loop over vmas, splitting where necessary.

No.. Not really! ;)  As I mentioned in my reply to Andrew, one of the 
main thrusts of this patch is to set up the infrastructure in a way that 
allows it to be fairly easily expanded in the future.  For now, as has 
been noted several time, it just works on shared memory segments and 
doesn't actually respect the length argument.  Your point is well taken, 
though.  I imagine the code for looping over vmas will looks similar to 
what is done in the mmap and mlock calls.

> + */
> +asmlinkage unsigned long sys_mbind(unsigned long start, unsigned long len, 
> +		unsigned long *mask_ptr, unsigned int mask_len, unsigned long policy)
> +{
> +	DECLARE_BITMAP(cpu_mask, NR_CPUS);
> +	DECLARE_BITMAP(node_mask, MAX_NUMNODES);
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
> 
> Shouldn't there be some capability restriction?  Is it right that
> anyone who can mmap a file for reading can determine its binding
> (until the next does it differently)?

Probably.  Once the binding call is expanded to encompass any mmap'd 
file, then yes, we'll want capabilities.  For now, with just shared 
memory segments, it's probably not quite as imperative.  Although I 
guess it also works for any shmem_fs segments, too.  I'll look into 
finding an appropriate capability to check...  Any suggestions?

> +	cpumask_to_nodemask(cpu_mask, node_mask);
> +
> +	vma = find_vma(current->mm, start);
> 
> You must not scan the vma list without at least
> down_read(&current->mm->mmap_sem).

OK..  Thanks for the heads up! ;)

> +	if (!(vma && vma->vm_file && vma->vm_ops && 
> +		vma->vm_ops->nopage == shmem_nopage)) {
> +		/* This isn't a shm segment.  For now, we bail. */
> 
> So you're allowing this on any file on tmpfs,
> but on no file on any other filesystem: curious.

See comments near the top of this reply, and the comments in my reply to 
Andrew.

> +		error = -EINVAL;
> +		goto out;
> +	}
> +
> +	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
> +	mapping->binding = alloc_binding(node_mask);
> 
> Your NUMA machines clearly have more memory than is good for you:
> nowhere is there an equivalent free_binding: which in particular
> would need to be called first here if binding is already set (or
> else old structure reused), and when inode is freed.

Heh...  erm, maybe I should retake CS-101.  Version 3 awaits! ;)

> So... mapping->binding conditions every page_cache_alloc for that
> inode.  Hmm, what on earth does this have to do with mbind or membind?
> It looks to me like fbind, except that you've dressed up the interface
> to use an address in the caller's address space: presumably because you
> couldn't get a file handle on SysV shared memory, and that's what you
> were really wanting to bind, hence the shmem_nopage test?
> 
> I think this interface is confused (but it probably thinks I am).

The original RFC I sent out some time ago was for shared memory segment 
binding only.  This is to be expanded, as per comments above.

> +	if (!mapping->binding)
> +		error = -EFAULT;
> +
> +out:
> +	return error;
> +}
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/mm/swap_state.c linux-2.5.66-membind/mm/swap_state.c
> --- linux-2.5.66-pre_membind/mm/swap_state.c	Mon Mar 24 14:00:21 2003
> +++ linux-2.5.66-membind/mm/swap_state.c	Tue Apr  1 17:12:00 2003
> @@ -47,6 +47,9 @@
>  	.i_shared_sem	= __MUTEX_INITIALIZER(swapper_space.i_shared_sem),
>  	.private_lock	= SPIN_LOCK_UNLOCKED,
>  	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
> +#ifdef CONFIG_NUMA
> +	.binding	= NULL,
> +#endif
>  };
>  
>  #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
> 
> Please leave swap_state.c out of it: this patch does nothing but add
> an ugly #ifdef to initialize something to 0 which would be 0 anyway.

Also in the anxiously awaited version 3.  Or should I say *not* in it?

Cheers!

-Matt

