Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282129AbRLLVCH>; Wed, 12 Dec 2001 16:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282133AbRLLVB6>; Wed, 12 Dec 2001 16:01:58 -0500
Received: from atlas.otago.ac.nz ([139.80.32.250]:14347 "EHLO
	atlas.otago.ac.nz") by vger.kernel.org with ESMTP
	id <S282129AbRLLVBl>; Wed, 12 Dec 2001 16:01:41 -0500
Date: Thu, 13 Dec 2001 10:01:37 +1300 (NZDT)
From: Corrin Lakeland <lakeland@atlas.otago.ac.nz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 not booting with Athlon optimisations
Message-ID: <Pine.OSF.4.21.0112130954120.517863-100000@atlas.otago.ac.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I recently upgraded my system including a new MB and Duron CPU.  Things
went largely as expected until I decided to recompile the kernel (2.4.16)
for the Duron rather than a generic PII.  Immediatly after booting with
the new kernel I got oopses.  Changing kernel parameters doesn't seem to
have any effect -- Duron optimisation -> !boot.

This message seems similar to a thread a few months back called "Duron
kernel crash (i686 works)".  I posted a) because I couldn't find a
solution at the end of that thread and b) I could be wrong about it being
the same.

These oopses occur very early in the boot sequence, and while they occured
at non-deterministic points I never got much further than mounting /
before an oops.  Running ksymoops was a little tricky since I couldn't
boot with the optimised kernel but by passing init=/bin/sh I was able to
get a prompt.  At this prompt everything worked perfectly for a while
until suddenly every command started giving a oops, except for shell
builtins.

The output (below) implies things died in mm/filemap.c (filemap_nopage),
although I'm a bit suspicious of the oops messages, especially after the
first one.

System specs:

Processor: AMD Duron 900MHz
MB: Soltek MK20N (built in video,sound,networking, KLX and VIA chipsets)
  -- the MB is a piece of junk and I wonder if it integral to the problem
Ram: 1*256MB, 1*512MB PC133 SDRAM.
/dev/hda Seagate ST317242A ATA
No PCI slots are used, the one ISA slot holds my 33.6 hardware modem.

I've tried two hard drives and reformatted with badblocks testing, so I'm
relativly confident it isn't a hard drive failure, although lilo reports
Int 0x13 function 8 and function 0x48 return different head/sector
geometries so it might be related to the controller.

I've also tested the memory using memtest86.  I didn't run the full suite
but it was passing everything both with and without the cache.

The system isn't perfectly stable apart from this:  I was getting random
freezes with the hard drive access light on.  They seemed to only occur
when I was running two tasks accessing the hdd.  I've added a call to
hdparm at startup (-d 1 -c 1 -u 1) and they appear to have gone away.  
This wasn't necessary before I upgraded the MB/CPU.

I was also getting infrequent random console messages saying "spurious
8259 interrupt: IRQ7" until I disabled LPT in the bios.

The motherboards built in networking (RTL8139) informs me it is only going
to work in half-duplex based on auto-negotiated abilities 00000.  This
might be correct, I don't know what the 8139 can do.

I've tried fiddling with various bios settings, caches, wait states, APCI,
APM, but none seem to affect the oopses.

So, I can avoid having any problems by just compiling the kernel for the
PII, but I'd kinda like to actually work out the cause and get things
working properly.  Does anybody have any ideas?

<oops messages follow>

No modules in ksyms, skipping objects
Dec 12 22:34:05 (none) kernel: c0122657
Dec 12 22:34:05 (none) kernel: Oops: 0000
Dec 12 22:34:05 (none) kernel: CPU:    0
Dec 12 22:34:05 (none) kernel: EIP:    0010:[__find_get_page+23/48]    Not tainted
Dec 12 22:34:05 (none) kernel: EFLAGS: 00010206
Dec 12 22:34:05 (none) kernel: eax: 0000000c   ebx: eefaaec0   ecx: ef4a81b0   edx: 0000000f
Dec 12 22:34:05 (none) kernel: esi: 00000014   edi: 0000000f   ebp: ef4a81b0   esp: eeaf5e90
Dec 12 22:34:05 (none) kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 22:34:05 (none) kernel: Process ls (pid: 73, stackpage=eeaf5000)
Dec 12 22:34:05 (none) kernel: Stack: c012371c ef4a81b0 0000000f ef5957e8 4000fda0 ef4a5140 eefaaec0 ef4a5140 
Dec 12 22:34:05 (none) kernel:        00000014 ef5957e8 ef4a8100 ef4b69c0 c0120425 eefaaec0 4000f000 00000000 
Dec 12 22:34:05 (none) kernel:        4000fda0 ef4a5140 00000000 eefaaec0 c0120522 ef4a5140 eefaaec0 4000fda0 
Dec 12 22:34:05 (none) kernel: Call Trace: [filemap_nopage+188/512] [do_no_page+69/240] [handle_mm_fault+82/176] [do_page_fault+355/1184] [do_page_fault+0/1184] 
Dec 12 22:34:05 (none) kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d b4 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 48 08                  cmp    %ecx,0x8(%eax)
Code;  00000002 Before first symbol
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> fffffff8 <END_OF_CODE+3fc96e1c/????>
Code;  00000004 Before first symbol
   5:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  00000008 Before first symbol
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> fffffff8 <END_OF_CODE+3fc96e1c/????>
Code;  0000000a Before first symbol
   a:   85 c0                     test   %eax,%eax
