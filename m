Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUGGEDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUGGEDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 00:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUGGEDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 00:03:24 -0400
Received: from danga.com ([66.150.15.140]:19409 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S264890AbUGGEDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 00:03:07 -0400
Date: Tue, 6 Jul 2004 21:03:06 -0700 (PDT)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: linux-kernel@vger.kernel.org
Subject: nfs_inode_cache not getting pruned
Message-ID: <Pine.LNX.4.55.0407062045200.24800@danga.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got a couple boxes here that keep running out of lowmem after about a
day of uptime, rendering them almost entirely unusable.  (OOM killer
taking out processes left and right, despite 1.5 GB highmem available...)

>From what I can tell, nfs_inode_cache isn't responding to memory pressure
and cleaning itself (enough?).

Where slabinfo says "tunables", does that mean it's my job to limit each
slab class to keep things stable?  I would guess not.

Any recommendations on how to keep this box alive more than a day?

Is the 2GB/2GB split patch still floating about, or was the rmap/anonvma
and/or heavier 4GB/4GB stuff supposed to solve all our lowmem woes?

Thanks!
- Brad


# uname -r
2.6.7

# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
nfs_inode_cache   883676 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
dentry_cache      754857 930528    144   27    1 : tunables  120   60    8 : slabdata  34464  34464      0
radix_tree_node   119204 120666    276   14    1 : tunables   54   27    8 : slabdata   8619   8619      0
ip_dst_cache       62730  62730    256   15    1 : tunables  120   60    8 : slabdata   4182   4182      0
size-4096            720    740   4096    1    1 : tunables   24   12    8 : slabdata    720    740     36
size-2048            944   1154   2048    2    1 : tunables   24   12    8 : slabdata    577    577      0
tcp_sock            2448   3507   1152    7    2 : tunables   24   12    8 : slabdata    501    501      0
ext2_inode_cache    3339   3339    512    7    1 : tunables   54   27    8 : slabdata    477    477      0
tcp_tw_bucket      11705  14167    128   31    1 : tunables  120   60    8 : slabdata    457    457    300
sock_inode_cache    2413   3460    384   10    1 : tunables   54   27    8 : slabdata    346    346      0
filp                2679   3750    256   15    1 : tunables  120   60    8 : slabdata    250    250      0
skbuff_head_cache   2064   3225    256   15    1 : tunables  120   60    8 : slabdata    215    215    360
inode_cache         1550   1550    384   10    1 : tunables   54   27    8 : slabdata    155    155      0
size-1024            488    596   1024    4    1 : tunables   54   27    8 : slabdata    149    149    173
size-64              755   8174     64   61    1 : tunables  120   60    8 : slabdata    134    134      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
size-512             555    936    512    8    1 : tunables   54   27    8 : slabdata    117    117    189
eventpoll_epi       2358   3503    128   31    1 : tunables  120   60    8 : slabdata    113    113      0
size-32             2376  13090     32  119    1 : tunables  120   60    8 : slabdata    110    110      0
ext3_inode_cache     461    721    512    7    1 : tunables   54   27    8 : slabdata    103    103      0


# cat /proc/meminfo
MemTotal:      4025568 kB
MemFree:       1547824 kB
Buffers:          1232 kB
Cached:        1519248 kB
SwapCached:          0 kB
Active:         277128 kB
Inactive:      1334944 kB
HighTotal:     3145152 kB
HighFree:      1533312 kB
LowTotal:       880416 kB
LowFree:         14512 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:            1592 kB
Writeback:           0 kB
Mapped:          96800 kB
Slab:           857372 kB
Committed_AS:   152636 kB
PageTables:        576 kB
VmallocTotal:   114680 kB
VmallocUsed:       304 kB
VmallocChunk:   114376 kB

# dmesg
<snip>
Out of Memory: Killed process 23405 (mogilefsd).
Out of Memory: Killed process 24333 (mogilefsd).
Out of Memory: Killed process 24341 (mogilefsd).
Out of Memory: Killed process 24348 (mogilefsd).
Out of Memory: Killed process 24351 (mogilefsd).
Out of Memory: Killed process 24354 (mogilefsd).
Out of Memory: Killed process 24355 (mogilefsd).
Out of Memory: Killed process 25262 (mogilefsd).
Out of Memory: Killed process 25263 (mogilefsd).
Out of Memory: Killed process 25264 (mogilefsd).
Out of Memory: Killed process 25268 (mogilefsd).
Out of Memory: Killed process 26150 (mogilefsd).
Out of Memory: Killed process 26172 (mogilefsd).
Out of Memory: Killed process 26176 (mogilefsd).
Out of Memory: Killed process 26177 (mogilefsd).
Out of Memory: Killed process 26178 (mogilefsd).
<snip>

sto2:/sys# while true; do grep nfs_inode_cache /proc/slabinfo; sleep 1 ; done
nfs_inode_cache   887611 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   887665 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   887719 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   887746 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   887816 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   887843 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   887870 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   887951 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   887978 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888032 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888032 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888086 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888113 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888113 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888194 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888221 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888275 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888275 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888356 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888383 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888437 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888464 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888464 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888545 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888599 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888599 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888626 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888707 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
nfs_inode_cache   888815 965706    640    6    1 : tunables   54   27    8 : slabdata 160951 160951      0
....
 (always growing)


-- 
Brad Fitzpatrick
brad@danga.com
www.danga.com
