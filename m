Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSJXVky>; Thu, 24 Oct 2002 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSJXVkx>; Thu, 24 Oct 2002 17:40:53 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:18425 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S265670AbSJXVkg>; Thu, 24 Oct 2002 17:40:36 -0400
Date: Thu, 24 Oct 2002 17:46:45 -0400
From: Josh Fryman <fryman@cc.gatech.edu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-Id: <20021024174645.0d88e008.fryman@cc.gatech.edu>
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
References: <3DB82ABF.8030706@colorfullife.com>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; sparc-sun-solaris2.8)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


several reports herein.  first, machine specs.  then, multiple compiler 
outputs with different compiler versions.  no real substantial variation
regardless of flags for best-case time.

machine is also loaded running services like web server, ssh sessions, etc.
not a heavy load, but may be a slight impact.

machine specs:
    1.33 GHz Athlon (non-XP)
    Asus A7V333 motherboard (Fast memory settings)
    512 (2x256) MB DDR-SDRAM  Crucial (Cas 2)


++++++++++++++
/proc/cpuinfo:
--------------

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1332.992
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
bogomips        : 2660.76


++++++++++
/proc/pci:
----------

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8367 [KT266] (rev 0).
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   5, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
16).      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xd800 [0xd8ff].
  Bus  0, device   6, function  0:
    RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 1).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=18.
      I/O at 0xd400 [0xd407].
      I/O at 0xd000 [0xd003].
      I/O at 0xb800 [0xb807].
      I/O at 0xb400 [0xb403].
      I/O at 0xb000 [0xb00f].
      Non-prefetchable 32 bit memory at 0xdb800000 [0xdb803fff].
  Bus  0, device   7, function  0:
    FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394
