Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbTDCMHG>; Thu, 3 Apr 2003 07:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263359AbTDCMHG>; Thu, 3 Apr 2003 07:07:06 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:9463 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S263362AbTDCMHC>; Thu, 3 Apr 2003 07:07:02 -0500
Date: Thu, 3 Apr 2003 13:20:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       Paolo Zeppegno <zeppegno.paolo@seat.it>, Andi Kleen <ak@muc.de>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [rfc][patch] Memory Binding Take 2 (1/1)
In-Reply-To: <3E8BCD21.2050307@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0304031317290.1718-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Matthew Dobson wrote:
+/*
+ * membind -  Bind a range of a process' VM space to a set of memory blocks according to

membind or mbind?  Me, I like mbind (modulo remarks below), but you may
find Linus does not (he was rather caustic when I suggested that fremap
should be mseek, and it ended up as remap_file_pages instead).

+ *            a predefined policy.
+ * @start:    beginning address of memory region to bind
+ * @len:      length of memory region to bind

Oh really? len is unused in the code below.  If you were to use it,
you'd need to loop over vmas, splitting where necessary.

+ * @mask_ptr: pointer to bitmask of cpus
+ * @mask_len: length of the bitmask
+ * @policy:   flag specifying the policy to use for the segment

I think you already remarked that policy is currently unused,
fair enough.

+ */
+asmlinkage unsigned long sys_mbind(unsigned long start, unsigned long len, 
+		unsigned long *mask_ptr, unsigned int mask_len, unsigned long policy)
+{
+	DECLARE_BITMAP(cpu_mask, NR_CPUS);
+	DECLARE_BITMAP(node_mask, MAX_NUMNODES);
+	struct vm_area_struct *vma = NULL;
+	struct address_space *mapping;
+	int copy_len, error = 0;
+
+	/* Deal with getting cpu_mask from userspace & translating to node_mask */
+	copy_len = min(mask_len, (unsigned int)NR_CPUS);
+	CLEAR_BITMAP(cpu_mask, NR_CPUS);
+	CLEAR_BITMAP(node_mask, MAX_NUMNODES);
+	if (copy_from_user(cpu_mask, mask_ptr, (copy_len+7)/8)) {
+		error = -EFAULT;
+		goto out;
+	}

Shouldn't there be some capability restriction?  Is it right that
anyone who can mmap a file for reading can determine its binding
(until the next does it differently)?

+	cpumask_to_nodemask(cpu_mask, node_mask);
+
+	vma = find_vma(current->mm, start);

You must not scan the vma list without at least
down_read(&current->mm->mmap_sem).

+	if (!(vma && vma->vm_file && vma->vm_ops && 
+		vma->vm_ops->nopage == shmem_nopage)) {
+		/* This isn't a shm segment.  For now, we bail. */

So you're allowing this on any file on tmpfs,
but on no file on any other filesystem: curious.

+		error = -EINVAL;
+		goto out;
+	}
+
+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	mapping->binding = alloc_binding(node_mask);

Your NUMA machines clearly have more memory than is good for you:
nowhere is there an equivalent free_binding: which in particular
would need to be called first here if binding is already set (or
else old structure reused), and when inode is freed.

So... mapping->binding conditions every page_cache_alloc for that
inode.  Hmm, what on earth does this have to do with mbind or membind?
It looks to me like fbind, except that you've dressed up the interface
to use an address in the caller's address space: presumably because you
couldn't get a file handle on SysV shared memory, and that's what you
were really wanting to bind, hence the shmem_nopage test?

I think this interface is confused (but it probably thinks I am).

+	if (!mapping->binding)
+		error = -EFAULT;
+
+out:
+	return error;
+}
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/mm/swap_state.c linux-2.5.66-membind/mm/swap_state.c
--- linux-2.5.66-pre_membind/mm/swap_state.c	Mon Mar 24 14:00:21 2003
+++ linux-2.5.66-membind/mm/swap_state.c	Tue Apr  1 17:12:00 2003
@@ -47,6 +47,9 @@
 	.i_shared_sem	= __MUTEX_INITIALIZER(swapper_space.i_shared_sem),
 	.private_lock	= SPIN_LOCK_UNLOCKED,
 	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
+#ifdef CONFIG_NUMA
+	.binding	= NULL,
+#endif
 };
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)

Please leave swap_state.c out of it: this patch does nothing but add
an ugly #ifdef to initialize something to 0 which would be 0 anyway.

Hugh

