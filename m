Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131300AbRDMNg1>; Fri, 13 Apr 2001 09:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbRDMNgS>; Fri, 13 Apr 2001 09:36:18 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:39672 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131300AbRDMNgF>; Fri, 13 Apr 2001 09:36:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Alexander Viro <viro@math.psu.edu>, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH] Re: memory usage - dentry_cacheg
Date: Fri, 13 Apr 2001 09:36:01 -0400
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0104122154560.22287-100000@weyl.math.psu.edu> <01041300454100.06447@oscar>
In-Reply-To: <01041300454100.06447@oscar>
MIME-Version: 1.0
Message-Id: <01041309360100.32757@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 April 2001 00:45, Ed Tomlinson wrote:
> On Thursday 12 April 2001 22:03, Alexander Viro wrote:

> > If you are talking about "unused" from the slab POV - _ouch_. Looks like
> > extremely bad fragmentation ;-/ It's surprising, and if that's thte case
> > I'd like to see more details.

> From the POV of dentry_stat.nr_unused.  From the slab POV,
> dentry_stat.nr_dentry always equals the number of objects used as reported
> in /proc/slabinfo.  If I could remember my stats from ages back I could
> take a stab at estimating the fragmentation...  From experience if you look
> at memory_pressure before and after a shrink of the dcache you will usually
> see it decrease if there if there is more that 75% or so free reported by
> dentry_stat.nr_unused.
>
> The inode cache is not as good.  With fewer inodes per page (slab) I
> would expect that percentage to be lower.  Instead it usually has to be
> above 80% to get pages free...
>
> I am trying your change now.

And it does seem to help here.  Worst case during an afio backup was:

inode_cache        14187  16952    480 2119 2119    1
dentry_cache        1832   3840    128  128  128    1
 4  1  0  45256   1600  36828 165156   4   8   576    79  163   612  39   6  55

without the patch 20000+ inode slabs was not uncommon.

Here are some numbers snapshoting every 120
seconds at the start of a backup.

oscar% while true;do  cat /proc/slabinfo | egrep "dentry|inode"; vmstat | tail -1; 
sleep 120; done
inode_cache        11083  11592    480 1449 1449    1
dentry_cache        4477   4500    128  150  150    1
 0  0  0    136   7116  17048 198072   0   0    36    64  129   443  20   3  77
inode_cache        11493  11816    480 1477 1477    1
dentry_cache        2611   3690    128  123  123    1
 4  0  0   8784   1596  66728 152484   0   1    44    65  131   448  20   3  77
inode_cache         4512   6168    480  771  771    1
dentry_cache        2708   4320    128  144  144    1
 3  0  0  24168   2936 170108  50196   0   3    62    66  135   457  20   4  76
inode_cache         1651   4184    480  523  523    1
dentry_cache         778   3330    128  111  111    1
 2  0  0    156  18560 130504  74848   4   5    77    68  138   462  21   4  75
inode_cache        11426  11432    480 1429 1429    1
dentry_cache         672   3240    128  108  108    1
 2  0  0  44928   1740  58292 151932   4  11   101    77  140   467  21   4  74
inode_cache        10572  11480    480 1435 1435    1
dentry_cache        1099   3240    128  108  108    1
 3  0  0  45668   1852  21412 189600   4  11   126    79  142   474  22   4  74
inode_cache        10620  11416    480 1427 1427    1
dentry_cache        1611   3240    128  108  108    1
 3  0  0  45648   2068  13020 202140   4  11   152    78  143   482  23   4  73
inode_cache        10637  11416    480 1427 1427    1
dentry_cache        1628   3240    128  108  108    1
 3  0  0  45648   1588  12412 200832   4  11   171    77  143   489  24   4  72
inode_cache        10652  11416    480 1427 1427    1
dentry_cache        1643   3240    128  108  108    1
 2  0  0  45648   1808  12556 191080   4  11   190    76  143   497  25   5  71
inode_cache        10698  11416    480 1427 1427    1
dentry_cache        1697   3240    128  108  108    1
 2  0  0  45648   1736  12788 191300   4  10   208    75  143   504  26   5  70
inode_cache        10729  11416    480 1427 1427    1
dentry_cache        1728   3240    128  108  108    1

Looks like there is some fragmentation ocuring.  It stays at near a 1:2 ratio for
most of the backup (using afio) and ends up with the slab cache having 10-20% more
entries than the dcache is using.

Thanks
Ed Tomlinson <tomlins@cam.org>
