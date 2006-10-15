Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWJOR5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWJOR5T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWJOR5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 13:57:19 -0400
Received: from h8922032063.dsl.speedlinq.nl ([89.220.32.63]:33746 "EHLO
	jumbo.lan") by vger.kernel.org with ESMTP id S1422654AbWJOR5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 13:57:18 -0400
Date: Sun, 15 Oct 2006 19:56:40 +0200
From: "Dennis J.A. Bijwaard" <dennis@h8922032063.dsl.speedlinq.nl>
To: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
Cc: linux-kernel@vger.kernel.org
Subject: BUG: soft lockup detected on CPU#0! in sys_close and ext3
Message-ID: <20061015175640.GA3673@jumbo.lan>
Reply-To: bijwaard@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ext3 kernel maintainers,

I got two soft lockups on one of the CPUs just now. I'm unsure if this
problem is in ext3, sys_close, or general kernel, so I've CC'd the
kernel list.

[1.] One line summary of the problem:

BUG: soft lockup detected on CPU#0! in sys_close/fput and ext3 journaling

[2.] Full description of the problem/report:

First lockup was in syscall sys_close fput, second was in ext3 journal code.

No problems were noticed after the first lockup, except slower responsiveness.
There was a number of hours between the two lockups. 

The second lockup occured during or shortly after unauthoring a dvd, which 
was mounted via a loop device. 

Only the mouse was moving after the second lockup. Sysrq wsa working, 
I could remotely log in and sync my disks, regular shutdown didn't 
work so I had to use sysrq umount, boot.

[3.] Keywords (i.e., modules, networking, kernel):

ext3 journal soft lockup sys_close fput

[4.] Kernel version (from /proc/version):

Linux version 2.6.18 (dennis@jumbo) (gcc version 3.4.6) #3 SMP Sun Oct 8
22:02:52 CEST 2006

[5.] Most recent kernel version which did not have the bug:

Haven't seen it in 2.6.15.1, didn't try anything in between.

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Here is the bugtrace from dmesg:

[353761.551772] kobject vcsa8: cleaning up
[360288.524830] BUG: soft lockup detected on CPU#0!
[360288.524849]  [<c0103e58>] show_trace+0x28/0x30
[360288.524880]  [<c0103f94>] dump_stack+0x24/0x30
[360288.524897]  [<c014b067>] softlockup_tick+0xb7/0xe0
[360288.524933]  [<c012c8b2>] run_local_timers+0x12/0x20
[360288.524967]  [<c012c68f>] update_process_times+0x7f/0xc0
[360288.524986]  [<c01121b6>] smp_apic_timer_interrupt+0x76/0x90
[360288.525020]  [<c0103aaa>] apic_timer_interrupt+0x2a/0x30
[360288.525038]  [<c0154aee>] test_clear_page_dirty+0x9e/0xf0
[360288.525069]  [<c01748cb>] try_to_free_buffers+0x8b/0xb0
[360288.525089]  [<c0172442>] try_to_release_page+0x32/0x60
[360288.525124]  [<c015647a>] invalidate_complete_page+0x3a/0xb0
[360288.525146]  [<c01568e5>] invalidate_mapping_pages+0xb5/0x100
[360288.525164]  [<c0156950>] invalidate_inode_pages+0x20/0x30
[360288.525182]  [<c017108d>] invalidate_bdev+0x2d/0x40
[360288.525200]  [<c01777eb>] kill_bdev+0x1b/0x40
[360288.525222]  [<c0178b50>] __blkdev_put+0x180/0x1a0
[360288.525242]  [<c0178b87>] blkdev_put+0x17/0x20
[360288.525258]  [<c0179208>] blkdev_close+0x28/0x40
[360288.525274]  [<c0170510>] __fput+0x180/0x1b0
[360288.525291]  [<c0170389>] fput+0x19/0x20
[360288.525306]  [<c016e874>] filp_close+0x44/0x90
[360288.525323]  [<c016e934>] sys_close+0x74/0xa0
[360288.525339]  [<c0102ffb>] syscall_call+0x7/0xb
[370291.514972] kobject_uevent
[370291.515007] fill_kobj_path: path = '/class/vc/vcs1'
[370291.517643] kobject vcs1: cleaning up
[370291.519303] kobject_uevent
[370291.519319] fill_kobj_path: path = '/class/vc/vcsa1'
[370291.522306] kobject vcsa1: cleaning up
[392734.016285] kobject udf: registering. parent: <NULL>, set: module
[392734.018113] kobject_uevent
[392734.018144] fill_kobj_path: path = '/module/udf'
[392734.112388] UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume
'THE_PRINCESS_AND_THE_PAUPER', timestamp 2004/08/19 11:14 (1078)
[392734.116242] kobject_uevent
[392734.116261] fill_kobj_path: path = '/block/loop0'
[407642.962313] BUG: soft lockup detected on CPU#0!
[407642.962334]  [<c0103e58>] show_trace+0x28/0x30
[407642.962369]  [<c0103f94>] dump_stack+0x24/0x30
[407642.962387]  [<c014b067>] softlockup_tick+0xb7/0xe0
[407642.962426]  [<c012c8b2>] run_local_timers+0x12/0x20
[407642.962463]  [<c012c68f>] update_process_times+0x7f/0xc0
[407642.962483]  [<c01121b6>] smp_apic_timer_interrupt+0x76/0x90
[407642.962518]  [<c0103aaa>] apic_timer_interrupt+0x2a/0x30
[407642.962537]  [<c0154aee>] test_clear_page_dirty+0x9e/0xf0
[407642.962571]  [<c01748cb>] try_to_free_buffers+0x8b/0xb0
[407642.962592]  [<e0a0e0e6>] journal_try_to_free_buffers+0xa6/0x110
[jbd]
[407642.962661]  [<e0a49495>] ext3_releasepage+0x55/0xa0 [ext3]
[407642.962756]  [<c017245d>] try_to_release_page+0x4d/0x60
[407642.962794]  [<c015647a>] invalidate_complete_page+0x3a/0xb0
[407642.962820]  [<c01568e5>] invalidate_mapping_pages+0xb5/0x100
[407642.962840]  [<c0156950>] invalidate_inode_pages+0x20/0x30
[407642.962859]  [<c018c2e4>] prune_icache+0x1e4/0x1f0
[407642.962877]  [<c018c310>] shrink_icache_memory+0x20/0x50
[407642.962894]  [<c0156e48>] shrink_slab+0x158/0x200
[407642.962913]  [<c0158346>] balance_pgdat+0x236/0x360
[407642.962933]  [<c015852b>] kswapd+0xbb/0x110
[407642.962950]  [<c01378c7>] kthread+0xb7/0x100
[407642.962968]  [<c01011d5>] kernel_thread_helper+0x5/0x10
[419558.203732] SysRq : Emergency Sync
[419558.555485] Emergency Sync complete

[7.] A small shell script or example program which triggers the
     problem (if possible)

Unauthoring a dvd may trigger it again, don't know.

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux jumbo 2.6.18 #3 SMP Sun Oct 8 22:02:52 CEST 2006 i686 pentium3
i386 GNU/Linux
 
Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.11
quota-tools            3.13.
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   097
Modules Loaded         snd_rtctimer isofs nfsd exportfs lockd sunrpc
ext3 jbd capability commoncap usblp parport_pc lp parport w83781d
hwmon_vid hwmon eeprom i2c_isa i2c_dev mga drm psmouse de4x5 de2104x
snd_seq_midi snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
snd_pcm_oss snd_mixer_oss ppp_deflate zlib_deflate zlib_inflate
ppp_async crc_ccitt ppp_generic slip slhc videodev zd1201 v4l1_compat
v4l2_common firmware_class evdev pcspkr sg shpchp snd_ens1370 gameport
snd_rawmidi snd_seq_device snd_pcm snd_timer snd_ak4531_codec snd
intel_agp soundcore i2c_piix4 agpgart uhci_hcd i2c_core snd_page_alloc
pcnet32 ne2k_pci serio_raw 8390 mii

[8.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 501.164
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1005.63

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 501.164
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1002.38

[8.3.] Module information (from /proc/modules):

snd_rtctimer 3596 0 - Live 0xe0a55000
isofs 33648 0 - Live 0xe0a83000
nfsd 223152 13 - Live 0xe0ab1000
exportfs 6144 1 nfsd, Live 0xe09c3000
lockd 61352 2 nfsd, Live 0xe0a0d000
sunrpc 143708 8 nfsd,lockd, Live 0xe0a30000
ext3 132152 14 - Live 0xe0a57000
jbd 57696 1 ext3, Live 0xe0a20000
capability 4360 0 - Live 0xe09a9000
commoncap 6400 1 capability, Live 0xe09a6000
usblp 13448 0 - Live 0xe09be000
parport_pc 26692 1 - Live 0xe0a05000
lp 11880 0 - Live 0xe09ba000
parport 34664 2 parport_pc,lp, Live 0xe09fb000
w83781d 34232 0 - Live 0xe09f1000
hwmon_vid 3968 1 w83781d, Live 0xe0956000
hwmon 3588 1 w83781d, Live 0xe0900000
eeprom 6808 0 - Live 0xe09a3000
i2c_isa 5000 1 w83781d, Live 0xe09a0000
i2c_dev 8964 0 - Live 0xe099c000
mga 61952 0 - Live 0xe09e0000
drm 65332 1 mga, Live 0xe09cf000
psmouse 40456 0 - Live 0xe0980000
de4x5 51248 0 - Live 0xe09ac000
de2104x 20104 0 - Live 0xe0996000
snd_seq_midi 7840 0 - Live 0xe0946000
snd_seq_dummy 3972 0 - Live 0xe0951000
snd_seq_oss 33680 0 - Live 0xe098c000
snd_seq_midi_event 7304 2 snd_seq_midi,snd_seq_oss, Live 0xe08b4000
snd_seq 51768 6 snd_seq_midi,snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 0xe0965000
snd_pcm_oss 45344 0 - Live 0xe0973000
snd_mixer_oss 17032 1 snd_pcm_oss, Live 0xe095f000
ppp_deflate 6016 0 - Live 0xe0943000
zlib_deflate 21656 1 ppp_deflate, Live 0xe0958000
zlib_inflate 14976 2 isofs,ppp_deflate, Live 0xe0935000
ppp_async 11032 0 - Live 0xe093f000
crc_ccitt 2944 1 ppp_async, Live 0xe08fe000
ppp_generic 26948 2 ppp_deflate,ppp_async, Live 0xe0949000
slip 12520 0 - Live 0xe093a000
slhc 6912 2 ppp_generic,slip, Live 0xe08af000
videodev 25376 0 - Live 0xe091f000
zd1201 22668 0 - Live 0xe092e000
v4l1_compat 14084 1 videodev, Live 0xe0906000
v4l2_common 22400 1 videodev, Live 0xe0927000
firmware_class 9216 1 zd1201, Live 0xe0866000
evdev 9472 0 - Live 0xe0902000
pcspkr 3712 0 - Live 0xe08b2000
sg 30372 0 - Live 0xe0916000
shpchp 37336 0 - Live 0xe090b000
snd_ens1370 18016 1 - Live 0xe08f8000
gameport 13848 1 snd_ens1370, Live 0xe08a3000
snd_rawmidi 21568 2 snd_seq_midi,snd_ens1370, Live 0xe08f1000
snd_seq_device 7956 5 snd_seq_midi,snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi, Live 0xe086e000
snd_pcm 76460 2 snd_pcm_oss,snd_ens1370, Live 0xe08cc000
snd_timer 22556 3 snd_rtctimer,snd_seq,snd_pcm, Live 0xe08b7000
snd_ak4531_codec 8840 1 snd_ens1370, Live 0xe089f000
snd 47524 12 snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_ens1370,snd_rawmidi,snd_seq_device,snd_pcm,snd_timer,snd_ak4531_codec, Live 0xe08bf000
intel_agp 21916 1 - Live 0xe08a8000
soundcore 8672 1 snd, Live 0xe089b000
i2c_piix4 8972 0 - Live 0xe088d000
agpgart 30488 2 drm,intel_agp, Live 0xe0892000
uhci_hcd 23828 0 - Live 0xe087b000
i2c_core 19088 5 w83781d,eeprom,i2c_isa,i2c_dev,i2c_piix4, Live 0xe0882000
snd_page_alloc 9224 2 snd_ens1370,snd_pcm, Live 0xe086a000
pcnet32 33412 0 - Live 0xe0871000
ne2k_pci 9952 0 - Live 0xe085e000
serio_raw 6916 0 - Live 0xe0858000
8390 9736 1 ne2k_pci, Live 0xe0862000
mii 6144 1 pcnet32, Live 0xe085b000
[8.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x1

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e1800000-e2bfffff
        Prefetchable memory behind bridge: e2f00000-e3ffffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev
01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev
01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
        Subsystem: Adaptec 2940U2W SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (9750ns min, 6250ns max)
        Interrupt: pin A routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at d000 [disabled] [size=256]
        Region 1: Memory at e1000000 (64-bit, non-prefetchable)
[size=4K]
        [virtual] Expansion ROM at 30200000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Winbond Electronics Corp W89C940
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at b800 [size=32]

00:0a.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970
[PCnet32 LANCE] (rev 33)
        Subsystem: Hewlett-Packard Company Ethernet with LAN remote
power Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (6000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at b400 [size=32]
        Region 1: Memory at e0800000 (32-bit, non-prefetchable)
[size=32]
        [virtual] Expansion ROM at 30000000 [disabled] [size=1M]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

00:0b.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970
[PCnet32 LANCE] (rev 33)
        Subsystem: Hewlett-Packard Company Ethernet with LAN remote
power Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (6000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at b000 [size=32]
        Region 1: Memory at e0000000 (32-bit, non-prefetchable)
[size=32]
        [virtual] Expansion ROM at 30100000 [disabled] [size=1M]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

00:0c.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at a800 [size=64]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. MGA-G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e3000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at e2000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at e1800000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at e2ff0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x1

[8.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: QUANTUM  Model: VIKING II 4.5WLS Rev: 4110
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 12 Lun: 00
  Vendor: QUANTUM  Model: ATLAS IV 9 WLS   Rev: 0B0B
  Type:   Direct-Access                    ANSI SCSI revision: 03

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

There were a number of media errors on the dvd 1 day before the BUG occured.

[345884.256666] hdc: media error (bad sector): status=0x51 { DriveReady SeekComp
lete Error }
[345884.256699] hdc: media error (bad sector): error=0x34 { AbortedCommand LastFailedSense=0x03 }
[345884.256736] ide: failed opcode was: unknown
[345884.257410] ATAPI device hdc:
[345884.257421]   Error: Medium error -- (Sense key=0x03)
[345884.257440]   Unrecovered read error -- (asc=0x11, ascq=0x00)
[345884.257453]   The failed "Read 10" packet command was: 
[345884.257459]   "28 00 00 04 bf 21 00 00 40 00 00 00 00 00 00 00 "
[345884.257519] end_request: I/O error, dev hdc, sector 1244292
[345884.257889] Buffer I/O error on device hdc, logical block 311073
[345884.258528] Buffer I/O error on device hdc, logical block 311074
[345884.258709] Buffer I/O error on device hdc, logical block 311075
[345884.258814] Buffer I/O error on device hdc, logical block 311076
[345884.258919] Buffer I/O error on device hdc, logical block 311077
[345884.259089] Buffer I/O error on device hdc, logical block 311078
[345884.259250] Buffer I/O error on device hdc, logical block 311079
[345884.259678] Buffer I/O error on device hdc, logical block 311080
[345884.259781] Buffer I/O error on device hdc, logical block 311081
[345884.259947] Buffer I/O error on device hdc, logical block 311082

I also reported a possibly related problem with "possible circular
locking dependency detected" on the kernel mailing list
(linux-kernel@vger.kernel.org). This didn't occur between the last 
reboot and the soft lockup bugs reported here.

[X.] Other notes, patches, fixes, workarounds:

-- 
Kind regards,
                Dennis
