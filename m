Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbSJPTfz>; Wed, 16 Oct 2002 15:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbSJPTfx>; Wed, 16 Oct 2002 15:35:53 -0400
Received: from pod.tau.ac.il ([132.66.10.227]:15248 "EHLO pod.tau.ac.il")
	by vger.kernel.org with ESMTP id <S261274AbSJPTfv>;
	Wed, 16 Oct 2002 15:35:51 -0400
Date: Wed, 16 Oct 2002 21:41:44 +0200 (IST)
From: Oded Comay <comay@comay.net>
X-X-Sender: comay@pod.tau.ac.il
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 memory leak, or just mis-understanding?
Message-ID: <Pine.LNX.4.44.0210162127410.21876-100000@pod.tau.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A 2.4.18 system in my domain swaps heavily with no apparent reason.  
Summing up memory usage according to /proc/meminfo, /proc/slabinfo, and
/proc/*/status shows as if an increasing amount of memory is unaccounted
for. As an example (details below) consider the following:

  Used memory: 108 MB

  Buffers:       1 MB
  Cached:       10 MB
  Slabinfo:      3 MB
  Processes:    10 MB

Which obviously doesn't sum up. What am I missing? Any clue from a 
kind soul is appreciated.

TIA,
Oded.

Details:

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  524374016 113479680 410894336        0   860160  9527296
Swap: 942473216  1503232 9409
MemTotal:       512084 kB
MemFree:        401264 kB
MemShared:           0 kB
Buffers:           840 kB
Cached:           8768 kB
SwapCached:        536 kB
Active:           6420 kB
Inactive:         4772 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       512084 kB
LowFree:        401264 kB
SwapTotal:      920384 kB
SwapFree:       918916 kB

slabsum.pl sums up the active pages in /proc/slabinfo. It works as
follows:

  while (<>) {
    s/([a-zA-Z]) ([a-zA-Z])/$1\_$2/;
    ($name, $active_obj, $total_obj, $size, $active_slabs,
$total_slabs, $pages)= split;
    $sum+= $total_slabs*$pages;
  }
  print $sum*4096;

# slabsum.pl < /proc/slabinfo
2498560

The following sums up the resident size of running processes. It
ignores shared memory issues, so it is at least as large as the actual
memory used (reported in kB):

# grep VmRSS: /proc/*/status | awk '{s+= $2; print s}' | tail -1
10164

No ipcs shared memory:

# ipcs

------ Shared Memory Segments --------
key       shmid     owner     perms     bytes     nattch    status

------ Semaphore Arrays --------
key       semid     owner     perms     nsems     status

------ Message Queues --------
key       msqid     owner     perms     used-bytes  messages



