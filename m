Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTDFHdu (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 03:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbTDFHdu (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 03:33:50 -0400
Received: from holomorphy.com ([66.224.33.161]:24985 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262884AbTDFHdr (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 03:33:47 -0400
Date: Sat, 5 Apr 2003 23:38:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406073836.GE1828@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
	dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random> <20030405132406.437b27d7.akpm@digeo.com> <20030405220621.GG1326@dualathlon.random> <20030405143138.27003289.akpm@digeo.com> <20030405231008.GI1326@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405231008.GI1326@dualathlon.random>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 01:10:08AM +0200, Andrea Arcangeli wrote:
> I still think we shouldn't associate any metadata with the nonlinear.
> nonlinaer should be enabled via a sysctl and have it run at true full
> speed, it's a bypass for the VM so you can mangle the pagetables from
> userspace.
> As soon as you start associating metadata to nonlinar, it's not the
> "raw fast" thing anymore and it increases the complexity.

One of the big reasons why it's desirable is to reduce the metadata,
so I agree here.


On Sun, Apr 06, 2003 at 01:10:08AM +0200, Andrea Arcangeli wrote:
> running bochs after echoing 1 into a sysctl should be fine, like also
> uml should echoing 1 into a sysctl to get revirtualized vsyscalls
> (unless we make it a prctl but that'll be more complex and slower).
> When bochs starts and runs the mmap(VM_NONLINEAR) it will get -EPERM and
> it will fall into the mmap mode (for 2.4 anyways). Or they can as well
> require the echoing so they won't need to maintain two modes.
> the nonlinear should work only in a separate special vma, its current
> api is very unclean since it can mix with original linear stuff into the
> same linear vma, and it doesn't allow more than one file into the same
> nonlinear vma. I still reccomend all my points that I posted yesterday
> to change the API to something much more approriate.

This is an unusual idea; I'd expect capable(CAP_IPC_LOCK) to suffice
to provide the privilege checks for direct mlocking as well as other
operations that lock memory (please don't look at hugetlbfs for this...).


On Sun, Apr 06, 2003 at 01:10:08AM +0200, Andrea Arcangeli wrote:
> there is a reason we have the vma. I mean, if we can do a lighter thing
> inside the nonlinear vmas, that has the same powerful functionality of
> the linear vmas, then why don't replace the vma with this ligher thing
> in the first place?

Well, the only information that the sub-vma's would need is the address
range and data structure linkage, the entire remainder of the rest
could be divined from the master vma. It's vaguely plausible, though
I've no idea how effective.


At some point in the past, akpm wrote:
>> There is talk going around about implementing some more sophisticated search
>> structure thatn a linear list.
>> And treating the nonlinear mappings as being mlocked is a great
>> simplification - I'd be interested in Ingo's views on that.

On Sun, Apr 06, 2003 at 01:10:08AM +0200, Andrea Arcangeli wrote:
> it's the right way IMHO, remap_file_pages is such an hack that can for
> sure live under a sysctl. Think vmware, it even requires the kernel
> modules. A sysctl is nothing compared to that. I wouldn't like to see
> applications start using it.  Esepcially those sigbus in the current api
> would be more expensive than the regular paging internal to the VM and
> besides the signal it would generate flood of syscalls and kind of
> duplication of memory management inside the userspace. And for the
> database they just live under the sysctl for the largepages in 2.4
> anyways.

I don't know of any SIGBUS in the current API; AFAIK it prefaults the
the PTE at remap_file_pages()-time if possible (there is a "blocking"
flag IIRC) and if not, allows minor faults by retrieving the file
offset from the (invalid!) PTE and otherwise normal fault servicing.

I'm not convinced it's truly a hack. Inherently complex mappings need
a more efficient mapping mechanism on both 32-bit and 64-bit machines,
for the reason of the pagetable utilization and space efficiency on
64-bit, and on 32-bit on the grounds of lowmem consumption of vma's.


On Sun, Apr 06, 2003 at 01:10:08AM +0200, Andrea Arcangeli wrote:
> About the rmap lower complexity vs objrmap, that's interesting now that
> I understood what your case is doing exactly, and well you have a good
> argument against objrmap, but given the performance difference I
> still definitely give the priority to the fast paths.  There's to say to
> be 100% fair the benchmarks comparisons between 2.4.21preXaaX and 2.5
> should be done with a glibc that uses the syscall instruction in 2.5,
> but I doubt it can only be explained by that especially given the latest
> speedups in that area. In short I personally don't care about running
> the rmap-test that much faster.

Predictability and graceful degradation under load is very important.
fork() and exec() are actually slow paths, despite being related to the
response times of forking servers and throughput of shell scripts;
they're very heavyweight operations and the "hit" seems to be within
reach of recovery with cocktails of pending or otherwise available but
not currently very well-interacting patches. Shell scripts and forking
servers are grossly inefficient anyway; performant methods generally
minimize process counts and spawning and/or turnover.

IMHO the real answer to these problems is refining the physical to
virtual address resolution methods. Physical scanning has very real
graceful degradation advantages in the presence of large-scale sharing
and complex mappings, but the space overhead of pointwise methods is
a catastrophic problem for large 32-bit machines and they have process
creation overheads that have raised eyebrows across the board.


-- wli
