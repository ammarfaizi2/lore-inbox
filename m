Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRC1XK5>; Wed, 28 Mar 2001 18:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132602AbRC1XKt>; Wed, 28 Mar 2001 18:10:49 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:29764 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S132596AbRC1XKg>;
	Wed, 28 Mar 2001 18:10:36 -0500
Date: Wed, 28 Mar 2001 17:08:36 -0600 (CST)
From: Paul Cassella <pwc@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Hangs under 2.4.2-ac{18,19,24} that do not happen under -ac12.
Message-ID: <Pine.SGI.3.96.1010328165432.10707A-100000@fsgi626.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

Hangs under 2.4.2-ac{18,19,24} that do not happen under -ac12.

[2.] Full description of the problem/report:

I have had hangs under 2.4.2-ac18, -ac19, and -ac24, after uptimes of
36 hours, 12 hours, and 10 hours, respectively.  -ac12 has twice run
for a week without crashing.  I didn't see anything in the later -ac
changelogs that looks responsible, but I haven't actually tried them.

All the crashes were under X.  The machine did not respond to pings,
and no sysrq keys other than B worked; I didn't hear disk activity
after S, and the disks weren't unmounted.  Nothing made it to the
logs.  In the -ac19 crash, I had run at the console for about 12
hours, and then started X; it crashed within 15 minutes.

In the one crash that happened while I was at the console, X
completely froze, and sound output stopped.  In the others, the
monitor was in power-save mode and didn't wake up.

The hangs don't appear to be related to IO load or anything else I can
think of besides X.  Each time, there was a distributed.net client
running, and nothing else that was in any way intensive.  I don't
believe any sort of updatedb or makewhatis was running during the
crashes, and it never hung overnight when these jobs run.


I ran with -ac12 with nearly 1300 lines of diff narrowed down from
"interdiff -h ac12 ac18" for about 36 hours in console mode; it hung
within 3 hours of starting X.

