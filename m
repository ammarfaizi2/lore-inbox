Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbVIONTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbVIONTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVIONTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:19:10 -0400
Received: from gold.veritas.com ([143.127.12.110]:10256 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030412AbVIONTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:19:07 -0400
Date: Thu, 15 Sep 2005 14:18:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Nick Piggin <npiggin@novell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
In-Reply-To: <20050914212405.GD4966@opteron.random>
Message-ID: <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com>
References: <20050914212405.GD4966@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Sep 2005 13:19:07.0250 (UTC) FILETIME=[0D15FD20:01C5B9F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Andrea Arcangeli wrote:
> 
> This patch went in recently:
> 
> 	http://kernel.org/hg/linux-2.6/?cmd=changeset;node=04131690c4cf45c50aedc8bec2366198e52eaf4e
> 
> I think it's wrong to allow exceptions to the rule in handle_mm_fault
> (i.e. to allow ptes to be marked readonly after a write fault). The
> current band-aid in get_user_pages that checks the VM_FAULT_WRITE is
> just a side effect of breaking that rule.
> 
> The real bug is the fact maybe_mkwrite exists in the first place, and
> the other hacks in get_user_pages (I mean the lookup_write now replaced
> by the VM_FAULT_WRITE hack that at least now doesn't lockup anymore).
> 
> As soon as you generate a write fault on a readonly pte, you broke
> coherency with the disk data, so the app _can_ break no matter what a
> kernel developer wants to do. In turn this means the userland developer
> doing the debugging must know what is going on regardless of all this
> unnnecessary complexity. No matter what you change in the kernel it'll
> still break.
> 
> Of course we can't write to the pagecache either, so we should just cow
> and leave the pte writeable, the coherency would be lost regardless,
> what _pratical_ gain do we have from marking it read-write when it's not
> pagecache anymore?
> 
> [ suggests reverting 2.6.13's VM_FAULT_WRITE and 2.6.4's maybe_mkwrite ]

Just like you and Nick, I'd be happy to revert maybe_mkwrite, and our
recent patch to rescue it.  But I don't know the pressures which led
to its introduction in the first place.  CC'ed Roland who introduced
it in 2.6.4, and Linus who supported it in the recent discussions.

  [PATCH] prevent ptrace from altering page permissions
  
  From: Roland McGrath <roland@redhat.com>
  
  Under some circumstances, ptrace PEEK/POKE_TEXT can cause page permissions
  to be permanently changed.  Thsi causes changes in application behaviour
  when run under gdb.
  
  Fix that by only marking the pte as writeable if the vma is marked for
  writing.  A write fault thus unshares the page but doesn't necessarily make
  it writeable.

Personally, I've little interest in whether the pte is left writable
or not (but prefer your simplicity of pte_mkwrite to maybe_mkwrite).
I'm more concerned about the anomaly of a page being written in an
vma marked unwritable.  It's been like that for a long time, I'm not
getting around to thinking it through for now.  But certainly it
subverts the Committed_AS calculations, and needs an audit for other
assumptions.  I've wondered whether we actually need ptrace to mprotect
(so splitting the vma) to handle it correctly.

> About generating anonymous pages on top of map_shared that should be
> fine with the vm, the way anon-vma works, it already happens for
> map_private and it's not conceputally different for anon-vma to deal
> with overlap with map-shared or map-private. So I don't think we need to
> forbid ptrace (i.e. gdb) to write to a readonly map shared or stuff like
> that.

It's certainly a big surprise to find an anonymous page in a shared vma,
bigger than just writing to a page in an unwritable vma.  But you're
quite right that it doesn't conflict with anon_vma design: just with
other assumptions elsewhere.  For example, where Nick's recent patch to
copy_page_range tests anon_vma is okay; whereas my VM_LOCKED|VM_MAYSHARE
test in page_referenced_file is strictly wrong (the file page may now be
unlocked because it's been replaced by an anonymous copy); there are
probably other places more seriously wrong.

I think get_user_pages' test
	flags = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
was probably written without any thought for MAP_SHARED.  Because it allows
ptrace to modify a write-protected MAP_SHARED vma if and only if the file
was opened for writing; but since do_wp_page COWs in this case (I thought
that a mistake, but you and Linus insist we not write to the file), what
relevance has it whether the mmap'ed file was opened for writing or not?

Anyway, let's hear Roland defend maybe_mkwrite.

Hugh
