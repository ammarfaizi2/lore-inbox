Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbSKQSHw>; Sun, 17 Nov 2002 13:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbSKQSHw>; Sun, 17 Nov 2002 13:07:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59602 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267541AbSKQSHv>;
	Sun, 17 Nov 2002 13:07:51 -0500
Date: Sun, 17 Nov 2002 20:31:21 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <Pine.LNX.4.44.0211170922020.4425-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211172024470.11571-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Linus Torvalds wrote:

> First off, a program had better be correctly startable even if the
> process that does the execve() is _not_ using the new glibc. [...]

it most definitely is. Binary compatibility is taken very seriously.

the SETTID change only affects the fork() case. Ie. there are 4 major ways
a context can be started:

  execve(): here we build a process image from scratch. NPTL changes 
            nothing here, except that if a new NPTL binary is started up,
            it will call sys_set_tid_address() to get the 'initial thread'
            set up properly. Old binaries continue to work.

  fork(): here we build a new process image by copying the parent image. 
          NPTL applications are using sys_clone(CLONE_SETTID) internally, 
          to set up the initial thread of the new process image. [the 
          fork() code in glibc also does other cleanup work to get a true
          initial thread going, even if a threaded application forks, but
          this is nothing the kernel should worry about.]

  pthread_create(): here we create a new thread that shares all sharable 
                    state with the parent thread. LinuxThreads (old glibc) 
                    does whatever it always did, NPTL uses all the new 
                    flags.

  raw clone(): share a subset of the parent thread's resources.

there is no change anywhere due to NPTL. You can start and old glibc
application from within a new glibc application and vice versa.

	Ingo

