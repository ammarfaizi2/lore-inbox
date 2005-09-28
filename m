Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVI1NTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVI1NTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVI1NTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:19:04 -0400
Received: from gold.veritas.com ([143.127.12.110]:44333 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750957AbVI1NTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:19:02 -0400
Date: Wed, 28 Sep 2005 14:18:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jay Lan <jlan@engr.sgi.com>
cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <4339AED4.8030108@engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0509281337420.6830@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
 <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
 <4339AED4.8030108@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Sep 2005 13:19:00.0139 (UTC) FILETIME=[3037AFB0:01C5C42F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005, Jay Lan wrote:
> 
> While in the work on separating hiwater_vm from hiwater_rss, i noticed
> that __vm_stat_account() was not called in these functions where
> total_vm was updated:
> mm/mmap.c                           do_brk
> mm/nommu.c                          do_mmap_pgoff
> mm/nommu.c                          do_munmap
> arch/ppc64/kernel/vdso.c            arch_setup_additional_pages
> arch/x86_64/ia32/syscall32.c        syscall32_setup_pages
> 
> Frank tried to touch the latter two in his proposed patch.
> Does it make sense we add __vm_stat_account() calls to the above
> routines?

Probably not.  Partly because of the PROCFS issue you noticed after.
And partly because that's a long list, whereas the evidence is that
__vm_stat_account is nowadays being called in the places that need it.

What, you couldn't find the call to __vm_stat_account next to
updating total_vm in do_mmap_pgoff :-?  And I don't see that total_vm
is updated in do_munmap, that and the vm_stat_account have to be done
at a lower, per-vma level.  Haven't looked at the others yet.

I think, better leave hiwater_vm to me for now.  Since I've got that
patchset in the next -mm, it's maybe easier for me to put something
together on top of that.  And it seems quite possible (haven't checked
yet) that actually we should be moving the update of total_vm in to the
core from out all over, rather than splattering hiwater_vm updates about.

I'll take a look in the next couple of days.

Hugh
