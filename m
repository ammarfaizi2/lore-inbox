Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbSANPmF>; Mon, 14 Jan 2002 10:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSANPl5>; Mon, 14 Jan 2002 10:41:57 -0500
Received: from schizo.hawo.stw.uni-erlangen.de ([131.188.24.10]:47627 "HELO
	schizo.hawo.stw.uni-erlangen.de") by vger.kernel.org with SMTP
	id <S286942AbSANPlp>; Mon, 14 Jan 2002 10:41:45 -0500
Date: Mon, 14 Jan 2002 16:42:00 +0100
From: Stephan Eisvogel <eisvogel-lkml@hawo.stw.uni-erlangen.de>
X-Mailer: The Bat! (v1.53d)
Organization: HAWO Network
X-Priority: 3 (Normal)
Message-ID: <2144085514.20020114164200@hawo.stw.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18pre3+patches stalls machine under heavy NFS load
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, first post.

Summary:
Experiencing machine stalls with 2.4.18pre3 with huge cache when
bonnie is working on mounted NFS over Fast Ethernet.

Full text:
I have the honor to administer two servers running Debian Woody,
hardware is Athlon XP, VIA KT133a, 1.5G RAM, 3ware raid controller
cards and three eepro100 each plus some. The 300G raid of the
first machine is mounted via NFS on the second, it carries /home
for users. Second machine runs a rock-steady and heavily patched
2.2.21pre2, the first runs the same but NFS performance sucks and
creates load 5 when running bonnie on the second.

So I tried 2.4.18pre3 to get a better NFS (v3, UDP load 0.3 with
fully utilized Fast Ethernet) but now the machine is almost dead
in the water, top not responding but vmstat delivers this:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0  42904  30692  39188 1009564   2   4  1621  2169 2599    74   2  15  83

vmstat 1 delivers one line and stalls forever... ssh and other
processes seem to continue but "top" just sits there. stracing
top leaves the trace sitting with:

[...lots of text...]
open("/proc/676/cmdline", O_RDONLY)     = 7
read(7, "top\0", 2047)                  = 4
close(7)                                = 0
getdents64(0x6, 0x80567a0, 0x400, 0)    = 0
close(6)                                = 0
gettimeofday({1011020904, 893442}, {4294967236, 0}) = 0
brk(0x806d000)                          = 0x806d000
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({1, 0}, 

I did apply the following patches to 2.4.17:

  patch-2.4.18-pre3
  00-vm-22
  01-vm-raend-1
  02-truncate-garbage-1
  03-ext3-0.9.17
  10-ide-20011210
  11-irqrate-A1
  12-intr-seq-file
  20-x86-fast-pte-1
  21-spinlock-cacheline-3
  22-smptimers-A0
  23-lowlatency-mini
  24-lowlatency-fixes-4
  30-i2c-2.6.2-20020111
  31-sensors-2.6.2-20020111
  50-bproc-3.1.5
  60-bttv-0.7.87
  61-btaudio-0.7.87
  90-make
  linux-2.4.18-NFS_ALL.dif

I am using gcc-2.91.66. No kernel warnings are visible. Oh, reboot
doesn't work as well, it is also stuck in nanosleep. The first box
has an UPS and the "nut" daemon now only delivers "STALE-DATA"; I
suppose the serial port got stuck with the rest. Trying the same
with Alan's 2.2.21pre2 yields load 5 on the server (nfsd#=16) but
except for sluggish response times and 1/2 or worse throughput for
NFS the kernel keeps going for ages.

Stephan

