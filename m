Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSKZFFs>; Tue, 26 Nov 2002 00:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbSKZFFs>; Tue, 26 Nov 2002 00:05:48 -0500
Received: from mnh-1-07.mv.com ([207.22.10.39]:15366 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262876AbSKZFFq>;
	Tue, 26 Nov 2002 00:05:46 -0500
Message-Id: <200211260517.AAA05038@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@sourceforge.net
Subject: uml-patch-2.5.49-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Nov 2002 00:17:07 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges the rework that has been in my 2.4 pool for the last month
or so.  I'm going to describe what happened in some detail since it hasn't 
been discussed on lkml at all, and there are some generic kernel changes
involved which may be of wider interest.

The design of UML has had as its main points:
	every UML process has a corresponding host process
	the UML kernel is mapped into the top .5G of each process' address space
	there is a special thread, the tracing thread, which ptraces all the
other threads, managing their transitions between the kernel and userspace.

This is insecure, because protecting UML kernel data from its processes is
hard to do right, and impossible to do quickly.  UML does have a 'jail' mode
which implements this, which is many times slower than non-jail.

It's also slow, because entry to userspace involves a signal delivery to
the process entering the kernel and a signal return when leaving the kernel.

To fix these problems, I followed up an observation by Ingo a few months ago
that a full process context switch is several times faster than an in-process
signal delivery.

I implemented a new mode which puts the UML kernel into a completely separate
address space from its processes.  skas (== "separate kernel address space" -
the traditional mode is now called tt (== "tracing thread")) mode has these
main points:
	the kernel is in a separate process and address space from its processes
	UML processes share a single host process
	each UML process has its own host address space
	thus, the "userspace" process hops between address spaces on each UML
context switch

skas mode has a number of advantages over the traditional tt mode:

better security - since the kernel is in a different address space, processes
can't even see, let alone modify, kernel data, since they can't form a kernel
address.

better performance - it is significantly faster.  Kernel builds in skas mode
approach twice the speed of tt mode, and ~30% slower than the host (compared
to ~100% slower with tt mode).

better debuggability - it is now possible to 'gdb linux' and have it do what
you expect.  Tools like gprof, gcov, and ddd should now just work, without
needing special support inside UML (although gprof currently needs the removal
of some of that support in order to work).  It is possible to build UML as
a normal dynamically linked binary, which will make it possible to valgrind
the kernel (although valgrind is currently bothered by UML's use of clone).

cleaner code - process creation, switching, and destruction are far simpler,
cleaner, and faster in the skas code than in the tt code.

miscellaneous - UML process address spaces are now identical to those on the
host - this is advantageous for applications such as honeypots, as well as
possibly for applications which use the full 3G address space.  The kernel
now has a full 3G of virtual address space.

There is one major disadvantage to skas mode - it can't be implemented given
the support currently in the stock kernel.

I've added some stuff into the generic and i386 code to make skas mode 
possible.  This support includes:
	/proc/mm, which allows address spaces to be created independently of
processes
	a number of ptrace extensions

/proc/mm has the following semantics -
	open creates a new, empty address space - the file descriptor returned
is used as a handle to that address space
	write modifies the address space according to the structure that is
passed in as the buffer argument.  The possible operations are map, unmap,
protect, and copy segments.  The first three are identical to mmap, munmap,
and mprotect.  The last is used to copy the arch-specific data associated
with the mm_struct as part of cloning the address space.
	close drops the reference count of the address space, which normally
frees it since UML will not have any processes running in it

The ptrace extensions are:
	PTRACE_FAULTINFO - returns the information assoicated with the child's
most recent segfault
	PTRACE_SIGPENDING - returns the child's pending signal mask
	PTRACE_LDT - performs a modify_ldt on the child - this is really an
address space operation and will be moved to /proc/mm at some point
	PTRACE_SWITCH_MM - switches the child from its current address space
to the one associated with the file descriptor pass in with this call

The host support patch is available with all the other UML downloads at
	http://user-mode-linux.sf.net/dl-sf.html

I welcome any comments on it.  The /proc/mm write semantics are less than
ideal - I especially would like suggestions for improvements.

The 2.5.49 UML patch is available at
        http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.49-1.bz2
 
For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org
 
                                Jeff