Code;  0000000c Before first symbol
   c:   74 03                     je     11 <_EIP+0x11> 00000010 Before first symbol
Code;  0000000e Before first symbol
   e:   ff 40 14                  incl   0x14(%eax)
Code;  00000010 Before first symbol
  11:   c3                        ret    
Code;  00000012 Before first symbol
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi

Dec 12 22:34:13 (none) kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000014
Dec 12 22:34:13 (none) kernel: c0122657
Dec 12 22:34:13 (none) kernel: Oops: 0000
Dec 12 22:34:13 (none) kernel: CPU:    0
Dec 12 22:34:13 (none) kernel: EIP:    0010:[__find_get_page+23/48]    Not tainted
Dec 12 22:34:13 (none) kernel: EFLAGS: 00010206
Dec 12 22:34:13 (none) kernel: eax: 0000000c   ebx: eefaae40   ecx: ef4a81b0   edx: 0000000f
Dec 12 22:34:13 (none) kernel: esi: 00000014   edi: 0000000f   ebp: ef4a81b0   esp: eea4de90
Dec 12 22:34:13 (none) kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 22:34:13 (none) kernel: Process ls (pid: 74, stackpage=eea4d000)
Dec 12 22:34:13 (none) kernel: Stack: c012371c ef4a81b0 0000000f ef5957e8 4000fda0 ef4a5140 eefaae40 ef4a5140 
Dec 12 22:34:13 (none) kernel:        00000014 ef5957e8 ef4a8100 eebb7c40 c0120425 eefaae40 4000f000 00000000 
Dec 12 22:34:13 (none) kernel:        4000fda0 ef4a5140 00000000 eefaae40 c0120522 ef4a5140 eefaae40 4000fda0 
Dec 12 22:34:13 (none) kernel: Call Trace: [filemap_nopage+188/512] [do_no_page+69/240] [handle_mm_fault+82/176] [do_page_fault+355/1184] [do_page_fault+0/1184] 
Dec 12 22:34:13 (none) kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d b4 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 48 08                  cmp    %ecx,0x8(%eax)
Code;  00000002 Before first symbol
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> fffffff8 <END_OF_CODE+3fc96e1c/????>
Code;  00000004 Before first symbol
   5:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  00000008 Before first symbol
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> fffffff8 <END_OF_CODE+3fc96e1c/????>
Code;  0000000a Before first symbol
   a:   85 c0                     test   %eax,%eax
Code;  0000000c Before first symbol
   c:   74 03                     je     11 <_EIP+0x11> 00000010 Before first symbol
Code;  0000000e Before first symbol
   e:   ff 40 14                  incl   0x14(%eax)
Code;  00000010 Before first symbol
  11:   c3                        ret    
Code;  00000012 Before first symbol
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi

Dec 12 22:34:18 (none) kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000014
Dec 12 22:34:18 (none) kernel: c0122657
Dec 12 22:34:18 (none) kernel: Oops: 0000
Dec 12 22:34:18 (none) kernel: CPU:    0
Dec 12 22:34:18 (none) kernel: EIP:    0010:[__find_get_page+23/48]    Not tainted
Dec 12 22:34:18 (none) kernel: EFLAGS: 00010206
Dec 12 22:34:18 (none) kernel: eax: 0000000c   ebx: eefaaec0   ecx: ef4a81b0   edx: 0000000f
Dec 12 22:34:18 (none) kernel: esi: 00000014   edi: 0000000f   ebp: ef4a81b0   esp: eea4de90
Dec 12 22:34:18 (none) kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 22:34:18 (none) kernel: Process sync (pid: 75, stackpage=eea4d000)
Dec 12 22:34:18 (none) kernel: Stack: c012371c ef4a81b0 0000000f ef5957e8 4000fda0 ef4a5140 eefaaec0 ef4a5140 
Dec 12 22:34:18 (none) kernel:        00000014 ef5957e8 ef4a8100 ef4b69c0 c0120425 eefaaec0 4000f000 00000000 
Dec 12 22:34:18 (none) kernel:        4000fda0 ef4a5140 00000000 eefaaec0 c0120522 ef4a5140 eefaaec0 4000fda0 
Dec 12 22:34:18 (none) kernel: Call Trace: [filemap_nopage+188/512] [do_no_page+69/240] [handle_mm_fault+82/176] [do_page_fault+355/1184] [do_page_fault+0/1184] 
Dec 12 22:34:18 (none) kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d b4 

(more similar oops follow)

Corrin

--
Corrin Lakeland <lakeland@cs.otago.ac.nz> 
Department of Computer Science
University of Otago, New Zealand

