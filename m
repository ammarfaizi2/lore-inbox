Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263562AbTDCX3f (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 18:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTDCX3f (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 18:29:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:52709 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263562AbTDCX3d (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 18:29:33 -0500
Message-ID: <3E8CC41D.90003@us.ibm.com>
Date: Thu, 03 Apr 2003 15:30:37 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, mbligh@aracnet.com, hch@infradead.org,
       zeppegno.paolo@seat.it, ak@muc.de, lse-tech@lists.sourceforge.net,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [rfc][patch] Memory Binding Take 2 (1/1)
References: <3E8BCB96.6090908@us.ibm.com>	<3E8BCD21.2050307@us.ibm.com> <20030402223736.1277755f.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>+#define __NR_mbind		223
> 
> 
> What was wrong with "membind"?
Well, there was nothing wrong with it, per se, I just liked Paolo's 
suggestion to align the naming with mmap, munmap, mremap, etc.  The 
syscalls that manipulate a processes address space tend to be called 
m(something).  Right now it isn't as generic as I'd like it to be, but 
all in good time.

>>+/* Translate a cpumask to a nodemask */
>>+static inline void cpumask_to_nodemask(bitmap_t cpumask, bitmap_t nodemask)
>>+{
>>+	int i;
>>+
>>+	for (i = 0; i < NR_CPUS; i++)
>>+		if (test_bit(i, cpumask))
> 
> 
> That's a bit weird.  test_bit is only permitted on longs, so why introduce
> bitmap_t?
Erm...  Good point.  I really wanted to try and maintain the abstraction 
of a bitmap type.  I hoped that we could, via macros and typedefs, keep 
the underlying data type obscured, and have a good facsimile of variable 
length bitmaps.  It's proving too difficult to hide the fact that 
they're just unsigned long[]'s, so I'll give up the ghost and pass them 
as unsigned long *'s.

>>+/* Top-level function for allocating a binding for a region of memory */
>>+static inline struct binding *alloc_binding(bitmap_t nodemask)
>>+{
>>+	struct binding *binding;
>>+	int node, zone_num;
>>+
>>+	binding = (struct binding *)kmalloc(sizeof(struct binding), GFP_KERNEL);
>>+	if (!binding)
>>+		return NULL;
>>+	memset(binding, 0, sizeof(struct binding));
>>+
>>+	/* Build binding zonelist */
>>+	for (node = 0, zone_num = 0; node < MAX_NUMNODES; node++)
>>+		if (test_bit(node, nodemask) && node_online(node))
>>+			zone_num = add_node(NODE_DATA(node), 
>>+				&binding->zonelist, zone_num);
>>+	binding->zonelist.zones[zone_num] = NULL;
>>+
>>+	if (zone_num == 0) {
>>+		/* No zones were added to the zonelist.  Let the caller know. */
>>+		kfree(binding);
>>+		binding = NULL;
>>+	}
>>+	return binding;
>>+} 
> 
> It looks like this function needs to be able to return a real errno (see
> below).
True.  EFAULT is a sorta decent catchall, but not appropriate for 
something like no memory, etc.

>>+	struct vm_area_struct *vma = NULL;
>>+	struct address_space *mapping;
>>+	int copy_len, error = 0;
>>+
>>+	/* Deal with getting cpu_mask from userspace & translating to node_mask */
>>+	copy_len = min(mask_len, (unsigned int)NR_CPUS);
>>+	CLEAR_BITMAP(cpu_mask, NR_CPUS);
>>+	CLEAR_BITMAP(node_mask, MAX_NUMNODES);
>>+	if (copy_from_user(cpu_mask, mask_ptr, (copy_len+7)/8)) {
>>+		error = -EFAULT;
>>+		goto out;
>>+	}
>>+	cpumask_to_nodemask(cpu_mask, node_mask);
>>+
>>+	vma = find_vma(current->mm, start);
>>+	if (!(vma && vma->vm_file && vma->vm_ops && 
>>+		vma->vm_ops->nopage == shmem_nopage)) {
>>+		/* This isn't a shm segment.  For now, we bail. */
>>+		error = -EINVAL;
>>+		goto out;
>>+	}
>>+
>>+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
>>+	mapping->binding = alloc_binding(node_mask);
>>+	if (!mapping->binding)
>>+		error = -EFAULT;
> 
> 
> It returns EFAULT on memory exhaustion?
No longer...  That'll be fixed in version 3.

> btw, can you remind me again why this is only available to tmpfs pagecache?
I can try! ;)  I originally wanted to do just a shared memory binding 
call, but people (correctly) suggested a more generic memory binding 
would be more useful.  So I've basically just set up a lot of the 
infrastructure for a more generic call, but haven't fully implemented 
it.  This patch is intended to be a starting point, from which it will 
be easy to incrementally add more functionality and power to the binding 
call.  The underlying code (syscalls, structures, .c files, allocator 
changes) won't have to change too much.  So this patch works for any 
shared memory segment.  It'd be straightforward to extend this to any 
file-backed vma (because it already has a struct address_space, with a 
struct binding in it), so I hope to grow this into something more.

Cheers!

-Matt

