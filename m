Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTFDLQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 07:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTFDLQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 07:16:54 -0400
Received: from rzserv1.gsi.de ([140.181.96.11]:11771 "EHLO rzserv1.gsi.de")
	by vger.kernel.org with ESMTP id S263219AbTFDLQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 07:16:46 -0400
Message-ID: <3EDDD843.4010403@gsi.de>
Date: Wed, 04 Jun 2003 13:30:11 +0200
From: Christopher Huhn <C.Huhn@gsi.de>
Organization: GSI
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops at slab.c:1441
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found the following oops in one of our box's kern.log.
It's a Debian Woody running 2.4.20.
The machine seems to have crashed immediatly afterwards - I have no idea 
what the user has been doing at that time.
There were no messages in the kern.log before for more than 12 hours.

Syslog reports:

May 30 15:42:02 linuxbox modprobe: modprobe: Can't locate module 
sound-slot-0
May 30 15:42:02 linuxbox modprobe: modprobe: Can't locate module 
sound-service-0-3

May 30 15:42:09 linuxbox kernel: kernel BUG at slab.c:1441!
May 30 15:42:09 linuxbox kernel: invalid operand: 0000
May 30 15:42:09 linuxbox kernel: CPU:    0
May 30 15:42:09 linuxbox kernel: EIP:    
0010:[kmem_cache_reap+495/1364]    Not tainted
May 30 15:42:09 linuxbox kernel: EFLAGS: 00010083
May 30 15:42:09 linuxbox kernel: eax: 170fc285   ebx: c4b7d004   ecx: 
dffe2300   edx: c4b7da7c
May 30 15:42:09 linuxbox kernel: esi: c4b7d9f0   edi: dffe2300   ebp: 
c162bf64   esp: c162bf1c
May 30 15:42:09 linuxbox kernel: ds: 0018   es: 0018   ss: 0018
May 30 15:42:09 linuxbox kernel: Process kswapd (pid: 4, stackpage=c162b000)
May 30 15:42:09 linuxbox kernel: Stack: 00000020 000001d0 00000020 
c0361da8 00000084 c4b7d968 dffe2310 dffe2324
May 30 15:42:09 linuxbox kernel:        c03faf2c 0000000b c163bc4c 
c163bc00 00000000 00000008 00000000 00000000
May 30 15:42:09 linuxbox kernel:        00000000 dffe2300 c162bf80 
c0139011 00000006 00000020 000001d0 00000006
May 30 15:42:09 linuxbox kernel: Call Trace:    [shrink_caches+29/140] 
[try_to_free_pages_zone+65/104] [kswapd_balance_pgdat+74/160]
[kswapd_balance+34/64] [kswapd+155/182]
May 30 15:42:09 linuxbox kernel:   [kernel_thread+40/56]
May 30 15:42:09 linuxbox kernel:
May 30 15:42:09 linuxbox kernel: Code: 0f 0b a1 05 71 01 2e c0 8b 7d fc 
8b 57 1c f6 c6 08 74 42 89

 >>eax; 170fc285 Before first symbol
 >>ebx; c4b7d004 <_end+473b8a0/204428fc>
 >>ecx; dffe2300 <_end+1fba0b9c/204428fc>
 >>edx; c4b7da7c <_end+473c318/204428fc>
 >>esi; c4b7d9f0 <_end+473c28c/204428fc>
 >>edi; dffe2300 <_end+1fba0b9c/204428fc>
 >>ebp; c162bf64 <_end+11ea800/204428fc>
 >>esp; c162bf1c <_end+11ea7b8/204428fc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   a1 05 71 01 2e            mov    0x2e017105,%eax
Code;  00000007 Before first symbol
   7:   c0 8b 7d fc 8b 57 1c      rorb   $0x1c,0x578bfc7d(%ebx)
Code;  0000000e Before first symbol
   e:   f6 c6 08                  test   $0x8,%dh
Code;  00000011 Before first symbol
  11:   74 42                     je     55 <_EIP+0x55> 00000055 Before 
first symbol
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

Some maybe useful info:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1208.772
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2411.72

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  526798848 518266880  8531968        0  5795840 384724992
Swap: 1048563712 105861120 942702592
MemTotal:       514452 kB
MemFree:          8332 kB
MemShared:           0 kB
Buffers:          5660 kB
Cached:         342652 kB
SwapCached:      33056 kB
Active:         171028 kB
Inactive:       305872 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514452 kB
LowFree:          8332 kB
SwapTotal:     1023988 kB
SwapFree:       920608 kB

# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3).
      Master Capable.  Latency=8.
      Prefetchable 32 bit memory at 0xe6000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   4, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 64).
  Bus  0, device   4, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 6).
      Master Capable.  Latency=32.
      I/O at 0xb800 [0xb80f].
  Bus  0, device   4, function  2:
    USB Controller: VIA Technologies, Inc. USB (rev 22).
      IRQ 9.
      Master Capable.  Latency=32.
      I/O at 0xb400 [0xb41f].
  Bus  0, device   4, function  3:
    USB Controller: VIA Technologies, Inc. USB (#2) (rev 22).
      IRQ 9.
      Master Capable.  Latency=32.
      I/O at 0xb000 [0xb01f].
  Bus  0, device   4, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
      IRQ 9.
  Bus  0, device   4, function  5:
    Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 80).
      IRQ 9.
      I/O at 0xa800 [0xa8ff].
      I/O at 0xa400 [0xa403].
      I/O at 0xa000 [0xa003].
  Bus  0, device  10, function  0:
    SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 
53c895 (rev 1).
      IRQ 9.
      Master Capable.  Latency=134.  Min Gnt=30.Max Lat=64.
      I/O at 0x9400 [0x94ff].
      Non-prefetchable 32 bit memory at 0xe3800000 [0xe38000ff].
      Non-prefetchable 32 bit memory at 0xe3000000 [0xe3000fff].
  Bus  0, device  11, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 12).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xe2800000 [0xe2800fff].
      I/O at 0x9000 [0x903f].
      Non-prefetchable 32 bit memory at 0xe2000000 [0xe201ffff].
  Bus  0, device  17, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0x8800 [0x8807].
      I/O at 0x8400 [0x8403].
      I/O at 0x8000 [0x8007].
      I/O at 0x7800 [0x7803].
      I/O at 0x7400 [0x743f].
      Non-prefetchable 32 bit memory at 0xe1800000 [0xe181ffff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 
1X/2X (rev 92).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe5000000 [0xe5ffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe4000fff].

Kind regards,

    Christopher


