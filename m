Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUHJF0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUHJF0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 01:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267436AbUHJF0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 01:26:39 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:30103 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267435AbUHJF0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 01:26:30 -0400
Date: Mon, 9 Aug 2004 22:25:31 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: bcasavan@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] get_nodes mask miscalculation
Message-Id: <20040809222531.1d2d8d05.pj@sgi.com>
In-Reply-To: <m31xifu5pn.fsf@averell.firstfloor.org>
References: <2rr7U-5xT-11@gated-at.bofh.it>
	<m31xifu5pn.fsf@averell.firstfloor.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> The idea behind this is was to make it behave like select.
> And select passes highest valid value + 1. In this case
> valid value is not the highest bit number, but the length
> of the bitmap.

Andi,

I think I need to be a pain in the butt about this ... sorry.

I wish I had had enough numa-sense to recognize this issue when
you proposed your patch earlier, when it would have been easier.

But this off-by-one wrinkle to the numa API cost me some time as
well, and I don't think Brent nor I are going to be the exception.

I'd like to request that you consider the following, admittedly
ugly, changes.

First, a little more motivation ...

If, say, I have 32 Nodes, numbered 0 ... 31, then it would be entirely
unsurprising for me to consider 31 to be the highest valid value (highest
valid node number), and hence expect to pass 32.

The get_mempolicy(2) man page (numactl-0.7-pre1) states:

    maxnode is the maximum bit number plus one that can be stored
    into nodemask.

This seems to read consistently with such expectations - the max
bit number is 31, so pass 32.  Wrong.

The mbind(2) and set_mempolicy(2) state this in different words,
but words which, to me, mean pretty much the same (wrong) thing:

    nodemask is pointer to a bit field of nodes that contains upto
    maxnode bits.

And the code is further confusing.  There are several places in
the code that either decrement maxnode (maxnode--), or keep its
passed in value, and work with one less (maxnode - 1).  So the
meaning of maxnode within the code is inconsistent.

Besides the man page, the other key documentation is the code.
Brent tried reading that, and came away with the wrong answer.

While I'm here, the statement that only the highest zone is policied
actually applies only to MPOL_BIND, right?  The comment that asserts
this should be so qualified, I suspect.

And there are hardcoded numbers 64 and 8 in copy_nodes_to_user().
Please consider replacing with appropriate macros.

So ... here's what I'd suggest:

 1) Change the man page wording, for each of get_mempolicy(2), mbind(2),
    and set_mempolicy(2), to boldly state:

	Beware:
		Pass in a value of maxnode that is * one more * than the
		number of nodes represented in nodemask.  If for example,
		nodemask represents 64 nodes, numbered 0 to 63, pass in a
		value of 65 for maxnodes.

 2) Review, test, fix, and apply as fixed the following patch.  For extra
    credit, get rid of the hard coded 8, 32 and 64 values in the compat stuff,
    visible in the patch below.  I compiled the patch, once, on an ia64.
    Otherwise totally untested.

    This patch:
	a) Notes the situation in a prominent "==> Beware <==".
	b) Consistently decrements maxnode immediately on each system call
	   entry (where someone reading the code might best notice).
	c) Otherwise treats maxnode consistently within the code.
	d) Addresses the MPOL_BIND max policy only comment.
	e) Addresses the harcoded numbers 64 and 8 in copy_nodes_to_user().

    Yes - it's ugly.  The time that will be lost by those who try to use
    this interface directly will be ugly too.

 3) Could you propose a strategy for fixing this?  It might take a couple
    of steps, and there might be other inconsistencies in the interim, such
    as special case handling in the kernel for maxnode values of 2049.  If
    you have to tell me that SGI has to put in a workaround for a year, on
    any machine with _exactly_ 2049 nodes, such as padding the user nodemask
    up to 2050 nodes, I'm prepared to deal with that <grin>.

    Sure seems like it would be worth it, in the long run.

Thanks for considering this.

Signed-off-by: Paul Jackson <pj@sgi.com>

diff -Naurp 2.6.8-rc3-mm2.orig/mm/mempolicy.c 2.6.8-rc3-mm2/mm/mempolicy.c
--- 2.6.8-rc3-mm2.orig/mm/mempolicy.c	2004-08-09 21:35:16.000000000 -0700
+++ 2.6.8-rc3-mm2/mm/mempolicy.c	2004-08-09 21:35:34.000000000 -0700
@@ -7,6 +7,17 @@
  * NUMA policy allows the user to give hints in which node(s) memory should
  * be allocated.
  *
