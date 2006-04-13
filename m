Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWDMBp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWDMBp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 21:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWDMBp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 21:45:56 -0400
Received: from gateway0.EECS.Berkeley.EDU ([169.229.60.93]:29357 "EHLO
	gateway0.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932423AbWDMBpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 21:45:55 -0400
Message-Id: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.5.6
Date: Wed, 12 Apr 2006 18:45:28 -0700
To: linux-kernel@vger.kernel.org
From: Dan Bonachea <bonachead@comcast.net>
Subject: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi - I believe I've discovered a thread-safety bug in the Linux 2.6.x kernel 
implementation of write(2).

The small C program below the problem - in a nutshell, if multiple threads 
write() to STDOUT_FILENO, and stdout has been redirected to a file, then some 
of the output lines get lost. The actual result is non-deterministic (even in 
a "correct" run) - however the expected correct behavior is 10 lines of output 
(in some non-deterministic order). However, the test program reproducibly 
generates some lost output (less than 10 lines of total output) on every run 
where the output is redirected to a new file. This appears to be a violation 
of the POSIX spec (POSIX 1003.1-2001:2.9.1 requires thread-safety of write()). 


The problem does not appear to occur if output goes to the console, or is 
redirected to append to an existing file, only when stdout is redirected to a 
new file.

---------------------------------------------------------------------------
/* Instructions:
  * compile as: gcc write-bug.c -lpthread
  * run with: ./a.out
  *   note that lines from all 10 threads are visible
  * run with: ./a.out > output
  *   note that lines from several threads are missing from the output file
  */
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
volatile int flag = 0;
void *start(void *arg) {
   char msg[255];
   int res;
   sprintf(msg,"hi from %i\n",(int)arg);
   if ((int)arg == 9) flag = 1;
   while (!flag) ; /* thread barrier */
   #if 1
     res = write(STDOUT_FILENO,msg,strlen(msg));
     if (res != strlen(msg)) fprintf(stderr,"Failure: %i 
%s\n",res,strerror(res));
   #else
     fputs(msg,stdout);
   #endif
   #if 1 /* work extra hard to flush output (makes no difference) */
     fflush(NULL);
     fsync(STDOUT_FILENO);
     sync();
   #endif
   return NULL;
}
int main() {
   int i;
   /* create 10 pthreads */
   pthread_t id[10];
   for (i =0 ; i < 10; i++) {
     int ret = pthread_create(&(id[i]),NULL,&start,(void*)i);
     if (ret) printf("pthread_create: %s\n",strerror(ret));
   }
   /* join 10 pthreads */
   for (i =0 ; i < 10; i++) {
     pthread_join(id[i], NULL);
   }
   sleep(1);
   return 0;
}
---------------------------------------------------------------------------

The problem occurs on every Linux 2.6 machine I've tried, including ones with 
Itanium-2, Athlon, Opteron and Pentium 4 chips, both SMP's and uniprocessors, 
using a variety of recent gcc versions. The problem does *not* appear to occur 
on any Linux 2.4 machine I've tried, even if I use the same executable which 
fails on the Linux 2.6 machine. Finally, replacing write(STDOUT_FILENO) with 
fputs(stdout) makes the problem disappear (presumably due to locking in libc).

I don't have administrative access to upgrade the kernel on these machines, 
however below is the full machine info for the most recent installed kernel 
version I have access to.

Any suggestions are appreciated.
Thanks,
Dan

# gcc --version
gcc (GCC) 3.4.4 20050721 (Red Hat 3.4.4-2)
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# cat /proc/version
Linux version 2.6.12-1.1376_FC3smp (bhcompile@tweety.build.redhat.com) (gcc 
version 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 SMP Fri Aug 26 23:50:33 EDT 2005
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2395.041
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4734.97

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2395.041
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4784.12
# cat /proc/modules
ipt_multiport 6465 2 - Live 0xe0a1d000
ipt_ULOG 11973 6 - Live 0xe0aff000
ipt_REJECT 9537 5 - Live 0xe0b03000
ipt_limit 6465 7 - Live 0xe0a2c000
ipt_state 5825 9 - Live 0xe0a20000
ip_conntrack 46249 1 ipt_state, Live 0xe0b54000
iptable_filter 6849 1 - Live 0xe09e3000
ip_tables 25025 6 
ipt_multiport,ipt_ULOG,ipt_REJECT,ipt_limit,ipt_state,iptable_filter, Live 
0xe0b3d000
parport_pc 30981 1 - Live 0xe0b0b000
lp 16713 0 - Live 0xe0a23000
parport 38793 2 parport_pc,lp, Live 0xe0af4000
autofs4 22725 11 - Live 0xe09ed000
nfs 196745 7 - Live 0xe0b77000
lockd 64745 2 nfs, Live 0xe09fa000
sunrpc 138629 3 nfs,lockd, Live 0xe0b1a000
dm_mod 59109 0 - Live 0xe0a0d000
video 19653 0 - Live 0xe09f4000
button 8001 0 - Live 0xe09aa000
battery 13253 0 - Live 0xe09e8000
ac 8773 0 - Live 0xe09a6000
md5 8001 1 - Live 0xe099d000
ipv6 262913 20 - Live 0xe0a30000
uhci_hcd 35665 0 - Live 0xe09d9000
ehci_hcd 37709 0 - Live 0xe0965000
hw_random 9429 0 - Live 0xe0961000
i2c_i801 12493 0 - Live 0xe089b000
i2c_core 25025 1 i2c_i801, Live 0xe0991000
snd_intel8x0 35585 0 - Live 0xe0935000
snd_ac97_codec 77497 1 snd_intel8x0, Live 0xe09c5000
snd_pcm_oss 53745 0 - Live 0xe090a000
snd_mixer_oss 21697 1 snd_pcm_oss, Live 0xe0894000
snd_pcm 91845 3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live 0xe09ad000
snd_timer 28357 1 snd_pcm, Live 0xe0861000
snd 58405 6 
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, Live 
0xe08fa000
soundcore 13217 1 snd, Live 0xe087a000
snd_page_alloc 13765 2 snd_intel8x0,snd_pcm, Live 0xe0875000
e1000 105517 0 - Live 0xe091a000
ext3 131529 2 - Live 0xe08d8000
jbd 61913 1 ext3, Live 0xe08a0000
ata_piix 13381 0 - Live 0xe0870000
libata 49093 1 ata_piix, Live 0xe087f000
sd_mod 22721 0 - Live 0xe0869000
scsi_mod 135561 2 libata,sd_mod, Live 0xe081a000
# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0800-087f : 0000:00:1f.0
   0800-0803 : PM1a_EVT_BLK
   0804-0805 : PM1a_CNT_BLK
   0808-080b : PM_TMR
   0810-0815 : ACPI CPU throttle
   0828-082f : GPE0_BLK
0880-08bf : 0000:00:1f.0
0c00-0c7f : pnp 00:0a
0cf8-0cff : PCI conf1
df40-df7f : 0000:02:0c.0
   df40-df7f : e1000
eda0-edbf : 0000:00:1f.3
   eda0-edaf : i801-smbus
edc0-edff : 0000:00:1f.5
   edc0-edff : Intel ICH5
ee00-eeff : 0000:00:1f.5
   ee00-eeff : Intel ICH5
fe00-fe07 : 0000:00:1f.2
   fe00-fe07 : libata
fe10-fe13 : 0000:00:1f.2
   fe10-fe13 : libata
fe20-fe27 : 0000:00:1f.2
   fe20-fe27 : libata
fe30-fe33 : 0000:00:1f.2
   fe30-fe33 : libata
fea0-feaf : 0000:00:1f.2
   fea0-feaf : libata
ff20-ff3f : 0000:00:1d.3
   ff20-ff3f : uhci_hcd
ff40-ff5f : 0000:00:1d.2
   ff40-ff5f : uhci_hcd
ff60-ff7f : 0000:00:1d.1
   ff60-ff7f : uhci_hcd
ff80-ff9f : 0000:00:1d.0
   ff80-ff9f : uhci_hcd
ffa0-ffaf : 0000:00:1f.1
   ffa0-ffa7 : ide0
   ffa8-ffaf : ide1
# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000cf800-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ff73fff : System RAM
   00100000-003027ae : Kernel code
   003027af-003c2b7f : Kernel data
1ff74000-1ff75fff : ACPI Non-volatile Storage
1ff76000-1ff96fff : ACPI Tables
1ff97000-1fffffff : reserved
e8000000-efffffff : 0000:00:00.0
f0000000-f7ffffff : PCI Bus #01
   f0000000-f7ffffff : 0000:01:00.0
fcfe0000-fcffffff : 0000:02:0c.0
   fcfe0000-fcffffff : e1000
fd000000-feafffff : PCI Bus #01
   fd000000-fdffffff : 0000:01:00.0
febff900-febff9ff : 0000:00:1f.5
   febff900-febff9ff : Intel ICH5
febffa00-febffbff : 0000:00:1f.5
   febffa00-febffbff : Intel ICH5
febffc00-febfffff : 0000:00:1f.1
fec00000-fec0ffff : reserved
fecf0000-fecf0fff : reserved
fed20000-fed8ffff : reserved
fee00000-fee0ffff : reserved
ffa80800-ffa80bff : 0000:00:1d.7
   ffa80800-ffa80bff : ehci_hcd
ffb00000-ffffffff : reserved
# cat /proc/scsi/scsi
Attached devices:
# lspci -vvv
00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub (rev 
02)
         Subsystem: Dell: Unknown device 0156
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
         Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP Controller (rev 
02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fd000000-feafffff
         Prefetchable memory behind bridge: f0000000-f7ffffff
         Secondary status: 66Mhz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #1 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Dell: Unknown device 0156
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 193
         Region 4: I/O ports at ff80 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #2 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Dell: Unknown device 0156
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 201
         Region 4: I/O ports at ff60 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3 
(rev 02) (prog-if 00 [UHCI])
         Subsystem: Dell: Unknown device 0156
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 169
         Region 4: I/O ports at ff40 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #4 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Dell: Unknown device 0156
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 193
         Region 4: I/O ports at ff20 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02) (prog-if 20 [EHCI])
         Subsystem: Dell: Unknown device 0156
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 185
         Region 0: Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
         Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00 
[Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fcf00000-fcffffff
         Prefetchable memory behind bridge: fff00000-000fffff
         Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface 
Bridge (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE 
Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: Dell: Unknown device 0156
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 169
         Region 0: I/O ports at <ignored>
         Region 1: I/O ports at <ignored>
         Region 2: I/O ports at <ignored>
         Region 3: I/O ports at <ignored>
         Region 4: I/O ports at ffa0 [size=16]
         Region 5: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 
02) (prog-if 8f [Master SecP SecO PriP PriO])
         Subsystem: Dell: Unknown device 0156
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 169
         Region 0: I/O ports at fe00 [size=8]
         Region 1: I/O ports at fe10 [size=4]
         Region 2: I/O ports at fe20 [size=8]
         Region 3: I/O ports at fe30 [size=4]
         Region 4: I/O ports at fea0 [size=16]

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 
02)
         Subsystem: Dell: Unknown device 0156
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 10
         Region 4: I/O ports at eda0 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) 
AC'97 Audio Controller (rev 02)
         Subsystem: Dell: Unknown device 0156
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 177
         Region 0: I/O ports at ee00 [size=256]
         Region 1: I/O ports at edc0 [size=64]
         Region 2: Memory at febffa00 (32-bit, non-prefetchable) [size=512]
         Region 3: Memory at febff900 (32-bit, non-prefetchable) [size=256]
         Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV34GL [Quadro FX 
500/600 PCI] (rev a1) (prog-if 00 [VGA])
         Subsystem: nVidia Corporation: Unknown device 01ba
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at fea00000 [disabled] [size=128K]
         Capabilities: <available only to root>

02:0c.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet 
Controller (rev 02)
         Subsystem: Dell: Unknown device 0156
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (63750ns min), Cache Line Size 10
         Interrupt: pin A routed to IRQ 169
         Region 0: Memory at fcfe0000 (32-bit, non-prefetchable) [size=128K]
         Region 2: I/O ports at df40 [size=64]
         Capabilities: <available only to root>

# 

