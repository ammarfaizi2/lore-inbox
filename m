Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSGTLPW>; Sat, 20 Jul 2002 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSGTLPW>; Sat, 20 Jul 2002 07:15:22 -0400
Received: from ns.suse.de ([213.95.15.193]:50189 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315525AbSGTLPU>;
	Sat, 20 Jul 2002 07:15:20 -0400
Date: Sat, 20 Jul 2002 13:18:19 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [DOCUMENTATION] Porting code to x86-64 linux
Message-ID: <20020720131819.A25248@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote a short document describing some common problems when porting
software to hammer. It assumes the code is already 64bit clean and 
does not describe generic 64bit problems, but just x86-64 specific
issues.  Some of these items describe user space problems, but most
apply to kernel code. At the end there are some kernel specific
issues. Perhaps it is useful for someone. If you plan to port linux code
to x86-64 you may find it useful.


Feedback welcome,

-Andi

------------ please bite here -------- bitte hier abbeissen -----------

Porting to Hammer

This document shows some common problems when porting software to Linux/x86-64

Andi Kleen, SuSE Labs <ak@suse.de> 


Prototypes must be correct when stdargs are involved.

Some programs have inconsistent prototypes over multiple source code
files. When the actual function definition uses stdargs or varargs it
expects the %rax register to be initialized to the number of floating
point arguments.  When the caller doesn't know about this because its
prototype doesn't include the ellipsis (...) it won't initialize %rax
and and a crash will occur after the call. The functions usually jump
into nirvana and cause very strange failure modes (completely
different functions are suddenly executed etc.)

glibc defines some functions unexpectedly as stdarg (e.g. ptrace,
fcntl, open) and expects %rax to be set correctly for them. These must
have correct prototypes, best by including the correct glibc header

How to check: 
Make sure your prototypes are correct and consistent. Look for
prototypes that are not declared in shared include files and verify
that they are connect.  Run lclint with only function call checking
enabled over the whole program to check for consistent prototypes. The
gcc protoize tool may also be used to generate a global prototype file
that could be included in every file using gcc's -include option.

----

Shared libraries must be compiled with -fPIC. 

i386 and other ports tolerate shared libraries that are not compiled
with -fPIC. On x86-64 this leads to a crash when accessing external
symbols to the shared library (e.g. symbols declared in the main
program) because only 32bit relocations are used for referencing
them. The shared library is loaded more than 32bits away from the main
program. The 32bit relocations sometimes work between shared libraries
when they are loaded at startup because then the shared libraries are
within reach of 32bit, but it may fail for shared libraries that are
loaded later with dlopen() for example.

How to check: 
Run readelf -r and nm on the shared library. Relocations showing as 'U' 
in nm must have an corresponding entry in the GOT table shown as the 
'.rela.got'. 

----

Libraries are in /lib64

64bit libraries are in */lib64 instead of */lib. Makefiles that
install libraries must be changed for this. Also the common
-L/usr/X11R6/lib compile flag or a similar flag for the Qt library
must be changed to reference */lib64.

----

Correct return type declarations for pointers.

Functions returning pointers must be prototyped to return a
pointer. When they are used implicitly they are assumed to return
32bit int, which leads to a truncation of the pointer and a crash on
accessing the pointer.  Common victims of this are standard library
functions like strerror or malloc when their include file is not
included.

How to check: 
Enable -Wall in gcc and look for warnings for undeclared functions.

-------------------------------------------------------------------------

The following are caveats for porting linux kernel code. This does not
apply to user space applications. If you are only porting user space
application you can stop reading now.


Interrupt flags used in save_flags() or spin_lock_irqsave() must be
unsigned long. Other architectures tolerate int, but Hammer doesn't.

How to check: 
The x86-64 include files force a warning for this with -Wall. Look for
the warning and fix it. Also the code may cause assembly failures with
wrong types.

----

Modules must be compiled with -mcmodel=kernel

Modules that are built external to the main source tree must be
compiled with -mcmodel=kernel. Otherwise they will crash soon after
loading.  Modules built in the kernel tree do this automatically.

----

Drivers must use the PCI DMA mapping API

Drivers must use the PCI dma mapping API for bus addresses. See
Documentation/DMA-mapping.txt in the kernel source tree. This is
currently not strictly required, but will be very soon if the drivers
should work on boxes with more than 4GB of ram.
