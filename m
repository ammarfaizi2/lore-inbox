Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266641AbRGOP2X>; Sun, 15 Jul 2001 11:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266647AbRGOP2N>; Sun, 15 Jul 2001 11:28:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29543 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266641AbRGOP2C>; Sun, 15 Jul 2001 11:28:02 -0400
To: David Madore <david.madore@ens.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: *very* strange heisenbug (kernel? libc?)... (SMP ldt bug?)
In-Reply-To: <20010714054641.A23701@clipper.ens.fr>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jul 2001 09:22:34 -0600
In-Reply-To: <20010714054641.A23701@clipper.ens.fr>
Message-ID: <m1ofqm2p51.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Madore <david.madore@ens.fr> writes:

> Hello all.
> 
> I have encountered a very, very strange bug, which has caused me a
> good number of hours pulling my hair trying to figure out what was
> going on.  I don't even know if it's a kernel bug, a glibc bug, or a
> misunderstanding on my part.

Weird.  This may be a kernel race in moving ldt state from one processor
to another.  I heard of some lazy context moving bugs, though I think
they are only for kernel state.  I would definentily say that this is
almost certainly some kind of race.   I hope this helps.

Eric



> 
> The basic program is simple enough - see <URL:
> ftp://quatramaran.ens.fr/pub/madore/tmp/weirdbug/weirdbug.c >.  All it
> does is open the Linux TUN/TAP device (/dev/misc/net/tun), register a
> tap device named "test0" (the actual name is unimportant), and then
> create a thread which runs an idle loop before quitting immediately.
> This seems sane enough.  The code to open the TUN/TAP device (function
> init_tap()) is practically copied from the sample code in the
> documentation, and the rest is trivial.  I can hardly imagine where it
> might contain an error.
> 
> Yet I have gotten it to dump core.  See <URL:
> ftp://quatramaran.ens.fr/pub/madore/tmp/weirdbug/core > for the core,
> which is produced by the binary at <URL:
> ftp://quatramaran.ens.fr/pub/madore/tmp/weirdbug/weirdbug >.  This is
> all on i386 (detailed system characteristics follow below).
> 
> Now that's not all.  There are several intriguing things about this
> core.
> 
> First of all, the place where the segfault happens: in
> pthread_create(), of all places!  To be precise, the function
> __pthread_create_1_2() (defined in linuxthreads/pthread.c in the glibc
> sources) calls thread_self() (defined in linuxthreads/internals.h),
> which is inlined, and which in turn calls the macro THREAD_SELF,
> defined in linuxthreads/sysdeps/i386/useldt.h (around line 57).  It is
> this macro which segfaults.  In fact, the libc tries to determine the
> thread's identity by looking up a place in memory accessed by %gs:0,
> where %gs is supposed to be a selector for the LDT (normally, 0x7, in
> fact); but here it happens that %gs was not initialized, and still
> refers to the "flat" memory model (GDT selector 0x2b), so the program
> tries to access memory page 0 and fails.
> 
> So this would look like a glibc bug (under some weird circumstances,
> %gs is not properly initialized by INIT_THREAD_SELF before THREAD_SELF
> is called).  Except that I've heard rumors that core files were not
> reliable for threaded programs.  So maybe the segfault is not where I
> think it is.  (Except that in any case it seems that %gs is wrong at
> the place where it is.)
> 
> The second funny thing is the circumstances under which I can
> reproduce this bug.  If I run the program directly, it doesn't
> segfault.  I have only been able to reproduce it by launching it with
> the following ridiculous script: (<URL:
> ftp://quatramaran.ens.fr/pub/madore/tmp/weirdbug/weirdbug-launcher >)
> 
> #! /bin/sh
> if echo FOO | egrep -q FOO ; then
> 	exec /tmp/weirdbug
> else
> 	exec /tmp/weirdbug
> fi
> 
> (wow!).  Even then, it is unpredictable.  It doesn't always work, and
> I've only ever gotten anything on my dual-processor machine.  Adding a
> "sleep" here or there will get rid of the bug.  Of course, trying to
> do anything like strace or gdb will make the bug go away - therefore
> it's a heisenbug.
> 
> Also, sometimes, instead of dumping core, it simply hangs and does
> nothing.
> 
> So what say the wise?  Is this a glibc bug in the linuxthreads
> implementation?  A kernel bug in the TUN/TAP device with odd
> consequences?  A kernel bug in the scheduler leading to a very rare
> race condition?  A bug in my program?  A karma problem?
> 
> Detailed system characteristics: RedHat-7.1 system: glibc-2.2.2 (RPM:
> glibc-2.2.2-10).  Kernel is stock 2.4.6 + international crypto patch
> (2.4.3.1), compiled for SMP, and with devfsd.  Filesystem in /tmp is
> ReiserFS.  Hardware is dual Intel Pentium II (Deschutes) at 450MHz.
> Compiler for kernel is stock egcs-1.1.2.  Compiler for program is
> RedHat's 2.96-81.  Program is compiled against actual kernel headers.
> 
> Session log (I'm willing to bet nobody can reproduce it, anyway):
> 
> vega root /tmp # /sbin/modprobe tun
> vega root /tmp # ls -la /dev/misc/net/tun
> crw-r-----    1 root     root      10, 200 Jan  1  1970 /dev/misc/net/tun
> vega root /tmp # md5sum weirdbug.c
> 0cbeaa9de585868b3d5dfd55f6f50397  weirdbug.c
> vega root /tmp # gcc -o weirdbug weirdbug.c -O6 -lpthread
> vega root /tmp # gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)
> vega root /tmp # md5sum weirdbug
> 7977421cf8b60a63659063d7c165c58b  weirdbug
> vega root /tmp # cat weirdbug-launcher
> #! /bin/sh
> if echo FOO | egrep -q FOO ; then
> 	exec /tmp/weirdbug
> else
> 	exec /tmp/weirdbug
> fi
> vega root /tmp # md5sum weirdbug-launcher
> 460666262466f12d89f33900e4dc74ec  weirdbug-launcher
> vega root /tmp # ./weirdbug
> vega root /tmp # ./weirdbug-launcher
> zsh: segmentation fault (core dumped)  ./weirdbug-launcher
> 
> -- 
>      David A. Madore
>     (david.madore@ens.fr,
>      http://www.eleves.ens.fr:8080/home/madore/ )
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
