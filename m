Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbTCQFaO>; Mon, 17 Mar 2003 00:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbTCQFaO>; Mon, 17 Mar 2003 00:30:14 -0500
Received: from rj.sgi.com ([192.82.208.96]:53212 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S262802AbTCQFaK>;
	Mon, 17 Mar 2003 00:30:10 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Announce: kdb v4.0 is available for kernels 2.4.19, 2.4.20, i386 and ia64
Date: Mon, 17 Mar 2003 16:40:44 +1100
Message-ID: <24691.1047879644@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v4.0/

  kdb-v4.0-2.4.19-common-1.bz2
  kdb-v4.0-2.4.19-i386-1.bz2
  kdb-v4.0-2.4.19-ia64-020821-1.bz2
  kdb-v4.0-2.4.20-common-1.bz2
  kdb-v4.0-2.4.20-i386-1.bz2
  kdb-v4.0-2.4.20-ia64-021210-1.bz2

 <=== You know what they say about .0 releases.  Caveat emptor. ===>

The biggest change is this release in the way that kdb captures data
from each cpu.  Prior to v4.0, the controlling cpu (first to get into
kdb) would try to pull the other cpus into kdb by sending them an IPI.
Doing a backtrace on the active tasks required that kdb switch its
context into each cpu in turn.

This works in most cases, but when the system is really wedged, it is
difficult to get data from the other cpus.  Of course this is precisely
the case when we want data from the other cpus.  This problem is
particularly noticeable on ia64, when machine checks (MCA) or INIT
interrupts can disable normal IPI or dive down into SAL, taking control
away from the OS.  Also on IA64 the non-maskable interrupt is actually
masked[1].

In kdb v4.0, each cpu pushes its state via a global array.  This allows
any cpu to do a backtrace on any other cpu, from a known starting
point.  It even handles the cases when IA64 requires that cpus
rendezvous and spin in SAL.  The push model also makes it easier to
detect when a cpu is dead, an event which would often hang the old kdb
pull model.

On ia64, kdb v4.0 gives decent backtraces from MCA callback, MCA
rendezvous and the INIT monarch event.  The next step in kdb v4.1 is to
detect hung spinloops and break out of them, and to support INIT slave
events.  The detection and debugging of hung spinloops is waiting on
acceptance of my new spinlock code for IA64[2].

[1] http://external-lists.valinux.com/archives//linux-ia64/2001-May/subject.html,
    look for 'Replacements for local_irq_xxx'.
[2] http://external-lists.valinux.com/archives//linux-ia64/2003-March/004976.html


Changelog extracts since v3.0.

2.4.{19,20}-common-1

2003-03-16 Keith Owens  <kaos@sgi.com>

        * Each cpu saves its state as it enters kdb or before it enters code
          which cannot call kdb.
        * Allow btp on process 0 for a specified cpu.
        * Add btt command, backtrace given a struct task address.
        * btc command no longer switches cpus, instead it uses the saved data.
        * bta shows the idle task on each cpu as well as real tasks, the idle
          task could be handling an interrupt.
        * ps command shows the idle task on each cpu.
        * ps checks that the saved data for a cpu matches the process running on
          that cpu and warns about stale saved data or no saved data at all.
        * Remove special cases for i386 backtrace from common code and simplify
          common bt code.
        * Clean up kdb interaction with CONFIG_SERIAL_CONSOLE.
        * Do not automatically repeat commands after the user typed 'q'.
        * O(1) scheduler patch changes the process cpu field but does not set
          any indicator that O(1) is being used.  Adjust kdb_process_cpu() by
          hand after applying O(1).
        * Add kdb_print_nameval() to common code.
        * Convert tests of cpu_online_map to cpu_online() macro.
        * module.h needs errno.h when compiling with CONFIG_MODULES=n.
        * Correct duplicate breakpoint handling.
        * Do not try to send IPI during a catastrophic error, send_ipi can hang
          and take kdb with it.
        * kdb memmap command is i386 only, restrict it.
        * Add large block device (LBD) support from XFS tree.  Eric Sandeen.

2.4.{19,20}-i386-1

2003-03-16 Keith Owens  <kaos@sgi.com>

        * Each cpu saves its state as it enters kdb or before it enters code
          which cannot call kdb, converting kdb from a pull to a push model.
        * Clean up kdb interaction with CONFIG_SERIAL_CONSOLE.
        * Removal of special cases for i386 backtrace from common code
          simplifies the architecture code.
        * Add command to dump i386 struct pt_regs.

2.4.{19,20}-ia64-*-1

2003-03-16 Keith Owens  <kaos@sgi.com>

        * Each cpu saves its state as it enters kdb or before it enters code
          which cannot call kdb, converting kdb from a pull to a push model.
        * Clean up kdb interaction with CONFIG_SERIAL_CONSOLE.
        * Removal of special cases for i386 backtrace from common code
          simplifies the architecture code.
        * Add support for MCA events (both main and rendezvous) plus INIT
          monarch event.
        * Correct decode of brl.
        * Move kdba_print_nameval to common code.
        * Generalize kdba unwind handlers.
        * Fix decode of sal records (fix included in later ia64 kernels).
        * Handle multiple pt_regs in stack (fix included in later ia64 kernels).
        * Clean up debug code in unwind (fix included in later ia64 kernels).
        * Move kdb break numbers to their own file so it can be used in asm.



v4.0/README

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

 vx.y    The version of kdb.  x.y is updated as new features are added to kdb.
 -v.p.s  The kernel version that the patch applies to.  's' may include -pre,
	 -rc or whatever numbering system the kernel keepers have thought up this
	 week.
 -common The common kdb code.  Everybody needs this.
 -i386   Architecture dependent code for i386.
 -ia64   Architecture dependent code for ia64, etc.
 -n      If there are multiple kdb patches against the same kernel version then
	 the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb for i386 on kernel 2.4.20, apply
  kdb-v4.0-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v4.0-2.4.20-i386-<n>              (use highest value of <n>)
in that order.  To use kdb for ia64-021210 on kernel 2.4.20, apply
  kdb-v4.0-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v4.0-2.4.20-ia64-021210-<n>       (use highest value of <n>)
in that order.

Use patch -p1 for all patches.

I do not have any time to work on 2.5, so there are no patches available
for 2.5 kernels.  If somebody wants to port the latest kdb patches to
2.5 kernels and send patches to kaos@sgi.com then I will put them up in
this directory.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE+dV/Zi4UHNye0ZOoRAnClAJ9w5o2dFH1PiacptvwX1uGJRWb1lACdEcpH
3F9mS5NCPrM91Nt1WuYEm+s=
=dlxz
-----END PGP SIGNATURE-----

