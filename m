Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264038AbRFSVYW>; Tue, 19 Jun 2001 17:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264039AbRFSVYN>; Tue, 19 Jun 2001 17:24:13 -0400
Received: from merc94.na.sas.com ([149.173.6.4]:5131 "EHLO merc94.na.sas.com")
	by vger.kernel.org with ESMTP id <S264038AbRFSVX4>;
	Tue, 19 Jun 2001 17:23:56 -0400
Message-ID: <0632CC5F67853B4D96D542BAE8AD008274BA10@merc08.na.sas.com>
From: Ed Connell <Ed.Connell@sas.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: intermittent hangs with threads (clone() bug?/linuxthreads bug?)
Date: Tue, 19 Jun 2001 17:23:48 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am experiencing intermittent hangs running LinuxThreads programs from a shell script.  This happens with any combination of stock RH 7.1 SMP kernel (2.4.2) or my own 2.4.5 kernel and stock RH 7.1 libc (2.2.2), redhat rawhide libc (2.2.3) and my own 2.2.3 libc.

If I run, for example, linuxthreads/Examples/ex1 (one thread prints 'a', one prints 'b') it will run fine.  If I run it from a shell script (bash or ksh) with 
   exec ex1
it almost always hangs.  When I do a "ps" I see the original "ex1" process plus another defunct "ex1" process  with a higher pid.  This defunct process was supposed to be the LinuxThreads manager thread but it seems that clone() is silently failing to create a valid thread.  Attaching a debugger to the original "ex1" and putting print statements in libc/linuxthreads and the kernel (do_fork() and friends) all indicate things are proceeding normally.  Yet the manager thread/process is never scheduled to run...it is immediately defunct.

My hardware is an 8-way i686.  I tried removing CPU's but the problem remains until I get down to a single CPU (or boot a uniprocessor kernel).  When I got down to 2 CPU's I noticed that running my script from console almost always produced a hang while running from an xterm always worked.  Obviously a timing issue.  Also things run fine on other SMP hardware I have access to.

If anyone has any idea what is going on, I would love to hear it.  If you need more information please let me know, as well.

Thanks
Ed Connell

Healthy traceback from original "ex1" process where it is waiting for the manager thread to take over.
(gdb) where
#0  0x40067ff5 in __sigsuspend (set=0xbffff2e8)
    at ../sysdeps/unix/sysv/linux/sigsuspend.c:45
#1  0x4002d25f in __pthread_wait_for_restart_signal (self=0x40036300)
    at pthread.c:958
#2  0x4002cbc4 in __pthread_create_2_1 (thread=0xbffff454, attr=0x0, 
    start_routine=0x8048580 <process>, arg=0x804871d) at restart.h:34
#3  0x080485e7 in main () at ex1.c:29
#4  0x400565e7 in __libc_start_main (main=0x80485cc <main>, argc=1, 
    ubp_av=0xbffff4c4, init=0x80483d0 <_init>, fini=0x80486e0 <_fini>, 
    rtld_fini=0x4000e154 <_dl_fini>, stack_end=0xbffff4bc)
    at ../sysdeps/generic/libc-start.c:129

