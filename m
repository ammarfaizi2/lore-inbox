Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbUEDXeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUEDXeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 19:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUEDXeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 19:34:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22148 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261419AbUEDXeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 19:34:07 -0400
Date: Tue, 4 May 2004 19:37:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Steve Beaty <beaty@emess.mscd.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: sigaction, fork, malloc, and futex
In-Reply-To: <200405042015.i44KFb0R001900@emess.mscd.edu>
Message-ID: <Pine.LNX.4.53.0405041928170.14876@chaos>
References: <200405042015.i44KFb0R001900@emess.mscd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004, Steve Beaty wrote:

>
> 	anyone have a clue on this one?  we set up a signal handler, create
> 	a child that sends that signal, and have the signal handler fork
> 	another child.  if there is a malloc(), the second child gets stuck
> 	in a futex(); without the malloc(), no problem.  2.4.20-30.9
> 	kernel.  straces at the end.  any help would be appreciated.
> 	thanks!

Sure buggy code. There are only a few things you can do from
a signal handler and I'm fairly sure fork() isn't one of them.
Did you just invent this as a way of concatenating system calls
to see what works? Surely you don't have a program that does this
do you? The signal handler executes on its own signal stack, it
can't reach anything thats located on the main program stack. The
malloc() stuff is in the heap, above the main program stack. Once
you do something that requires access to the heap or the main
program stack, in the signal handler, all bets are off.

So, just don't dooooo this!

