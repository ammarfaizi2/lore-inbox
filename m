Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTEPSHC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264521AbTEPSHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:07:02 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:8191 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264505AbTEPSHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:07:00 -0400
Message-ID: <3EC52BC1.7070003@nortelnetworks.com>
Date: Fri, 16 May 2003 14:19:45 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: help...where is my memory going?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got an embedded blade with a powerpc chip and a gig of ram. There are 
hardly any processes running, but I'm using up 106MB of memory, mostly due to 
91MB of cache--only one problem, the filesystem is only 27MB.

I boot it with a normal ramdisk, then create a tmpfs filesystem, copy everything 
to it, pivot to the new filesystem, chroot, and then clean up the ramdisk with 
blockdev.  These measurements were made by shutting down most of the default 
startup processes, then running a tool which chews progressively larger amounts 
of memory until it gets OOM-killed.  I figure this should result in as much 
memory as possible being extracted from the buffer/cache.

I can see needing the following:
27MB filesystem
a few megs for running processes (data only, tmpfs is execute in place IIRC)
maybe 10 megs for the kernel?

Any ideas what the remaining ~50MB is?


Here are some program outputs that might be useful:

[root@10.40.14.67 tmp]# top
16 processes: 15 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  1.4% user,  4.9% system,  0.1% nice, 93.4% idle
Mem:  1010480K av,  106148K used,  904332K free,       0K shrd,    1276K buff
Swap:       0K av,       0K used,       0K free                   91076K cached

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
     1 root       4   0   436  436   292 S     0.0  0.0   0:10 init
     2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
     3 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
     4 root       9   0     0    0     0 SW    0.0  0.0   0:01 kswapd
     5 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
     6 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdated
   353 root       9   0   748  732   432 S     0.0  0.0   0:00 xinetd
   932 root       9   0   532  532   344 S     0.0  0.0   0:00 crond
  1018 root       9   0   300  300   172 S     0.0  0.0   0:00 mingetty
  1143 root       9   0   500  500   308 S     0.0  0.0   0:00 in.telnetd
  1144 root       9   0  1064 1064   684 S     0.0  0.1   0:00 login
  1145 mtc        9   0  1424 1424  1024 S     0.0  0.1   0:00 bash
  1219 root       9   0  1392 1392   160 S     0.0  0.1   0:02 minilogd
  1445 root      10   0  1128 1128   832 S     0.0  0.1   0:00 su
  1447 root      14   0  1684 1684  1268 S     0.0  0.1   0:00 bash
  1456 root      14   0  1192 1192   892 R     0.0  0.1   0:00 top

[root@10.40.14.67 tmp]# df -h
Filesystem            Size  Used Avail Use% Mounted on
tmpfs                  37M   27M   10M  71% /

[root@10.40.14.67 tmp]# cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  1034731520 108552192 926179328        0  1306624 93261824
Swap:        0        0        0
MemTotal:      1010480 kB
MemFree:        904472 kB
MemShared:           0 kB
Buffers:          1276 kB
Cached:          91076 kB
SwapCached:          0 kB
Active:          88664 kB
Inactive:         7524 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1010480 kB
LowFree:        904472 kB
SwapTotal:           0 kB
SwapFree:            0 kB

[root@10.40.14.67 tmp]# mount
tmpfs on / type tmpfs (rw,size=37M)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0622)

[root@10.40.14.67 tmp]# mount -t ext2 /dev/ramdisk /mnt
mount: wrong fs type, bad option, bad superblock on /dev/ramdisk,
        or too many mounted file systems

Note: at this last command, the serial console prints:

VFS: Can't find ext2 filesystem on dev ramdisk(1,0).



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

