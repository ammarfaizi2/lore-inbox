Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWFSKuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWFSKuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWFSKuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:50:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53891 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932379AbWFSKuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:50:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] utrace: new modular infrastructure for user debug/tracing
X-Shopping-List: (1) Geopolitical ignorant bacon
   (2) Big rectum malnutrition
   (3) Dormant cognizant gloves
   (4) Mathematical ominous burger fashions
Message-Id: <20060619105011.31953180049@magilla.sf.frob.com>
Date: Mon, 19 Jun 2006 03:50:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on for a while, and imagining for much longer,
replacing ptrace from the ground up.  This is what I've come up with so
far, and I'm looking for some reactions on the direction.  What I'm
proposing here is a substrate for doing wonderful new things, and I don't
yet have something built on top of it to demonstrate wonderful things.
This is intended to make it easy for lots of folks to whip up new things
and show what fancy business is possible and worthwhile.

Since I posted about this before, I've rebased.  These patches are relative
to 2.6.17.  The patches are somewhat large and when I posted before they
didn't all go through.  They are bigger than the cutoff suggested in
SubmittingPatches, so this time I'll instead give their URLs.

http://people.redhat.com/roland/utrace/1-utrace-tracehook.patch
http://people.redhat.com/roland/utrace/2-utrace-regset.patch
http://people.redhat.com/roland/utrace/3-utrace-core.patch
http://people.redhat.com/roland/utrace/4-utrace-ptrace-compat.patch

I've separated this into four successive patches in hopes it makes it
easier to read the patches.  The intent is that each intermediate patch
yields a kernel tree that compiles and works, though after the first patch
and before the last you get ENOSYS from any ptrace call.  Patch #1 wipes
out ptrace and its cruft from the bowels of the kernel.  Patch #2 converts
the architecture-specific ptrace guts into the architecture-specific guts
for the new thing.  Patch #3 is the crux of it, the new layer for writing
debugging interfaces.  Patch #4 implements ptrace with user ABI
compatibility in terms of that layer.

There are some known loose ends in the code.  I am seeking feedback on the
patches now to identify more issues I have not already noted in the code.
I'm also hoping to encourage some folks to try out the patches and beat on
ptrace some to work out the kinks.  I hope you'll also be inspired to write
a little module using utrace and see what you can do easily with it.  There
are some examples you can find off the web page below to start with.

These changes require some small porting work for each architecture.  In
these patches, I have done the architecture work only for i386, x86_64, and
powerpc.  The machine-specific work is quite small and straightforward for
anyone even mildly familiar with the architecture in question.  It consists
mainly of rearranging the existing architecture code used for ptrace into
some new functions.  There should be no need for new assembly hacking or
anything like that.  I was able to do the powerpc support in a couple of
hours, and am not any kind of expert on ppc (and took quite a bit longer
just to get myself able to build and boot ppc kernels).  Anyone interested
in doing the architecture support for another machine, please contact me
and I'll be glad to help.  The steps might already be fairly obvious from
reading the arch/ changes in these patches.

At http://redhat.com/~roland/utrace/ you can always find the current state
of this work.  There you can also find a small test suite I use, and an
example module demonstrating a novel feature implemented very cheaply using
the new infrastructure.  Please send feedback to me at <roland@redhat.com>.

---

This series of patches revamps the support for user process debugging
from the ground up, replacing the old ptrace support completely.

Two major problems with ptrace are its interface and its implementation.

The low-level code for tracing core events is directly tied into the
implementation of the ptrace system call interface.  Machine-dependent
code for accessing registers and controlling single-stepping is
intermingled with core implementation details that are actually
machine-independent and repeated across arch directories.  ptrace
interferes with the normal parent-child linkage, introducing many
corner cases that have caused trouble in the past.

The shortcomings of ptrace as a user-mode interface for debugging are
many, and well-known to those who have worked with it from the userland
side, or been involved in fixing and maintaining it in the kernel.  The
system call interface is clunky to use and to extend, and makes it
difficult to reduce the overhead of doing several operations and of
transferring large amounts of data.  There is no way for more than one
party to trace a process.  The reporting model using SIGCHLD and wait4
is tricky to use reliably from userland, and especially hard to
integrate with other kinds of event loop.  Thread event reporting is
heavy-weight and not specified with good granularity: in practice a
traced thread stops for everything.

The old ptrace implementation is removed entirely and replaced with a
modular interface layer that provides user debugging and tracing
functionality separate from any single userland interface.  Rather than
trying to come up with a single new interface to replace ptrace, this
provides a platform for higher-level code in kernel modules to provide
userland interfaces for tracing and debugging.  The ptrace system call
is provided for compatibility, written on top of the new modular layer.

Currently there are these four patches:

[PATCH 1] utrace: tracehook (die, ptrace, die)
[PATCH 2] utrace: register sets
[PATCH 3] utrace core
[PATCH 4] utrace: ptrace compatibility


Thanks,
Roland
