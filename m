Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWFFUGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWFFUGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 16:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWFFUGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 16:06:50 -0400
Received: from silver.veritas.com ([143.127.12.111]:42151 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751057AbWFFUGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 16:06:49 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,214,1146466800"; 
   d="scan'208"; a="38890130:sNHT24730676"
Date: Tue, 6 Jun 2006 21:06:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/3] mm: tracking dirty pages -v5
In-Reply-To: <20060525135534.20941.91650.sendpatchset@lappy>
Message-ID: <Pine.LNX.4.64.0606062056540.1507@blonde.wat.veritas.com>
References: <20060525135534.20941.91650.sendpatchset@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Jun 2006 20:06:48.0290 (UTC) FILETIME=[BE0E7C20:01C689A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006, Peter Zijlstra wrote:
> 
> I hacked up a new version last night.
> 
> Its now based on top of David's patches, Hugh's approach of using the
> MAP_PRIVATE protections instead of the MAP_SHARED seems far superior indeed.

Although I like this approach, and your patches implementing it,
I have realized a snag with it, see below.  I hope someone can
make a suggestion that shows up my stupidity and melts away the
difficulty, but for now I'm stumped.

> Q: would it be feasable to do so for al shared mappings so we can remove
> the MAP_SHARED protections all together?

That would impose the overhead of additional write faults on those
cases (notably shared memory) where we just don't need it.

> They survive my simple testing, but esp. the msync cleanup might need some
> more attention.

Yes, I think you've cleaned up slightly too far, see remarks below.

> I post them now instead of after a little more testing because I'll not 
> have much time the coming few days to do so, and hoarding them does 
> nobody any good.

I'll mention the minor points first, then after come to the tiresome
issue I've spent so much time failing to resolve.

You tend to use get_page/put_page amidst code using page_cache_get/
page_cache_release.  Carry on: it sometimes looks odd, but I can't see
any way to impose consistency, short of abolishing one or the other
throughout the tree.  So don't worry about it.

It's irritating to have to be setting "dirty_page" near the page_mkwrite
code, then doing the set_page_dirty_balance separately at the end.  But
I agree with you and David: the page_mkwrite needs to be checked before,
and the set_page_dirty needs to be done after (when the pte is exposed
in the page table): otherwise page_mkclean would miss instances, and
the nr_dirty count drift slowly downwards away from reality.  Or, am
I mistaken?  Maybe, but the way you have it is exact (one could add a
BUG in zap_pte_range, that a VM_SHARED page with pte dirty is already
PageDirty; though I wouldn't recommend doing so unless testing), let's
keep it like that for now, maybe look into relaxing at a future date.

You've got a minor cleanup to install_page, left over from an earlier
iteration: the cleanup looked okay, but of no relevance to your patchset
now, is it?  Just cut mm/fremap.c out of the patchset I think.

You've taken the simplification of sys_msync a little too far, I believe:
you ought to try to reproduce the same errors as before, so MS_ASYNC
should be winding through the separate vmas like MS_SYNC, just to
report -ENOMEM if it crosses an unmapped area; and MS_INVALIDATE
used to say -EBUSY if VM_LOCKED, but that has disappeared.  (Perhaps
I've missed other such details, please recheck.)  Your comment should
say "Nor does it mark" instead of "Nor does it just marks".

I think remove the update_mmu_cache from page_mkclean_one as Christoph
suggested, leaving the lazy_mmu_prot_update: I cannot then justify why
do_wp_page's reuse case does update_mmu_cache when it's merely changing
the protection on the page, but it always has so I suppose it should
continue to do so; what you have in page_mkclean_one is more like
mprotecting than faulting.

Your is_shared_writable(vma) in mprotect_fixup is along the right
lines, but wrong: because at that point vma->vm_flags is the old one,
and may be omitting VM_WRITE when that is about to be added.  Perhaps
you should move the "vma->vm_flags = newflags" above it, or perhaps
you should change is_shared_writable to work on flags rather than vma
(as Linus' is_cow_mapping does).

And whenever I see that call to change_protection, I wonder whether
we should optimize it out when newprot is the same as the old
vma->vm_page_prot: we've not done so in the past, but perhaps now
we're adding cases when it's likely to be the same as before, we
should add that little optimization.

But the tiresome issue is the similar mapping_cap_account_dirty
check in do_mmap_pgoff.  Whereas page_mkwrite defaults to unset,
so that the restriction on vm_page_prot only applies to drivers
or filesystems which have opted in by declaring a page_mkwrite,
mapping->backing_dev_info (initialized in alloc_inode) defaults to
default_backing_dev_info, which does not have BDI_CAP_NO_ACCT_DIRTY.

Which is fine for ordinary filesystems, but means that all the strange
drivers with their own ->mmap are by default mapping_cap_account_dirty,
and therefore you will be adjusting their vm_page_prot; and some of
them have set vm_page_prot rather carefully e.g. with a NOCACHE bit.

This shouldn't be a problem for remap_pfn_range and vm_insert_page
users (vmas now marked VM_PFNMAP or VM_INSERTPAGE), since they should
have already set up their ptes in the ->mmap above, and have no further
use for vm_page_prot - though there might be odd cases, and it would
be preferable not to risk changing behaviour on them.

Where it's really a problem is for the various drivers with .nopage
methods.  In the old scheme (before I diverted you to follow
page_mkwrite), that could have been handled in do_no_page, by
checking page->mapping (there is then a question of race with truncate
on ordinary filesystem pages, which also lose page->mapping, but I
think that works out not to matter - though I'm not sure); but in
do_mmap_pgoff we do not know whether the filesystem or driver will
be dealing in pagecache pages or not.

There are several ways forward, but I don't know which to advise:
I'm hoping someone else will see an easy and safe solution which
I've been missing.

The "right" solution is for us to declare another backing_dev_info
with BDI_CAP_NO_ACCT_DIRTY set, and all those drivers point their
mapping->backing_dev_info to that instead in their .mmap.  But that
means your work becomes dependent on changes to a variety of drivers;
an obscure further requirement on drivers trying to enable mmap, when
there's too many things to get right already; and obscure bugs in any
drivers forgotten or outside the tree.

Or resurrect the VM_RESERVED flag we were thinking of scrapping, add
it in whichever drivers it's needed but missing, and check that?

Or is there anything we can key off instead, to default to this other
backing_dev_info from the core, without changing drivers?

Make character devices use the BDI_CAP_NO_ACCT_DIRTY info, leaving
block devices and files with the current default?  Perhaps, but I'm
not sure if that apportions all the cases correctly, and it would
sit better in UNIX than in Linux (which doesn't key much off the
block/character distinction, I think).

Check for ->fsync in the file_operations, use BDI_CAP_NO_ACCT_DIRTY
backing_dev_info when it's NULL?  That looks to me like it would
work pretty well; but definitely a hack, and again I'm not certain
it would get all the cases right (I haven't the faintest idea what
should happen with arch/powerpc/platforms/cell/spufs, for example).

Or give up, apologize, and ask you to go back to testing in do_no_page,
instead of following the page_mkwrite vm_page_prot technique?

I don't know: sorry.

Hugh
