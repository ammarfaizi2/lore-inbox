Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUHCD7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUHCD7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 23:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUHCD7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 23:59:41 -0400
Received: from caribou.intercarve.net ([66.111.34.130]:8721 "EHLO
	caribou.intercarve.net") by vger.kernel.org with ESMTP
	id S265022AbUHCD7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 23:59:15 -0400
From: Drew Vogel <dvogel@intercarve.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: OOPS in 2.6.7 kmem_cache_alloc
Date: Mon, 2 Aug 2004 23:00:21 -0500
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408022300.22076.dvogel@intercarve.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

An oops in kmem_cache_alloc during high IO.



[2.] Full description of the problem/report:

Seemingly any high I/O for more than a minute or two will produce an oops in
kmem_cache_alloc. I first came across this while resampling an audio book 
using the program "resample" from the following sh loop:

	for dir in 1 2 3 4 5 6; do
		cd $dir
		for file in *; do
			resample -to 16000 $file ../16k/$dir/$file
		done
	done

Somewhere around 600-900 MB of resampled WAV files, I get an OOPS which I 
wasn't able to capture. I can reproduce it easily. I wasn't able to get any 
OOPS-dumping tools to work (due to my own lack of understanding, I'm sure) 
and the system panics saying "In interrupt handler -- not syncing". This data 
was being both read from and written to the same ext3 partition (journaling 
enabled, if it matters).

I tried reproducing the problem on another partition with this sh script:

	while 1; do
		resample -to 2000 /tmp/junk.wav /tmp/junk2.wav
		rm junk2.wav
	done

This produced another OOPS that caused the system to panic. I did this twice. 
The second time I noticed at the bottom the panic message said:

	<6>APIC error on CPU0: 00(80)

I didn't notice that the first time because I rebooted too quickly. Now that I 
knew it would happen regardless of the partition, I tried to test whether the 
input or output, or both, is the problem. The following test of the output 
caused an OOPS.

	while 1; do
		dd if=/dev/urandom of=/tmp/junk bs=1024 count=40960
		rm /tmp/junk
	done

Actually, that produced two OOPSs in kmem_cache_alloc without making the 
system panic. The output of ksymoops is below. The system didn't panic, but 
various commands would get stuck in D-state. e.g. "vim /var/log/messages" did 
get stuck but "tail -n 100 /var/log/messages /root/oops.txt" did not.




[3.] Keywords (i.e., modules, networking, kernel):

No modules loaded.



[4.] Kernel version (from /proc/version):

Linux version 2.6.7-5 (root@lukahn) (gcc version 3.3.4 (Debian 1:3.3.4-6)) #1 
Mon Aug 2 18:49:03 CDT 2004



[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Below is the output of ksymoops for the oops data gathered 
from /var/log/messages after the last two oops described above.

	ksymoops 2.4.9 on i686 2.6.7-5.  Options used
	-V (default)
	-k /proc/ksyms (default)
	-l /proc/modules (default)
	-o /lib/modules/2.6.7-5/ (default)
	-m /boot/System.map-2.6.7-5 (default)
	
	Warning: You did not tell me where to find symbol information.  I will
	assume that the log matches the kernel and modules that are running
	right now and I'll use the default options above for symbol resolution.
	If the current kernel and/or modules do not match the log, you can get
	more accurate output by telling me the kernel version and where to find
	map, modules, ksyms etc.  ksymoops -h explains the options.
	
	Error (regular_file): read_ksyms stat /proc/ksyms failed
	No modules in ksyms, skipping objects
	No ksyms, skipping lsmod
	Aug  2 20:57:57 localhost kernel: c01ff053
	Aug  2 20:57:57 localhost kernel: CPU:    0
	Aug  2 20:57:57 localhost kernel: EIP:    0060:[add_entropy_words+243/400]    
Not tainted
	Aug  2 20:57:57 localhost kernel: EFLAGS: 00010086   (2.6.7-5) 
	Aug  2 20:57:57 localhost kernel: eax: c0204839   ebx: 18e115a1   ecx: 
84350439   edx: 09faa670
	Aug  2 20:57:57 localhost kernel: esi: 00000015   edi: ce37ccf9   ebp: 
09faa670   esp: c3951db0
	Aug  2 20:57:57 localhost kernel: ds: 007b   es: 007b   ss: 0068
	Aug  2 20:57:57 localhost kernel: Stack: 84350439 00000292 968e9666 01b1fa57 
3a989ad2 968e9666 99c027ea 4c336600 
	Aug  2 20:57:57 localhost kernel:        7c000000 c3951e14 c3951e04 00000020 
00000004 cccccccd cdd78514 c01ff898 
	Aug  2 20:57:57 localhost kernel:        c3951e04 c3951e0c 7c000001 00000004 
00000258 ce37ccfa 4c336600 99c027ea 
	Aug  2 20:57:57 localhost kernel: Call Trace:
	Aug  2 20:57:57 localhost kernel: Code: 33 14 83 8b 04 24 03 44 24 18 21 f8 
33 14 83 8b 04 24 03 44 
	Using defaults from ksymoops -t elf32-i386 -a i386
	
	
	>>eax; c0204839 <tty_register_driver+129/230>
	>>edi; ce37ccf9 <pg0+dfa5cf9/3fc27000>
	>>esp; c3951db0 <pg0+357adb0/3fc27000>
	
	Code;  00000000 Before first symbol
	00000000 <_EIP>:
	Code;  00000000 Before first symbol
	0:   33 14 83                  xor    (%ebx,%eax,4),%edx
	Code;  00000003 Before first symbol
	3:   8b 04 24                  mov    (%esp),%eax
	Code;  00000006 Before first symbol
	6:   03 44 24 18               add    0x18(%esp),%eax
	Code;  0000000a Before first symbol
	a:   21 f8                     and    %edi,%eax
	Code;  0000000c Before first symbol
	c:   33 14 83                  xor    (%ebx,%eax,4),%edx
	Code;  0000000f Before first symbol
	f:   8b 04 24                  mov    (%esp),%eax
	Code;  00000012 Before first symbol
	12:   03 44 00 00               add    0x0(%eax,%eax,1),%eax
	
	Aug  2 21:00:36 localhost kernel: c0138360
	Aug  2 21:00:36 localhost kernel: CPU:    0
	Aug  2 21:00:36 localhost kernel: EIP:    0060:[kmem_cache_alloc+32/64]    
Not tainted
	Aug  2 21:00:36 localhost kernel: EFLAGS: 00010002   (2.6.7-5) 
	Aug  2 21:00:36 localhost kernel: eax: 00000008   ebx: 00000292   ecx: 
cdfccc60   edx: cdfc5000
	Aug  2 21:00:36 localhost kernel: esi: 00000000   edi: 00000400   ebp: 
c108fd60   esp: c3951c98
	Aug  2 21:00:36 localhost kernel: ds: 007b   es: 007b   ss: 0068
	Aug  2 21:00:36 localhost kernel: Stack: 00000000 00000000 c7b76b6c c0150110 
cdfccc60 00000050 c7b76b6c 00000000 
	Aug  2 21:00:36 localhost kernel:        c014d97c 00000050 c108fd60 00000400 
c108fd60 00000000 c108fd60 00000010 
	Aug  2 21:00:36 localhost kernel:        c014e335 c108fd60 00000400 00000001 
c108fd60 ca0572b0 c014eacc c108fd60 
	Aug  2 21:00:36 localhost kernel: Call Trace:
	Aug  2 21:00:36 localhost kernel: Code: 8b 44 82 10 53 9d 8b 5c 24 08 83 c4 
0c c3 8b 44 24 14 89 0c 
	
	
	>>ecx; cdfccc60 <pg0+dbf5c60/3fc27000>
	>>edx; cdfc5000 <pg0+dbee000/3fc27000>
	>>ebp; c108fd60 <pg0+cb8d60/3fc27000>
	>>esp; c3951c98 <pg0+357ac98/3fc27000>
	
	Code;  00000000 Before first symbol
	00000000 <_EIP>:
	Code;  00000000 Before first symbol
	0:   8b 44 82 10               mov    0x10(%edx,%eax,4),%eax
	Code;  00000004 Before first symbol
	4:   53                        push   %ebx
	Code;  00000005 Before first symbol
	5:   9d                        popf   
	Code;  00000006 Before first symbol
	6:   8b 5c 24 08               mov    0x8(%esp),%ebx
	Code;  0000000a Before first symbol
	a:   83 c4 0c                  add    $0xc,%esp
	Code;  0000000d Before first symbol
	d:   c3                        ret    
	Code;  0000000e Before first symbol
	e:   8b 44 24 14               mov    0x14(%esp),%eax
	Code;  00000012 Before first symbol
	12:   89 0c 00                  mov    %ecx,(%eax,%eax,1)
	
	
	1 warning and 1 error issued.  Results may not be reliable.




	ksymoops 2.4.9 on i686 2.6.7-5.  Options used
	-V (default)
	-k /proc/ksyms (default)
	-l /proc/modules (default)
	-o /lib/modules/2.6.7-5/ (default)
	-m /boot/System.map-2.6.7-5 (default)
	
	Warning: You did not tell me where to find symbol information.  I will
	assume that the log matches the kernel and modules that are running
	right now and I'll use the default options above for symbol resolution.
	If the current kernel and/or modules do not match the log, you can get
	more accurate output by telling me the kernel version and where to find
	map, modules, ksyms etc.  ksymoops -h explains the options.
	
	Error (regular_file): read_ksyms stat /proc/ksyms failed
	No modules in ksyms, skipping objects
	No ksyms, skipping lsmod
	Aug  2 20:57:57 localhost kernel: c01ff053
	Aug  2 20:57:57 localhost kernel: CPU:    0
	Aug  2 20:57:57 localhost kernel: EIP:    0060:[add_entropy_words+243/400]    
Not tainted
	Aug  2 20:57:57 localhost kernel: EFLAGS: 00010086   (2.6.7-5) 
	Aug  2 20:57:57 localhost kernel: eax: c0204839   ebx: 18e115a1   ecx: 
84350439   edx: 09faa670
	Aug  2 20:57:57 localhost kernel: esi: 00000015   edi: ce37ccf9   ebp: 
09faa670   esp: c3951db0
	Aug  2 20:57:57 localhost kernel: ds: 007b   es: 007b   ss: 0068
	Aug  2 20:57:57 localhost kernel: Stack: 84350439 00000292 968e9666 01b1fa57 
3a989ad2 968e9666 99c027ea 4c336600 
	Aug  2 20:57:57 localhost kernel:        7c000000 c3951e14 c3951e04 00000020 
00000004 cccccccd cdd78514 c01ff898 
	Aug  2 20:57:57 localhost kernel:        c3951e04 c3951e0c 7c000001 00000004 
00000258 ce37ccfa 4c336600 99c027ea 
	Aug  2 20:57:57 localhost kernel: Call Trace:
	Aug  2 20:57:57 localhost kernel: Code: 33 14 83 8b 04 24 03 44 24 18 21 f8 
33 14 83 8b 04 24 03 44 
	Using defaults from ksymoops -t elf32-i386 -a i386
	
	
	>>eax; c0204839 <tty_register_driver+129/230>
	>>edi; ce37ccf9 <pg0+dfa5cf9/3fc27000>
	>>esp; c3951db0 <pg0+357adb0/3fc27000>
	
	Code;  00000000 Before first symbol
	00000000 <_EIP>:
	Code;  00000000 Before first symbol
	0:   33 14 83                  xor    (%ebx,%eax,4),%edx
	Code;  00000003 Before first symbol
	3:   8b 04 24                  mov    (%esp),%eax
	Code;  00000006 Before first symbol
	6:   03 44 24 18               add    0x18(%esp),%eax
	Code;  0000000a Before first symbol
	a:   21 f8                     and    %edi,%eax
	Code;  0000000c Before first symbol
	c:   33 14 83                  xor    (%ebx,%eax,4),%edx
	Code;  0000000f Before first symbol
	f:   8b 04 24                  mov    (%esp),%eax
	Code;  00000012 Before first symbol
	12:   03 44 00 00               add    0x0(%eax,%eax,1),%eax
	
	Aug  2 21:00:36 localhost kernel: c0138360
	Aug  2 21:00:36 localhost kernel: CPU:    0
	Aug  2 21:00:36 localhost kernel: EIP:    0060:[kmem_cache_alloc+32/64]    
Not tainted
	Aug  2 21:00:36 localhost kernel: EFLAGS: 00010002   (2.6.7-5) 
	Aug  2 21:00:36 localhost kernel: eax: 00000008   ebx: 00000292   ecx: 
cdfccc60   edx: cdfc5000
	Aug  2 21:00:36 localhost kernel: esi: 00000000   edi: 00000400   ebp: 
c108fd60   esp: c3951c98
	Aug  2 21:00:36 localhost kernel: ds: 007b   es: 007b   ss: 0068
	Aug  2 21:00:36 localhost kernel: Stack: 00000000 00000000 c7b76b6c c0150110 
cdfccc60 00000050 c7b76b6c 00000000 
	Aug  2 21:00:36 localhost kernel:        c014d97c 00000050 c108fd60 00000400 
c108fd60 00000000 c108fd60 00000010 
	Aug  2 21:00:36 localhost kernel:        c014e335 c108fd60 00000400 00000001 
c108fd60 ca0572b0 c014eacc c108fd60 
	Aug  2 21:00:36 localhost kernel: Call Trace:
	Aug  2 21:00:36 localhost kernel: Code: 8b 44 82 10 53 9d 8b 5c 24 08 83 c4 
0c c3 8b 44 24 14 89 0c 
	
	
	>>ecx; cdfccc60 <pg0+dbf5c60/3fc27000>
	>>edx; cdfc5000 <pg0+dbee000/3fc27000>
	>>ebp; c108fd60 <pg0+cb8d60/3fc27000>
	>>esp; c3951c98 <pg0+357ac98/3fc27000>
	
	Code;  00000000 Before first symbol
	00000000 <_EIP>:
	Code;  00000000 Before first symbol
	0:   8b 44 82 10               mov    0x10(%edx,%eax,4),%eax
	Code;  00000004 Before first symbol
	4:   53                        push   %ebx
	Code;  00000005 Before first symbol
	5:   9d                        popf   
	Code;  00000006 Before first symbol
	6:   8b 5c 24 08               mov    0x8(%esp),%ebx
	Code;  0000000a Before first symbol
	a:   83 c4 0c                  add    $0xc,%esp
	Code;  0000000d Before first symbol
	d:   c3                        ret    
	Code;  0000000e Before first symbol
	e:   8b 44 24 14               mov    0x14(%esp),%eax
	Code;  00000012 Before first symbol
	12:   89 0c 00                  mov    %ecx,(%eax,%eax,1)
	
	
	1 warning and 1 error issued.  Results may not be reliable.




[7.1.] Software (add the output of the ver_linux script here)
Linux lukahn 2.6.7-5 #1 Mon Aug 2 18:49:03 CDT 2004 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.2
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1



[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 2100+
stepping        : 2
cpu MHz         : 1742.803
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3448.83




[7.3.] Module information (from /proc/modules):

This is empty

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 2100+
stepping        : 2
cpu MHz         : 1742.803
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3448.83



00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7dff : Video ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
  00100000-002dcfb8 : Kernel code
  002dcfb9-0038f53f : Kernel data
0dff0000-0dff2fff : ACPI Non-volatile Storage
0dff3000-0dffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-dbffffff : PCI Bus #01
  d8000000-dbffffff : 0000:01:00.0
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : 0000:01:00.0
de000000-de0000ff : 0000:00:10.3
  de000000-de0000ff : ehci_hcd
de001000-de0010ff : 0000:00:12.0
  de001000-de0010ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved




[7.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400] Chipset Host 
Bridge
        Subsystem: Giga-byte Technology GA-7VM400M Motherboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d8000000-dbffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin C routed to IRQ 21
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 
20 [EHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a 
[Master SecP PriP])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at dc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: Giga-byte Technology: Unknown device a004
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D3 PME-Enable- DSel=0 DScale=0 PME-

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 74)
        Subsystem: Giga-byte Technology: Unknown device e000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at e400 [size=256]
        Region 1: Memory at de001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8378 [S3 
UniChrome] Integrated Video (rev 01) (prog-if 00 [VGA])
        Subsystem: VIA Technologies, Inc. VT8378 [S3 UniChrome] Integrated 
Video
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>




[7.6.] SCSI information (from /proc/scsi/scsi)

No SCSI compiled.

