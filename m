Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbTEDR1U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 13:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTEDR1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 13:27:20 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:16900 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S261283AbTEDR1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 13:27:17 -0400
Date: Sun, 4 May 2003 19:39:56 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.68] Scalability issues
Message-ID: <20030504173956.GA28370@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running several scalability tests on Linux 2.5.68, all related to
network servers.  My test box is my notebook, Pentium 3 @ 900 MHz, 256
MB RAM.  I run a small http server on it that supports the following
models:

  - epoll
  - sigio
  - poll
  - pthread_create for each connection
  - fork for each connection

epoll works, sigio works as well, poll is slow but works.

pthread_create (using glibc 2.3.2 and gcc 3.2.3, by the way) fails after
creating several threads.  I run different scalability benchmarks; one
fetches the same web page over and over again and sees how many fetches
per second it can get, the other does the same but with a rapidly
increasing amount of "idle" background connections to the server doing
nothing but stealing resources.

I expected fork and pthread_create to fail sooner or later.  Here is
what happened (dmesg):

  Out of Memory: Killed process 51 (sshd).
  artillery-fork: page allocation failure. order:0, mode:0x20
    [this message comes about 50 times]
  Out of Memory: Killed process 52 (zsh).
  spurious 8259A interrupt: IRQ7.
  Out of Memory: Killed process 49 (sshd).
  alloc_area_pte: page already exists
  alloc_area_pte: page already exists
  alloc_area_pte: page already exists
  alloc_area_pte: page already exists
  VFS: Close: file count is 0
  VFS: Close: file count is 0

these don't look very good, but it gets better:

  Unable to handle kernel NULL pointer dereference at virtual address 00000017
  printing eip:
  c014c95b
  *pde = 00000000
  Oops: 0000 [#1]
  CPU:    0
  EIP:    0060:[<c014c95b>]    Tainted: P
  EFLAGS: 00010286
  eax: d241b000   ebx: 00000003   ecx: c037c450   edx: 00000003
  esi: 00000405   edi: c3194620   ebp: 00000021   esp: c379bf60
  ds: 007b   es: 007b   ss: 0068
  Process artillery-fork (pid: 6966, threadinfo=c379a000 task=c37bad80)
  Stack: c0341e60 c3194620 07ffffff 00000405 c3194620 00000021 c011e21c 00000003
	c3194620 c3194620 00000000 4003c904 c37bad80 c011edc4 c319d780 c319d780
	c379a000 c014d557 00000000 00200001 4003c904 c379a000 c011f0b3 00000000
  Call Trace: [<c011e21c>]  [<c011edc4>]  [<c014d557>]  [<c011f0b3>]  [<c0109279>]
  Code: 8b 43 14 85 c0 0f 84 9a 00 00 00 8b 43 10 31 ed 85 c0 74 45

This should not happen, right?  But wait, there's more!

  <3>alloc_area_pte: page already exists
  alloc_area_pte: page already exists
  alloc_area_pte: page already exists
  alloc_area_pte: page already exists

  Unable to handle kernel paging request at virtual address d209bd38
  printing eip:
  c014e30f
  *pde = 09a1b067
  *pte = 00000000
  Oops: 0000 [#2]
  CPU:    0
  EIP:    0060:[<c014e30f>]    Tainted: P
  EFLAGS: 00010287
  eax: d209a000   ebx: 00000000   ecx: 0000074e   edx: c23e4000
  esi: c21e8548   edi: c23e5f64   ebp: 00000000   esp: c23e5f24
  ds: 007b   es: 007b   ss: 0068
  Process artillery-fork (pid: 6894, threadinfo=c23e4000 task=c23e3980)
  Stack: 00000000 c015fabd c0124bc0 c23e3980 c21e8540 c23e5f60 c23e5f64 00000000
	c015fb9a 00000001 c21e8548 c23e5f60 c23e5f64 c23e4000 c23e4000 00000000
	00000000 bffff7c8 00000000 c21e8540 00000001 c015fd60 00000001 c21e8540
  Call Trace: [<c015fabd>]  [<c0124bc0>]  [<c015fb9a>]  [<c015fd60>]  [<c015df65>]  [<c015f0f0>]  [<c0109279>]
  Code: 8b 1c 88 85 db 74 03 ff 43 14 ff 4a 14 8b 42 08 83 e0 08 75

Mhh.  What about this one, then?

 <6>note: artillery-fork[6894] exited with preempt_count 1

  Unable to handle kernel paging request at virtual address d209a000
  printing eip:
  c011e1fd
  *pde = 09a1b067
  *pte = 00000000
  Oops: 0002 [#3]
  CPU:    0
  EIP:    0060:[<c011e1fd>]    Tainted: P
  EFLAGS: 00010246
  eax: d209a000   ebx: ffffffff   ecx: 00000000   edx: 00000000
  esi: 00000000   edi: c22f8380   ebp: 00000001   esp: c23e5de0
  ds: 007b   es: 007b   ss: 0068
  Process artillery-fork (pid: 6894, threadinfo=c23e4000 task=c23e3980)
  Stack: 00000000 c23e3980 c22f8380 00000000 c23e3980 c23e3980 c011edc4 c2299e20 
	c2299e20 00001aee 00000001 c23e4000 c23e5ef0 c23e3980 0000009b c010a2fc 
	0000000b c033dc76 00000000 00000002 00000000 00000000 c0117e3a c033dc76 
  Call Trace: [<c011edc4>]  [<c010a2fc>]  [<c0117e3a>]  [<c029ca2d>]  [<c029cb34>]  [<c010b7ed>]  [<c011c604>]  [<c0117cf0>]  [<c0109cd5>]
    [<c012007b>]  [<c014e30f>]  [<c015fabd>]  [<c0124bc0>]  [<c015fb9a>]  [<c015fd60>]  [<c015df65>]  [<c015f0f0>]  [<c0109279>] 
  Code: 87 14 b0 85 d2 75 0c 46 d1 eb 75 e7 eb bd 90 8d 74 26 00 89 

Obviously, the kernel gets more and more confused.  Finally, another one of
these:

 <6>note: artillery-fork[6894] exited with preempt_count 1

This was only from the fork tests, the pthread_tests wouldn't let me
create enough threads to consume too much memory.  How did the Red Hat
people run those tests with 100000 threads?  Set increased the hard
limits for process count and installed the latest glibc and gcc but I'm
apparently still stuck with the old LinuxThreads.  pthread_create fails
on me after an apparently random number of threads have been created,
it's going from 5 to 600 to 1200 so far.  I was not able to even get
close to the 10000 connection I was aiming for!

So I decided that threads don't work for many concurrent connections and
settled for the other benchmark of mine, that just tries to fetch 10000
times the same page with 10 concurrent connections.  It turns out that
pthread_create will still fail after a while.  All my threads are
created detached, because I considered the "thread zombies" might be a
problem.  ps shows that there are only 4 or so threads running when
pthread_create fails.  How can that be?  The system is otherwise idle.

Felix
