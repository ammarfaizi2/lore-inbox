Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280238AbRKEFke>; Mon, 5 Nov 2001 00:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280245AbRKEFkZ>; Mon, 5 Nov 2001 00:40:25 -0500
Received: from ash.lnxi.com ([207.88.130.242]:33779 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S280238AbRKEFkM>;
	Mon, 5 Nov 2001 00:40:12 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: 2.4.14-pre8 Alt-SysRq-[TM] failure during lockup...
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 04 Nov 2001 22:40:06 -0700
Message-ID: <m3wv15n5c9.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:  I triggered a condition in 2.4.14-pre8 where SysRq triggered
but would not print reports.  I managed to unstick the condition but
had played to much to determine the root cause.  My guess is that
somehow my default loglevel was messed up.  Full information is
provided just case I did not muddy the waters too much.

I accidentily typed mke2fs /dev/hdc instead of mke2fs /dev/hdc6 on 
my machine flinx a few days ago.  So to recover the machine I made up a
boot flopy intially with pre7 (which rebooted while I wasn't in the
room) and then with pre8.  I booted the machine with a read-only nfs
root.  I have been recovering the machine by untaring a multiple
volume tarball stored, on CDs, which I mounted via NFS from my other
machine.  To unmount and remount the CDs I was starting and stopping
the nfs server.

flinx is a 486-DX80 with 32MB of RAM. 1 512MB hard drive /dev/hda 
,1 20GB hard driver /dev/hdc, and 1 ancient IDE-CDRW /dev/hdd.  Also
is attached a NE2000 clone, which I believe is a 10Mbit D-Link card.
The machine has no PCI, just EISA and PCI.  It has been solidly
running linux for the past 5 years.  For the last year and a half it
has been running 2.2.12, until I typo'd.  It has a small swap
partition on /dev/hda and a 1 GB swap partition on /dev/hdc, both of
which I enabled.  

At the time of the lockup the system had been running 2.4.14-pre8 for
about 12 hours, in single user mode.  I had untar approxiamently 9GB
of data over the NFS mount, and was just finishing up.  I stopped the
NFS server and removed the last CD.  The I typed ls on flinx,
attempting to list /dev/hdc2 where I had placed all of the data.  With
the NFS server stop it hung of course.  Then I started the NFS server,
and the machine stayed locked.  I stoped and started it again with no
luck.  

I then tried playing with sysrq and this is where I got worried.
Alt-SysRq-Space gave the menu as normal.
Alt-SysRq-M (showMem) printed just: "SysRq: Show Memory"
Alt-SysRq-T (showTasks) printed just: "Sysrq: Show State"

Which is extremely strange the reports which should be at a higher
loglevel were not displayed.

Then I typoed and pressed. Alt-SysRq-E (tErm) and I started getting the
reports back.  

Also interesting is that Alt-SysRq-S prints:
SysRq : Emergency Sync
Syncing device 16:02 ... OK
Done.

Even after several times of pressing it like the sync really doesn't
happen.  I suppose this could be a strange affect of having the
filesystem mounted read-write though.

By now I have all Alt-SysRq-K (saK) and Alt-SysRq-I (kIll).  So I have
killed off all of my shells.  I had though I had pressed Alt-SysRq-L
(killalL) but that was my confusion.  I don't use SysRq much.  The
result being I doubt my system in a state that is useful for
debugging, but for completeness.

The current output of Alt-SysRq-T (showTasks) lists:
init         D   1
keventd      S   2
ksotirqd_CPU S   3
kswapd       S   4
bdflush      S   5
kupdate      S   6
rpciod       S   7
init         Z   8
rc.sysinit   Z   9
bash         Z  76
bash         Z 270

Mem-info:
Free pages:              26596kB (      0kB HighMem)
Zone: DMA freepages: 13192kB min: 512kB low: 1024kB high: 1536kB
Zone: Normal freepages: 13404kB min: 128kB low: 256kB high: 384kB
Zone: HighMem freepages:     0kb min:  0kb low: 0kb high: 0kb
( Active: 170, inactive: 150, free 6649 )
276*4Kb 267*8kB 196*16Kb 101*32kb 34*64Kb 7*128Kb 0*256kb 1*512kb 0*1024kB 0*1024kb 0*2048kb = 13192kb) 
293*4Kb 249*8kB 204*16Kb 116*32kb 37*64Kb 7*128Kb 0*256kb 0*512kb 0*1024kB 0*1024kb 0*2048kb = 13404kb) 
= 0kb)
Swap cache: add 11552, delete 11429, find 4400/5117, race 0+0
Free Swap:   1050244kb
8192 pages of RAM
0 pages of HIGHMEM
560 reserved pages
158 pages shared
123 pages swap cached
48 pages in page table cache
Buffer memory:   72kB


With tcpdump all I see on the network between my two machines is:
22:12:24.172976 flinx.1618384030 > frodo.nfs: 112 read [|nfs] (DF)
22:12:24.173019 frodo.nfs > flinx.1618384030: reply ok 28 read [|nfs]
22:12:24.174598 flinx.1635161246 > frodo.nfs: 112 read [|nfs] (DF)
22:12:24.174636 frodo.nfs > flinx.1635161246: reply ok 28 read [|nfs]
22:12:24.176419 flinx.1651938462 > frodo.nfs: 112 read [|nfs] (DF)
22:12:24.176445 frodo.nfs > flinx.1651938462: reply ok 28 read [|nfs]
22:12:24.178027 flinx.1668715678 > frodo.nfs: 112 read [|nfs] (DF)
22:12:24.182406 frodo.nfs > flinx.1668715678: reply ok 28 read [|nfs]

and ping works.

With Alt-Sys-P (ShowPc) the pids cycle through:
Pid 1: init
Pid 7: rpciod
Pid 0: ``swapper'' but really the idle task.


And finally Alt-SysRq-L (killalL) instead of panicing the kernel
Locked it up so that Alt-SysRq functions and the machine is now
completely unresponsive.

Eric
