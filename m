Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbUDAT24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDAT24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:28:56 -0500
Received: from faui10.informatik.uni-erlangen.de ([131.188.31.10]:17342 "EHLO
	faui10.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S263075AbUDAT2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:28:24 -0500
From: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Message-Id: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
Subject: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
To: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Date: Thu, 1 Apr 2004 21:28:20 +0200 (CEST)
Cc: schwidefsky@de.ibm.com, ak@suse.de
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm seeing a race condition on Linux 2.6 that rather reproducibly
causes GCC bootstrap failures on current mainline.

The problem is spurious rebuilds of some auto-generated files
in the gcc/ directory while building the Ada libraries.

For example, we have the following chain of dependencies:
genconditions generates insn-conditions.c, which is compiled
into insn-conditions.o, which is archived into libbackend.a,
which is linked into the compiler binaries (cc1, cc1plus, ...).

Now, insn-conditions.c is a rather small file, and compiling it
into insn-conditions.o takes usually less than a second.  So,
it may well happen that these two files end up having a time
stamp that differs only in the sub-second part.  (Note that
with Linux 2.4, file time stamps didn't actually have a
sub-second part; this is a new 2.6 feature.)

Unfortunately, while Linux now has sub-second time stamps,
those cannot actually be *stored* on disk when using the ext3
file system (because the on-disk format has no space).  This
has the rather curious effect that while the inode is still
held in Linux's inode cache, the time stamp will retain its
sub-second component, but once the inode was dropped from the
inode cache and later re-read from disk, the sub-second part
will be truncated to zero.

Now, if this truncation happens to the insn-conditions.o file,
but not the insn-conditions.c file, the former will jump from
being just slightly newer than the latter to being just slightly
*older* than the latter.  For some reason, this tends to occur
rather reliably during a gcc bootstrap on my system.

Now, as long as the main 'make' is running, this has no adverse
effect (apparently because make remembers it has already built
the insn-conditions.o file from insn-conditions.c).  However,
once the libada library is built, it performs a recursive make
invocation that once again checks dependencies in the master
gcc build directory, including the dependencies on gnat1.
At this point, make will re-check the file time stamps and
decide it needs to rebuild insn-conditions.o.  This in turn
triggers a rebuild of libbackend.a and all compiler binaries.

This is bad for two reasons.  First, at this point in time various
macros required to build the main gcc components aren't in fact
set up correctly, and thus the file will be rebuilt using the
host compiler and not the newly built stage3 gcc.

More importantly, when using parallel make to do the bootstrap,
at this point some *other* library, e.g. libstdc++ or libjava,
will be built at the same time, using the cc1plus or jc1 binaries
that the libada make has just decided it needs to rebuild.
While these binaries are being rebuilt, they will be in a deleted
or inconsistent state for a certain period of time.  During this
period, attempts to start compiles for libstdc++ or libjava
components will fail, causing the whole bootstrap to abort.

 
The appended makefile hack ensures that for generated files,
the .c and .o file time stamps differ by at least a second,
which makes the problem disappear.  This allows the bootstrap
to succeed again on my system.

However, I'd say that this should probably be fixed in the kernel,
e.g. by not reporting high-precision time stamps in the first
place if the file system cannot store them ...

Bye,
Ulrich


Index: gcc/Makefile.in
===================================================================
RCS file: /cvs/gcc/gcc/gcc/Makefile.in,v
retrieving revision 1.1266
diff -c -p -r1.1266 Makefile.in
*** gcc/Makefile.in	24 Mar 2004 18:03:15 -0000	1.1266
--- gcc/Makefile.in	30 Mar 2004 23:46:11 -0000
*************** POD2MAN = pod2man --center="GNU" --relea
*** 247,253 ****
  # Some versions of `touch' (such as the version on Solaris 2.8)
  # do not correctly set the timestamp due to buggy versions of `utime'
  # in the kernel.  So, we use `echo' instead.
! STAMP = echo timestamp >
  
  # Make sure the $(MAKE) variable is defined.
  @SET_MAKE@
--- 247,253 ----
  # Some versions of `touch' (such as the version on Solaris 2.8)
  # do not correctly set the timestamp due to buggy versions of `utime'
  # in the kernel.  So, we use `echo' instead.
! STAMP = sleep 1 >
  
  # Make sure the $(MAKE) variable is defined.
  @SET_MAKE@
-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
