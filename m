Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUEOOlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUEOOlu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUEOOlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:41:49 -0400
Received: from aun.it.uu.se ([130.238.12.36]:38091 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261862AbUEOOjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:39:20 -0400
Date: Sat, 15 May 2004 16:39:10 +0200 (MEST)
Message-Id: <200405151439.i4FEdAQq001360@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: hch@infradead.org
Subject: Re: [PATCH][1/7] perfctr-2.7.2 for 2.6.6-mm2: core
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 15:40:05 +0100, Christoph Hellwig wrote:
>  And even without that it's a really horrible
>interface.  Any chance to do a proper fs-based interface ala oprofile?

I object to "proper" and "fs-based". If that was universally
true, then we'd only have 3 file-system related system
calls (open, read, write) and _everything_ else would
be expressed using those on various special fs:s.

Several 64-bit archs already have low-level performance
counter interfaces (non-fs based I might add) in the kernel.
This interface is no worse than those.

The per-process counters API needs to express:
- Open the perfctr state belonging to a given process
  (a real kernel process, not that process group thing)
  returning a handle (file descriptor).
  The fd is used with mmap() for low-overhead sampling,
  and as an access-rights token in the other operations.
- Alternatively, create the state and return a handle.
- Unlink the state represented by a handle from the
  process it is attached to.
- Update the state's control data. This involves CPU-specific
  data, the signal you want on overflow interrupts, and a
  mask indicating which counter sums you want to preserve
  (otherwise they're reset).
- Resume the counters. The counters are temporarily suspended
  when the overflow signal handler is invoked; the handler
  uses this operation to tell the kernel to resume the counters.
  The handler can of course choose not to do this.
- Read the counter sums from the state. This is used when
  user-space can't or doesn't want to use the mmap()ed state.
  (Old P5 and Winchip processors must do this.)
- Read the control data from the state. Used e.g. when
  the counters are accessed from a different process.

The global-mode counters API needs to express:
- Stop all counters on all CPUs.
- Write control data to a given CPU.
- Start the counters, with a given sampling interval.
- Read the control data and counter sums from a given CPU.

The CPU-specific control data needs to express:
- Which CPU-counter to map a given counter to. This is
  rarely a 1-to-1 mapping because processors tend to have
  asymmetric counters, and sometimes a large set in which
  only a few are to be used.
  User-space needs to be in charge of this mapping. This
  is NOT something the kernel should be doing behind the
  user's back, precisely because HW isn't symmetric.
  This mapping also affects the user-space sampling code.
- The per-counter control data to associate with a given counter.
  The amount of this varies considerably.
- The global control data shared by all counters.
  The amount of this varies considerably.
- The initial and restart values for interrupt-on-overflow
  counters.
- Whether to also sample the CPU's clock-like counter.

Doing all of this via file-system operations would either
require a big hierarchy of directories and files, or a smaller
hierarchy plus parsers for written textual data.

Passing struct:s works, except for binary compatibility
issues. (And since the structures must be updated to match
newer CPUs, these issues are very real.) 

>Haven't looked over much of the code yet, but the people who support
>32bit userspace on 64bit architectures will probably kill you for
>the multiplexer syscall.

The previous ioctl()-based perfctr-2.6 version supports i386
binaries on x86_64 kernels, as should this syscall() version.

Key to this is the structure marshalling code which does
several things:
- allows the kernel to add fields (e.g. for new processors)
  without affecting older user-space code
- allows user-space code to work on an older kernel whose
  structures have fewer fields (supports fewer processors),
  as long as user-space does CPU type detection and doesn't
  attempt to use e.g. P4-only fields on a P6 or K7

The pass-binary-structures-via-marshalling approach works,
but I admit it is uncommon. Converting to a pseudo-fs
interface will require a substantial amount of work and code.
Of course, I will do that if I have no choice...

/Mikael
