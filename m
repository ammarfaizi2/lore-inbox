Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbUDOAjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 20:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUDOAjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 20:39:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:11973 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262742AbUDOAi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 20:38:56 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040407232712.2595ac16.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis>
	 <20040407232712.2595ac16.ak@suse.de>
Content-Type: multipart/mixed; boundary="=-xAhPQI3A1AGk9H3Gl99P"
Organization: IBM LTC
Message-Id: <1081989517.1206.206.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Apr 2004 17:38:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xAhPQI3A1AGk9H3Gl99P
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andi,
	I'm sure you're sick of me commenting on your patches without "showing
you the money".  I've attached a patch with some of the changes I think
would be beneficial.  Feel free to let me know which changes you think
are crap and which you think are not.

Changes include:

1) Redefine the value of some of the MPOL_* flags
2) Rename check_* to mpol_check_*
3) Remove get_nodes().  This should be done in the same manner as
sys_sched_setaffinity().  We shouldn't care about unused high bits.
4) Create mpol_check_flags() to, well, check the flags.  As the number
of flags and modes grows, it will be easier to do this check in its own
function.
5) In the syscalls (sys_mbind() & sys_set_mempolicy()), change 'len' to
a size_t, add __user to the declaration of 'nmask', change 'maxnode' to
'nmask_len', and condense 'flags' and 'mode' into 'flags'.  The
motivation here is to make this syscall similar to
sys_sched_setaffinity().  These calls are basically the memory
equivalent of set/getaffinity, and should look & behave that way.  Also,
dropping an argument leaves an opening for a pid argument, which I
believe would be good.  We should allow processes (with appropriate
permissions, of course) to mbind other processes.
6) Change how end is calculated as follows:
	end = PAGE_ALIGN(start+len);
	start &= PAGE_MASK;
Basically, this allows users to pass in a non-page aligned 'start', and
makes sure we mbind all pages from the page containing 'start' to the
page containing 'start'+'len'.

This patch also shows that sys_mbind() and sys_set_mempolicy() have more
commonalities than differences.  I believe these two syscalls should be
combined into one with the call signature of sys_mbind().  If the user
passes a start address and length of 0 (or maybe even a flag?), we bind
the whole process, otherwise we bind just a region.  This would shrink
the patch even more than the measly 3 lines the current patch saves, and
save a syscall.

[mcd@arrakis source]$ diffstat ~/linux/patches/265-mm4/mcd_mods.patch
 include/linux/mempolicy.h |   12 ++--
 mm/mempolicy.c            |  119
++++++++++++++++++++++------------------------
 2 files changed, 64 insertions(+), 67 deletions(-)

-Matt

--=-xAhPQI3A1AGk9H3Gl99P
Content-Disposition: attachment; filename=mcd_mods.patch
Content-Type: text/x-patch; name=mcd_mods.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.5-mm4/include/linux/mempolicy.h linux-2.6.5-mcd_numa_api/include/linux/mempolicy.h
--- linux-2.6.5-mm4/include/linux/mempolicy.h	2004-04-12 15:07:18.000000000 -0700
+++ linux-2.6.5-mcd_numa_api/include/linux/mempolicy.h	2004-04-14 17:13:22.000000000 -0700
@@ -8,20 +8,22 @@
  * Copyright 2003,2004 Andi Kleen SuSE Labs
  */
 
-/* Policies */
+/* Policies aka 'modes' */
 #define MPOL_DEFAULT	0
 #define MPOL_PREFERRED	1
 #define MPOL_BIND	2
 #define MPOL_INTERLEAVE	3
 
-#define MPOL_MAX MPOL_INTERLEAVE
+#define MPOL_MAX	(MPOL_INTERLEAVE)
+/* Reserve low 4 bits for policies, ie: 16 possible 'modes' */
+#define MPOL_MODE_MASK	(0xf)
 
 /* Flags for get_mem_policy */
-#define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */
-#define MPOL_F_ADDR	(1<<1)	/* look up vma using address */
+#define MPOL_F_NODE	(1<<4)	/* return next IL mode instead of node mask */
+#define MPOL_F_ADDR	(1<<5)	/* look up vma using address */
 
 /* Flags for mbind */
