Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269671AbTHBRE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 13:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269676AbTHBRE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 13:04:59 -0400
Received: from almesberger.net ([63.105.73.239]:4365 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S269671AbTHBREz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 13:04:55 -0400
Date: Sat, 2 Aug 2003 14:04:44 -0300
From: Werner Almesberger <werner@almesberger.net>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: TOE brain dump
Message-ID: <20030802140444.E5798@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At OLS, there was a bit of discussion on (true and false *) TOEs
(TCP Offload Engines). In the course of this discussion, I've
suggested what might be a novel approach, so in case this is a
good idea, I'd like to dump my thoughts on it, before someone
tries to patent my ideas. (Most likely, some of this has already
been done or tried elsewhere, but it can't hurt to try to err on
the safe side.)

(*) The InfiniBand people unfortunately call also their TCP/IP
    bypass "TOE" (for which they promptly get shouted down,
    every time they use that word). This is misleading, because
    there is no TCP that's getting offloaded, but TCP is simply
    never done. I would consider it to be more accurate to view
    this as a separate networking technology, with semantics
    different from TCP/IP, similar to ATM and AAL5.

While I'm not entirely convinced about the usefulness of TOE in
all the cases it's been suggested for, I can see value in certain
areas, e.g. when TCP per-packet overhead becomes an issue.

However, I consider the approach of putting a new or heavily
modified stack, which duplicates a considerable amount of the
functionality in the main kernel, on a separate piece of hardware
questionable at best. Some of the issues:

 - if this stack is closed source or generally hard to modify,
   security fixes will be slowed down

 - if this stack is closed source or generally hard to modify,
   TOE will not be available to projects modifying the stack,
   e.g. any of the research projects trying to make TCP work at
   gigabit speeds

 - this stack either needs to implement all administrative
   interfaces of the regular kernel, or such a system would have
   non-uniform configuration/monitoring across interfaces

 - in some cases, administrative interfaces will require a
   NIC/TOE-specific switch in the kernel (netlink helps here)

 - route changes on multi-homed hosts (or any similar kind of
   failover) are difficult if the state of TCP connections is
   tied to specific NICs (I've discussed some issues when
   "migrating" TCP connections in the documentation of tcpcp,
   http://www.almesberger.net/tcpcp/)

 - new kernel features will always lag behind on this kind of
   TOE, and different kernels will require different "firmware"

 - last but not least, keeping TOE firmware up to date with the
   TCP/IP stack in the mainstream kernel will require - for each
   such TOE device - a significant and continuous effort over a
   long period of time

In short, I think such a solution is either a pain to use, or
unmaintainable, or - most likely - both.

So, how to do better ? Easy: use the Source, Luke. Here's my
idea:

 - instead of putting a different stack on the TOE, a
   general-purpose processor (probably with some enhancements,
   and certainly with optimized data paths) is added to the NIC

 - that processor runs the same Linux kernel image as the host,
   acting like a NUMA system

 - a selectable part of TCP/IP is handled on the NIC, and the
   rest of the system runs on the host processor

 - instrumentation is added to the mainstream kernel to ensure
   that as little data as possible is shared between the main
   CPU and such peripheral CPUs. Note that such instrumentation
   would be generic, outlining possible boundaries, and not tied
   to a specific TOE design.

 - depending on hardware details (cache coherence, etc.), the
   instrumentation mentioned above may even be necessary for
   correctness. This would have the unfortunate effect of making
   the design very fragile with respect to changes in the
   mainstream kernel. (Performance loss in the case of imperfect
   instrumentation would be preferable.)

 - further instrumentation may be needed to let the kernel switch
   CPUs (i.e. host to NIC, and vice versa) at the right time

 - since the NIC would probably use a CPU design different from
   the host CPU, we'd need "fat" kernel binaries:

   - data structures are the same, i.e. word sizes, byte order,
     bit numbering, etc. are compatible, and alignments are
     chosen such that all CPUs involved are reasonably happy

   - kernels live in the same address space

   - function pointers become arrays, with one pointer per
     architecture. When comparing pointers, the first element is
     used.

 - if one should choose to also run parts of user space on the
   NIC, fat binaries would also be needed for this (along with
   other complications)

Benefits:

 - putting the CPU next to the NIC keeps data paths short, and
   allows for all kinds of optimizations (e.g. a pipelined
   memory architecture)

 - the design is fairly generic, and would equally apply to
   other areas of the kernel than TCP/IP

 - using the same kernel image eliminates most maintenance
   problems, and encourages experimenting with the stack

 - using the same kernel image (and compatible data structures)
   guarantees that administrative interfaces are uniform in the
   entire system

 - such a design is likely to be able to allow TCP state to be
   moved to a different NIC, if necessary

Possible problems, that may kill this idea:

 - it may be too hard to achieve correctness

 - it may be too hard to switch CPUs properly

 - it may not be possible to express copy operations efficiently
   in such a context

 - there may be no way to avoid sharing of hardware-specific
   data structures, such as page tables, or to emulate their use

 - people may consider the instrumentation required for this,
   although fairly generic, too intrusive

 - all this instrumentation may eat too much performance

 - nobody may be interested in building hardware for this

 - nobody may be patient enough to pursue such long-termish
   development, with uncertain outcome

 - something I haven't thought of

I lack the resources (hardware, financial, and otherwise) to
actually do something with these ideas, so please feel free to
put them to some use.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
