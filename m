Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUDHTUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUDHTUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:20:37 -0400
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:16302 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S262293AbUDHTUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:20:34 -0400
Date: Thu, 8 Apr 2004 15:20:22 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@ruby.engin.umich.edu
To: Hugh Dickins <hugh@veritas.com>
cc: mbligh@aracnet.com, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
In-Reply-To: <1IMik-2is-37@gated-at.bofh.it>
Message-ID: <Pine.LNX.4.58.0404081503110.28416@ruby.engin.umich.edu>
References: <1IL3l-1dP-35@gated-at.bofh.it> <1IMik-2is-37@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Apr 2004, Hugh Dickins wrote:

> On Thu, 8 Apr 2004, Martin J. Bligh wrote:
> > > On Wed, 7 Apr 2004, Andrew Morton wrote:
> > >>
> > >> Your patch takes the CONFIG_NUMA vma from 64 bytes to 68.  It would be nice
> > >> to pull those 4 bytes back somehow.
> > >
> > > How significant is this vma size issue?
> > >
> > > anon_vma objrmap will add 20 bytes to each vma (on 32-bit arches):
> > > 8 for prio_tree, 12 for anon_vma linkage in vma,
> > > sometimes another 12 for the anon_vma head itself.
> >
> > Ewwww. Isn't some of that shared most of the time though?
>
> The anon_vma head may well be shared with other vmas of the fork group.
> But the anon_vma linkage is a list_head and a pointer within the vma.
>
> prio_tree is already using a union as much as it can (and a pointer
> where a list_head would simplify the code); Rajesh was thinking of
> reusing vm_private_data for one pointer, but I've gone and used it
> for nonlinear swapout.

I guess using vm_private_data for nonlinear is not a problem because
we use list i_mmap_nonlinear for nonlinear vmas.

As you have found out vm_private_data is only used if vm_file != NULL
or VM_RESERVED or VM_DONTEXPAND is set. I think we can revert back to
i_mmap{_shared} list for such special cases and use prio_tree for
others. I maybe missing something. Please teach me.

If anonmm is merged then I plan to seriously consider removing that
8 extra bytes for prio_tree. If anon_vma is merged, then I can easily
point my finger at 12 more bytes added by anon_vma and be happy :)

I still think removing the 8 extra bytes used by prio_tree from
vm_area_struct is possible.

> > > anonmm objrmap adds just the 8 bytes for prio_tree,
> > > remaining overhead 28 bytes per mm.
> >
> > 28 bytes per *mm* is nothing, and I still think the prio_tree is
> > completely unneccesary. Nobody has ever demonstrated a real benchmark
> > that needs it, as far as I recall.
>
> I'm sure an Ingobench will shortly follow that observation.

Yeap. If Andrew didn't write his rmap-test.c and Ingo didn't write his
test-mmap3.c, I wouldn't even have considered developing prio_tree.

Thanks,
Rajesh