-#define MPOL_MF_STRICT	(1<<0)	/* Verify existing pages in the mapping */
+#define MPOL_MF_STRICT	(1<<6)	/* Verify existing pages in the mapping */
 
 #ifdef __KERNEL__
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.5-mm4/mm/mempolicy.c linux-2.6.5-mcd_numa_api/mm/mempolicy.c
--- linux-2.6.5-mm4/mm/mempolicy.c	2004-04-12 15:42:30.000000000 -0700
+++ linux-2.6.5-mcd_numa_api/mm/mempolicy.c	2004-04-14 17:22:05.000000000 -0700
@@ -88,13 +88,11 @@ static struct mempolicy default_policy =
 };
 
 /* Check if all specified nodes are online */
-static int check_online(unsigned long *nodes)
+static int mpol_check_online(unsigned long *nodes)
 {
 	DECLARE_BITMAP(offline, MAX_NUMNODES);
 
 	bitmap_copy(offline, node_online_map, MAX_NUMNODES);
-	if (bitmap_empty(offline, MAX_NUMNODES))
-		set_bit(0, offline);
 	bitmap_complement(offline, MAX_NUMNODES);
 	bitmap_and(offline, offline, nodes, MAX_NUMNODES);
 	if (!bitmap_empty(offline, MAX_NUMNODES))
@@ -103,7 +101,7 @@ static int check_online(unsigned long *n
 }
 
 /* Do sanity checking on a policy */
-static int check_policy(int mode, unsigned long *nodes)
+static int mpol_check_policy(int mode, unsigned long *nodes)
 {
 	int empty = bitmap_empty(nodes, MAX_NUMNODES);
 
@@ -120,46 +118,25 @@ static int check_policy(int mode, unsign
 			return -EINVAL;
 		break;
 	}
-	return check_online(nodes);
+	return mpol_check_online(nodes);
 }
 
-/* Copy a node mask from user space. */
-static int get_nodes(unsigned long *nodes, unsigned long *nmask,
-		     unsigned long maxnode, int mode)
-{
-	unsigned long k;
-	unsigned long nlongs;
-	unsigned long endmask;
-
-	--maxnode;
-	nlongs = BITS_TO_LONGS(maxnode);
-	if ((maxnode % BITS_PER_LONG) == 0)
-		endmask = ~0UL;
-	else
-		endmask = (1UL << (maxnode % BITS_PER_LONG)) - 1;
-
-	/* When the user specified more nodes than supported just check
-	   if the non supported part is all zero. */
-	if (nmask && nlongs > BITS_TO_LONGS(MAX_NUMNODES)) {
-		for (k = BITS_TO_LONGS(MAX_NUMNODES); k < nlongs; k++) {
-			unsigned long t;
-			if (get_user(t,  nmask + k))
-				return -EFAULT;
-			if (k == nlongs - 1) {
-				if (t & endmask)
-					return -EINVAL;
-			} else if (t)
-				return -EINVAL;
-		}
-		nlongs = BITS_TO_LONGS(MAX_NUMNODES);
-		endmask = ~0UL;
-	}
+/*
+ * Do sanity checking on flags argument to sys_mbind.
+ * Return 'mode' bits if sane, 0 if bad flags.
+ */
+static int mpol_check_flags(int flags)
+{
+	int mode = flags & MPOL_MODE_MASK;
+	flags &= ~MPOL_MODE_MASK;
 
-	bitmap_zero(nodes, MAX_NUMNODES);
-	if (nmask && copy_from_user(nodes, nmask, nlongs*sizeof(unsigned long)))
-		return -EFAULT;
-	nodes[nlongs-1] &= endmask;
-	return check_policy(mode, nodes);
+	if (flags & ~MPOL_MF_STRICT)
+		return 0;
+
+	if (mode > MPOL_MAX)
+		return 0;
+
+	return mode;
 }
 
 /* Generate a custom zonelist for the BIND policy. */
@@ -259,7 +236,7 @@ verify_pages(unsigned long addr, unsigne
 
 /* Step 1: check the range */
 static struct vm_area_struct *
-check_range(struct mm_struct *mm, unsigned long start, unsigned long end,
+mpol_check_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 	    unsigned long *nodes, unsigned long flags)
 {
 	int err;
@@ -334,32 +311,39 @@ static int mbind_range(struct vm_area_st
 }
 
 /* Change policy for a memory range */
-asmlinkage long sys_mbind(unsigned long start, unsigned long len,
-			  unsigned long mode,
-			  unsigned long *nmask, unsigned long maxnode,
-			  unsigned flags)
+asmlinkage long sys_mbind(unsigned long start, size_t len,
+			  unsigned long __user *nmask, unsigned int nmask_len,
+			  int flags)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	struct mempolicy *new;
 	unsigned long end;
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
-	int err;
+	int err, mode = 0;
 
-	if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
-		return -EINVAL;
-	if (start & ~PAGE_MASK)
+	/* Make sure user passed us sane 'flags', and separate the 'mode' */
+	mode = mpol_check_flags(flags);
+	if (mode == 0)
 		return -EINVAL;
+	flags &= ~MPOL_MODE_MASK;
 	if (mode == MPOL_DEFAULT)
 		flags &= ~MPOL_MF_STRICT;
-	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
-	end = start + len;
+
+	/* Ensure start and end are on page boundaries */
+	end = PAGE_ALIGN(start + len);
+	start &= PAGE_MASK;
 	if (end < start)
 		return -EINVAL;
 	if (end == start)
 		return 0;
 
-	err = get_nodes(nodes, nmask, maxnode, mode);
+	/* Copy user's bitmask of nodes */
+	if (nmask_len < sizeof(*nodes))
+		return -EINVAL;
+	if (copy_from_user(nodes, nmask, sizeof(*nodes)))
+		return -EFAULT;
+	err = mpol_check_policy(mode, nodes);
 	if (err)
 		return err;
 
@@ -367,11 +351,9 @@ asmlinkage long sys_mbind(unsigned long 
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
-	PDprintk("mbind %lx-%lx mode:%ld nodes:%lx\n",start,start+len,
-			mode,nodes[0]);
-
+	PDprintk("mbind %lx-%lx mode:%ld nodes:%lx\n", start, end, mode, nodes[0]);
 	down_write(&mm->mmap_sem);
-	vma = check_range(mm, start, end, nodes, flags);
+	vma = mpol_check_range(mm, start, end, nodes, flags);
 	err = PTR_ERR(vma);
 	if (!IS_ERR(vma))
 		err = mbind_range(vma, start, end, new);
@@ -381,21 +363,34 @@ asmlinkage long sys_mbind(unsigned long 
 }
 
 /* Set the process memory policy */
-asmlinkage long sys_set_mempolicy(int mode, unsigned long *nmask,
-				   unsigned long maxnode)
+asmlinkage long sys_set_mempolicy(unsigned long __user *nmask,
+				  unsigned int nmask_len, int flags)
 {
-	int err;
 	struct mempolicy *new;
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
+	int err, mode = 0;
 
-	if (mode > MPOL_MAX)
+	/* Make sure user passed us sane 'flags', and separate the 'mode' */
+	mode = mpol_check_flags(flags);
+	if (mode == 0)
 		return -EINVAL;
-	err = get_nodes(nodes, nmask, maxnode, mode);
+	flags &= ~MPOL_MODE_MASK;
+	if (mode == MPOL_DEFAULT)
+		flags &= ~MPOL_MF_STRICT;
+
+	/* Copy user's bitmask of nodes */
+	if (nmask_len < sizeof(*nodes))
+		return -EINVAL;
+	if (copy_from_user(nodes, nmask, sizeof(*nodes)))
+		return -EFAULT;
+	err = mpol_check_policy(mode, nodes);
 	if (err)
 		return err;
+
 	new = new_policy(mode, nodes);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
+
 	mpol_free(current->mempolicy);
 	current->mempolicy = new;
 	if (new && new->policy == MPOL_INTERLEAVE)

--=-xAhPQI3A1AGk9H3Gl99P--

