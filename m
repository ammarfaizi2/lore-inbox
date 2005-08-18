Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVHRCTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVHRCTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVHRCTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:19:12 -0400
Received: from rain.plan9.de ([193.108.181.162]:47021 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S932065AbVHRCTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:19:11 -0400
Date: Thu, 18 Aug 2005 04:19:08 +0200
From: Marc Lehmann <schmorp@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at "fs/exec.c":777
Message-ID: <20050818021908.GA11047@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(A courteasy CC: on replies would be appreciated, thanks)

Hi!

I get the above oops message (full details below) sometimes when running the
CVS version of "cv", a gtk+ image viewer.

I use kernel 2.6.12.5, but it occured on 2.6.11 that I ran earlier, too.
Unfortunately, it only happens during interactive use (or at least my
simple test scripts were unable to reproduce the behaviour yet).

cv is a perl/gtk script that uses the IO::AIO module. That module starts a
number of threads that basically emulate asynchronous I/O.

The oops happen when cv starts to move files (which it does by fork+exec
of /bin/mv, which is where it oopses). IO::AIO has an pthread_atfork
handler that recreates the aio threads after the fork (but doesn't kill
the threads before the fork). The forked process than does an exec() and
rarely oopses.

So what happens is:

   pthread_create (4 or more times)
   fork           ("main" thread forks)
   pthread_create (4 or more times)
   exec           ("main" thread execs)
   ...            (very rarely oopses)

All in quick successsion.

fs/exec.c:777 is:

    593 static inline int de_thread(struct task_struct *tsk)
   ...
    776         if (!thread_group_empty(current))
    777                 BUG();
    778         if (!thread_group_leader(current))
    779                 BUG();
    780         return 0;

2.6.11 oopsed at the same BUG().

The system is an SMP dual opteron in 64 bit mode with gcc-3.3 (I think)
compiled kernel and the nvidia kernel module loaded (but the program only
does X calls, no direct gl access). If wanted, I can probably reproduce
that without the nvidia kernel module loaded.

If any other info is required to fix that bug I'll happily try to find
out or test things.

Thanks!

The complete OOPS is:

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "fs/exec.c":777
invalid operand: 0000 [1] SMP 
CPU 0 
Modules linked in: nls_utf8 nls_cp850 vfat fat loop nvidia tg3 snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_seq_device snd_util_mem snd_hwdep w83627hf i2c_sensor i2c_isa amd64_agp 3w_9xxx
Pid: 11032, comm: cv Tainted: P      2.6.12.5
RIP: 0010:[<ffffffff8017e47b>] <ffffffff8017e47b>{flush_old_exec+1531}
RSP: 0018:ffff810002cddd28  EFLAGS: 00010202
RAX: ffff81001d064a90 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff81001d064910 RSI: ffff81003e501680 RDI: ffff81003fec4e80
RBP: ffff81002555ccc0 R08: ffffffff805b1880 R09: 0000000000000002
R10: 00000000ffffffff R11: ffff810001e104e0 R12: 00000000ffffffb0
R13: ffff81002577a8c0 R14: ffff81002577b0c8 R15: ffff81003e501680
FS:  00002aaaab1a7e10(0000) GS:ffffffff80576780(0000) knlGS:0000000056a06500
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000003563600 CR3: 0000000015335000 CR4: 00000000000006e0
Process cv (pid: 11032, threadinfo ffff810002cdc000, task ffff81001d064910)
Stack: 0000000100000101 ffffffff801a2eee 0000000000000080 ffff81001295e480 
       0000000000000080 ffff81002dfbd600 ffff810000000000 ffff81002dfbd600 
       000000001295e480 ffff81000a4c9b40 
Call Trace:<ffffffff801a2eee>{dnotify_parent+46} <ffffffff8019f4a7>{load_elf_binary+1335}
       <ffffffff80157fd3>{buffered_rmqueue+323} <ffffffff8019ef70>{load_elf_binary+0}
       <ffffffff8017ea3e>{search_binary_handler+158} <ffffffff8017ed82>{do_execve+386}
       <ffffffff8010e72a>{system_call+126} <ffffffff8010d181>{sys_execve+65}
       <ffffffff8010eb4a>{stub_execve+106} 

Code: 0f 0b 05 ec 42 80 ff ff ff ff 09 03 65 48 8b 04 25 00 00 00 
RIP <ffffffff8017e47b>{flush_old_exec+1531} RSP <ffff810002cddd28>
 nfs warning: mount version older than kernel





-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
