Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268399AbUIBO5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268399AbUIBO5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUIBO5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:57:09 -0400
Received: from adsl-ull-123-100.42-151.net24.it ([151.42.100.123]:53233 "EHLO
	www.gtkperl.org") by vger.kernel.org with ESMTP id S268389AbUIBO4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:56:35 -0400
Date: Thu, 2 Sep 2004 16:56:27 +0200
From: Paolo Molaro <lupus@debian.org>
To: linux-kernel@vger.kernel.org
Subject: incorrect time accouting
Message-ID: <20040902145627.GX2761@debian.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While benchmarking, a user pointed out that time(1) reported
incorrect user and system times when running mono.
A typical example (running on 2.6.8.1 is):

	$ /usr/bin/time mono so-sieve.exe 5000
	Count: 1028
	0.02user 0.00system 0:01.97elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (1major+1509minor)pagefaults 0swaps

Where so-sieve.exe is a cpu-bound benchmark.
On 2.6.8.1 very low user and system times are reported every time, while
on both 2.4.19 and 2.2.20 sometimes the correct (or at least sensible) 
results are reported, while sometimes very low timings are reported as
well.
top reports high cpu usage and low idle percentages, but with no cpu
time accounted to the mono process.
This looks like a mild security issue, since it appears there is some way
to circumvent the kernel's idea of the cpu resource usage of a process,
so the limits set become useless and users could bog down the system.

http://primates.ximian.com/~lupus/time-strace has the result of
	strace -tt -f time /usr/local/bin/mono so-sieve.exe 5000 2> time-strace
The highlights include:

[pid  9630] 19:22:28.609566 execve("/usr/local/bin/mono", ["/usr/local/bin/mono", "so-sieve.exe", "5000"], [/* 33 vars */]) = 0
Pid 9630 is the main process: it creates a thread that will execute the
bulk of the cpu-intensive code (pid 9633):

[pid  9630] 19:22:28.839532 clone(Process 9633 attached child_stack=0x40d17b48, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0x40d17bf8, {entry_number:6, base_addr:0x40d17bb0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0x40d17bf8) = 9633
The main loop starts here, after some memory allocation:

[pid  9633] 19:22:28.849138 brk(0x82ae000) = 0x82ae000
And it ends about two seconds later, with the next entry in the trace
for the 9633 pid:

[pid  9633] 19:22:30.780451 brk(0)      = 0x82ae000
At the end, wait4 is called to collect the times, less than 0.5 sec
user+system:
[pid  9629] 19:22:30.821596 <... wait4 resumed> [WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL], 0, {ru_utime={0, 14997}, ru_stime={0, 1999}, ...}) = 9630

http://primates.ximian.com/~lupus/mono-1.1.1.tar.gz is the mono source,
if you don't have mono installed to reproduce (I tried to reproduce with
a simple pthread program what mono is doing, executing cpu-intensive
code in a subthread, but times are reported correctly there).
http://primates.ximian.com/~lupus/so-sieve.exe is the sample program,
but other programs exibited the same behaviour.
Let me know if more info is needed to track down the problem.

lupus

-- 
-----------------------------------------------------------------
lupus@debian.org                                     debian/rules
lupus@ximian.com                             Monkeys do it better
