Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbUC2Si1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbUC2Si1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:38:27 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:13842 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262791AbUC2SiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:38:25 -0500
Date: Mon, 29 Mar 2004 19:38:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>, akpm@osdl.org,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, roehrich@sgi.com
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040329193816.A17065@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
	Rajesh Venkatasubramanian <vrajesh@umich.edu>, akpm@osdl.org,
	riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, roehrich@sgi.com
References: <20040329172248.GR3808@dualathlon.random> <Pine.LNX.4.44.0403291843320.18876-100000@localhost.localdomain> <20040329182051.GD3808@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040329182051.GD3808@dualathlon.random>; from andrea@suse.de on Mon, Mar 29, 2004 at 08:20:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 08:20:51PM +0200, Andrea Arcangeli wrote:
> > > --- sles/fs/xfs/dmapi/dmapi_xfs.c.~1~	2004-03-29 18:33:03.781501328 +0200
> > > +++ sles/fs/xfs/dmapi/dmapi_xfs.c	2004-03-29 18:58:57.754261560 +0200
> > > @@ -228,17 +228,21 @@ prohibited_mr_events(
> > >  	struct address_space *mapping = LINVFS_GET_IP(vp)->i_mapping;
> > >  	int prohibited = (1 << DM_EVENT_READ);
> > >  	struct vm_area_struct *vma;
> > > +	struct prio_tree_iter iter;
> > >  
> > >  	if (!VN_MAPPED(vp))
> > >  		return 0;
> > >  
> > >  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> > >  	down(&mapping->i_shared_sem);
> > > -	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
> > > +	vma = __vma_prio_tree_first(&mapping->i_mmap_shared, &iter, 0, ULONG_MAX);
> > > +	while (vma) {
> > >  		if (!(vma->vm_flags & VM_DENYWRITE)) {
> > >  			prohibited |= (1 << DM_EVENT_WRITE);
> > >  			break;
> > >  		}
> > > +
> > > +		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared, &iter, 0, ULONG_MAX);
> > >  	}
> > >  	up(&mapping->i_shared_sem);
> > >  #else
> > 
> > This looks horrid (not your change, the original), and would need to look
> > at nonlinears too; but I thought this was what i_writecount < 0 is for?
> 
> no idea what's the point of this stuff, Christoph maybe wants to
> elaborate.

That's dmapi, a standard for Hierachial Storage Management.  The code is not
in mainline for a reason, no idea where you got it from.

AFAIK the code tries to detect whether there could be anyone writing to the
vma, but ask Dean for the details
