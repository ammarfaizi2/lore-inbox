Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274173AbSITAgX>; Thu, 19 Sep 2002 20:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274200AbSITAgW>; Thu, 19 Sep 2002 20:36:22 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:29827
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S274173AbSITAgQ>; Thu, 19 Sep 2002 20:36:16 -0400
Message-ID: <3D8A6EC1.1010809@redhat.com>
Date: Thu, 19 Sep 2002 17:41:37 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Native POSIX Thread Library 0.1
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We are pleased to announce the first publically available source
release of a new POSIX thread library for Linux.  As part of the
continuous effort to improve Linux's capabilities as a client, server,
and computing platform Red Hat sponsored the development of this
completely new implementation of a POSIX thread library, called Native
POSIX Thread Library, NPTL.

Unless major flaws in the design are found this code is intended to
become the standard POSIX thread library on Linux system and it will
be included in the GNU C library distribution.

The work visible here is the result of close collaboration of kernel
and runtime developers.  The collaboration proceeded by developing the
kernel changes while writing the appropriate parts of the thread
library.  Whenever something couldn't be implemented optimally some
interface was changed to eliminate the issue.  The result is this
thread library which is, unlike previous attempts, a very thin layer
on top of the kernel.  This helps to achieve a maximum of performance
for a minimal price.


A white paper (still in its draft stage, though) describing the design
is available at

   http://people.redhat.com/drepper/nptl-design.pdf

It provides a larger number of details on the design and insight into
the design process.  At this point we want to repeat only a few
important points:

- - the new library is based on an 1-on-1 model.  Earlier design
   documents stated that an M-on-N implementation was necessary to
   support a scalable thread library.  This was especially true for
   the IA-32 and x86-64 platforms since the ABI with respect to threads
   forces the use of segment registers and the only way to use those
   registers was with the Local Descriptor Table (LDT) data structure
   of the processor.

   The kernel limitations the earlier designs were based on have been
   eliminated as part of this project, opening the road to a 1-on-1
   implementation which has many advantages such as

   + less complex implementation;
   + avoidance of two-level scheduling, enabling the kernel to make all
     scheduling decisions;
   + direct interaction between kernel and user-level code (e.g., when
     delivering signals);
   + and more and more.

   It is not generally accepted that a 1-on-1 model is superior but our
   tests showed the viability of this approach and by comparing it with
   the overhead added by existing M-on-N implementations we became
   convinced that 1-on-1 is the right approach.

   Initial confirmations were test runs with huge numbers of threads.
   Even on IA-32 with its limited address space and memory handling
   running 100,000 concurrent threads was no problem at all, creating
   and destroying the threads did not take more than two seconds.  This
   all was made possible by the kernel work performed as part of this
   project.

   The only limiting factors on the number of threads today are
   resource availability (RAM and processor resources) and architecture
   limitations.  Since every thread needs at least a stack and data
   structures describing the thread the number is capped.  On 64-bit
   machines the architecture does not add any limitations anymore (at
   least for the moment) and with enough resources the number of
   threads can be grown arbitrarily.

   This does not mean that using hundreds of thousands of threads is a
   desirable design for the majority of applications.  At least not
   unless the number of processors matches the number of threads.  But
   it is important to note that the design on the library does not have
   a fixed limit.

   The kernel work to optimize for a high thread count is still
   ongoing.  Some places in which the kernel iterates over process and
   threads remain and other places need to be cleaned up.  But it has
   already been shown that given sufficient resources and a reasonable
   architecture an order of magnitude more threads can be created than
   in our tests on IA-32.


- - The futex system call is used extensively in all synchronization
   primitives and other places which need some kind of
   synchronization.  The futex mechanism is generic enough to support
   the standard POSIX synchronization mechanisms with very little
   effort.

   The fact that this is possible is also essential for the selection
   of the 1-on-1 model since only with the kernel seeing all the
   waiters and knowing that they are blocked for synchronization
   purposes will allow the scheduler to make decisions as good as a
   thread library would be able to in an M-on-N model implementation.

   Futexes also allow the implementation of inter-process
   synchronization primitives, a sorely missed feature in the old
   LinuxThreads implementation (Hi jbj!).


- - Substantial effort went into making the thread creation and
   destruction as fast as possible.  Extensions to the clone(2) system
   call were introduced to eliminate the need for a helper thread in
   either creation or destruction.  The exit process in the kernel was
   optimized (previously not a high priority).  The library itself
   optimizes the memory allocation so that in many cases the creation
   of a new thread can be achieved with one single system call.

   On an old IA-32 dual 450MHz PII Xeon system 100,000 threads can be
   created and destroyed in 2.3 secs (with up to 50 threads running at
   any one time).


- - Programs indirectly linked against the thread library had problems
   with the old implementation because of the way symbols are looked
   up. This should not be a problem anymore.


The thread library is designed to be binary compatible with the old
LinuxThreads implementation.  This compatibility obviously has some
limitations.  In places where the LinuxThreads implementation diverged
from the POSIX standard incompatibilities exist.  Users of the old
library have been warned from day one that this day will come and code
which added work-arounds for the POSIX non-compliance better be
prepared to remove that code.  The visible changes of the library
include:


- - The signal handling changes from per-thread signal handling to the
   POSIX process signal handling.  This change will require changes in
   programs which exploit the non-conformance of the old implementation.

   One consequence of this is that SIGSTOP works on the process.  Job 
control
   in the shell and stopping the whole process in a debugger work now.

- - getpid() now returns the same value in all threads

