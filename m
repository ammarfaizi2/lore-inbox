Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUHFNMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUHFNMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUHFNMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:12:50 -0400
Received: from cliff.cse.wustl.edu ([128.252.166.5]:9375 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S268131AbUHFNMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:12:44 -0400
From: Berkley Shands <berkley@cs.wustl.edu>
Date: Fri, 6 Aug 2004 08:12:43 -0500 (CDT)
Message-Id: <200408061312.i76DChO0000119045@mudpuddle.cs.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: A fix for Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Taking the 2.6.6-bk6/mm/readahead.c (a one line change from vanilla 2.6.6/mm/readahead.c)
and inserting it into 2.6.7 and 2.6.8-rc3 restores the thread read ahead functionality
and througput seen in the 2.6.6 kernel. This does however reduce the single stream read
performance from 426MB/Sec (under 2.6.8-rc3) to 386MB/Sec (same as 2.6.6).
The major functionality change was to try to detect "random" read performance,
if randomness is detected, then NEVER read ahead. In this case, two threads
using two different file descriptors to the same file read alternating strides
of the file. Since each thread did not do SEQUENTIAL reads, both were treated as random
accesses.

readahead.c needs to look at a little more context, or it needs to increase the size of the
window it uses to detect "randomness". In this case the read stride is 11KB.
A decent minimum window should be at least the stripe size for raid0.

The larger-than-phys-memory file read issue seems to have calmed down with the
readahead.c update. The 10MB/Sec is now 295MB/Sec (it should be 400+MB/Sec).
top shows
 08:08:27  up 14 min,  2 users,  load average: 1.34, 0.56, 0.21
75 processes: 73 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  cpu    user    nice  system    irq  softirq  iowait    idle
           total    0.3%    0.0%   41.5%   0.3%     3.1%   39.2%   15.2%
           cpu00    0.5%    0.0%   51.2%   0.7%     6.3%   39.4%    1.5%
           cpu01    0.3%    0.0%   31.8%   0.0%     0.0%   39.0%   28.7%
Mem:  7587576k av, 7575424k used,   12152k free,       0k shrd,    7676k buff
           20k active,            7391452k inactive
Swap: 2008116k av,   13496k used, 1994620k free                 7379716k cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
   57 root      15   0     0    0     0 RW    5.1  0.0   0:07   1 kswapd0

so kswapd is not out to lunch anymore. I will still have to figure out a peak
value for block size and RASize to see if I can improve large file read performance.

berkley
