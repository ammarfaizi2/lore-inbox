Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbTGCLc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTGCLc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:32:28 -0400
Received: from holomorphy.com ([66.224.33.161]:4798 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265166AbTGCLcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:32:22 -0400
Date: Thu, 3 Jul 2003 04:46:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030703114626.GP26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random> <20030702214032.GH20413@holomorphy.com> <20030702220246.GS23578@dualathlon.random> <20030702221551.GH26348@holomorphy.com> <20030702222641.GU23578@dualathlon.random> <20030702231122.GI26348@holomorphy.com> <20030702233014.GW23578@dualathlon.random> <20030702235540.GK26348@holomorphy.com> <20030703113144.GY23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703113144.GY23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 04:55:40PM -0700, William Lee Irwin III wrote:
>> it from; we don't unmap it from all processes, just the current one, and

On Thu, Jul 03, 2003 at 01:31:44PM +0200, Andrea Arcangeli wrote:
> if this is the case, this also means mlock isn't enough to guarantee to
> drop the pte_chains: you also will need everybody else mapping the file
> to mlock after every mmap or the pte_chains will stay there.

IMHO the unpriviliged applications might as well just be subject to
restrictive resource limits on number of processes etc. to cope with
that. I see zero loss in creating the pte_chains for mappers of the
files that aren't privileged enough to mlock().


On Thu, Jul 03, 2003 at 01:31:44PM +0200, Andrea Arcangeli wrote:
> Last but not the least mlock is a privilegied operations and it in turn
> it *can't* be used. Those apps strictly runs as normal user for all the
> good reasons. so at the very least you need a sysctl to allow anybody to
> run mlock.

This is obviously out of the question if the entire goal of the exercise
of devolving inhibition of pte_chains to mlock() is enabling things to
run with minimal privileges.

I suggest granting CAP_IPC_LOCK with libcap and/or its associated
utility programs in pam modules in preference to sysctl's that allow
arbitrary users to exercise such privileges, despite the administrative
overhead and/or obscurity of such interfaces and/or utilities.


On Thu, Jul 03, 2003 at 01:31:44PM +0200, Andrea Arcangeli wrote:
> Yet another issue is that mlock at max locks in half of the physical
> ram, this makes it unusable (google is patching it too for their
> internal usage that skips the more costly page faults), so you would
> need another sysctl to select the max amount of mlockable memory (or you
> could share the same sysctl that makes mlock a non privilegied
> operation, it's up to you).

Twiddling resource limits doesn't sound like a significant obstacle to me.


On Thu, Jul 03, 2003 at 01:31:44PM +0200, Andrea Arcangeli wrote:
> Bottom line is that you will still need a sysctl for security reasons
> (equivalent to my sysctl to make remap_file_pages runnable as normal
> user with my proposal), and my proposal is an order of magnitude simpler
> to implement and maintain, and it doesn't affect mlock and it doesn't
> create any complication with the rest of VM, since the rest of the VM
> will never see those populated-pages via remap_file_pages, they will be
> threated like pages under I/O via kiobuf etc... (so anonymous ones)

Well, what I'm _trying_ to do is cut down the privilege requirements to
where API's remain generally useful as opposed to totally castrating
them to the point where almost nothing can use them. I think by the
time it's chopped down to maximum mlock()'able RAM with all other
mechanisms usable by normal users we're home free.


On Thu, Jul 03, 2003 at 01:31:44PM +0200, Andrea Arcangeli wrote:
> Your only advantage for the VM complications is that the emulator won't
> need to use the sysctl (and well, most emulators needs root privilegies
> anyways for kernel modules for nat etc..) and that it will be allowed to
> swap heavily without the vma overhead (that IMHO is negligeable anyways
> during heavy swapping with the box idle, especially after mmap will
> always run in O(log(N)) where N is the number of vmas, currently it's
> O(N) but it'll be improved).

Actually it's not entirely for vma overhead. Compacting the virtual
address space allows users to be "friendly" with respect to pagetable
space or other kernel metadata space consumption whether on 32-bit or
64-bit. For instance, the "vast and extremely sparsely accessed"
mapping on 64-bit machines can have its pagetable space mitigated by
userspace using the remap_file_pages() API, where otherwise it would
either OOM or incur pagetable reclamation overhead (where pagetable
reclamation is not yet implemented).


-- wli
