Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270009AbUJNJop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbUJNJop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 05:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270013AbUJNJop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 05:44:45 -0400
Received: from pop.gmx.net ([213.165.64.20]:718 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270009AbUJNJok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 05:44:40 -0400
X-Authenticated: #4399952
Date: Thu, 14 Oct 2004 12:00:07 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       jackit-devel@lists.sourceforge.net
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014120007.01c26760@mango.fruits.de>
In-Reply-To: <20041014091953.GA21635@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<20041014105711.654efc56@mango.fruits.de>
	<20041014091953.GA21635@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC'ed jackit-devel mailing list, cause this might be interesting for them,
too.

Ah, btw: U0 booted fine here.. Seems to run allright, too (for everything
non jackd). Only thing is:

When starting jackd i get a floating point exception. Dunno where that comes from:

~$ jackd -d alsa -p 512
jackd 0.99.0
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

loading driver ..
creating alsa driver ... hw:0|hw:0|512|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 48000Hz, period = 512 frames, buffer = 2 periods
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead
Floating point exception



running jackd in gdb locks up the gdb process i think [i'm not too
experienced in debugging stuff].

here;s partial strace and ltrace logs (only the end). I have no idea if this is a jack bug
exposed by your kernrel patches or a bug in your kernel patches exposed by
jackd :) But it seems to be a mutex/futex issue...


strace:

....
sched_get_priority_max(SCHED_FIFO)      = 99
sched_get_priority_max(SCHED_FIFO)      = 99
sched_get_priority_min(SCHED_FIFO)      = 1
mmap2(NULL, 8388608, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6d42000
mprotect(0xb6d42000, 4096, PROT_NONE)   = 0
clone(child_stack=0xb7541b48, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0xb7541bf8, {entry_number:6, base_addr:0xb7541bb0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0xb7541bf8) = 1546
sched_setscheduler(1546, SCHED_OTHER, { 0 }) = 0
sched_setscheduler(1546, SCHED_FIFO, { 20 }) = 0
futex(0xb7541d94, FUTEX_WAKE, 1)        = 1
ioctl(7, 0x4140, 0x1)                   = 0
ioctl(7, 0x4142, 0x1)                   = 0
sched_get_priority_max(SCHED_FIFO)      = 99
sched_get_priority_min(SCHED_FIFO)      = 1
mmap2(NULL, 8388608, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6542000
mprotect(0xb6542000, 4096, PROT_NONE)   = 0
clone(child_stack=0xb6d41b48, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0xb6d41bf8, {entry_number:6, base_addr:0xb6d41bb0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0xb6d41bf8) = 1547
sched_setscheduler(1547, SCHED_OTHER, { 0 }) = 0
sched_setscheduler(1547, SCHED_FIFO, { 10 }) = 0
futex(0xb6d41d94, FUTEX_WAKE, 1)        = 1
+++ killed by SIGFPE +++






ltrace:

....
jack_client_alloc_internal(0x8057800, 0x8063a78, 0xbfffe310, 0x80538b1, 0xbffff758) = 0x8064d20
pthread_mutex_unlock(0x8063abc, 0x8063a78, 0xbfffe310, 0x80538b1, 0xbffff758) = 0
creating alsa driver ... hw:0|hw:0|512|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 48000Hz, period = 512 frames, buffer = 2 periods
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead
free(0x8058658)                                  = <void>
snprintf("/jck-[32 bit float mono audio]", 64, "/jck-[%s]", "32 bit float mono audio") = 30
jack_shmalloc(0xbfffd140, 262144, 0x8063b80, 0xb7fdc21c, 0) = 0
jack_attach_shm(0x8063b80, 262144, 0x8063b80, 0xb7fdc21c, 0) = 0
pthread_mutex_lock(0x8063b00, 0x8063b80, 0x8063b00, 262144, 2048) = 0
malloc(1024)                                     = 0x806e830
malloc(8)                                        = 0x806dd80
malloc(8)                                        = 0x8058658
malloc(8 <unfinished ...>
+++ killed by SIGTRAP +++

