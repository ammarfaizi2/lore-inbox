Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTJTMfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 08:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbTJTMfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 08:35:40 -0400
Received: from as7-4-3.ehn.lk.bonet.se ([217.215.90.41]:50444 "EHLO
	mulder.hem.za.org") by vger.kernel.org with ESMTP id S262556AbTJTMfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 08:35:13 -0400
Date: Mon, 20 Oct 2003 14:35:10 +0200
From: Mikael Magnusson <mikaelmagnusson@tjohoo.se>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8: lockd fails for non-root users
Message-ID: <20031020123510.GA2954@skinner.hem.za.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Summary:
2.6.0-test8: lockd fails for non-root users

2. Description:
When running 2.6.0-test8 I have problems with file locks on nfs mounted
file-systems. When trying to create a file lock as an ordinary non-root user,
I get the following errors:

RPC: Can't bind to reserved port (13).
RPC: can't bind to reserved port.
lockd: cannot monitor 192.168.0.1
lockd: failed to monitor 192.168.0.1

3. Keywords:
nfs, lockd, portmap

4. Kernel version:
2.6.0-test8

5. Oops:
no oops

6. Testscript:
Compile and run as non-root user on nfs mounted filesystem:

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main (int argc, char **argv)
{
  FILE *k;
  struct flock fl;

  k = fopen ("testlock", "a+");

  if (!k) {
    printf ("Unable to open testlock\n");
    exit (0);
  }

  fl.l_type = F_RDLCK;
  fl.l_whence = 0;
  fl.l_start = 0;
  fl.l_len = 0;

  if ((fcntl (fileno(k), F_SETLK, &fl)) == -1) {
    printf ("Unable to get lock for testlock\n");
    exit (0);
  }

  fclose (k);
  return 0;
}

7.1 sh scripts/ver_linux output:
Linux skinner 2.6.0-test8-dmv1 #1 Mon Oct 20 01:12:05 CEST 2003 i686 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre2
e2fsprogs              1.35-WIP
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         md5 ipv6 nfsd exportfs autofs snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_via82xx snd_mpu401_uart snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd ov511 nfs lockd sunrpc af_packet uhci_hcd ohci_hcd ehci_hcd
nls_utf8 nls_cp437 tuner tvaudio bttv video_buf i2c_algo_bit btcx_risc v4l2_common videodev soundcore w83781d i2c_sensor i2c_core 8139too mii crc32 hid scanner

7.2 cat /proc/cpuinfo output:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 4
cpu MHz         : 1336.706
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2629.63

7.3 cat /proc/modules output:
md5 4032 1 - Live 0xd0a4f000
ipv6 255616 8 - Live 0xd0d0b000
nfsd 102768 8 - Live 0xd0ca6000
exportfs 6592 1 nfsd, Live 0xd0b1b000
autofs 17216 1 - Live 0xd0c82000
snd_seq_midi 8416 0 - Live 0xd0c4f000
snd_emu10k1_synth 7744 0 - Live 0xd0c4c000
snd_emux_synth 37504 1 snd_emu10k1_synth, Live 0xd0c77000
snd_seq_virmidi 7552 1 snd_emux_synth, Live 0xd0c49000
snd_seq_midi_emul 7936 1 snd_emux_synth, Live 0xd0b52000
snd_seq_oss 34560 0 - Live 0xd0ac0000
snd_seq_midi_event 7872 3 snd_seq_midi,snd_seq_virmidi,snd_seq_oss, Live 0xd0a51000
snd_seq 55376 8 snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_oss,snd_seq_midi_event, Live 0xd0c68000
snd_pcm_oss 53028 0 - Live 0xd0c5a000
snd_mixer_oss 19136 1 snd_pcm_oss, Live 0xd0aba000
snd_via82xx 25184 0 - Live 0xd0b4a000
snd_mpu401_uart 7744 1 snd_via82xx, Live 0xd0a36000
snd_emu10k1 95684 1 snd_emu10k1_synth, Live 0xd0b55000
snd_rawmidi 25056 4 snd_seq_midi,snd_seq_virmidi,snd_mpu401_uart,snd_emu10k1, Live 0xd0b02000
snd_pcm 98404 3 snd_pcm_oss,snd_via82xx,snd_emu10k1, Live 0xd0b1f000
snd_timer 25412 2 snd_seq,snd_pcm, Live 0xd0afa000
snd_seq_device 8136 7 snd_seq_midi,snd_emu10k1_synth,snd_emux_synth,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi, Live 0xd0a2c000
snd_ac97_codec 54084 2 snd_via82xx,snd_emu10k1, Live 0xd0a68000
snd_page_alloc 11716 3 snd_via82xx,snd_emu10k1,snd_pcm, Live 0xd0a64000
snd_util_mem 4416 2 snd_emux_synth,snd_emu10k1, Live 0xd0a39000
snd_hwdep 9504 1 snd_emu10k1, Live 0xd0a49000
snd 51044 18 snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_mpu401_uart,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, Live 0xd0aac000
ov511 83996 0 - Live 0xd0ae4000
nfs 100912 2 - Live 0xd0aca000
lockd 64944 3 nfsd,nfs, Live 0xd0a78000
sunrpc 133896 8 nfsd,nfs,lockd, Live 0xd0a8a000
af_packet 21768 2 - Live 0xd0a5d000
uhci_hcd 32336 0 - Live 0xd0a54000
ohci_hcd 18368 0 - Live 0xd0a43000
ehci_hcd 24452 0 - Live 0xd0a3c000
nls_utf8 1984 1 - Live 0xd0a32000
nls_cp437 5632 1 - Live 0xd0a2f000
tuner 15372 0 - Live 0xd089e000
tvaudio 21964 0 - Live 0xd08a6000
bttv 136492 0 - Live 0xd08bf000
video_buf 22212 1 bttv, Live 0xd0897000
i2c_algo_bit 10184 1 bttv, Live 0xd0881000
btcx_risc 4808 1 bttv, Live 0xd0866000
v4l2_common 4608 1 bttv, Live 0xd0845000
videodev 9792 2 ov511,bttv, Live 0xd087d000
soundcore 9472 2 snd,bttv, Live 0xd0879000
w83781d 35456 0 - Live 0xd0885000
i2c_sensor 2944 1 w83781d, Live 0xd0861000
i2c_core 25288 6 tuner,tvaudio,bttv,i2c_algo_bit,w83781d,i2c_sensor, Live 0xd0871000
8139too 24256 0 - Live 0xd086a000
mii 5184 1 8139too, Live 0xd084b000
crc32 4352 1 8139too, Live 0xd0848000
hid 32896 0 - Live 0xd0857000
scanner 22404 0 - Live 0xd0850000

7.4 cat /proc/ioports /proc/iomem output:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
d000-d0ff : 0000:00:09.0
  d000-d0ff : 8139too
d400-d41f : 0000:00:0a.0
  d400-d41f : EMU10K1
d800-d807 : 0000:00:0a.1
dc00-dc0f : 0000:00:11.1
  dc00-dc07 : ide0
  dc08-dc0f : ide1
e000-e01f : 0000:00:11.2
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:11.3
  e400-e41f : uhci_hcd
e800-e81f : 0000:00:11.4
  e800-e81f : uhci_hcd
ec00-ecff : 0000:00:11.5
  ec00-ecff : VIA8233
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002d5d89 : Kernel code
  002d5d8a-0039553f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
e0000000-e1ffffff : PCI Bus #01
  e0000000-e0ffffff : 0000:01:00.0
e2000000-e20000ff : 0000:00:09.0
  e2000000-e20000ff : 8139too
e2001000-e2001fff : 0000:00:0b.0
  e2001000-e2001fff : bttv0
e2002000-e2002fff : 0000:00:0b.1
e2003000-e2003fff : 0000:00:0c.0
  e2003000-e2003fff : ohci_hcd
ffff0000-ffffffff : reserved

7.5 lspci -vvv output:
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Surecom Technology EP-320X-R
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at e2000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d400 [size=32]
	Capabilities: <available only to root>

00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at d800 [size=8]
	Capabilities: <available only to root>

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at e2001000 (32-bit, prefetchable) [size=4K]

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at e2002000 (32-bit, prefetchable) [size=4K]

00:0c.0 USB Controller: Lucent Microelectronics USS-312 USB Controller (rev 10) (prog-if 10 [OHCI])
	Subsystem: Lucent Microelectronics USS-312 USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e2003000 (32-bit, non-prefetchable) [size=4K]

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at dc00 [size=16]
	Capabilities: <available only to root>

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at e000 [size=32]
	Capabilities: <available only to root>

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at e400 [size=32]
	Capabilities: <available only to root>

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at e800 [size=32]
	Capabilities: <available only to root>

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 30)
	Subsystem: Unknown device 1695:3004
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at ec00 [size=256]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

