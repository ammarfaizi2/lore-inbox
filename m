Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUAFNDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 08:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUAFNCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 08:02:45 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:61970 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264353AbUAFNCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 08:02:34 -0500
Date: Tue, 6 Jan 2004 15:00:44 +0100
From: Bauke Jan Douma <bjdouma@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: TSC cannot be used as a timesource -> SOLVED
Message-ID: <20040106140044.GA944@sagittarius.unix9.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Disclaimer: your mileage may vary
X-Operating-System: Linux 2.4.20
Organization: A training zoo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

First part of this message is somewhat of a FYI, second an issue that
troubles me, and which I don't know if it may be related to the first.

First
-----
Until today I had my Linux system running on an old 1.7Gb /dev/hda and a
newer 20Gb /dev/hdb.  Because the 1.7Gb was extremely unreliable with
DMA (established a long time ago), I always had it off for that disk;
the 20Gb disk had DMA on (udma4).

Kernel in recent months has always been the current 2.6.0-testNN and
since its release, kernel 2.6.0

With the 2.6 kernels (and possibly with late 2.5 versions too?) I would
always get the mystifying:

  Losing too many ticks!
  TSC cannot be used as a timesource. (Are you running with SpeedStep?)
  Falling back to a sane timesource.

during the boot-up, right at the point it seems where a standard e2fsck
is run.

Today I installed a new 80Gb harddisk, making the 20Gb /dev/hda and
the 80Gb /dev/hdb, and junking the 1.7Gb.  Both have DMA enabled (udma5).

It seems the TSC problem has vanished, no more such messages -- knock on
wood.

FYI, I have an ASUS P4PE motherboard with Intel 2.4GHz, here's lspci
and /proc/cpu:

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440SE AGP 8x] (rev a2)
02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
02:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping	: 7
cpu MHz		: 2406.215
cache size	: 512 KB
physical id	: 0
siblings	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4751.36

Anyone who wants more info, let me know and I'll be glad to provide.


Second
------
In order to use my new 80Gb harddisk, I first installed it alongside
the two 'old' disks, as /dev/hdc, so as to be able to move ca. 16Gb of
data from the 20Gb to the 80Gb.  So I temporarily had:
hda: 1.7Gb / no dma
hdb: 20Gb / udma4
hdc: 80Gb / udma5

Now here's what happened: during the one foul swoop 'cp -axvp *' from
the 20Gb HD to the 80Gb HD, at two times the copying process seemed
to 'hang' for ca. 10-15 minutes (at least there were two times I noticed),
the copy being in a 'D' state (uninterruptable sleep).

By the time the cp was finally finished (could be ~1.5 hr later wall clock
time!), the system clock was running behind ca. 45 minutes!

The same odd behaviour was noticed some time later when I copied a small
2Gb from the 20Gb HD to the 80Gb HD.  During that copy, the system clock
ran behind ca. 10 minutes.

I had no other major apps running at the time, other than a TV program
running in an xawtv window through my Pinnacle PCTV Pro TV-card, which
doesn't affect system load much (might as well enjoy the time, I thought).
Nothing else.

What I /did/ have was a redirect of stdout/stderr of the 'cp' process on
both occasions (quite verbose), to a file on the 1.7Gb HD, which rose to
about 36Mb for the first copy.
So all three HD's were accessed continuously during both copies.

After bootup, the system time was in sync with wall-clock time again.

I was and am running Linux-2.6.0.

So, is this a problem with this kernel version?  May it be caused by the
differing DMA for ide0 (no dma for the old 1.7Gb HD and udma5 for the
20Gb HD)?  Or be related to the now seemingly gone TSC pain-in-the-a**?
Anything else?

I have my 20Gb and 80Gb up and running now --and smoothly at that, it
seems--, the 1.7Gb is out, and I'll keep an eye on this problem (will
do some tests tomorrow), but meanwhile I'd thought I'd just throw it
in there.

Thanks for your time.

BJ


-- 
 typos hapen
