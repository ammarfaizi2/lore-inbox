Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUC2RXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbUC2RXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:23:13 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:48268
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263017AbUC2RWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 12:22:50 -0500
Date: Mon, 29 Mar 2004 19:22:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: akpm@osdl.org, hugh@veritas.com, riel@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040329172248.GR3808@dualathlon.random>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain> <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu> <20040325225919.GL20019@dualathlon.random> <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu> <20040326075343.GB12484@dualathlon.random> <Pine.LNX.4.58.0403261013480.672@ruby.engin.umich.edu> <20040326175842.GC9604@dualathlon.random> <Pine.GSO.4.58.0403271448120.28539@sapphire.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403271448120.28539@sapphire.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 02:51:45PM -0500, Rajesh Venkatasubramanian wrote:
> 
> This patch adds a list_head i_mmap_nonlinear to the address_space
> structure. The list is used for storing all nonlinear vmas. This
> is helpful in try_to_unmap_inode to find all nonlinear mappings of
> a file.
> 
> This patch does not change invalidate_mmap_range_list. Already
> the behavior of truncate on nonlinear mappings is undefined. We
> understand that nonlinear mappings do not guarantee SIGBUS on
> truncate. After this patch, we do not touch nonlinear maps on
> the truncate path. So it is assured that the nonlinear maps will
> not be destroyed by a truncate.
> 
> I am not happy with the truncate behavior on nonlinear maps. I
> think we can guarantee SIGBUS on nonlinear maps by reusing Andrea's
> try_to_unmap_nonlinear code. But, I have to study more to do that.
> So I am leaving that for future.
> 
> This patch is against 2.6.5-rc2-aa4. The patch was tested in a
> SMP m/c. It boots and compiles a kernel without any problem.
> 
> Please review and apply.

great work, looks fine, applied thanks.

Here a further update for xfs:

--- sles/fs/xfs/linux/xfs_vnode.h.~1~	2004-03-29 18:33:20.047028592 +0200
+++ sles/fs/xfs/linux/xfs_vnode.h	2004-03-29 19:02:37.101915648 +0200
@@ -601,8 +601,8 @@ static __inline__ void vn_flagclr(struct
  * Some useful predicates.
  */
 #define VN_MAPPED(vp)	\
-	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap)) || \
-	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_shared))))
+	(!prio_tree_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap)) || \
+	(!prio_tree_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_shared))))
 #define VN_CACHED(vp)	(LINVFS_GET_IP(vp)->i_mapping->nrpages)
 #define VN_DIRTY(vp)	mapping_tagged(LINVFS_GET_IP(vp)->i_mapping, \
 					PAGECACHE_TAG_DIRTY)


and really some other bigger tree needs this part too (not a mainline
issue).

--- sles/fs/xfs/dmapi/dmapi_xfs.c.~1~	2004-03-29 18:33:03.781501328 +0200
+++ sles/fs/xfs/dmapi/dmapi_xfs.c	2004-03-29 18:58:57.754261560 +0200
@@ -228,17 +228,21 @@ prohibited_mr_events(
 	struct address_space *mapping = LINVFS_GET_IP(vp)->i_mapping;
 	int prohibited = (1 << DM_EVENT_READ);
 	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
 
 	if (!VN_MAPPED(vp))
 		return 0;
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 	down(&mapping->i_shared_sem);
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+	vma = __vma_prio_tree_first(&mapping->i_mmap_shared, &iter, 0, ULONG_MAX);
+	while (vma) {
 		if (!(vma->vm_flags & VM_DENYWRITE)) {
 			prohibited |= (1 << DM_EVENT_WRITE);
 			break;
 		}
+
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared, &iter, 0, ULONG_MAX);
 	}
 	up(&mapping->i_shared_sem);
 #else


let me know if you see any bug in the above, thanks!
