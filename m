Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWAKDZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWAKDZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWAKDZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:25:29 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:9622 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932584AbWAKDZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:25:28 -0500
Message-ID: <43C47AD9.10800@jp.fujitsu.com>
Date: Wed, 11 Jan 2006 12:26:17 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH 0/5] Direct Migration V9: Overview
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Christoph Lameter wrote:
> Swap migration is now in Linus tree. So this is the first direct page
Congratz.
> migration patchset against his tree (2.6.15-git6 no changes apart
> from the rediff). Also done on the off chance that we decide to have
> the full thing in 2.6.16 instead of only swap migration.
> Maybe this can now get into Andrew's tree?
> 
I don't find any problem with this patch now.
'How to do memory hot-removing' is another issue.
I'm grad if this goes to -mm tree.


By the way, what is the limitation of migratable pages ?
I think  current limitation is just Hugetlb pages and mlocked pages. right ?
Could you make it clear and add comment or doc before going to -mm ?

-- Kame




> -----
> 
> Page migration allows the moving of the physical location of pages between
> nodes in a numa system while the process is running. This means that the
> virtual addresses that the process sees do not change. However, the
> system rearranges the physical location of those pages.
> 
> The main intend of page migration patches here is to reduce the latency of
> memory access by moving pages near to the processor where the process
> accessing that memory is running.
> 
> The migration patchsets allow a process to manually relocate the node
> on which its pages are located through the MF_MOVE and MF_MOVE_ALL options
> while setting a new memory policy. The pages of process can also be relocated
> from another process using the sys_migrate_pages() function call. The
> migrate_pages function call takes two sets of nodes and moves pages of a
> process that are located on the from nodes to the destination nodes.
> 
> Manual migration is very useful if for example the scheduler has relocated
> a process to a processor on a distant node. A batch scheduler or an
> administrator can detect  the situation and move the pages of the process
> nearer to the new processor.
> 
> Larger installations usually partition the system using cpusets into
> sections of nodes. Paul Jackson has  equipped cpusets with the ability to
> move pages when a task is moved to another cpuset. This allows automatic
> control over locality of a process. If a task is moved to a new cpuset
> then also all its pages are moved with it so that the performance of the
> process does not sink dramatically (as is the case today).
> 
> The swap migration patchset in 2.6.16-git6 works by simply evicting
> the page. The pages must be faulted back in. The pages are then typically
> reallocated by the system near the node where the process is executing.
> For swap migration the destination of the move is controlled by the
> allocation policy. Cpusets set the allocation policy before calling
> sys_migrate_pages() in order to move the pages as intended.
> 
> No allocation policy changes are performed for sys_migrate_pages(). This
> means that the pages may not faulted in to the specified nodes if no
> allocation policy was set by other means. The pages will just end up
> near the node where the fault occurred.  The direct migration patchset
> extends the migration functionality to avoid going through swap.
> The destination node of the relation is controllable during the actual
> moving of pages. The crutch of using the allocation policy to relocate
> is not necessary any and the pages are moved directly to the target.
> 
> The direct migration patchset allows the preservation of the relative
> location of pages within a group of nodes for all migration techniques which
> will preserve a particular memory allocation pattern generated even after
> migrating a process. This is necessary in order to preserve the memory
> latencies. Processes will run with similar performance after migration.
> 
> This patch makes sys_migrate_pages() finally work as intended but does not
> do any significant modifications to APIs.
> 
> Benefits over swap migration:
> 
> 1. It makes migrates_pages() actually migrate pages instead of just
>    swapping pages from a set of nodes out.
> 
> 2. Its faster because the page does not need to be written to swap space.
> 
> 3. It does not use swap space and therefore there is no danger of running
>    out of swap space.
> 
> 4. The need to write back a dirty page before migration is avoided through
>    a file system specific method.
> 
> 5. Direct migration allows the preservation of the relative location of a page
>    within a set of nodes.
> 
> Many of the ideas for this code were originally developed in the memory
> hotplug project and we hope that this code also will allow the hotplug
> project to build on this patch in order to get to their goals.
> 
> The patchset consists of five patches (only the first two are necessary to
> have basic direct migration support):
> 
> 1. SwapCache patch
> 
>    SwapCache pages may have changed their type after lock_page() if the
>    page was migrated. Check for this and retry lookup if the page is no
>    longer a SwapCache page.
> 
> 2. migrate_pages()
> 
>    Basic direct migration with fallback to swap if all other attempts
>    fail.
> 
> 3. remove_from_swap()
> 
>    Page migration installs swap ptes for anonymous pages in order to
>    preserve the information contained in the page tables. This patch
>    removes the swap ptes after migration and replaces them with regular
>    ptes.
> 
> 4. upgrade of MPOL_MF_MOVE and sys_migrate_pages()
> 
>    Add logic to mm/mempolicy.c to allow the policy layer to control
>    direct page migration. Thanks to Paul Jackson for the interative
>    logic to move between sets of nodes.
> 
> 5. buffer_migrate_pages() patch
> 
>    Allow migration without writing back dirty pages. Add filesystem dependent
>    migration support for ext2/ext3 and xfs. Use swapper space to setup a
>    method to migrate anonymous pages without writeback.
> 
> Credits (also in mm/vmscan.c):
> 
> The idea for this scheme of page migration was first developed in the context
> of the memory hotplug project. The main authors of the migration code from
> the memory hotplug project are:
> 
> IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
> Hirokazu Takahashi <taka@valinux.co.jp>
> Dave Hansen <haveblue@us.ibm.com>
> 
> Changes V8->V9:
> - Patchset against 2.6.15-git6
> 
> Changes V7->V8:
> - Patchset against 2.6.15-rc5-mm3
> - Export more functions so that filesystems are able to implement their own
>   migrate_page() function.
> - Fix remove_from_swap() to remove the page from the swap cache in addition
>   to replacing swap ptes. Call with the page lock on the new page.
> - Fix copying of struct page {} field to avoid using the macros that process
>   field information.
> 
> Changes V7->V7:
> - Rediff against 2.6.14-rc5-mm2
> 
> Changes V6->V7:
> - Patchset agsinst 2.6.15-rc5-mm1
> - Fix one occurence of page->mapping in migrate_page_remove_references()
> - Update description]
> 
> Changes V5->V6:
> - Patchset against 2.6.15-rc3-mm1
> - Remove checks for page count increases while migrating after Andrew assured
>   me that this cannot happen. Revise documentation to reflect that. If this is
>   the case then we will have no need to include the unwind code from the
>   hotplug project in the future.
> - Wrong reference while calling remove_from_swap to page instead of newpage
>   fixed.
> 
> Changes V4->V5:
> - Patchset against 2.6.15-rc2-mm1
> - Update policy layer patch to use the generic check_range in 2.6.15-rc2-mm1.
> - Remove try_to_unmap patch since VM_RESERVED vanished under us and therefore
>   there is no point anymore to distinguish between permament and transitional
>   failures.
> 
> Changes V3->V4:
> - Patchset against 2.6.15-rc1-mm2 + two swap migration fixes posted today.
> - Remove what is already in 2.6.14-rc1-mm2 which results in a significant
>   cleanup of the code.
> 
> Changes V2->V3:
> - Patchset against 2.6.14-mm2
> - Fix single processor build and builds without CONFIG_MIGRATION
> - export symbols for filesystems that are modules and for
>   modules using migrate_pages().
> - Paul Jackson's cpuset migration support is in 2.6.14-mm2 so
>   this patchset can be easily applied to -mm2 to get from swap
>   based to direct page migration.
> 
> Changes V1->V2:
> - Call node_remap with the right parameters in do_migrate_pages().
> - Take radix tree lock while examining page count to avoid races with
>   find_get_page() and various *_get_pages based on it.
> - Convert direct ptes to swap ptes before radix tree update to avoid
>   more races.
> - Fix problem if CONFIG_MIGRATION is off for buffer_migrate_page
> - Add documentation about page migration
> - Change migrate_pages() api so that the caller can decide what
>   to do about the migrated pages (badmem handling and hotplug
>   have to remove those pages for good).
> - Drop config patch (already in mm)
> - Add try_to_unmap patch
> - Patchset now against 2.6.14-mm1 without requiring additional patches.
> 
> 
> 


