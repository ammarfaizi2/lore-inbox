Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRDFJ7x>; Fri, 6 Apr 2001 05:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131426AbRDFJ7o>; Fri, 6 Apr 2001 05:59:44 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:38440 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S131424AbRDFJ73>; Fri, 6 Apr 2001 05:59:29 -0400
Date: Fri, 6 Apr 2001 12:58:43 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: David Weinehall <tao@acc.umu.se>
Cc: linux-kernel@vger.kernel.org
Subject: 2.0.39 stat/inode handling race? [2.0.39 oopses in sys_new(l)stat]
Message-ID: <20010406125843.B8000@niksula.cs.hut.fi>
In-Reply-To: <20010405180927.A8000@niksula.cs.hut.fi> <20010405233445.A28501@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010405233445.A28501@khan.acc.umu.se>; from tao@acc.umu.se on Thu, Apr 05, 2001 at 11:34:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2001 at 11:34:46PM +0200, you [David Weinehall] claimed:
> 
> I'll look into it. A note, however: the additional oops:es that follow
> the first one are almost never ever useful, because the system is no
> longer in a consistent state after the first one.

Apr  5 05:33:35 some kernel: general protection: 0000
Apr  5 05:33:36 some kernel: CPU:    0
Apr  5 05:33:36 some kernel: EIP:    0010:[__iget+60/544]
Apr  5 05:33:36 some kernel: EFLAGS: 00010292
Apr  5 05:33:36 some kernel: eax: 00000341   ebx: 9a0004b6   ecx: 000203e5 edx: 001c7658
Apr  5 05:33:36 some kernel: esi: 001ba164   edi: 00000000   ebp: 001c7658 esp: 06436ef0
Apr  5 05:33:36 some kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Apr  5 05:33:36 some kernel: Process rsync (pid: 15624, process nr: 76, stackpage=06436000)
Apr  5 05:33:36 some kernel: Stack: 05144d00 07ff1418 00000004 03070004 07ff1418 00154f27 001c7658 000203e5
Apr  5 05:33:36 some kernel:        00000001 05144d00 06436f74 06436f74 00000004 0897eaf8 000203e5 0012ce12
Apr  5 05:33:36 some kernel:        05144d00 03070004 00000004 06436f74 00000000 06436f74 06436fb4 bfffdb30
Apr  5 05:33:36 some kernel: Call Trace: [ext2_lookup+343/368]
[lookup+222/248] [_namei+90/228] [lnamei+48/72] [sys_newlstat+41/88]
[system_call+85/124]
Apr  5 05:33:36 some kernel: Code: 66 39 03 75 0d 8b 4c 24 1c 39 4b 04 0f 84 fa 00 00 00 8b 5b

I'm trying to make sense of the oops. Looking at the __iget and ext2_lookup
source, (1) 000203e5 might be the inode number? Is (2) 00000004 the length
of the filename? Looking at the System.map (0012cd34 T lookup), (3) seems to
be the return address to lookup+222, and (4) the return address to
ext2_lookup+343.

Stack: 05144d00 07ff1418 00000004 03070004 07ff1418 00154f27 001c7658 000203e5
                         (2)                        (4)               (1)
       00000001 05144d00 06436f74 06436f74 00000004 0897eaf8 000203e5 0012ce12
                                                                      (3)
       05144d00 03070004 00000004 06436f74 00000000 06436f74 06436fb4 bfffdb30

Inode 132069 is (0x000203e5) is

  File: "./mnt/hdb/backup/backup-versioned/2001-03-10_05.23.01/dev/vcs6"
  Size: 0            Filetype: Character Device
  Mode: (0620/crw--w----)         Uid: ( 1414/  vherva)  Gid: (    5/
tty)
Device:  3,0   Inode: 132069    Links: 30        Device type:  7,0 
Access: Tue May  5 23:32:27 1998(01066.13:15:05)
Modify: Tue May  5 23:32:27 1998(01066.13:15:05)
Change: Fri Apr  6 05:28:24 2001(00000.07:19:08)

At the time of the oops, to heavy stat() callers where running: a cron job
that rsyncs pretty much the whole / to a backup fs (where there are
mutually hardlinked daily snapshots of /) and a cvs checkout that checks out
~20MB of source and then builds it. Rsync runs on root fs and backup fs,
where as the cvs is running only on /. Perhaps there is some kind of race
for example in the inode cache handling? This is of course just a wild
guess... (Note that this is UP, though). It'd be curious, though, that the
race wouldn't have showed up before.

In addition to the instense and concurrent stat()'ing activity, one
noteworthy thing might be that on the backup fs, the inodes are likely to
have quite high link counts. I don't know what it could affect, though.

Any ideas?


-- v --

v@iki.fi
