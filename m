Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135809AbRD2QS2>; Sun, 29 Apr 2001 12:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135820AbRD2QSS>; Sun, 29 Apr 2001 12:18:18 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:15113 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S135809AbRD2QSH>;
	Sun, 29 Apr 2001 12:18:07 -0400
Date: Sun, 29 Apr 2001 18:18:09 +0200
From: Frank de Lange <frank@unternet.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Severe trashing in 2.4.4
Message-ID: <20010429181809.A10479@unternet.org>
In-Reply-To: <200104290311.f3T3BeO09131@bellini.kjist.ac.kr> <20010429140155.D24432@unternet.org> <3AEC09EE.342FE1C8@kjist.ac.kr> <20010429152414.B11395@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010429152414.B11395@athlon.random>; from andrea@suse.de on Sun, Apr 29, 2001 at 03:24:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK,

I seem to have found the culprit, although I'm stillin the dark st to the
'why' and 'how'.

First, some info:

2.4.4 with Maciej's IO-APIC patch
Abit BP-6, dual Celeron466@466
256MB RAM

So, 'yes, SMP...'

Running 'nget v0.7' (a command line nntp 'grabber') on 2.4.4 leads to massive
amounts of memory disappearing in thin air. I'm currently running a single
instance of this app, and I'm seeing the memory drain away. The system has 256
MB of physycal memory, and access to 500 MB of swap. Swap is not really being
used now, but it soon will be. Have a look at the current /proc/meminfo:

[frank@behemoth mozilla]$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  262049792 259854336  2195456        0  1773568 31211520
Swap: 511926272     4096 511922176
MemTotal:       255908 kB
MemFree:          2144 kB
MemShared:           0 kB
Buffers:          1732 kB
Cached:          30480 kB
Active:          26944 kB
Inact_dirty:      2384 kB
Inact_clean:      2884 kB
Inact_target:      984 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255908 kB
LowFree:          2144 kB
SwapTotal:      499928 kB
SwapFree:       499924 kB

Also look at the top 10 memory users:

[frank@behemoth mp3]$ ps -xao rss,vsz,pid,command|sort -rn|head 
6388 55320  1310 /usr/bin/X11/XFree86 -depth 16 -gamma 1.6 -auth /var/lib/gdm/:0
3604  8972  1438 gnome-terminal -t frank@behemoth.localnet
3116  8356  1405 panel --sm-config-prefix /panel.d/default-ZTNCVS/ --sm-client-i
3084  5484  1401 sawfish --sm-client-id 11c0a80105000098495218600000010240115 --
2940  8388  1696 gnome-terminal --tclass=Remote -x ssh -v ostrogoth.localnet
2748  7536  1432 mini_commander_applet --activate-goad-server mini-commander_app
2692  7656  1413 tasklist_applet --activate-goad-server tasklist_applet --goad-f
2536  7588  1411 deskguide_applet --activate-goad-server deskguide_applet --goad
2320  7388  1383 /usr/bin/gnome-session
2232  7660  1421 multiload_applet --activate-goad-server multiload_applet --goad

(the rest is mostly small stuff, < 1 MB, total of 89 processes)

 [ swap is being hit at this moment... ]

Where did my memory go? 

A few minutes later, with the same process load (minimal), a look at
/proc/meminfo:

[frank@behemoth mozilla]$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  262049792 260108288  1941504        0  1380352 11689984
Swap: 511926272 34279424 477646848
MemTotal:       255908 kB
MemFree:          1896 kB
MemShared:           0 kB
Buffers:          1348 kB
Cached:          11416 kB
Active:           9164 kB
Inact_dirty:      1240 kB
Inact_clean:      2360 kB
Inact_target:      996 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255908 kB
LowFree:          1896 kB
SwapTotal:      499928 kB
SwapFree:       466452 kB

Already 34MB in swap...

Start xmms, and this is the result:

[frank@behemoth mozilla]$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  262049792 260411392  1638400        0  1380352 10063872
Swap: 511926272 38449152 473477120
MemTotal:       255908 kB
MemFree:          1600 kB
MemShared:           0 kB
Buffers:          1348 kB
Cached:           9828 kB
Active:           6400 kB
Inact_dirty:      1236 kB
Inact_clean:      3540 kB
Inact_target:     2128 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255908 kB
LowFree:          1600 kB
SwapTotal:      499928 kB
SwapFree:       462380 kB

(top 10 memory users)

[frank@behemoth mp3]$ ps -xao rss,vsz,pid,command|sort -rn|head
2340 56604  1310 /usr/bin/X11/XFree86 -depth 16 -gamma 1.6 -auth /var/lib/gdm/:0
1592  5484  1401 sawfish --sm-client-id 11c0a80105000098495218600000010240115 --
1452 33784  1780 xmms
1436 33784  1785 xmms
1436 33784  1782 xmms
1436 33784  1781 xmms
1296  9000  1438 gnome-terminal -t frank@behemoth.localnet
1184  2936  1790 ps -xao rss,vsz,pid,command
1060  7656  1413 tasklist_applet --activate-goad-server tasklist_applet --goad-f
1008  8388  1696 gnome-terminal --tclass=Remote -x ssh -v ostrogoth.localnet

The memory is used somewhere, but nowhere I can find or pinpoint. Not in
buffers, not cached, not by processes I can see in ps or top or /proc. And it
does not come back either. Shooting down the nget process and xmms frees up
some swap, buth the disappeared memory stays that way as can be seen from this
(final) /proc/meminfo / ps combo:

[frank@behemoth mozilla]$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  262049792 260411392  1638400        0  1388544  8568832
Swap: 511926272 36360192 475566080
MemTotal:       255908 kB
MemFree:          1600 kB
MemShared:           0 kB
Buffers:          1356 kB
Cached:           8368 kB
Active:           6284 kB
Inact_dirty:      1236 kB
Inact_clean:      2204 kB
Inact_target:      632 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255908 kB
LowFree:          1600 kB
SwapTotal:      499928 kB
SwapFree:       464420 kB

[frank@behemoth mp3]$ ps -xao rss,vsz,pid,command|sort -rn|head
2244 55304  1310 /usr/bin/X11/XFree86 -depth 16 -gamma 1.6 -auth /var/lib/gdm/:0
1644  5484  1401 sawfish --sm-client-id 11c0a80105000098495218600000010240115 --
1252  9008  1438 gnome-terminal -t frank@behemoth.localnet
1172  2924  1796 ps -xao rss,vsz,pid,command
 956  7656  1413 tasklist_applet --activate-goad-server tasklist_applet --goad-f
 944  8388  1696 gnome-terminal --tclass=Remote -x ssh -v ostrogoth.localnet
 776  7588  1411 deskguide_applet --activate-goad-server deskguide_applet --goad
 556  3012  1797 sort -rn
 504  7436  1419 asclock_applet --activate-goad-server asclock_applet --goad-fd 
 464  8356  1405 panel --sm-config-prefix /panel.d/default-ZTNCVS/ --sm-client-i

 [ system just started thrashing again, had to sysrq-reboot ]

So, there's something wrong here... Wish I knew what...

2.4.3 runs fine on the same box with the same apps. 

Any clues?

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
