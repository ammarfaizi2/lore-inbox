Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267275AbUGNBuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267275AbUGNBuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 21:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267288AbUGNBuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 21:50:39 -0400
Received: from smtp.sig.net.nz ([202.27.199.35]:158 "EHLO smtp.sig.net.nz")
	by vger.kernel.org with ESMTP id S267275AbUGNBty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 21:49:54 -0400
Date: Wed, 14 Jul 2004 13:49:51 +1200 (NZST)
From: Martin D Kealey <martin@sig.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: [KBUG] Oops in kscand
Message-ID: <Pine.LNX.4.33.0407141329010.21456-100000@sophie.sig.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(My apologies in advance for not being more specific; I've not been involved
with Linux Kernel development, and am not familiar with the customs of the
community... but I did do OS design & Kernel analysis as a CompSci paper
back in 1987 so I can make a few educated guesses. I've included the
information suggested by
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html, except that
the last crash was a week ago and I wasn't here at the time so my
information is limited to log extracts.)

1. Kscand crashed.

2. It appears that the kernel thread for kscand died with a NULL pointer
dereference in "page_referenced", from scan_active_list; given that
scan_active_list uses "list_for_each_safe/list_entry", this seems quite odd.

3. Kernel

4.
Linux version 2.4.20-28.8 (bhcompile@daffy.perf.redhat.com) (gcc version 3.2
20020903 (Red Hat Linux 8.0 3.2-7)) #1 Thu Dec 18 12:53:39 EST 2003

5.
ksymoops 2.4.5 on i686 2.4.20-28.8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-28.8/ (default)
     -m /boot/System.map-2.4.20-28.8 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/reiserfs.o) for reiserfs
Error (expand_objects): cannot stat(/lib/raid1.o) for raid1
Error (expand_objects): cannot stat(/lib/lvm-mod.o) for lvm-mod
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (map_ksym_to_module): cannot match loaded module reiserfs to a unique module object.  Trace may not be reliable.
Jul  5 18:00:09 skud kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000070
Jul  5 18:00:09 skud kernel: c014075e
Jul  5 18:00:09 skud kernel: *pde = 00000000
Jul  5 18:00:09 skud kernel: Oops: 0000
Jul  5 18:00:09 skud kernel: CPU:    0
Jul  5 18:00:09 skud kernel: EIP:    0010:[<c014075e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul  5 18:00:09 skud kernel: EFLAGS: 00010202
Jul  5 18:00:09 skud kernel: eax: c11f3870   ebx: 00000ffc   ecx: 00000000   edx: 00000001
Jul  5 18:00:09 skud kernel: esi: 0000001d   edi: cd190f00   ebp: 00000001   esp: c1b09f84
Jul  5 18:00:09 skud kernel: ds: 0018   es: 0018   ss: 0018
Jul  5 18:00:09 skud kernel: Process kscand/Normal (pid: 7, stackpage=c1b09000)
Jul  5 18:00:09 skud kernel: Stack: cd190b00 00000000 00000001 c1b09fb4 c133b990 c133b990 c030adcc c127cd3c
Jul  5 18:00:09 skud kernel:        00000003 c0138bee c1209a98 00000003 00000001 00000003 c1b08000 c030ac80
Jul  5 18:00:09 skud kernel:        c1b08000 c0139de4 c030ac80 00000003 00000001 c025cf89 000009c4 00000f00
Jul  5 18:00:09 skud kernel: Call Trace:   [<c0138bee>] scan_active_list [kernel] 0x3e (0xc1b09fa8))
Jul  5 18:00:10 skud kernel: [<c0139de4>] kscand [kernel] 0xb4 (0xc1b09fc8))
Jul  5 18:00:10 skud kernel: [<c0105000>] stext [kernel] 0x0 (0xc1b09fe8))
Jul  5 18:00:10 skud kernel: [<c010741e>] arch_kernel_thread [kernel] 0x2e (0xc1b09ff0))
Jul  5 18:00:10 skud kernel: [<c0139d30>] kscand [kernel] 0x0 (0xc1b09ff8))
Jul  5 18:00:10 skud kernel: Code: 8b 41 70 39 41 5c 0f 43 54 24 04 45 4e 89 54 24 04 0f 89 3b


>>EIP; c014075e <page_referenced+21e/2c0>   <=====

>>eax; c11f3870 <_end+e3c470/10455c60>
>>ebx; 00000ffc Before first symbol
>>edi; cd190f00 <_end+cdd9b00/10455c60>
>>esp; c1b09f84 <_end+1752b84/10455c60>

Trace; c0138bee <scan_active_list+3e/80>
Trace; c0139de4 <kscand+b4/160>
Trace; c0105000 <_stext+0/0>
Trace; c010741e <arch_kernel_thread+2e/40>
Trace; c0139d30 <kscand+0/160>

Code;  c014075e <page_referenced+21e/2c0>
00000000 <_EIP>:
Code;  c014075e <page_referenced+21e/2c0>   <=====
   0:   8b 41 70                  mov    0x70(%ecx),%eax   <=====
Code;  c0140761 <page_referenced+221/2c0>
   3:   39 41 5c                  cmp    %eax,0x5c(%ecx)
Code;  c0140764 <page_referenced+224/2c0>
   6:   0f 43 54 24 04            cmovae 0x4(%esp,1),%edx
Code;  c0140769 <page_referenced+229/2c0>
   b:   45                        inc    %ebp
Code;  c014076a <page_referenced+22a/2c0>
   c:   4e                        dec    %esi
