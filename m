Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289028AbSAFUfl>; Sun, 6 Jan 2002 15:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289029AbSAFUfa>; Sun, 6 Jan 2002 15:35:30 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:3800 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S289028AbSAFUfM>; Sun, 6 Jan 2002 15:35:12 -0500
Date: Sun, 6 Jan 2002 15:38:54 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020106153854.A10824@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.17rc2aa2 seems to handle the grow/shrink of buffer_head, 
dentry_cache, inode_cache slabs and page/buffer caches pretty 
well.

Machine has 1GB RAM and CONFIG_NOHIGHMEM=y
1027 MB swap.

root# dmesg|grep Mem
Memory: 901804k/917504k available (1049k kernel code, 15312k reserved, 259k data, 236k init, 0k highmem)

root# uptime
2:47pm  up 4 days, 17:04,  12 users,  load average: 1.00, 1.00, 1.00

# Run updatedb to expand the size of dentry_cache.
root# updatedb

# At first, slabs are fairly large.
root# egrep 'inode_cache|dentry_cache|buffer_head' /proc/slabinfo
inode_cache       469072 469168    512 67024 67024    1
dentry_cache      539651 539670    128 17989 17989    1
buffer_head       119438 126330    128 4211 4211    1

Machine has been up for a while, compiling things, running tests, etc,
so page and buffer caches are large too.  That's expected/desireable
as there is no memory shortage.

root# free -mt
             total       used       free     shared    buffers     cached
Mem:           880        868         11          0        152        316
-/+ buffers/cache:        400        480
Swap:         1027          0       1027
Total:        1908        868       1039

# count processes
root# ps axu|wc -l
     64

# allocate and write to 99% of virtual memory
root# time ./mtest01 -p 99 -w
Filling up 99%  of ram which is 1855075778d bytes
PASS ... 1855979520 bytes allocated.

real    0m39.006s
user    0m8.610s
sys     0m7.170s

# notice how much the slabs shrank compared to above.
root# egrep 'inode_cache|dentry_cache|buffer_head' /proc/slabinfo
inode_cache          254    658    512   94   94    1
dentry_cache         193   1140    128   38   38    1
buffer_head         8609  43650    128 1455 1455    1

# Memory allocated to buffers/cache has decreased considerably too.
root# free -mt
             total       used       free     shared    buffers     cached
Mem:           880         71        809          0         29          6
-/+ buffers/cache:         35        845
Swap:         1027         27       1000
Total:        1908         98       1810

# no processes killed by OOM
root# ps aux|wc -l
     64

# Now force an OOM condition
root# time ./mtest01 -p 101 -w
Filling up 101%  of ram which is 1916602941d bytes
Killed

real    0m40.083s
user    0m8.770s
sys     0m7.270s

Note the time to notice and kill mtest01 because of OOM is short.
39 seconds to allocate 1855979520 bytes of VM.
40 seconds to allocate 1916602941 bytes and kill with OOM handler.

# Only mtest01 killed by OOM
root# ps axu|wc -l
     64

In the experiment above, it appears the rc2aa2 VM shinks slabs and 
page/buffer caches in a reasonable way when a process needs a lot
of memory.

-- 
Randy Hron

