Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264209AbRFSMiF>; Tue, 19 Jun 2001 08:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264213AbRFSMhz>; Tue, 19 Jun 2001 08:37:55 -0400
Received: from inway98.cdi.cz ([213.151.81.98]:57070 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S264209AbRFSMhn>;
	Tue, 19 Jun 2001 08:37:43 -0400
Posted-Date: Tue, 19 Jun 2001 14:37:33 +0200
Date: Tue, 19 Jun 2001 14:37:33 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: linux-kernel@vger.kernel.org
Subject: possible deadlock in 2.4.4 sys_getdents ?
Message-ID: <Pine.LNX.4.10.10106191420300.9068-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

after weeks of uptime, 2.4.4 kernel freezed several of
my processes. It seems like deadlock.
I typed "whereis perl" and system got frozen. After quick
look I found that I typed the command while "makedb" script
was running. All processes are on down:
budha:~# ps -A -o pid,cmd,eip,wchan|grep down
 1131 find / /dev/pts  400cd923 down
 5740 ls --color /usr/ 400bb923 down
 5738 whereis perl     400bb79e down

budha:~# ls /proc/1131/fd -l
total 0
lr-x------    1 root     root         64 Jun 19 14:37 0 -> /dev/null
l-wx------    1 root     root         64 Jun 19 14:37 1 -> pipe:[2577]
l-wx------    1 root     root         64 Jun 19 14:37 2 -> pipe:[2558]
lr-x------    1 root     root         64 Jun 19 14:37 3 -> /
lr-x------    1 root     root         64 Jun 19 14:37 4 -> /usr/share/man/man1

Now see strace output of whereis:
5738  getdents(5, /* 0 entries */, 3933) = 0
5738  close(5)                          = 0
5738  stat("/usr/share/man/man1", {st_mode=S_IFDIR|0755, st_size=22528,
...}) = 
0
5738  open("/usr/share/man/man1", O_RDONLY|O_NONBLOCK|0x10000) = 5
5738  fstat(5, {st_mode=S_IFDIR|0755, st_size=22528, ...}) = 0
5738  fcntl(5, F_SETFD, FD_CLOEXEC)     = 0
5738  getdents(5, 

It stops at getdents. I don't know how to trace it further down ..
I have to reboot machine and probably will not be able to simulate
it again. Only it is evident that it is possible to hang it up 
and kill -9 doesn't work (uninteruptible sleep).

I hope this helps improve stability.
devik

