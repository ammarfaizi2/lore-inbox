Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTDEXAK (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 18:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTDEXAK (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 18:00:10 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:20846 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S262719AbTDEW6o (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:58:44 -0500
Date: Sun, 6 Apr 2003 01:10:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030405231008.GI1326@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random> <20030405132406.437b27d7.akpm@digeo.com> <20030405220621.GG1326@dualathlon.random> <20030405143138.27003289.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405143138.27003289.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 02:31:38PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > I see what you mean, you're right. That's because all the 10,000 vma
> > belongs to the same inode.
> 
> I see two problems with objrmap - this search, and the complexity of the
> interworking with nonlinear mappings.

I still think we shouldn't associate any metadata with the nonlinear.
nonlinaer should be enabled via a sysctl and have it run at true full
speed, it's a bypass for the VM so you can mangle the pagetables from
userspace.

As soon as you start associating metadata to nonlinar, it's not the
"raw fast" thing anymore and it increases the complexity.

running bochs after echoing 1 into a sysctl should be fine, like also
uml should echoing 1 into a sysctl to get revirtualized vsyscalls
(unless we make it a prctl but that'll be more complex and slower).

When bochs starts and runs the mmap(VM_NONLINEAR) it will get -EPERM and
it will fall into the mmap mode (for 2.4 anyways). Or they can as well
require the echoing so they won't need to maintain two modes.

the nonlinear should work only in a separate special vma, its current
api is very unclean since it can mix with original linear stuff into the
same linear vma, and it doesn't allow more than one file into the same
nonlinear vma. I still reccomend all my points that I posted yesterday
to change the API to something much more approriate.

there is a reason we have the vma. I mean, if we can do a lighter thing
inside the nonlinear vmas, that has the same powerful functionality of
the linear vmas, then why don't replace the vma with this ligher thing
in the first place?

> There is talk going around about implementing some more sophisticated search
> structure thatn a linear list.
> 
> And treating the nonlinear mappings as being mlocked is a great
> simplification - I'd be interested in Ingo's views on that.

it's the right way IMHO, remap_file_pages is such an hack that can for
sure live under a sysctl. Think vmware, it even requires the kernel
modules. A sysctl is nothing compared to that. I wouldn't like to see
applications start using it.  Esepcially those sigbus in the current api
would be more expensive than the regular paging internal to the VM and
besides the signal it would generate flood of syscalls and kind of
duplication of memory management inside the userspace. And for the
database they just live under the sysctl for the largepages in 2.4
anyways.

About the rmap lower complexity vs objrmap, that's interesting now that
I understood what your case is doing exactly, and well you have a good
argument against objrmap, but given the performance difference I
still definitely give the priority to the fast paths.  There's to say to
be 100% fair the benchmarks comparisons between 2.4.21preXaaX and 2.5
should be done with a glibc that uses the syscall instruction in 2.5,
but I doubt it can only be explained by that especially given the latest
speedups in that area. In short I personally don't care about running
the rmap-test that much faster.

about the oom problem, I tried to C^c a few times but nothing bad
happened here. I'm not sure if it worth for me to change anything on the
2.4 side, I would like to reproduce it at least once. I know I can't
guarantee 100% reliable allocations, that's given, I don't know how many
pages are freeable, if I loop forever I could deadlock.

Andrea