+ *
+ * ==> Beware <==
+ *
+ *	Pass in a value of maxnode to the system calls mbind(2),
+ *	get_mempolicy(2) and set_mempolicy(2) that is one larger
+ *	than you expect.  If you have 64 nodes, represented by bits
+ *	numbered 0..63 in your nodemask -- pass in 65 for maxnode.
+ *	To remain compatible with existing libnuma user code, this
+ *	cannot be changed.
+ *	
+ *
  * Support four policies per VMA and per process:
  *
  * The VMA policy has priority over the process policy for a page fault.
@@ -37,10 +48,10 @@
  * is not applied, but the majority should be handled. When process policy
  * is used it is not remembered over swap outs/swap ins.
  *
- * Only the highest zone in the zone hierarchy gets policied. Allocations
- * requesting a lower zone just use default policy. This implies that
- * on systems with highmem kernel lowmem allocation don't get policied.
- * Same with GFP_DMA allocations.
+ * When using MPOL_BIND, only the highest zone in the zone hierarchy gets
+ * policied. Allocations requesting a lower zone just use default policy.
+ * This implies that on systems with highmem kernel lowmem allocation don't
+ * get policied by MPOL_BIND.  Same with GFP_DMA allocations.
  *
  * For shmfs/tmpfs/hugetlbfs shared memory the policy is shared between
  * all users and remembered even when nobody has memory mapped.
@@ -84,7 +95,7 @@ static kmem_cache_t *sn_cache;
 #define PDprintk(fmt...)
 
 /* Highest zone. An specific allocation for a zone below that is not
-   policied. */
+   policied by MPOL_BIND */
 static int policy_zone;
 
 static struct mempolicy default_policy = {
@@ -134,7 +145,6 @@ static int get_nodes(unsigned long *node
 	unsigned long nlongs;
 	unsigned long endmask;
 
-	--maxnode;
 	bitmap_zero(nodes, MAX_NUMNODES);
 	if (maxnode == 0 || !nmask)
 		return 0;
@@ -352,6 +362,8 @@ asmlinkage long sys_mbind(unsigned long 
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
 	int err;
 
+	maxnode = maxnode - 1;			/* See ==> Beware <==, above */
+
 	if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
 		return -EINVAL;
 	if (start & ~PAGE_MASK)
@@ -394,6 +406,8 @@ asmlinkage long sys_set_mempolicy(int mo
 	struct mempolicy *new;
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
 
+	maxnode = maxnode - 1;			/* See ==> Beware <==, above */
+
 	if (mode > MPOL_MAX)
 		return -EINVAL;
 	err = get_nodes(nodes, nmask, maxnode, mode);
@@ -454,8 +468,7 @@ static int lookup_node(struct mm_struct 
 static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 			      void *nodes, unsigned nbytes)
 {
-	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
-
+	unsigned long copy =  BITS_TO_LONGS(maxnode) * sizeof(unsigned long);
 	if (copy > nbytes) {
 		if (copy > PAGE_SIZE)
 			return -EINVAL;
@@ -477,6 +490,8 @@ asmlinkage long sys_get_mempolicy(int __
 	struct vm_area_struct *vma = NULL;
 	struct mempolicy *pol = current->mempolicy;
 
+	maxnode = maxnode - 1;			/* See ==> Beware <==, above */
+
 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
 		return -EINVAL;
 	if (nmask != NULL && maxnode < numnodes)
@@ -539,10 +554,13 @@ asmlinkage long compat_get_mempolicy(int
 {
 	long err;
 	unsigned long __user *nm = NULL;
+
+	maxnode = maxnode - 1;			/* See ==> Beware <==, above */
+
 	if (nmask)
-		nm = compat_alloc_user_space(ALIGN(maxnode-1, 64) / 8);
+		nm = compat_alloc_user_space(ALIGN(maxnode, 64) / 8);
 	err = sys_get_mempolicy(policy, nm, maxnode, addr, flags);
-	if (!err && copy_in_user(nmask, nm, ALIGN(maxnode-1, 32)/8))
+	if (!err && copy_in_user(nmask, nm, ALIGN(maxnode, 32)/8))
 		err = -EFAULT;
 	return err;
 }



-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
