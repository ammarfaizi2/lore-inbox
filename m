Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVFTKcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVFTKcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVFTKcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:32:14 -0400
Received: from Nazgul.esiway.net ([193.194.16.154]:45289 "EHLO
	Nazgul.esiway.net") by vger.kernel.org with ESMTP id S261159AbVFTKb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:31:28 -0400
Subject: Tracking down a memory leak
From: Marco Colombo <marco@esi.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: ESI srl
Date: Mon, 20 Jun 2005 12:33:12 +0200
Message-Id: <1119263592.31049.19.camel@Frodo.esi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
today I've found a server in a OOM condition, the funny thing is that
after some investigation I've found no process that has mem allocated
to. I even switched to single user, here's what I've found: 

sh-2.05b# ps axu; free
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  2708  432 ?        S    May16   0:10 init [S]
root         2  0.0  0.0     0    0 ?        SWN  May16   0:03 [ksoftirqd/0]
root         3  0.0  0.0     0    0 ?        SW<  May16   1:49 [events/0]
root         4  0.0  0.0     0    0 ?        SW<  May16   0:00 [khelper]
root        16  0.0  0.0     0    0 ?        SW<  May16   0:00 [kacpid]
root        87  0.0  0.0     0    0 ?        SW<  May16   0:33 [kblockd/0]
root        95  0.0  0.0     0    0 ?        SW   May16   0:00 [khubd]
root       152  0.0  0.0     0    0 ?        SW<  May16   0:00 [aio/0]
root       151  0.0  0.0     0    0 ?        SW   May16  45:44 [kswapd0]
root       245  0.0  0.0     0    0 ?        SW   May16   0:00 [kseriod]
root       473  0.0  0.0     0    0 ?        SW   May16   0:00 [md7_raid1]
root       475  0.0  0.0     0    0 ?        SW   May16   0:11 [md6_raid1]
root       477  0.0  0.0     0    0 ?        SW   May16   0:00 [md5_raid1]
root       479  0.0  0.0     0    0 ?        SW   May16   0:00 [md4_raid1]
root       481  0.0  0.0     0    0 ?        SW   May16   0:00 [md3_raid1]
root       483  0.0  0.0     0    0 ?        SW   May16   0:08 [md2_raid1]
root       485  0.0  0.0     0    0 ?        SW   May16   0:00 [md1_raid1]
root       486  0.0  0.0     0    0 ?        SW   May16   0:02 [md0_raid1]
root       487  0.0  0.0     0    0 ?        SW   May16   0:38 [kjournald]
root       690  0.0  0.0     0    0 ?        SW   May16   0:03 [kjournald]
root       691  0.0  0.0     0    0 ?        SW   May16   4:05 [kjournald]
root       692  0.0  0.0     0    0 ?        SW   May16   0:03 [kjournald]
root       693  0.0  0.0     0    0 ?        SW   May16   0:03 [kjournald]
root       694  0.0  0.0     0    0 ?        SW   May16   0:03 [kjournald]
root       695  0.0  0.0     0    0 ?        SW   May16   6:14 [kjournald]
root       696  0.0  0.0     0    0 ?        SW   May16   0:00 [kjournald]
root     16545  0.0  0.0     0    0 ?        SW   11:47   0:00 [pdflush]
root     16551  0.0  0.0     0    0 ?        SW   11:47   0:00 [pdflush]
root     16889  0.0  0.0  3072  744 ?        S    11:59   0:00 minilogd
root     17235  0.0  0.0  2708  444 ttyS0    S    12:00   0:00 init [S]
root     17236  0.0  0.1  3176 1180 ttyS0    S    12:00   0:00 /bin/sh
root     17248  0.0  0.0  2732  748 ttyS0    R    12:07   0:00 ps axu
             total       used       free     shared    buffers     cached
Mem:       1035812     898524     137288          0       3588      16732
-/+ buffers/cache:     878204     157608
Swap:      1049248        788    1048460
sh-2.05b# uptime
 12:13:28 up 35 days,  1:48,  0 users,  load average: 0.00, 0.59, 16.13
sh-2.05b# uname -a
Linux xxxx.example.org 2.6.10-1.12_FC2.marco #1 Mon Feb 7 14:53:42 CET 2005
i686 athlon i386 GNU/Linux

I know this is an old Fedora Core 2 kernel, eventually I'll bring the
issue on thier lists. An upgrade has already been scheduled for this
host, so I'm not really pressed in tracking this specific bug (unless it
occurs on the new system, of course).

Anyway, I just wonder if generally there's a way to find out where those
850+ MBs are allocated. Since there are no big user processes, I'm
assuming it's a memory leak in kernel space. I'm curious, this is the
first time I see something like this. Any suggestion what to look at
besides 'ps' and 'free'?

The server has been mainly running PostgreSQL at a fairly high load for
the last 35 days, BTW.

TIA,
.TM.
-- 
      ____/  ____/   /
     /      /       /                   Marco Colombo
    ___/  ___  /   /                  Technical Manager
   /          /   /                      ESI s.r.l.
 _____/ _____/  _/                      Colombo@ESI.it

