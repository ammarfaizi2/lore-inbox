Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTEBQZD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbTEBQZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:25:03 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50586 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262976AbTEBQY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:24:59 -0400
Date: Fri, 2 May 2003 12:37:23 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: linux-kernel@vger.kernel.org
Subject: [Announcement] "Exec Shield", new Linux security feature
Message-ID: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are pleased to announce the first publically available source code
release of a new kernel-based security feature called the "Exec Shield",
for Linux/x86. The kernel patch (against 2.4.21-rc1, released under the
GPL/OSL) can be downloaded from:

	http://redhat.com/~mingo/exec-shield/

The exec-shield feature provides protection against stack, buffer or
function pointer overflows, and against other types of exploits that rely
on overwriting data structures and/or putting code into those structures.
The patch also makes it harder to pass in and execute the so-called
'shell-code' of exploits. The patch works transparently, ie. no
application recompilation is necessary.

Background:
-----------

It is commonly known that x86 pagetables do not support the so-called
executable bit in the pagetable entries - PROT_EXEC and PROT_READ are
merged into a single 'read or execute' flag. This means that even if an
application marks a certain memory area non-executable (by not providing
the PROT_EXEC flag upon mapping it) under x86, that area is still
executable, if the area is PROT_READ.

Furthermore, the x86 ELF ABI marks the process stack executable, which
requires that the stack is marked executable even on CPUs that support an
executable bit in the pagetables.

This problem has been addressed in the past by various kernel patches,
such as Solar Designer's excellent "non-exec stack patch". These patches
mostly operate by using the x86 segmentation feature to set the code
segment 'limit' value to a certain fixed value that points right below the
stack frame. The exec-shield tries to cover as much virtual memory via the
code segment limit as possible - not just the stack.

Implementation:
---------------

The exec-shield feature works via the kernel transparently tracking
executable mappings an application specifies, and maintains a 'maximum
executable address' value. This is called the 'exec-limit'. The scheduler
uses the exec-limit to update the code segment descriptor upon each
context-switch. Since each process (or thread) in the system can have a
different exec-limit, the scheduler sets the user code segment dynamically
so that always the correct code-segment limit is used.

the kernel caches the user segment descriptor value, so the overhead in
the context-switch path is a very cheap, unconditional 6-byte write to the
GDT, costing 2-3 cycles at most.

Furthermore, the kernel also remaps all PROT_EXEC mappings to the
so-called ASCII-armor area, which on x86 is the addresses 0-16MB. These
addresses are special because they cannot be jumped to via ASCII-based
overflows. E.g. if a buggy application can be overflown via a long URL:

  http://somehost/buggy.app?realyloooooooooooooooooooong.123489719875

then only ASCII (ie. value 1-255) characters can be used by attackers. If
all executable addresses are in the ASCII-armor, then no attack URL can be
used to jump into the executable code - ie. the attack cannot be
successful. (because no URL string can contain the \0 character.) E.g. the
recent sendmail remote root attack was an ASCII-based overflow as well.

With the exec-shield activated, and the 'cat' binary relinked into the the
ASCII-armor, the following layout is created:

  $ ./cat-lowaddr /proc/self/maps
  00101000-00116000 r-xp 00000000 03:01 319365     /lib/ld-2.3.2.so
  00116000-00117000 rw-p 00014000 03:01 319365     /lib/ld-2.3.2.so
  00117000-0024a000 r-xp 00000000 03:01 319439     /lib/libc-2.3.2.so
  0024a000-0024e000 rw-p 00132000 03:01 319439     /lib/libc-2.3.2.so
  0024e000-00250000 rw-p 00000000 00:00 0
  01000000-01004000 r-xp 00000000 16:01 2036120    /home/mingo/cat-lowaddr
  01004000-01005000 rw-p 00003000 16:01 2036120    /home/mingo/cat-lowaddr
  01005000-01006000 rw-p 00000000 00:00 0
  40000000-40001000 rw-p 00000000 00:00 0
  40001000-40201000 r--p 00000000 03:01 464809     locale-archive
  40201000-40207000 r--p 00915000 03:01 464809     locale-archive
  40207000-40234000 r--p 0091f000 03:01 464809     locale-archive
  40234000-40235000 r--p 00955000 03:01 464809     locale-archive
  bfffe000-c0000000 rw-p fffff000 00:00 0

In the above layout, the highest executable address is 0x01003fff, ie.
every executable address is in the ASCII-armor.

this means that not only the stack is non-executable, but lots of
mmap()-ed data areas and the malloc() heap is non-executable as well.  
(some data areas are still executable, but most of them are not.)

the first 1MB of the ASCII-armor is left unused to provide NULL pointer
dereference protection and leave space for 16-bit emulation mappings used
by XFree86 and others.

