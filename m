Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKAKkd>; Wed, 1 Nov 2000 05:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbQKAKkX>; Wed, 1 Nov 2000 05:40:23 -0500
Received: from mta03.mail.au.uu.net ([203.2.192.83]:61170 "EHLO
	mta03.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S129057AbQKAKkK>; Wed, 1 Nov 2000 05:40:10 -0500
Date: Wed, 1 Nov 2000 21:39:52 +1100
From: Peter Hawkins <peter@hawkins.emu.id.au>
To: linux-kernel@vger.kernel.org
Subject: ISSUE: infinite fork() kills 2.4.0-test10
Message-ID: <20001101213952.A550@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I am not subscribed to this list at present (subscription is pending approval), so please CC me with replies.

This simple program run as an unprivileged user effectively kills 2.4.0-test10 "Greased weasel":
int main(void)
{
fork();
main();
return 0;
}

Watching a top(1) listing once this program has been started, the load average briefly hits ~560, before the system temporarily ceases responding. After a few seconds, all processes on consoles are killed, and there is an endless spew of:
__alloc_pages: 1-order allocation failed

The system is still responsive to Magic-Sysrq key requests, but login prompts on the console no longer respond (and there is a very large latency, ~10-20 seconds, before characters typed appear on the screen).

The Show Mem stats sysrq command shows:
Mem-info:
Free pages:  480kB (0kB High Mem)
(Active 1125, inactive_dirty: 46, inactive_clean: 2, free: 253 (351 702 1053)
0*4kb, 1*8kB, 1*16kB, 1*32kB, 1*64kB, 0*128kB, 0*256kB, 0*512kB, 0*1024kB, 0*2048kB = 120kB)
225*4kb, 0*8kB, 0*16kB, 0*32kB, 0*64kB, 0*128kB, 0*256kB, 0*512kB, 0*1024kB, 0*2048kB = 842kB)
=0kB)
Swap cache: add 375, delete 288, find 15/73
Free swap: 123668kB
32748 pages of RAM
0 pages of HIGHMEM
969 reserved pages
247518 pages shared
41 pages swap cached
0 buffer pages in page table cache
Buffer memory 168kB

The tasks dump (Alt-Sysrq-T) shows a whole bunch of the offending processes (many screens worth).

Network routing apparently continues to work after this has occurred.

For what it's worth, this is on an AMD Athlon 800 with 128Mb RAM, ~128Mb swap, running Debian (Woody), not many other tasks running at the same time.


Completely unrelated issue:
I can't reproduce it, but while building "gnome-vfs" from today's gnome CVS with "make -j30", at the same time as an endless loop of sync(1) on another console, I caused a very wierd problem where two makefiles somehow became merged. Makefile 1 spontaneously terminated halfway through line 426, and became makefile 2. It was gone on remount (a fsck was clean), which makes me suspect it's a kernel problem. As I say, I can't reproduce it, but I thought I'd sneak this possible bug report in here too.

Please don't abuse me too much if this is common knowledge and I'm merely dredging up old news.

=)
Peter

/proc/version:
Linux version 2.4.0-test10 (peterh@blackhole) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #6 Wed Nov 1 19:19:57 EST 2000

/proc/cpuinfo:
$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 807.000205
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips	: 1608.91

/proc/meminfo (under normal conditions):
total:    used:    free:  shared: buffers:  cached:
Mem:  130273280 115941376 14331904        0  4214784 58978304
Swap: 127954944        0 127954944
MemTotal:       127220 kB
MemFree:         13996 kB
MemShared:           0 kB
Buffers:          4116 kB
Cached:          57596 kB
Active:          23988 kB
Inact_dirty:     37724 kB
Inact_clean:         0 kB
Inact_target:        0 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       127220 kB
LowFree:         13996 kB
SwapTotal:      124956 kB
SwapFree:       124956 kB


/proc/modules:
ppp_deflate            40576   1 (autoclean)
bsd_comp                4224   0 (autoclean)
ppp_async               6448   1 (autoclean)
ppp_generic            16288   3 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    5040   1 (autoclean) [ppp_generic]
ipx                    13424   1 (autoclean)
es1370                 23328   1 (autoclean)
nls_iso8859-1           2880   1 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                   10800   1 (autoclean)
fat                    31584   0 (autoclean) [vfat]
sr_mod                 12128   0 (autoclean) (unused)
cdrom                  27232   0 (autoclean) [sr_mod]
ide-scsi                8240   0 (autoclean)
scsi_mod               87344   2 (autoclean) [sr_mod ide-scsi]
floppy                 46080   0 (autoclean)
serial                 41680   1 (autoclean)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
