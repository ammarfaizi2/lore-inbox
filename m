Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268067AbUHFOom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268067AbUHFOom (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUHFOof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:44:35 -0400
Received: from pop.gmx.net ([213.165.64.20]:42386 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268067AbUHFOoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:44:19 -0400
Date: Fri, 6 Aug 2004 16:44:18 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-ia64@vger.kernel.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.7, ia64] continual memory leak at ~102kB/s...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <20029.1091803458@www55.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running 2.6.7 on a generic ia64 system, I see memory being leaked in
the kernel. Most of the fancy (preempt, hot-plug procs, ...) features are
disabled, and the system in a quiescent state [1].

/proc/meminfo shows the memory as unaccounted for [2], so it seems likely it
has been kmalloc()d somehere. A small script shows memory disappearing at
102kB/s [3].

Anyone else seen this on ia64?

--- [1]

# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  1 10:29 ?        00:00:04 init [S]              
root         2     1  0 10:29 ?        00:00:00 [migration/0]
root         3     1  0 10:29 ?        00:00:00 [ksoftirqd/0]
root         4     1  0 10:29 ?        00:00:00 [migration/1]
root         5     1  0 10:29 ?        00:00:00 [ksoftirqd/1]
root         6     1  0 10:29 ?        00:00:00 [migration/2]
root         7     1  0 10:29 ?        00:00:00 [ksoftirqd/2]
root         8     1  0 10:29 ?        00:00:00 [migration/3]
root         9     1  0 10:29 ?        00:00:00 [ksoftirqd/3]
root        10     1  0 10:29 ?        00:00:00 [events/0]
root        11     1  0 10:29 ?        00:00:00 [events/1]
root        12     1  0 10:29 ?        00:00:00 [events/2]
root        13     1  0 10:29 ?        00:00:00 [events/3]
root        14    10  0 10:29 ?        00:00:00 [khelper]
root        15    10  0 10:29 ?        00:00:00 [kacpid]
root        70    10  0 10:29 ?        00:00:00 [kblockd/0]
root        71    10  0 10:29 ?        00:00:00 [kblockd/1]
root        72    10  0 10:29 ?        00:00:00 [kblockd/2]
root        73    10  0 10:29 ?        00:00:00 [kblockd/3]
root        83    10  0 10:29 ?        00:00:00 [pdflush]
root        84    10  0 10:29 ?        00:00:00 [pdflush]
root        85     1  0 10:29 ?        00:00:00 [kswapd0]
root        86    10  0 10:29 ?        00:00:00 [aio/0]
root        87    10  0 10:29 ?        00:00:00 [aio/1]
root        88    10  0 10:29 ?        00:00:00 [aio/2]
root        89    10  0 10:29 ?        00:00:00 [aio/3]
root       194     1  0 10:29 ?        00:00:00 [scsi_eh_0]
root       206     1  0 10:29 ?        00:00:00 [scsi_eh_1]
root       210     1  0 10:29 ?        00:00:00 [kjournald]
root       836     1  0 10:29 ttyS1    00:00:00 init [S]              
root       837   836  0 10:29 ttyS1    00:00:00 /bin/sh
root       846   837  0 10:33 ttyS1    00:00:00 ps -ef

--- [2]

# cat /proc/meminfo; sleep 10; cat /proc/meminfo
MemTotal:      1006272 kB
MemFree:        671104 kB
Buffers:         14720 kB
Cached:          18304 kB
SwapCached:          0 kB
Active:          35584 kB
Inactive:         9216 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1006272 kB
LowFree:        671104 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           6592 kB
Slab:           212160 kB
Committed_AS:     8576 kB
PageTables:       1344 kB
VmallocTotal: 35184363699328 kB
VmallocUsed:       384 kB
VmallocChunk: 35184363698944 kB

MemTotal:      1006272 kB
MemFree:        670016 kB
Buffers:         14720 kB
Cached:          18304 kB
SwapCached:          0 kB
Active:          35648 kB
Inactive:         9152 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1006272 kB
LowFree:        670016 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             256 kB
Writeback:           0 kB
Mapped:           6592 kB
Slab:           212224 kB
Committed_AS:     8576 kB
PageTables:       1344 kB
VmallocTotal: 35184363699328 kB
VmallocUsed:       384 kB
VmallocChunk: 35184363698944 kB

--- [3]

# ./vm.pl; sleep 10; ./vm.pl 
leaked=104640KB
leaked=105664KB
# 102.4kB/s leak rate here

-- 
Daniel J Blueman

NEU: WLAN-Router für 0,- EUR* - auch für DSL-Wechsler!
GMX DSL = supergünstig & kabellos http://www.gmx.net/de/go/dsl