When I get home and reboot (following this most recent hang :( ), I'll
put the diff, .config, and more stuff from /proc at

  http://manetheren.eigenray.com/~fortytwo/crash-12-18.2

This should be sometime around 8PM CST.  (If someone wants the diff
now, email me.  I have it here, but I don't want to spam the list with
it.)

This diff wasn't "complete"; some modules (ide-cd, at least) weren't
able to load due to missing symbols.


The diff included all the changes referencing bust_spinlocks(), and
everything to do with the console_sem and the console tasklet/tq.  This
included all the changes to printk.c. 

It also included the following.  In -ac18, this is a BUG(), not a
printk(), but I wanted something I could see while X was running.  The
message never showed up.  I didn't look to see what the effect of
returning -1 here is, though.


diff -u linux.ac/kernel/pm.c linux.ac/kernel/pm.c
--- linux.ac/kernel/pm.c
+++ linux.ac/kernel/pm.c
@@ -150,6 +154,10 @@
 {
 	int status = 0;
 	int prev_state, next_state;
+
+	if (in_interrupt())
+		{printk("pm_send called from interrupt (0x%p)!\n", __builtin_return_address(0)); return -1; }
+
 	switch (rqst) {
 	case PM_SUSPEND:
 	case PM_RESUME:

AFAICT there was nothing else in the diff.


[7.1.] Software (add the output of the ver_linux script here)

Linux manetheren 2.4.2-ac12 #8 Mon Mar 5 20:02:30 CST 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.11.90.0.1
util-linux             2.11a
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.59
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         usb-uhci parport_pc lp parport binfmt_misc rtc usbcore

Since I didn't think to copy my .config off the machine, I won't be
able to get to it until tonight.  In the meantime, I do remember that

- It's a UP kernel on a UP box
- Celeron kernel and processor
- The hang happens with USB completely disabled
   (Though I don't think I ever turned off hotplugging.)
- VTs, console on VT, and console on serial configured
   (console was not on serial)
- i810, (Debian unstable) X 4.0.2, with DRI
- PIIX tuning enabled
- Auto-DMA
- No kernel debugging other than SysRq
- No SCSI
- APM was off; don't remember the other pm stuff.
- ecn was on, syncookies off.
- no ip masquerading or firewalling or anything fancy.
- 128M RAM; no HIGHMEM stuff.


I'll be happy to try out patches, configuration changes, and other
suggestions, but I won't be able to tell for three or four days
whether or not it helped.


[7.2.] Processor information (from /proc/cpuinfo):

Single processor,
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino) (466Mhz/66Mhz FSB)
stepping        : 5
cpu MHz         : 465.265
cache size      : 128 KB


[7.3.] Module information (from /proc/modules):

The modules loaded at the -ac24 crash appear to have been

visor                   8400   1
usbserial              17488   1 [visor]
parport_pc             18480   1 (autoclean)
lp                      6096   1 (autoclean)
parport                24704   1 (autoclean) [parport_pc lp]
uhci                   21920   0 (unused)
binfmt_misc             5600   0
rtc                     5056   0 (autoclean)
usbcore                50480   1 (autoclean) [visor usbserial uhci]

from Debian's /var/log/ksymoops

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

Under plain -ac12:

manetheren:/var/log/ksymoops# cat /proc/ioports 
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
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
  d800-d8ff : Lite-On Communications Inc LNE100TX
    d800-d8ff : eth0
  df00-df3f : Ensoniq ES1371 [AudioPCI-97]
    df00-df3f : es1371
ef80-ef9f : Intel Corporation 82801AA USB
  ef80-ef9f : usb-uhci
efa0-efaf : Intel Corporation 82801AA SMBus
ffa0-ffaf : Intel Corporation 82801AA IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
manetheren:/var/log/ksymoops# cat /proc/iomem   
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ebffff : System RAM
  00100000-001cd2c5 : Kernel code
  001cd2c6-0020c2ff : Kernel data
07ec0000-07ef7fff : ACPI Tables
07ef8000-07efffff : ACPI Non-volatile Storage
f6a00000-f6afffff : PCI Bus #01
f8000000-fbffffff : Intel Corporation 82810-DC100 CGC [Chipset Graphics Controller]
ff800000-ff8fffff : PCI Bus #01
  ff8ffc00-ff8ffcff : Lite-On Communications Inc LNE100TX
    ff8ffc00-ff8ffcff : eth0
ffa80000-ffafffff : Intel Corporation 82810-DC100 CGC [Chipset Graphics Controller]
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
manetheren:/var/log/ksymoops# lspci -vvv
00:00.0 Host bridge: Intel Corporation 82810-DC100 GMCH [Graphics Memory Controller Hub] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0

00:01.0 VGA compatible controller: Intel Corporation 82810-DC100 CGC [Chipset Graphics Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Intel Corporation: Unknown device 4341
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff800000-ff8fffff
        Prefetchable memory behind bridge: f6a00000-f6afffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
        Subsystem: Intel Corporation 82801AA IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801AA USB
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at ef80 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
        Subsystem: Intel Corporation 82801AA SMBus
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at efa0 [size=16]

01:08.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at ff8ffc00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at ff880000 [disabled] [size=256K]

01:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at df00 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



BTW (and this isn't related to my crash because I didn't include this in
my diff) I noticed this in the difference between -ac12 and -ac18 (and I
believe it's still like this in -ac24):

diff -u linux.ac/mm/memory.c linux.ac/mm/memory.c
--- linux.ac/mm/memory.c
+++ linux.ac/mm/memory.c
@@ -978,7 +978,12 @@
        }
        inode->i_size = offset;
        if (inode->i_op && inode->i_op->truncate)
+       {
+               /* This doesnt scale but it is meant to be a 2.4 invariant */
+               lock_kernel();
                inode->i_op->truncate(inode);
+               unlock_kernel();
+       }
        return 0;
 out:
        return -EFBIG;


A few lines earlier in this function, inode->i_op->truncate() is called
without lock_kernel().  Should it also have a lock_kernel(), or is it not
needed there? 

-- 
Paul Cassella

