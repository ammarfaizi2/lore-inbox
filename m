Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275822AbRJULDD>; Sun, 21 Oct 2001 07:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275843AbRJULCy>; Sun, 21 Oct 2001 07:02:54 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:9 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S275822AbRJULCp>; Sun, 21 Oct 2001 07:02:45 -0400
Date: Sun, 21 Oct 2001 12:05:39 +0100
From: Colin Phipps <cph@cph.demon.co.uk>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated preempt-kernel
Message-ID: <20011021120539.A1197@cph.demon.co.uk>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1003562833.862.65.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1003562833.862.65.camel@phantasy>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] NULL pointer deference in con_flush_chars with preempt patch
[2.]
Ok, running with preempt-kernel-rml-2.4.12-ac3-2.patch I had a crash
yesterday.  It occured when the machine was under
light load, I had just exited X, and I was logging off a console - I may
have hit ctrl-d twice.  I did a little investigating myself, and the
closest I could find in the archives was the problem mentioned in
http://www.geocrawler.com/archives/3/35/1998/11/0/217652/ , except my
crash is occuring at console close instead of open. It may not be
preempt related, just preempt induced :-)

Looks like a race condition on console close, driver_data gets set to NULL
but a interrupt-induced con_flush_chars then tries to access it.

[3.] preempt, console
[4.] Linux version 2.4.12-ac3-preempt (root@micro) (gcc version 2.95.4 20011006 (Debian prerelease)) #2 Sat Oct 20 19:07:28 BST 2001
[5.] 
ksymoops 2.4.1 on i686 2.4.12-ac3-preempt.  Options used
     -V (default)
     -k /var/log/ksymoops/20011020212838.ksyms (specified)
     -l /var/log/ksymoops/20011020212838.modules (specified)
     -o /lib/modules/2.4.12-ac3-preempt/ (default)
     -m /boot/System.map-2.4.12-ac3-preempt (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01878d7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[con_flush_chars+31/52]    Tainted: P 
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c0200ac0   edx: c51a4000
esi: c51a4000   edi: c51a4169   ebp: 00000000   esp: c5ff7eb0
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=c5ff7000)
Stack: c51a4980 c017c0ff c51a4000 c51a4568 c51a4168 c5ff7f9c 0008e000 00000050 
       00000010 00000000 c4d55220 00000000 00000050 c51a4569 c51a4169 c0271248 
       00000001 0000001d c019d4ab c0271248 00000001 0000000d 0000001d 00000008 
Call Trace: [n_tty_receive_buf+4059/4236] [fbcon_cursor+167/456] [complete_change_console+146/152] [flush_to_ldisc+251/260] [__run_task_queue+109/124] 
Code: 8b 03 50 e8 31 c9 ff ff e8 38 be f8 ff 83 c4 04 5b c3 8d 76 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 03                     mov    (%ebx),%eax
Code;  00000002 Before first symbol
   2:   50                        push   %eax
Code;  00000003 Before first symbol
   3:   e8 31 c9 ff ff            call   ffffc939 <_EIP+0xffffc939> ffffc939 <END_OF_CODE+38d6916f/????>
Code;  00000008 Before first symbol
   8:   e8 38 be f8 ff            call   fff8be45 <_EIP+0xfff8be45> fff8be45 <END_OF_CODE+38cf867b/????>
Code;  0000000d Before first symbol
   d:   83 c4 04                  add    $0x4,%esp
Code;  00000010 Before first symbol
  10:   5b                        pop    %ebx
Code;  00000011 Before first symbol
  11:   c3                        ret    
Code;  00000012 Before first symbol
  12:   8d 76 00                  lea    0x0(%esi),%esi

14 warnings issued.  Results may not be reliable.

[6.] Not trivially reproducible
[7.] 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11h
mount                  2.11h
modutils               2.4.10
e2fsprogs              1.25
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ide-cd cdrom rtc tulip sb sb_lib uart401 sound soundcore serial hid usb-uhci usbcore mousedev input atyfb fbcon-cfb24 fbcon-cfb8 fbcon-cfb16 fbcon-cfb32 apm unix

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 4
cpu MHz		: 267.284
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips	: 532.48

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
0220-022f : soundblaster
02f8-02ff : serial(set)
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4f00-4f3f : Intel Corporation 82371AB PIIX4 ACPI
5f00-5f1f : Intel Corporation 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e000-e01f : Intel Corporation 82371AB PIIX4 USB
  e000-e01f : usb-uhci
e400-e47f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  e400-e47f : tulip
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-05ffffff : System RAM
  00100000-001d9ef3 : Kernel code
  001d9ef4-0020cb47 : Kernel data
e0000000-e3ffffff : Intel Corporation 440LX/EX - 82443LX/EX Host bridge
e4000000-e5ffffff : PCI Bus #01
  e5000000-e5000fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
    e6000000-e6ffffff : atyfb
e8000000-e800007f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  e8000000-e800007f : tulip
ffff0000-ffffffff : reserved

00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:02.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at e000 [size=32]

00:02.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:10.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
	Subsystem: D-Link System Inc DE-530+
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e400 [size=128]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at e7000000 [disabled] [size=256K]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at d000 [size=256]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

No SCSI.

-- 
Colin Phipps <cph@cph.demon.co.uk>   http://www.cph.demon.co.uk/
