Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTDZVyk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 17:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbTDZVyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 17:54:40 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:10153 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261994AbTDZVyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 17:54:39 -0400
Date: Sat, 26 Apr 2003 15:06:43 -0700
Message-Id: <200304262206.h3QM6hJ22525@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: davidm@hpl.hp.com
X-Fcc: ~/Mail/linus
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] i386 vsyscall DSO implementation
In-Reply-To: David Mosberger's message of  Friday, 25 April 2003 09:21:46 -0700 <16041.24730.267207.671647@napali.hpl.hp.com>
X-Windows: a terminal disease.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I like this.  Even better would be if all platforms could do the same.
> I'm definitely interested in doing something similar for ia64 (the
> getunwind() syscall was always just a stop-gap solution).

It is very straightforward to implement.  The arch/i386/kernel/Makefile
rules can be copied for other architectures, modified slightly if you don't
need two different .so's (or name them differently).  The syntax in
vsyscall.S using .incbin works in gas for any platform AFAIK.  You can also
use -iformat binary and tweaks to the kernel linker script to do the
equivalent without wrapper assembly file.  The vsyscall-syms.o hacks are
only necessary if you want kernel code to refer to symbol names defined in
the DSO source.  The vsyscall.lds linker script will be slightly different
for each platform, but the tweaks should be trivial.  If you aren't making
vsyscall-syms.o then you don't need to hard-wire the .text offset, and the
entry point addresses will just be chosen by ld.  As Ulrich mentioned, you
can write the contents of the page however you would like to write it as
normal user code (C or assembly).

> I assume that these kernel ELF images would then show up in
> dl_iterate_phdr()?

Yes.  I have glibc changes for this that will go in when the kernel is ready.
(This is the primary immediate benefit of the scheme.  The immediate need
is for the unwind info, which with this and PT_GNU_EH_FRAME fits in neatly.)

> To complete the picture, it would be nice if the kernel ELF images were
> mappable files (either in /sysfs or /proc) and would show up in
> /proc/PID/maps.  That way, a distributed application such as a remote
> debugger could gain access to the kernel unwind tables on a remote
> machine (assuming you have a remote filesystem).

The /proc file is obviously trivial to do and I've considered offering it.
A remote debugger is much better prepared to read it out of the inferior
process's memory than to find the right filesystem, and that seems like the
debugger implementation most likely to always find the right info.  (We
expect to be hacking gdb to do this soon.)  The reason I can see for
wanting a /proc/sys/vsyscall.so or such file is if you are linking a
program against the DSO for its soname and symbols.  But for that purpose
it isn't necessary, and I think not even desireable, to always use the
fresh DSO image from the live kernel.  You can extract the DSO image from
the running kernel with a trivial program, and store it in a normal file,
package and version it manually for kernel-devel packages, etc.  I'm not
opposed to having a /proc file, but I doubt there is any essential purpose
for which it's really what you want to use.

Having some note of the region in /proc/PID/maps is another question.  Even
if it's not said to refer to some named file, it would be nice to have the
address range indicated so as to preserve the pre-vsyscall property that
maps lines show all addresses that the particular process could in fact
access.  That can be implemented either by a hack or by having a normal vma
for the vsyscall page.  The latter would also eliminate the need for a hack
in ptrace to allow reading the page (I will post that patch again shortly).


Thanks,
Roland
