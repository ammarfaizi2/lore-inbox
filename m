Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272723AbRILJuL>; Wed, 12 Sep 2001 05:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272730AbRILJuB>; Wed, 12 Sep 2001 05:50:01 -0400
Received: from [195.157.147.30] ([195.157.147.30]:6156 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S272723AbRILJty>; Wed, 12 Sep 2001 05:49:54 -0400
Date: Wed, 12 Sep 2001 10:51:51 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: linux-kernel@vger.kernel.org
Subject: /proc/meminfo swap counter wraparound in 2.2
Message-ID: <20010912105151.L6126@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

Having put 8Gb of swap on one of our production database servers[1], I found
that "top", "free" et al report the amount of available swap space incorrectly.

This is because they all parse /proc/meminfo, and its counters seem to wrap
when they encounter very high numbers.  The relevant bit is the totalswap
member of "struct sysinfo"

sean@lisa:~$ cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/rd/c0d2p1                  partition       530104  41436   10
/usr/SWAPFILE1                  file            1048568 56      2
/usr/local/SWAPFILE1            file            1048568 52      2
/usr/SWAPFILE2                  file            1572856 0       3
/usr/local/SWAPFILE2            file            1572856 0       3
/var/SWAPFILE2                  file            1572856 0       3
/home/SWAPFILE2                 file            1572856 0       -6

sean@lisa:~$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  4125683712 2820616192 1305067520        0 82919424 232722432
Swap: 542777344 42541056 500236288
MemTotal:   4028988 kB
MemFree:    1274480 kB
MemShared:        0 kB
Buffers:      80976 kB
Cached:      227268 kB
BigTotal:   3111908 kB
BigFree:    1266988 kB
SwapTotal:   530056 kB
SwapFree:    488512 kB

sean@lisa:~$ uname -a
Linux lisa.sportingbet.com 2.2.19-6.2.7enterprise #1 SMP Thu Jun 14 07:34:12 EDT 2001 i686 unknown

As you can see, we are running redhat's "enterprise" 2.2.19 kernel.

I would be amazed if this bug were not also in the main 2.2.x tree.  Is a fix
likely or even possible in 2.2 ?

Sean

[1]One of several changes to avoid random oracle 600 errors under heavy load.