Controller (PHY/Link) 1394a-2000 (rev 0).      IRQ 10.
      Master Capable.  Latency=35.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xdb000000 [0xdb0007ff].
      Non-prefetchable 32 bit memory at 0xda800000 [0xda803fff].
  Bus  0, device   9, function  0:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 80).
      IRQ 5.
      Master Capable.  Latency=32.
      I/O at 0xa800 [0xa81f].
  Bus  0, device   9, function  1:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 80).
      IRQ 11.
      Master Capable.  Latency=32.
      I/O at 0xa400 [0xa41f].
  Bus  0, device  17, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (#3) (rev 35).
      IRQ 9.
      Master Capable.  Latency=32.
      I/O at 0x8800 [0x881f].
  Bus  0, device  17, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#4) (rev 35).
      IRQ 9.
      Master Capable.  Latency=32.
      I/O at 0x8400 [0x841f].
  Bus  0, device   9, function  2:
    USB Controller: VIA Technologies, Inc. USB 2.0 (rev 81).
      IRQ 10.
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xda000000 [0xda0000ff].
  Bus  0, device  13, function  0:
    Ethernet controller: Macronix, Inc. [MXIC] MX987x5 (rev 32).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      I/O at 0xa000 [0xa0ff].
      Non-prefetchable 32 bit memory at 0xd9800000 [0xd98000ff].
  Bus  0, device  15, function  0:
    Ethernet controller: Macronix, Inc. [MXIC] MX987x5 (#2) (rev 32).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      I/O at 0x9400 [0x94ff].
      Non-prefetchable 32 bit memory at 0xd8800000 [0xd88000ff].
  Bus  0, device  14, function  0:
    SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev
1).      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0x9800 [0x98ff].
      Non-prefetchable 32 bit memory at 0xd9000000 [0xd9000fff].
  Bus  0, device  16, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xde000000 [0xde000fff].
  Bus  0, device  16, function  1:
    Multimedia controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xdd800000 [0xdd800fff].
  Bus  0, device  17, function  0:
    ISA bridge: PCI device 1106:3147 (VIA Technologies, Inc.) (rev 0).
  Bus  0, device  17, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.
      I/O at 0x9000 [0x900f].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation Riva TnT [NV04] (rev
4).      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xdc000000 [0xdcffffff].
      Prefetchable 32 bit memory at 0xdf000000 [0xdfffffff].

Default gcc is gcc 2.95.3:

   chadh@goliath athlon $ gcc -v
   Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/specs
   gcc version 2.95.3 20010315 (release)

gcc-3.1 is gcc 3.1:

   chadh@goliath athlon $ gcc-3.1 -v
   Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.1/specs
   Configured with: /var/tmp/portage/gcc-3.1-r7/work/gcc-3.1/configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --host=i686-pc-linux-gnu --build=i686-pc-linux-gnu --target=i686-pc-linux-gnu --enable-threads=posix --enable-long-long --enable-cstdio=stdio --enable-clocale=generic --disable-checking --with-gxx-include-dir=/usr/include/g++-v31 --with-local-prefix=/usr/local --with-system-zlib --enable-shared --enable-nls --without-included-gettext --program-suffix=-3.1
   Thread model: posix
   gcc version 3.1
   
Results:

gcc athlon.c
-----------

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13448 cycles per page
copy_page function '2.4 non MMX'	 took 28448 cycles per page
copy_page function '2.4 MMX fallback'	 took 28420 cycles per page
copy_page function '2.4 MMX version'	 took 13446 cycles per page
copy_page function 'faster_copy'	 took 8163 cycles per page
copy_page function 'even_faster'	 took 8213 cycles per page
copy_page function 'no_prefetch'	 took 6472 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13434 cycles per page
copy_page function '2.4 non MMX'	 took 28435 cycles per page
copy_page function '2.4 MMX fallback'	 took 28453 cycles per page
copy_page function '2.4 MMX version'	 took 13361 cycles per page
copy_page function 'faster_copy'	 took 8118 cycles per page
copy_page function 'even_faster'	 took 8082 cycles per page
copy_page function 'no_prefetch'	 took 6448 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13393 cycles per page
copy_page function '2.4 non MMX'	 took 28392 cycles per page
copy_page function '2.4 MMX fallback'	 took 28148 cycles per page
copy_page function '2.4 MMX version'	 took 13419 cycles per page
copy_page function 'faster_copy'	 took 8110 cycles per page
copy_page function 'even_faster'	 took 8204 cycles per page
copy_page function 'no_prefetch'	 took 6454 cycles per page


++++++++++++++++
gcc -O3 athlon.c
----------------

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 14060 cycles per page
copy_page function '2.4 non MMX'	 took 28371 cycles per page
copy_page function '2.4 MMX fallback'	 took 28396 cycles per page
copy_page function '2.4 MMX version'	 took 13405 cycles per page
copy_page function 'faster_copy'	 took 8212 cycles per page
copy_page function 'even_faster'	 took 8494 cycles per page
copy_page function 'no_prefetch'	 took 6090 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13406 cycles per page
copy_page function '2.4 non MMX'	 took 28389 cycles per page
copy_page function '2.4 MMX fallback'	 took 28452 cycles per page
copy_page function '2.4 MMX version'	 took 13404 cycles per page
copy_page function 'faster_copy'	 took 8439 cycles per page
copy_page function 'even_faster'	 took 8260 cycles per page
copy_page function 'no_prefetch'	 took 6124 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13393 cycles per page
copy_page function '2.4 non MMX'	 took 28324 cycles per page
copy_page function '2.4 MMX fallback'	 took 28338 cycles per page
copy_page function '2.4 MMX version'	 took 13399 cycles per page
copy_page function 'faster_copy'	 took 8431 cycles per page
copy_page function 'even_faster'	 took 8126 cycles per page
copy_page function 'no_prefetch'	 took 6122 cycles per page


+++++++++++++++++++++++++++++++++++++++
gcc -O3 -march=i686 -mcpu=i686 athlon.c
---------------------------------------

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13345 cycles per page
copy_page function '2.4 non MMX'	 took 28367 cycles per page
copy_page function '2.4 MMX fallback'	 took 28351 cycles per page
copy_page function '2.4 MMX version'	 took 13458 cycles per page
copy_page function 'faster_copy'	 took 8420 cycles per page
copy_page function 'even_faster'	 took 8260 cycles per page
copy_page function 'no_prefetch'	 took 6119 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13398 cycles per page
copy_page function '2.4 non MMX'	 took 28401 cycles per page
copy_page function '2.4 MMX fallback'	 took 28186 cycles per page
copy_page function '2.4 MMX version'	 took 14125 cycles per page
copy_page function 'faster_copy'	 took 8209 cycles per page
copy_page function 'even_faster'	 took 8306 cycles per page
copy_page function 'no_prefetch'	 took 6115 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13436 cycles per page
copy_page function '2.4 non MMX'	 took 28450 cycles per page
copy_page function '2.4 MMX fallback'	 took 28395 cycles per page
copy_page function '2.4 MMX version'	 took 13429 cycles per page
copy_page function 'faster_copy'	 took 8450 cycles per page
copy_page function 'even_faster'	 took 8283 cycles per page
copy_page function 'no_prefetch'	 took 6117 cycles per page


++++++++++++++++++++++++++++++++++
gcc -O3 -march=k6 mcpu=k6 athlon.c
----------------------------------

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13369 cycles per page
copy_page function '2.4 non MMX'	 took 28292 cycles per page
copy_page function '2.4 MMX fallback'	 took 28058 cycles per page
copy_page function '2.4 MMX version'	 took 13381 cycles per page
copy_page function 'faster_copy'	 took 8461 cycles per page
copy_page function 'even_faster'	 took 8520 cycles per page
copy_page function 'no_prefetch'	 took 6113 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13414 cycles per page
copy_page function '2.4 non MMX'	 took 28120 cycles per page
copy_page function '2.4 MMX fallback'	 took 28994 cycles per page
copy_page function '2.4 MMX version'	 took 13391 cycles per page
copy_page function 'faster_copy'	 took 8238 cycles per page
copy_page function 'even_faster'	 took 8577 cycles per page
copy_page function 'no_prefetch'	 took 6136 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13489 cycles per page
copy_page function '2.4 non MMX'	 took 28185 cycles per page
copy_page function '2.4 MMX fallback'	 took 28417 cycles per page
copy_page function '2.4 MMX version'	 took 13464 cycles per page
copy_page function 'faster_copy'	 took 8277 cycles per page
copy_page function 'even_faster'	 took 8334 cycles per page
copy_page function 'no_prefetch'	 took 6132 cycles per page


++++++++++++++++
gcc-3.1 athlon.c
----------------

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13447 cycles per page
copy_page function '2.4 non MMX'	 took 28371 cycles per page
copy_page function '2.4 MMX fallback'	 took 28337 cycles per page
copy_page function '2.4 MMX version'	 took 13445 cycles per page
copy_page function 'faster_copy'	 took 8421 cycles per page
copy_page function 'even_faster'	 took 8535 cycles per page
copy_page function 'no_prefetch'	 took 6449 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13378 cycles per page
copy_page function '2.4 non MMX'	 took 28340 cycles per page
copy_page function '2.4 MMX fallback'	 took 28364 cycles per page
copy_page function '2.4 MMX version'	 took 13389 cycles per page
copy_page function 'faster_copy'	 took 8425 cycles per page
copy_page function 'even_faster'	 took 8498 cycles per page
copy_page function 'no_prefetch'	 took 6423 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13316 cycles per page
copy_page function '2.4 non MMX'	 took 28466 cycles per page
copy_page function '2.4 MMX fallback'	 took 28416 cycles per page
copy_page function '2.4 MMX version'	 took 13445 cycles per page
copy_page function 'faster_copy'	 took 8172 cycles per page
copy_page function 'even_faster'	 took 8322 cycles per page
copy_page function 'no_prefetch'	 took 6421 cycles per page


++++++++++++++++++++
gcc-3.1 -O3 athlon.c
--------------------

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13452 cycles per page
copy_page function '2.4 non MMX'	 took 28625 cycles per page
copy_page function '2.4 MMX fallback'	 took 28431 cycles per page
copy_page function '2.4 MMX version'	 took 13459 cycles per page
copy_page function 'faster_copy'	 took 8225 cycles per page
copy_page function 'even_faster'	 took 8250 cycles per page
copy_page function 'no_prefetch'	 took 6174 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13327 cycles per page
copy_page function '2.4 non MMX'	 took 28407 cycles per page
copy_page function '2.4 MMX fallback'	 took 28433 cycles per page
copy_page function '2.4 MMX version'	 took 13422 cycles per page
copy_page function 'faster_copy'	 took 8214 cycles per page
copy_page function 'even_faster'	 took 8517 cycles per page
copy_page function 'no_prefetch'	 took 6182 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13473 cycles per page
copy_page function '2.4 non MMX'	 took 28443 cycles per page
copy_page function '2.4 MMX fallback'	 took 28472 cycles per page
copy_page function '2.4 MMX version'	 took 13444 cycles per page
copy_page function 'faster_copy'	 took 8077 cycles per page
copy_page function 'even_faster'	 took 8479 cycles per page
copy_page function 'no_prefetch'	 took 6192 cycles per page


+++++++++++++++++++++++++++++++++++++++++++
gcc-3.1 -O3 -march=i686 -mcpu=i686 athlon.c
-------------------------------------------

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13424 cycles per page
copy_page function '2.4 non MMX'	 took 28320 cycles per page
copy_page function '2.4 MMX fallback'	 took 28360 cycles per page
copy_page function '2.4 MMX version'	 took 13308 cycles per page
copy_page function 'faster_copy'	 took 8437 cycles per page
copy_page function 'even_faster'	 took 8233 cycles per page
copy_page function 'no_prefetch'	 took 6132 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13414 cycles per page
copy_page function '2.4 non MMX'	 took 28406 cycles per page
copy_page function '2.4 MMX fallback'	 took 28379 cycles per page
copy_page function '2.4 MMX version'	 took 13397 cycles per page
copy_page function 'faster_copy'	 took 8202 cycles per page
copy_page function 'even_faster'	 took 8274 cycles per page
copy_page function 'no_prefetch'	 took 6182 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13361 cycles per page
copy_page function '2.4 non MMX'	 took 28395 cycles per page
copy_page function '2.4 MMX fallback'	 took 28371 cycles per page
copy_page function '2.4 MMX version'	 took 13416 cycles per page
copy_page function 'faster_copy'	 took 8271 cycles per page
copy_page function 'even_faster'	 took 8281 cycles per page
copy_page function 'no_prefetch'	 took 6186 cycles per page


++++++++++++++++++++++++++++++++++++++++++++++++
gcc-3.1 -O3 -march=athlon -mcpu=athlon athlon.c
------------------------------------------------

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13408 cycles per page
copy_page function '2.4 non MMX'	 took 28380 cycles per page
copy_page function '2.4 MMX fallback'	 took 28357 cycles per page
copy_page function '2.4 MMX version'	 took 13380 cycles per page
copy_page function 'faster_copy'	 took 8442 cycles per page
copy_page function 'even_faster'	 took 8080 cycles per page
copy_page function 'no_prefetch'	 took 6179 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13429 cycles per page
copy_page function '2.4 non MMX'	 took 28376 cycles per page
copy_page function '2.4 MMX fallback'	 took 28360 cycles per page
copy_page function '2.4 MMX version'	 took 14140 cycles per page
copy_page function 'faster_copy'	 took 8342 cycles per page
copy_page function 'even_faster'	 took 8231 cycles per page
copy_page function 'no_prefetch'	 took 6121 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13417 cycles per page
copy_page function '2.4 non MMX'	 took 28408 cycles per page
copy_page function '2.4 MMX fallback'	 took 28397 cycles per page
copy_page function '2.4 MMX version'	 took 13403 cycles per page
copy_page function 'faster_copy'	 took 8217 cycles per page
copy_page function 'even_faster'	 took 8493 cycles per page
copy_page function 'no_prefetch'	 took 6226 cycles per page


+++++++++++++++++++++++++++++++++++++++++++++++++++
gcc-3.1 -O3 -march=athlon-4 -mcpu=athlon-4 athlon.c
----------------------------------------------------

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13371 cycles per page
copy_page function '2.4 non MMX'	 took 28983 cycles per page
copy_page function '2.4 MMX fallback'	 took 28330 cycles per page
copy_page function '2.4 MMX version'	 took 13038 cycles per page
copy_page function 'faster_copy'	 took 8437 cycles per page
copy_page function 'even_faster'	 took 8509 cycles per page
copy_page function 'no_prefetch'	 took 6178 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13471 cycles per page
copy_page function '2.4 non MMX'	 took 28421 cycles per page
copy_page function '2.4 MMX fallback'	 took 28413 cycles per page
copy_page function '2.4 MMX version'	 took 13463 cycles per page
copy_page function 'faster_copy'	 took 8195 cycles per page
copy_page function 'even_faster'	 took 8508 cycles per page
copy_page function 'no_prefetch'	 took 6038 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 13408 cycles per page
copy_page function '2.4 non MMX'	 took 28326 cycles per page
copy_page function '2.4 MMX fallback'	 took 28357 cycles per page
copy_page function '2.4 MMX version'	 took 13410 cycles per page
copy_page function 'faster_copy'	 took 8202 cycles per page
copy_page function 'even_faster'	 took 8488 cycles per page
copy_page function 'no_prefetch'	 took 6174 cycles per page