>
> ===========================================================================
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <assert.h>
>
> /* comment out the following to show the problem */
> #define WORKS
>
> void sig_handler (int signum)
> {
> 	int     child;
>
> 	fprintf (stderr, "Process %d received a SIGALRM signal\n", getpid());
> 	if ((child = fork ()) == 0)
> 	{
> 		fprintf (stderr, "%d exiting\n", getpid());
> 		exit (0);
> 	}
> 	fprintf (stderr, "%d waiting for %d\n", getpid(), child);
> 	waitpid (child, NULL, 0);
> }
>
> int
> main (int argc, char **argv)
> {
> 	int parent = getpid();
> 	int child;
>
> 	struct sigaction action;
> 	sigemptyset (&action.sa_mask);
> 	action.sa_handler = sig_handler;
>
> #ifndef WORKS
> 	malloc (sizeof (int));
> #endif
>
> 	assert (sigaction (SIGALRM, &action, NULL) == 0);
>
> 	if ((child = fork ()) == 0)
> 	{
> 		fprintf (stderr, "%d sending SIGALRM to %d\n", getpid(), parent);
> 		if (kill (parent, SIGALRM) == -1) perror ("kill 1");
> 		fprintf (stderr, "%d exiting\n", getpid());
> 		exit (0);
> 	}
> 	fprintf (stderr, "%d waiting for %d\n", getpid(), child);
> 	waitpid (child, NULL, 0);
> }
>
> /*
> ** if WORKS defined:
>
> $ ./a.out
> 9106 sending SIGALRM to 9105
> 9106 exiting
> Process 9105 received a SIGALRM signal
> 9107 exiting
> 9105 waiting for 9107
> 9105 waiting for 9106
>
> ** if WORKS undefined:
>
> $ ./a.out
> 9095 sending SIGALRM to 9094
> 9095 exiting
> Process 9094 received a SIGALRM signal
>
> $ sh /usr/src/linux-2.4.20-30.9/scripts/ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux emess0.mscd.edu 2.4.20-30.9 #1 Wed Feb 4 20:44:26 EST 2004 i686 i686
> i386 GNU/Linux
>
> Gnu C                  3.2.2
> Gnu make               3.79.1
> util-linux             2.11y
> mount                  2.11y
> modutils               2.4.22
> e2fsprogs              1.32
> jfsutils               1.0.17
> reiserfsprogs          3.6.4
> pcmcia-cs              3.1.31
> PPP                    2.4.1
> isdn4k-utils           3.1pre4
> Linux C Library        2.3.2
> Dynamic linker (ldd)   2.3.2
> Procps                 2.0.11
> Net-tools              1.60
> Kbd                    1.08
> Sh-utils               4.5.3
> Modules Loaded         ieee1394 ide-cd cdrom i810_audio ac97_codec
> soundcore mga agpgart binfmt_misc autofs e100 ipchains loop lvm-mod keybdev
> mousedev hid input usb-uhci usbcore ext3 jbd
>
> */
>
> #if 0
>
> BAD:
> ---------------------------------------------------------------------------
> $ strace ./a.out
> execve("./a.out", ["./a.out"], [/* 42 vars */]) = 0
> uname({sys="Linux", node="emess.mscd.edu", ...}) = 0
> brk(0)                                  = 0x80499fc
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
> directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=105716, ...}) = 0
> old_mmap(NULL, 105716, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
> close(3)                                = 0
> open("/lib/tls/libc.so.6", O_RDONLY)    = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360W\1"..., 512) =
> 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=1539996, ...}) = 0
> old_mmap(0x42000000, 1267276, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
> 0x42000000
> old_mmap(0x42130000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
> 0x130000) = 0x42130000
> old_mmap(0x42133000, 9804, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x42133000
> close(3)                                = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x40030000
> set_thread_area({entry_number:-1 -> 6, base_addr:0x400304a0, limit:1048575,
> seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, useable:1}) = 0
> munmap(0x40016000, 105716)              = 0
> getpid()                                = 9059
> brk(0)                                  = 0x80499fc
> brk(0x804a9fc)                          = 0x804a9fc
> brk(0)                                  = 0x804a9fc
> brk(0x804b000)                          = 0x804b000
> rt_sigaction(SIGALRM, {0x8048568, [],
> SA_RESTORER|SA_NOMASK|SA_SIGINFO|0x21328d0, 0x420277b0}, NULL, 8) = 0
> clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|0x11,
> <ignored>, <ignored>, 0x400304e8) = 9060
> 9060 sending SIGALRM to 9059
> 9060 exiting
> --- SIGALRM (Alarm clock) @ 0 (0) ---
> getpid()                                = 9059
> --- SIGCHLD (Child exited) @ 0 (0) ---
> write(2, "Process 9059 received a SIGALRM "..., 39Process 9059 received a
> SIGALRM signal
> ) = 39
> futex(0x421336d0, FUTEX_WAIT, 2, NULL
> [control-c]
> ---------------------------------------------------------------------------
>
> GOOD
>
> ---------------------------------------------------------------------------
> $ strace ./a.out
> execve("./a.out", ["./a.out"], [/* 42 vars */]) = 0
> uname({sys="Linux", node="emess.mscd.edu", ...}) = 0
> brk(0)                                  = 0x80499b8
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
> directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=105716, ...}) = 0
> old_mmap(NULL, 105716, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
> close(3)                                = 0
> open("/lib/tls/libc.so.6", O_RDONLY)    = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360W\1"..., 512) =
> 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=1539996, ...}) = 0
> old_mmap(0x42000000, 1267276, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
> 0x42000000
> old_mmap(0x42130000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
> 0x130000) = 0x42130000
> old_mmap(0x42133000, 9804, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x42133000
> close(3)                                = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x40030000
> set_thread_area({entry_number:-1 -> 6, base_addr:0x400304a0, limit:1048575,
> seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, useable:1}) = 0
> munmap(0x40016000, 105716)              = 0
> getpid()                                = 9087
> rt_sigaction(SIGALRM, {0x8048534, [],
> SA_RESTORER|SA_NOMASK|SA_SIGINFO|0x21328d0, 0x420277b0}, NULL, 8) = 0
> clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|0x11,
> <ignored>, <ignored>, 0x400304e8) = 9088
> 9088 sending SIGALRM to 9087
> 9088 exiting
> --- SIGALRM (Alarm clock) @ 0 (0) ---
> getpid()                                = 9087
> --- SIGCHLD (Child exited) @ 0 (0) ---
> write(2, "Process 9087 received a SIGALRM "..., 39Process 9087 received a
> SIGALRM signal
> ) = 39
> clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|0x11,
> <ignored>, <ignored>, 0x400304e8) = 9089
> getpid()                                = 9087
> write(2, "9087 waiting for 9089\n", 229087 waiting for 9089
> ) = 22
> wait4(9089, 9089 exiting
> NULL, 0, NULL)              = 9089
> rt_sigreturn(0x1200011)                 = 9088
> getpid()                                = 9087
> write(2, "9087 waiting for 9088\n", 229087 waiting for 9088
> ) = 22
> wait4(9088, NULL, 0, NULL)              = 9088
> exit_group(0)                           = ?
> ---------------------------------------------------------------------------
> #endif
> ===========================================================================
>
> --
> Dr. Steve Beaty (B80)                                 Associate Professor
> Metro State College of Denver                        beaty@emess.mscd.edu
> VOX: (303) 556-5321                                 Science Building 134C
> FAX: (303) 556-5381                         http://clem.mscd.edu/~beatys/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