7.6 cat /proc/scsi/scsi output:
cat: /proc/scsi/scsi: No such file or directory

7.7 
$ cat /proc/sys/sunrpc/nfsd_debug
0
$ cat /proc/sys/sunrpc/nfs_debug
0
$ cat /proc/sys/sunrpc/nlm_debug
0
$ cat /proc/sys/sunrpc/rpc_debug
0
$ cat /proc/net/rpc/nfs
net 0 0 0 0
rpc 562 0 0
proc2 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
proc3 22 0 146 18 166 136 2 14 27 3 0 2 0 0 0 0 0 0 25 0 2 0 21

$ sudo cat /proc/net/rpc/nfsd
rc 0 0 1
fh 0 0 0 0 0
io 0 0
th 8 0 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000
ra 16 0 0 0 0 0 0 0 0 0 0 0
net 1 1 0 0
rpc 1 0 0 0 0
proc2 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
proc3 22 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Dpkg -l portmap nfs-common nfs-kernel-server outputs:

The client is running Debian testing/unstable
ii  portmap        5-2.1          The RPC portmapper
ii  nfs-common     1.0.5-3        NFS support files common to client and serve
ii  nfs-kernel-ser 1.0.5-3        Kernel NFS server support

The server is running Debian stable
ii  portmap        5-2            The RPC portmapper
ii  nfs-common     1.0-2woody1    NFS support files common to client and serve
ii  nfs-kernel-ser 1.0-2woody1    Kernel NFS server support

8. Workarounds:

A workaround that I have found is to first create a lock running as root.
After that nfs file locks works for non root users too.

Mikael Magnusson
