Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265651AbSJXUiG>; Thu, 24 Oct 2002 16:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265653AbSJXUiG>; Thu, 24 Oct 2002 16:38:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:51721 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265651AbSJXUiC>;
	Thu, 24 Oct 2002 16:38:02 -0400
Date: Thu, 24 Oct 2002 22:44:04 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024204404.GA486@pcw.home.local>
References: <3DB82ABF.8030706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 07:15:43PM +0200, Manfred Spraul wrote:
> AMD recommends to perform memory copies with backward read operations 
> instead of prefetch.
> 
> http://208.15.46.63/events/gdc2002.htm
> 
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?
> 
> Please run 2 or 3 times.

Dual Athlon XP 1800+ on ASUS A7M266-D (760MPX), 512 MB of PC2100 in two identical banks.
I observed a noticeable slowdown several minutes later (after typing this mail),
see below.

willy@pcw:c$ ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 16402 cycles per page
copy_page function '2.4 non MMX'         took 17886 cycles per page
copy_page function '2.4 MMX fallback'    took 17956 cycles per page
copy_page function '2.4 MMX version'     took 16382 cycles per page
copy_page function 'faster_copy'         took 9807 cycles per page
copy_page function 'even_faster'         took 10205 cycles per page
copy_page function 'no_prefetch'         took 8457 cycles per page
willy@pcw:c$ ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 16552 cycles per page
copy_page function '2.4 non MMX'         took 17744 cycles per page
copy_page function '2.4 MMX fallback'    took 17713 cycles per page
copy_page function '2.4 MMX version'     took 16427 cycles per page
copy_page function 'faster_copy'         took 9823 cycles per page
copy_page function 'even_faster'         took 10266 cycles per page
copy_page function 'no_prefetch'         took 8451 cycles per page
willy@pcw:c$ ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 16409 cycles per page
copy_page function '2.4 non MMX'         took 17547 cycles per page
copy_page function '2.4 MMX fallback'    took 17516 cycles per page
copy_page function '2.4 MMX version'     took 16354 cycles per page
copy_page function 'faster_copy'         took 9807 cycles per page
copy_page function 'even_faster'         took 10219 cycles per page
copy_page function 'no_prefetch'         took 8442 cycles per page

--- several minutes later ---

willy@pcw:c$ ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 18140 cycles per page
copy_page function '2.4 non MMX'         took 20370 cycles per page
copy_page function '2.4 MMX fallback'    took 20361 cycles per page
copy_page function '2.4 MMX version'     took 18086 cycles per page
copy_page function 'faster_copy'         took 10231 cycles per page
copy_page function 'even_faster'         took 10457 cycles per page
copy_page function 'no_prefetch'         took 8456 cycles per page

=> it seems that the memory areas have changed and that it is a bit
slower now. But as you can see, no_prefetch is stable. Only "common"
functions get slower.

So I tried to allocate hundreds of MB of RAM to swap a bit, then free it.
The results look better again :

willy@pcw:c$ ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 16135 cycles per page
copy_page function '2.4 non MMX'         took 17863 cycles per page
copy_page function '2.4 MMX fallback'    took 17866 cycles per page
copy_page function '2.4 MMX version'     took 16057 cycles per page
copy_page function 'faster_copy'         took 9669 cycles per page
copy_page function 'even_faster'         took 10176 cycles per page
copy_page function 'no_prefetch'         took 8433 cycles per page

=> "common" implementations seem to really suffer from physical location.

Other data :
------------

willy@pcw:c$ cat /proc/pci
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 17).
      Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xfc000000 [0xfdffffff].
      Prefetchable 32 bit memory at 0xfb800000 [0xfb800fff].
      I/O at 0xe800 [0xe803].

willy@pcw:c$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 1800+
stepping        : 2
cpu MHz         : 1546.000
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3080.19

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 1800+
stepping        : 2
cpu MHz         : 1546.000
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3086.74


Cheers,
Willy