- - the exec functions are implemented correctly: the exec'ed process gets
   the PID of the process.  The parent of the multi-threaded application
   is only notified when the exec'ed process terminates.

- - thread handlers registered with pthread_atfork are not anymore run
   if vfork is used.  This isn't required by the standard (which does
   not define vfork) and all which is allowed in the child is calling
   exit() or an exec function.  A user of vfork better knows what s/he
   does.

- - libpthread should now be much more resistant to linking problems: even
   if the application doesn't list libpthread as a direct dependency
   functions which are extended by libpthread should work correctly.

- - no manager thread

- - inter-process mutex, read-write lock, conditional variable, and barrier
   implementations are available

- - the pthread_kill_other_threads_np function is not available.  It was
   needed to work around the broken signal handling.  If somebody shows
   some existing code which makes legitimate use of this function we
   might add it back.

- - requires a kernel with the threading capabilities of Linux 2.5.36.



The sources for the new library are for the time being available at

   ftp://people.redhat.com/drepper/nptl/

The current sources contain support only for IA-32 but this will
change very quickly.  The thread library is built as part of glibc so
the complete set of glibc sources is available as well.  The current
snapshot for glibc 2.3 (or glibc 2.3 when released) is necessary.  You
can find it at

   ftp://sources.redhat.com/pub/glibc/snapshots

Final releases will be available on ftp.gnu.org and its mirrors.


Building glibc with the new thread library is demanding on the
compilation environment.

- - The 2.5.36 kernel or above must be installed and used.  To compile
   glibc it is necessary to create the symbolic link

      /lib/modules/$(uname -r)/build

   to point to the build directory.

- - The general compiler requirement for glibc is at least gcc 3.2.  For
   the new thread code it is even necessary to have working support for
   the __thread keyword.

   Similarly, binutils with functioning TLS support are needed.

   The (Null) beta release of the upcoming Red Hat Linux product is
   known to have the necessary tools available after updating from the
   latest binaries on the FTP site.  This is no ploy to force everybody
   to use Red Hat Linux, it's just the only environment known to date
   which works.  If alternatives are known they can be announced on the
   mailing list.

- - To configure glibc it is necessary to run in the build directory
   (which always should be separate from the source directory):

    /path/to/glibc/configure --prefix=/usr --enable-add-ons=linuxthreads2 \
       --enable-kernel=current --with-tls

   The --enable-kernel parameter requires that the 2.5.36+ kernel is
   running.  It is not strictly necessary but helps to avoid mistakes.
   It might also be a good idea to add --disable-profile, just to speed
   up the compilation.

   When configured as above the library must not be installed since it
   would overwrite the system's library.  If you want to install the
   resulting library choose a different --prefix parameter value.
   Otherwise the new code can be used without installation.  Running
   existing binaries is possible with

    elf/ld.so --library-path .:linuxthreads2:dlfcn:math <binary> <args>...

   Alternatively the binary could be build to find the dynamic linker
   and DSO by itself.  This is a much easier way to debug the code
   since gdb can start the binary.  Compiling is a bit more complicated
   in this case:

    gcc -nostdlib -nostartfiles -o <OUTPUT> csu/crt1.o csu/crti.o \
      $(gcc --print-file-name=crtbegin.o) <INPUTS> \
      -Wl,-rpath,$PWD,-dynamic-linker,$PWD/ld-linux.so.2 \
      linuxthreads2/libpthread.so.0 ./libc.so.6 ./libc_nonshared.a \
      elf/ld-linux.so.2 $(gcc --print-file-name=crtend.o) csu/crtn.o

   This command assumes that it is run in the build directory.  Correct
   the paths if necessary.  The compilation will use the system's
   headers which is a good test but might lead to strange effects if
   there are compatibility bugs left.


Once all these prerequisites are met compiling glibc should be easy.
But there are some tests which will flunk.  For good reasons we aren't
officially releasing the code yet.  The bugs are either in the TLS
code which is not enabled in the standard glibc build, or obviously in
the thread library itself.  To run the tests for the thread library
run

   make subdirs=linuxthreads2 check

One word on the name 'linuxthreads2' of the directory.  This is only a
convenience thing so that the glibc configure scripts don't complain
about missing thread support.  It will we changed to reflect the real
name of the library ASAP.


What can you expect?

This is a very early version of the code so the obvious answer is:
some problems.  The test suite for the new thread code should pass but
beside that and some performance measurement tool we haven't run much
code.  Ideally we would get people to write many more of these small
test programs which are included in the sources.  Compiling big
programs would mean not being able to locate problems easy.  But I
certainly won't object to people running and debugging bigger
applications.  Please report successes and failures to the mailing
list.

People who are interested in contributing must be aware that for any
non-trivial change we need an assignment of the code to the FSF.  The
process is unfortunately necessary in today's world.

People who are contaminated by having worked on proprietary thread
library implementation should not participate in discussions on the
mailing list unless they willfully disclose the information.  Every
bit of information is publically available from the mailing list
archive.


Which brings us to the final point: the mailing list for *all*
discussions related to this thread library implementation is

   phil-list@redhat.com

Go to

   https://listman.redhat.com/mailman/listinfo/phil-list

to subscribe, unsubscribe, or review the archive.

- -- 
- ---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9im7E2ijCOnn/RHQRApe9AKCN20A8A5ITi3DUq+3IRZ0gsSVHTQCeKqEu
fA5OFtNuzYqltxSMoL8Ambw=
=4pb4
-----END PGP SIGNATURE-----

