Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVAHUWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVAHUWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 15:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVAHUWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 15:22:14 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:57281 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261378AbVAHUVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 15:21:48 -0500
Date: Sat, 8 Jan 2005 20:20:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Mauricio Lin <mauriciolin@gmail.com>, William Irwin <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] A new entry for /proc
In-Reply-To: <20050106202339.4f9ba479.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Andrew Morton wrote:
> Mauricio Lin <mauriciolin@gmail.com> wrote:
> >
> > Here is a new entry developed for /proc that prints for each process
> > memory area (VMA) the size of rss. The maps from original kernel is
> > able to present the virtual size for each vma, but not the physical
> > size (rss). This entry can provide an additional information for tools
> > that analyze the memory consumption. You can know the physical memory
> > size of each library used by a process and also the executable file.
> > 
> > Take a look the output:
> > # cat /proc/877/smaps
> > 08048000-08132000 r-xp  /usr/bin/xmms
> > Size:     936 kB
> > Rss:     788 kB
> 
> This is potentially quite useful.  I'd be interested in what others think of
> the idea and implementation.

Regarding the idea.

Well, it goes back to just what wli freed 2.6 from, and what we scorned
clameter for: a costly examination of every pte-slot of every vma of the
process.  That doesn't matter _too_ much so long as there's no standard
tool liable to do it every second or so, nor doing it to every single
process, and it doesn't need spinlock or preemption disabled too long.

But personally I'd be happier for it to remain an out-of-tree patch,
just to discourage people from writing and running such tools,
and to discourage them from adding other such costly analyses.

Potentially quite useful, perhaps.  But I don't have a use for it
myself, and if I do have, I'll be content to search out (or recreate)
the patch.  Let's hear from those who actually have a use for it now -
the more useful it is, of course, the stronger the argument for inclusion.

I am a bit sceptical how useful such a lot of little numbers would
really be - usually it's an overall picture we're interested in.

Regarding the implementation.

Unnecessarily inefficient: a pte_offset_map and unmap for each pte.
Better go back to the 2.4.28 or 2.5.36 fs/proc/array.c design for
statm_pgd_range + statm_pmd_range + statm_pte_range - but now you
need a pud level too.

Seems to have no locking: needs to down_read mmap_sem to guard vmas.
Does it need page_table_lock?  I think not (and proc_pid_statm didn't).

If there were a use for it, that use might want to distinguish between
the "shared rss" of pagecache pages from a file, and the "anon rss" of
private pages copied from file or originally zero - would need to get
the struct page and check PageAnon.  And might want to count swap
entries too.  Hard to say without real uses in mind.

Andrew mentioned "unsigned long page": similarly, we usually say
"struct vm_area_struct *vma" rather than "*map" (well, some places
say "*mpnt", but that's not a precedent to follow).

Regarding the display.

It's a mixture of two different styles, the /proc/<pid>/maps
many-hex-fields one-vma-per-line style and the /proc/meminfo 
one-decimal-kB-per-line style.  I think it would be better following
the /proc/<pid>/maps style, but replacing the major,minor,ino fields
by size and rss (anon_rss? swap?) fields (decimal kB? I suppose so).

Hugh

