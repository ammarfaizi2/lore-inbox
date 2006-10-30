Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWJ3QC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWJ3QC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWJ3QC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:02:56 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:50699 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161187AbWJ3QCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:02:55 -0500
Message-ID: <4546212B.4010603@openvz.org>
Date: Mon, 30 Oct 2006 18:58:35 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, menage@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>
In-Reply-To: <4545D51A.1060808@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

> Reclaimable memory
> 
> (i)   Anonymous pages - Anonymous pages are pages allocated by the user space,
>       they are mapped into the user page tables, but not backed by a file.

I do not agree with such classification.
When one maps file then kernel can remove page from address
space as there is already space on disk for it. When one
maps an anonymous page then kernel won't remove this page
for sure as system may simply be configured to be swapless.

I also remind you that beancounter code keeps all the logic
of memory classification in one place, so changing this
would require minimal changes.

[snip]

> 
> (i)  Slabs
> (ii) Kernel pages and page_tables allocated on behalf of a task.

I'd pay more attention to kernel memory accounting and less
to user one as having kmemsize resource actually protects
the system from DoS attacks. Accounting and limiting user
pages doesn't protect system from anything.

[snip]

>      (b) Hard guarantees is a more deterministic method of providing QoS.
>      Resources need to be allocated in advance, to ensure that the group
>      is always able to meet its guarantee. This form is undesirable as

How would you allocate memory on NUMA in advance?

[snip]

> +----+---------+------+---------+------------+----------------+-----------+
> | No |Guarantee| Limit| User I/F| Controllers| New Controllers|Statistics |
> +----+---------+------+---------+------------+----------------+-----------+
> | i  |  No     | Yes  | syscall | Memory     | No framework   |   Yes     |
> |    |         |      |         |            | to write new   |           |
> |    |         |      |         |            | controllers    |           |

The lattest Beancounter patches do provide framework for
new controllers.

[snip]

> a. Beancounters currently account for the following resources
> 
> (i)   kmemsize - memory obtained through alloc_pages() with __GFP_BC flag set.
> (ii)  physpages - Resident set size of the tasks in the group.
>       Reclaim support is provided for this resource.
> (iii) lockedpages - User pages locked in memory
> (iv)  slabs - slabs allocated with kmem_cache_alloc_bc are accounted and
>       controlled.

This is also not true now. The latest beancounter code accounts for
1. kmemsie - this includes slab and vmalloc objects and "raw" pages
   allocated directly from buddy allocator.
2. unreclaimable memory - this accounts for the total length of
   mappings of a certain type. These are _mappings_ that are
   accounted since limiting mapping limits memory usage and alows
   a grace rejects (-ENOMEM returned from sys_mmap), but with
   unlimited mappings you may limit memory usage with SIGKILL only.
3. physical pages - these includes pages mapped in page faults and
   hitting the pyspages limit starts pages reclamation.

[snip]

> 5. Open issues
> 
> (i)    Can we allow threads belonging to the same process belong
>        to two different resource groups? Does this mean we need to do per-thread
>        VM accounting now?

Solving this question is the same as solving "how would we account for
pages that are shared between several processes?".

> (ii)   There is an overhead associated with adding a pointer in struct page.
>        Can this be reduced/avoided? One solution suggested is to use a
>        mirror mem_map.

This does not affect infrastructure, right? E.g. current beancounter
code uses page_bc() macro to get BC pointer from page. Changing it
from
#define page_bc(page) ((page)->page_bc)
to
#define page_bc(page) ((bc_mmap[page_to_pfn(page)])
or similar may be done at any moment.

We may deside that "each page has an associated BC pointer" and
go on further discussion (e.g. which interface to use). The solution
where to store this pointer may be taken after we agree on all the
rest.

Since we're not going to discuss right now what kind of locking
we are going to have, let's delay the discussion of anything that
is code-dependent.

> (iii)  How do we distribute the remaining resources among resource hungry
>        groups? The Resource Group implementation used the ratio of the limits
>        to decide on the ratio according to which they are distributed.
> (iv)   How do we account for shared pages? Should it be charged to the first
>        container which touches the page or should it be charged equally among
>        all containers sharing the page?
> (v)    Definition of RSS (see http://lkml.org/lkml/2006/10/10/130)
> 
> 6. Going forward
> 
> (i)    Agree on requirements (there has been some agreement already, please
>        see http://lkml.org/lkml/2006/9/6/102 and the BOF summary [7])
> (ii)   Agree on minimum accounting and hooks in the kernel. It might be
>        a good idea to take this up in phases
>        phase 1 - account for user space memory
>        phase 2 - account for kernel memory allocated on behalf of the user/task

I'd raised the priority of kernel memory accounting.

I see that everyone agree that we want to see three resources:
  1. kernel memory
  2. unreclaimable memory
  3. reclaimable memory
if this is right then let's save it somewhere
(e.g. http://wiki.openvz.org/Containers/UBC_discussion)
and go on discussing the next question - interface.

Right now this is the most diffucult one and there are two
candidates - syscalls and configfs. I've pointed my objections
agains configfs and haven't seen any against system calls...
