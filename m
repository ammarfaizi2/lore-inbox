Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbSLSSKa>; Thu, 19 Dec 2002 13:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSLSSKa>; Thu, 19 Dec 2002 13:10:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:59882 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265890AbSLSSK2>;
	Thu, 19 Dec 2002 13:10:28 -0500
Message-ID: <3E020D6E.429D4107@digeo.com>
Date: Thu, 19 Dec 2002 10:18:23 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: mremap use-after-free [was Re: 2.5.52-mm2]
References: <3E01943B.4170B911@digeo.com> <Pine.LNX.4.44.0212191602190.1893-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2002 18:18:23.0383 (UTC) FILETIME=[0446B270:01C2A78B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> ...
> I doubt that (but may be wrong, I haven't time right now to think as
> twistedly as mremap demands).

Maybe, maybe not.  Think about it - because VM_LOCKED is cleared
by slab poisoning, the chances of anyone noticing it are very small.
 
> The code (patently!) expects new_vma
> to be good at the end, it certainly wasn't intending to unmap it;
> but 2.5 split_vma has been through a couple of convulsions, either
> of which might have resulted in the potential for new_vma to be
> freed where before it was guaranteed to remain.

I see no "guarantees" around do_munmap() at all.  The whole thing
is foul; no wonder it keeps blowing up.

It died partway into kde startup.  It was in fact the first mremap
call.

> Do you know the vmas before and after, and the mremap which did this?

Breakpoint 1, move_vma (vma=0xcf1ed734, addr=1077805056, old_len=36864, new_len=204800, new_addr=1078050816) at mm/mremap.c:176
176     {
(gdb) n
183             next = find_vma_prev(mm, new_addr, &prev);
(gdb) 
177             struct mm_struct * mm = vma->vm_mm;
(gdb) 
180             int split = 0;
(gdb) 
182             new_vma = NULL;
(gdb) 
183             next = find_vma_prev(mm, new_addr, &prev);
(gdb) 
184             if (next) {
(gdb) p/x next
$1 = 0xce3bee84
(gdb) p/x *next
$2 = {vm_mm = 0xcf7cc624, vm_start = 0xbffcd000, vm_end = 0xc0000000, vm_next = 0x0, vm_page_prot = {pgprot = 0x25}, 
  vm_flags = 0x100177, vm_rb = {rb_parent = 0xcf1ed74c, rb_color = 0x1, rb_right = 0x0, rb_left = 0x0}, shared = {next = 0xce3beeac, 
    prev = 0xce3beeac}, vm_ops = 0x0, vm_pgoff = 0xffffffce, vm_file = 0x0, vm_private_data = 0x0}
(gdb) p prev
$3 = (struct vm_area_struct *) 0xcf1ed734
(gdb) p/x *prev
$4 = {vm_mm = 0xcf7cc624, vm_start = 0x403e0000, vm_end = 0x4041c000, vm_next = 0xce3bee84, vm_page_prot = {pgprot = 0x25}, 
  vm_flags = 0x100073, vm_rb = {rb_parent = 0xce3be4c4, rb_color = 0x0, rb_right = 0xce3bee9c, rb_left = 0xce3be1ac}, shared = {
    next = 0xcf1ed75c, prev = 0xcf1ed75c}, vm_ops = 0x0, vm_pgoff = 0x0, vm_file = 0x0, vm_private_data = 0x0}


> ...
> 
> Hmmm.  Am I right to suppose that all the changes above are "cleanup"
> which you couldn't resist making while you looked through this code,
> but entirely irrelevant to the bug in question?

to make the code readable so I could work on the bug, it then "accidentally"
got left in.

>  If those mods above
> were right, they should be the subject of a separate patch.

well yes it would be nice to clean that code up.  Like, documenting
it and working out what the locking rules are.

What does this do?
                        spin_lock(&mm->page_table_lock);
                        prev->vm_end = new_addr + new_len;
                        spin_unlock(&mm->page_table_lock);
and this?
                        spin_lock(&mm->page_table_lock);
                        next->vm_start = new_addr;
                        spin_unlock(&mm->page_table_lock);

clearly nothing.  OK, but is this effectively-unlocked code safe?

> There's certainly room for cleanup there, but my preference would be
> to remove "can_vma_merge" completely, or at least its use in mremap.c,
> using its explicit tests instead.  It looks like it was originally
> quite appropriate for a use or two in mmap.c, but obscurely unhelpful
> here - because in itself it is testing a bizarre asymmetric subset of
> what's needed (that subset which remained to be tested in its original
> use in mmap.c).

yes
 
> The problem with your changes above is, you've removed the !vma->vm_file
> tests, presumably because you noticed that can_vma_merge already tests
> !vma->vm_file.  But "vma" within can_vma_merge is "prev" or "next" here:
> they are distinct tests, and you're now liable to merge an anonymous
> mapping with a private file mapping - nice if it's from /dev/zero,
> but otherwise not.  Please just cut those hunks out.

ok
 
> ...
> > -             do_munmap(current->mm, addr, old_len);
> > -
> 
> Anguished cry!  There was careful manipulation of VM_ACCOUNT before and
> after do_munmap, now you've for no reason moved do_munmap down outside.

How do we know that *vma was not altered by the do_munmap() call?

With this change, nobody will touch any locally-cached vma*'s from
the do_munmap() right through to syscall exit.