Compare this with the memory layout without exec-shield:

  08048000-0804b000 r-xp 00000000 16:01 3367       /bin/cat
  0804b000-0804c000 rw-p 00003000 16:01 3367       /bin/cat
  0804c000-0804e000 rwxp 00000000 00:00 0
  40000000-40012000 r-xp 00000000 16:01 3759       /lib/ld-2.2.5.so
  40012000-40013000 rw-p 00011000 16:01 3759       /lib/ld-2.2.5.so
  40013000-40014000 rw-p 00000000 00:00 0
  40018000-40129000 r-xp 00000000 16:01 4058       /lib/libc-2.2.5.so
  40129000-4012f000 rw-p 00111000 16:01 4058       /lib/libc-2.2.5.so
  4012f000-40133000 rw-p 00000000 00:00 0
  bffff000-c0000000 rwxp 00000000 00:00 0

In this layout none of the executable areas are in the ASCII-armor, plus
the exec-limit is 0xbfffffff (3GB) - ie. including all userspace mappings.

Note that the kernel will relocate every shared-library to the
ASCII-armor, but the binary address is determined at link-time. To ease
the relinking of applications to the ASCII-armor, Arjan Van de Ven has
written a binutils patch (binutils-2.13.90.0.18-elf-small.patch), which
adds a new 'ld' flag "ld -melf_i386_small" (or "gcc -Wl,-melf_i386_small")
to relink applications into the ASCII-armor. (The patch can be found at
the exec-shield URL as well.)

Overhead:
---------

the patch was designed to be as efficient as possible. There's a very
minimal (couple of cycles) tracking overhead for every PROT_MMAP
system-call, plus there's the 2-3 cycles cost per context-switch.

Limitations:
------------

This feature will not protect against every type of attack.

E.g. if an overflow can be used to overwrite a local variable which
changes the flow of control in a way that compromises the system. But we
do believe that this feature will stop every attack that is purely
operating by overflowing the return address on the stack, or overflowing a
function pointer in the heap. Furthermore, exec-shield makes it quite hard
to mount a successful attack even in the other cases, because it inhibits
the execution of exploit shell-code, in most cases.

also, if the overflow is within the exec-shield itself (e.g. within the
data section of one of the shared library objects in the ASCII-armor) then
the overflow might be possible to exploit.

All in one, exec-shield is one barrier against attacks, not blanket 100%
protection in any way. The most efficient security can be provided by
installing as many layers as possible.

To provide as good protection as possible, there's no trampoline
workaround in the exec-shield code - ie. exec-limit violations in the
trampoline case are never let through. Applications that need to rely on
gcc trampolines will have to use the per-binary ELF flag to make the stack
executable again. (The ELF flag is the same as used by Solar Designer's
non-exec stack patch, to provide as much compatibility with existing
non-exec-stack installations as possible.)

The exec-shield feature will uncover applications that incorrectly assumed
that PROT_READ allows execution on x86. One such example is the XFree86
module loader. The latest XFree86 on rawhide.redhat.com fixes this
problem. For those who cannot install the XFree86 bugfix at the moment
there's a workaround added by the patch, which can be activated via:

    echo 1 > /proc/sys/kernel/X-workaround

This will make every iopl() using application (such as X) have the
exec-shield disabled. Other applications (sendmail, etc.) will still have
the exec-shield enabled. This workaround is default-off. We strongly
encourage to solve this problem by upgrading X, or by using the 'chkstk'
utility to make X's stack forced-executable.

Using it:
---------

Apply the exec-shield-2.4.21-rc1-B6 kernel patch to the 2.4.21-rc1 kernel,
recompile & install the kernel and reboot into it, that's all.

There is a new boot-time kernel command line option called exec-shield=,
which has 4 values. Each value represents a different level of security:

 exec-shield=0    - always-disabled
 exec-shield=1    - default disabled, except binaries that enable it
 exec-shield=2    - default enabled, except binaries that disable it
 exec-shield=3    - always-enabled

the current patch defaults to 'exec-shield=2'. The security level can also
be changed runtime, by writing the level into /proc:

  echo 0 > /proc/sys/kernel/exec-shield

IMPORTANT: security-relevant applications that were started while the
exec-shield was disabled, will have an executable stack and will thus have
to be restarted if the exec-shield is enabled again.

I've also uploaded a modified version of Solar Designer's chstk.c code,
which adds the options necessary to change the 'enable non-exec stack' ELF
flag:

  $ ./chstk
  Usage: ./chstk OPTION FILE...
  Manage stack area executability flag for binaries

    -e    enable execution permission
    -E    enable non-execution permission
    -d    disable execution permission
    -D    disable non-execution permission
    -v    view current flag state

ie. there are two distinct flags, one for forcing an executable stack, one
for forcing a non-executable stack. If both flags are zero then the binary
will follow the system default.

ie. it's possible to use an exec-shield level of 1, and enable the
non-exec stack on a per binary basis, by using the 'exec-shield=1' boot
option and changing binaries one at a time:

   ./chstk -E /usr/sbin/sendmail

(People migrating production environments to an exec-shield kernel might
prefer this variant.)

anyway, comments, suggestions and test feedback is welcome.

	Ingo




