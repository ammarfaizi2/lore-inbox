Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUIEOa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUIEOa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUIEOa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:30:29 -0400
Received: from ozlabs.org ([203.10.76.45]:17871 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266725AbUIEOaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:30:11 -0400
Date: Mon, 6 Sep 2004 00:27:20 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@muc.de>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040905142719.GJ7716@krispykreme>
References: <m3zn4bidlx.fsf@averell.firstfloor.org> <20040831183655.58d784a3.pj@sgi.com> <20040901015922.GM26072@krispykreme> <20040904134020.GG33964@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904134020.GG33964@muc.de>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Looks good from a quick review. But there is nothing to call it? 

Heres one :) Unfortunately we have to frob 32bit userspace bitmaps to
64bit ones on big endian platforms. This version does extra copies but
is simple, avoids set_fs tricks and gets things working for me on ppc64.

Anton

diff -puN mm/mempolicy.c~numa_api mm/mempolicy.c
--- gr_work/mm/mempolicy.c~numa_api	2004-09-04 21:14:44.595414365 -0500
+++ gr_work-anton/mm/mempolicy.c	2004-09-05 09:12:18.899685327 -0500
@@ -525,20 +525,82 @@ asmlinkage long sys_get_mempolicy(int __
 }
 
 #ifdef CONFIG_COMPAT
-/* The other functions are compatible */
+
 asmlinkage long compat_get_mempolicy(int __user *policy,
-				  unsigned __user *nmask, unsigned  maxnode,
-				  unsigned addr, unsigned  flags)
+				     compat_ulong_t __user *nmask,
+				     compat_ulong_t maxnode,
+				     compat_ulong_t addr, compat_ulong_t flags)
 {
 	long err;
 	unsigned long __user *nm = NULL;
+	unsigned long nr_bits, alloc_size;
+	DECLARE_BITMAP(bm, MAX_NUMNODES);
+
+	nr_bits = min(maxnode-1, MAX_NUMNODES);
+	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
+
 	if (nmask)
-		nm = compat_alloc_user_space(ALIGN(maxnode-1, 64) / 8);
-	err = sys_get_mempolicy(policy, nm, maxnode, addr, flags);
-	if (!err && copy_in_user(nmask, nm, ALIGN(maxnode-1, 32)/8))
-		err = -EFAULT;
+		nm = compat_alloc_user_space(alloc_size);
+
+	err = sys_get_mempolicy(policy, nm, nr_bits+1, addr, flags);
+
+	if (!err && nmask) {
+		err = copy_from_user(bm, nm, alloc_size);
+		/* ensure entire bitmap is zeroed */
+		err |= clear_user(nmask, ALIGN(maxnode-1, 8) / 8);
+		err |= compat_put_bitmap(nmask, bm, nr_bits);
+	}
+
 	return err;
 }
+
+asmlinkage long compat_set_mempolicy(int mode, compat_ulong_t __user *nmask,
+				     compat_ulong_t maxnode)
+{
+	long err;
+	unsigned long __user *nm = NULL;
+	unsigned long nr_bits, alloc_size;
+	DECLARE_BITMAP(bm, MAX_NUMNODES);
+
+	nr_bits = min(maxnode-1, MAX_NUMNODES);
+	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
+
+	if (nmask) {
+		err = compat_get_bitmap(bm, nmask, nr_bits);
+		nm = compat_alloc_user_space(alloc_size);
+		err |= copy_to_user(nm, bm, alloc_size);
+	}
+
+	if (err)
+		return -EFAULT;
+
+	return sys_set_mempolicy(mode, nm, nr_bits+1);
+}
+
+asmlinkage long compat_mbind(compat_ulong_t start, compat_ulong_t len,
+			     compat_ulong_t mode, compat_ulong_t __user *nmask,
+			     compat_ulong_t maxnode, compat_ulong_t flags)
+{
+	long err;
+	unsigned long __user *nm = NULL;
+	unsigned long nr_bits, alloc_size;
+	DECLARE_BITMAP(bm, MAX_NUMNODES);
+
+	nr_bits = min(maxnode-1, MAX_NUMNODES);
+	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
+
+	if (nmask) {
+		err = compat_get_bitmap(bm, nmask, nr_bits);
+		nm = compat_alloc_user_space(alloc_size);
+		err |= copy_to_user(nm, bm, alloc_size);
+	}
+
+	if (err)
+		return -EFAULT;
+
+	return sys_mbind(start, len, mode, nm, nr_bits+1, flags);
+}
+
 #endif
 
 /* Return effective policy for a VMA */
@@ -900,7 +962,7 @@ mpol_shared_policy_lookup(struct shared_
 
 static void sp_delete(struct shared_policy *sp, struct sp_node *n)
 {
-	PDprintk("deleting %lx-l%x\n", n->start, n->end);
+	PDprintk("deleting %lx-%lx\n", n->start, n->end);
 	rb_erase(&n->nd, &sp->root);
 	mpol_free(n->policy);
 	kmem_cache_free(sn_cache, n);
