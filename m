Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135782AbRD2O3q>; Sun, 29 Apr 2001 10:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135783AbRD2O3g>; Sun, 29 Apr 2001 10:29:36 -0400
Received: from [212.217.140.14] ([212.217.140.14]:22532 "HELO
	Iluvatar.nyren.net") by vger.kernel.org with SMTP
	id <S135782AbRD2O30> convert rfc822-to-8bit; Sun, 29 Apr 2001 10:29:26 -0400
Date: Sun, 29 Apr 2001 16:29:19 +0200 (CEST)
From: Ralf Nyren <ralf@nyren.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.4: Kernel crash, possibly tcp related
Message-ID: <Pine.LNX.4.31.0104291552190.523-100000@HADDOCK.100Mbit.nyren.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

A possibly tcp-related bug causing a kernel crash, possible to trigger
from an unprivileged user.

Kernel 2.4.4, no patches applied.

The problem appeared when performing some network-performance tests with a
program called tcpblast. tcpblast has an option to set its "block size".
The block size is the size of the buffer passed to the write function.
The problem appears when this value is set to 40481 or higher. For ex:
$ tcpblast -d0 -s 40481 another_host 9000
With this block size the following message spammed:
tcp/udpblast send:: No such file or directory
Trying the same command with a 2.2.18 kernel gave:
tcp/udpblast send:: Bad address
The first part is from tcpblast, the second is printed via perror.
  Well, if the machine then has "some" other work running a kernel
crash occurs (note that this only applies to 2.4.4, 2.2.18 didn't
seem to have the problem):

KERNEL: assertion (!skb_queue_empty(&sk->write_queue)) failed at tcp_timer.c(327):
tcp_retransmit_timer
Unable to handle kernel NULL pointer dereference...
.
.
.
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Then the machine is completely locked up, no vt-changing or ctrl->scroll_lock etc
works.


The most efficient way I found to produce "some load" to trigger the bug while running
tcpblast was to use a simple forkbomb:
int main() { while(1) fork(); }

If you need more information, just ask.

regards,
/Ralf Nyrén


System information:

cat /proc/version
Linux version 2.4.4 (plumbum@client2) (gcc version 2.95.2 20000220 (Debian GNU/Linux))
#4 Sat Apr 28 15:47:17 CEST 2001

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 232.349
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips        : 463.66

cat /proc/modules
vfat                    8688   0 (unused)
fat                    30272   0 [vfat]

cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
6400-641f : Intel Corporation 82371AB PIIX4 USB
6800-687f : VIA Technologies, Inc. VT86C100A [Rhine 10/100]
  6800-687f : via-rhine
e000-efff : PCI Bus #01
  e000-e0ff : ATI Technologies Inc 3D Rage LT Pro AGP-133
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-001d160b : Kernel code
  001d160c-0021a957 : Kernel data
a8000000-afffffff : PCI Bus #01
d8000000-dfffffff : PCI Bus #01
  d8000000-d8ffffff : ATI Technologies Inc 3D Rage LT Pro AGP-133
  d9000000-d9000fff : ATI Technologies Inc 3D Rage LT Pro AGP-133
e0000000-e3ffffff : Intel Corporation 440LX/EX - 82443LX/EX Host bridge
e4000000-e4ffffff : 3Dfx Interactive, Inc. Voodoo 2
e5000000-e500007f : VIA Technologies, Inc. VT86C100A [Rhine 10/100]
  e5000000-e500007f : via-rhine
ffff0000-ffffffff : reserved



