Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318879AbSG1BpT>; Sat, 27 Jul 2002 21:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318882AbSG1BpT>; Sat, 27 Jul 2002 21:45:19 -0400
Received: from holomorphy.com ([66.224.33.161]:24741 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318879AbSG1BpS>;
	Sat, 27 Jul 2002 21:45:18 -0400
Date: Sat, 27 Jul 2002 18:48:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Robert Love <rml@tech9.net>,
       Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
Message-ID: <20020728014813.GH2907@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>, Robert Love <rml@tech9.net>,
	Russell Lewis <spamhole-2001-07-16@deming-os.org>,
	linux-kernel@vger.kernel.org
References: <1027710974.2443.39.camel@sinai> <Pine.LNX.4.44L.0207261617020.3086-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0207261617020.3086-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 04:18:56PM -0300, Rik van Riel wrote:
> Large pages and/or shared page tables should be more than
> sufficient to handle all 'benign' real workloads.
> However, 'malicious' workloads can easily generate the
> need for more pagetables than what will fit into physical
> RAM; at that point you just _have_ to throw some of these
> page tables out of RAM.  If the data can be reconstructed
> from the VMA and the page cache, we can just blow the page
> table away. If it can't, we have to come up with another
> solution (maybe as simple as killing the application).

If I can poke at the malice & sufficiency bits, the workloads
triggering pagetable memory exhaustion seem to be:

(1) forking server
(2) memory-sharing constellation of processes
(3) university workload, i.e. [tens of] thousands of idle /bin/sh's etc.
(4) someone mapping a large object (64-bit)
(5) large address space coverage over time with mmap/mremap/etc. (64-bit)

(4) and (5) both involve only a single task, largely innocent of trying
to do anything industrial-strength. Yes. It's that easy to do.

Databases on 32-bit appear to be hybrids of (1) and (2), and on 64-bit,
combinations of (1), (2), (4), and (5).

Of these workloads, only (2) is feasible through pagetable sharing and
cooperation from userspace, and only (4) is feasible though large pages
and cooperation from userspace. All of these exceed physical memory
bounds, not just virtual, and hence none are solved by pte-highmem.
64-bit doesn't have highmem so (4) and (5) are immune to it anyway. The
failure mode is typically deadlock, but SCSI panics were often seen in
2.4.x, along with other nondeterministic failures.

Feasible database workloads on 32-bit machines running mainline kernels
seem to run with between 50% and 90% of physical memory consumed by
process pagetables and severe restrictions on the number of clients
that attempt to connect. When larger proportions of memory are consumed
by process pagetables, kernel deadlock often ensues.

Cheers,
Bill
