Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUC2SU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUC2SU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:20:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55693
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263060AbUC2SUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:20:53 -0500
Date: Mon, 29 Mar 2004 20:20:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>, akpm@osdl.org,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040329182051.GD3808@dualathlon.random>
References: <20040329172248.GR3808@dualathlon.random> <Pine.LNX.4.44.0403291843320.18876-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403291843320.18876-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 07:12:34PM +0100, Hugh Dickins wrote:
> On Mon, 29 Mar 2004, Andrea Arcangeli wrote:
> > 
> > Here a further update for xfs:
> > 
> > --- sles/fs/xfs/linux/xfs_vnode.h.~1~	2004-03-29 18:33:20.047028592 +0200
> > +++ sles/fs/xfs/linux/xfs_vnode.h	2004-03-29 19:02:37.101915648 +0200
> > @@ -601,8 +601,8 @@ static __inline__ void vn_flagclr(struct
> >   * Some useful predicates.
> >   */
> >  #define VN_MAPPED(vp)	\
> > -	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap)) || \
> > -	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_shared))))
> > +	(!prio_tree_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap)) || \
> > +	(!prio_tree_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_shared))))
> >  #define VN_CACHED(vp)	(LINVFS_GET_IP(vp)->i_mapping->nrpages)
> >  #define VN_DIRTY(vp)	mapping_tagged(LINVFS_GET_IP(vp)->i_mapping, \
> >  					PAGECACHE_TAG_DIRTY)
> 
> Needs also to check
> 	!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_nonlinear))
> 
> Various arches need a similar conversion too (and use page_mapping(page)
> rather than page->mapping: see arch and include/asm in my anobjrmap 3/6).
> 
> Those arches which do more than test list_empty (now prio_tree_empty),
> arm and parisc (I think that's all): look as if they can take full

I've noticed arm and parisc, luckily no arm/parisc user tried my tree
yet ;).

> advantage of the prio tree; and I hope we can ignore the nonlinears
> in those cases - if a page is mapped in a nonlinear vma it may suffer
> from  D-cache aliasing inconsistencies if also mapped elsewhere in
> that user address space, never mind.  Is that reasonable?

some arch was setting a max file offset multiple in the mmap API to
avoid aliasing issues too, nonlinear broke it off, not sure if that is
being taken into account, but certainly having a i_mmap_nonlinear will
facilitate the life of those archs.

> > and really some other bigger tree needs this part too (not a mainline
> > issue).
> > 
> > --- sles/fs/xfs/dmapi/dmapi_xfs.c.~1~	2004-03-29 18:33:03.781501328 +0200
> > +++ sles/fs/xfs/dmapi/dmapi_xfs.c	2004-03-29 18:58:57.754261560 +0200
> > @@ -228,17 +228,21 @@ prohibited_mr_events(
> >  	struct address_space *mapping = LINVFS_GET_IP(vp)->i_mapping;
> >  	int prohibited = (1 << DM_EVENT_READ);
> >  	struct vm_area_struct *vma;
> > +	struct prio_tree_iter iter;
> >  
> >  	if (!VN_MAPPED(vp))
> >  		return 0;
> >  
> >  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> >  	down(&mapping->i_shared_sem);
> > -	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
> > +	vma = __vma_prio_tree_first(&mapping->i_mmap_shared, &iter, 0, ULONG_MAX);
> > +	while (vma) {
> >  		if (!(vma->vm_flags & VM_DENYWRITE)) {
> >  			prohibited |= (1 << DM_EVENT_WRITE);
> >  			break;
> >  		}
> > +
> > +		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared, &iter, 0, ULONG_MAX);
> >  	}
> >  	up(&mapping->i_shared_sem);
> >  #else
> 
> This looks horrid (not your change, the original), and would need to look
> at nonlinears too; but I thought this was what i_writecount < 0 is for?

no idea what's the point of this stuff, Christoph maybe wants to
elaborate.