Code;  c014076b <page_referenced+22b/2c0>
   d:   89 54 24 04               mov    %edx,0x4(%esp,1)
Code;  c014076f <page_referenced+22f/2c0>
  11:   0f 89 3b 00 00 00         jns    52 <_EIP+0x52>


2 warnings and 6 errors issued.  Results may not be reliable.

7.1.
Linux skud 2.4.20-28.8 #1 Thu Dec 18 12:53:39 EST 2003 i686 i686 i386
GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         sg binfmt_misc nfsd lockd sunrpc autofs eepro100 mii
iptable_filter ip_tables microcode st loop mousedev keybdev hid input
usb-uhci usbcore reiserfs raid1 lvm-mod aic7xxx sd_mod scsi_mod

7.2.
processor  : 0
vendor_id  : GenuineIntel
cpu family : 15
model      : 1
model name : Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping   : 2
cpu MHz    : 1595.318
cache size : 256 KB
fdiv_bug   : no
hlt_bug    : no
f00f_bug   : no
coma_bug   : no
fpu        : yes
fpu_exception   : yes
cpuid level : 2
wp         : yes
flags      : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips   : 3185.04

7.3.
sg                     36556   0 (autoclean)
binfmt_misc             7464   1
nfsd                   80272   8 (autoclean)
lockd                  58864   1 (autoclean) [nfsd]
sunrpc                 81724   1 (autoclean) [nfsd lockd]
autofs                 13332   0 (autoclean) (unused)
eepro100               22772   1
mii                     3976   0 [eepro100]
iptable_filter          2412   0 (autoclean) (unused)
ip_tables              15096   1 [iptable_filter]
microcode               4668   0 (autoclean)
st                     31628   0
loop                   12184   0 (autoclean)
mousedev                5588   0 (unused)
keybdev                 2976   0 (unused)
hid                    22340   0 (unused)
input                   5920   0 [mousedev keybdev hid]
usb-uhci               26412   0 (unused)
usbcore                78944   1 [hid usb-uhci]
reiserfs              205520   6
raid1                  15212   3
lvm-mod                63936  16
aic7xxx               140980   2
sd_mod                 13484   4
scsi_mod              107576   4 [sg st aic7xxx sd_mod]

7.4.
[martink@skud linux-2.4.20-28.8]$ cat /proc/ioports
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
1000-10ff : Adaptec AIC-7892A U160/m
1400-14ff : Adaptec AIC-7892A U160/m (#2)
1800-183f : Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller
  1800-183f : eepro100
2000-20ff : Intel Corp. 82801BA/BAM AC'97 Audio
2400-243f : Intel Corp. 82801BA/BAM AC'97 Audio
2440-245f : Intel Corp. 82801BA/BAM USB (Hub #1)
  2440-245f : usb-uhci
2460-247f : Intel Corp. 82801BA/BAM USB (Hub #2)
  2460-247f : usb-uhci
2480-248f : Intel Corp. 82801BA IDE U100
  2480-2487 : ide0
  2488-248f : ide1

[martink@skud linux-2.4.20-28.8]$ cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c9800-000cafff : Extension ROM
000cb000-000d05ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffdffff : System RAM
  00100000-0024f069 : Kernel code
  0024f06a-00348fc3 : Kernel data
0ffe0000-0fffffff : ACPI Non-volatile Storage
f5e00000-f7ffffff : PCI Bus #01
  f6000000-f7ffffff : nVidia Corporation NV6 [Vanta]
f8000000-fbffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
fc400000-fc400fff : Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller
  fc400000-fc400fff : eepro100
fc401000-fc401fff : Adaptec AIC-7892A U160/m
  fc401000-fc401fff : aic7xxx
fc402000-fc402fff : Adaptec AIC-7892A U160/m (#2)
  fc402000-fc402fff : aic7xxx
fd000000-fe1fffff : PCI Bus #01
  fd000000-fdffffff : nVidia Corporation NV6 [Vanta]
feda0000-ffffffff : reserved

7.5.
[martink@skud linux-2.4.20-28.8]$ /sbin/lspci -vvv
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fd000000-fe1fffff
        Prefetchable memory behind bridge: f5e00000-f7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 12) (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: fc200000-fc4fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 12)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12) (prog-if 80
[Master])
        Subsystem: Compaq Computer Corporation: Unknown device 2411
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at 2480 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 12)
(prog-if 00 [UHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 2411
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at 2440 [size=32]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 12)
(prog-if 00 [UHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 2411
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 2460 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio
(rev 12)
        Subsystem: Compaq Computer Corporation: Unknown device 008a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 2000 [size=256]
        Region 1: I/O ports at 2400 [size=64]

01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta] (rev 15)
(prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 0072
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f6000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet
Controller (rev 03)
        Subsystem: Compaq Computer Corporation EtherExpress PRO/100 VM
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fc400000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1800 [size=64]
        Capabilities: <available only to root>

02:09.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160LP Low Profile Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: I/O ports at 1000 [disabled] [size=256]
        Region 1: Memory at fc401000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

02:0b.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160 Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at 1400 [disabled] [size=256]
        Region 1: Memory at fc402000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

7.6.
[martink@skud linux-2.4.20-28.8]$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: IC35L036UWD210-0 Rev: S5BS
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: IC35L036UWD210-0 Rev: S5BS
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: EXABYTE  Model: VXA-2            Rev: 100E
  Type:   Sequential-Access                ANSI SCSI revision: 02

 --
"War against Terrorism" is an oxymoron

