Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130092AbQL2QgF>; Fri, 29 Dec 2000 11:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131463AbQL2Qfz>; Fri, 29 Dec 2000 11:35:55 -0500
Received: from mailout3-0.nyroc.rr.com ([24.92.226.118]:47493 "EHLO
	mailout3-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S130092AbQL2Qfo>; Fri, 29 Dec 2000 11:35:44 -0500
Date: Fri, 29 Dec 2000 11:05:13 -0500
From: Karl Heinz Kremer <khk@khk.net>
To: linux-kernel@vger.kernel.org
Subject: PCI IRQ Routing Problem - Kernel OOPS
Message-ID: <20001229110513.A3661@khk.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having problems with something that looks like a PCI IRQ routing
problem. Everything worked just fine up until test12-pre7. Test12-pre8 did
not even boot, it hung when initializing the SCSI adapter.

Everything after that (including test12) booted successfully, but crashed when
I loaded the Firewire OHCI driver. All other drivers seem to work and if I
don't try to load the IEEE-1394 subsystem, then the machine runs stable.

I can observe the same problem with all test13-preX kernels up to pre5.

Here is the output of lspci -v (this was done with a 2.2.18 kernel, which 
is what I use for "normal" work):

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Flags: bus master, medium devsel, latency 16
	Memory at e0000000 (32-bit, prefetchable)
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e4000000-e7ffffff
	Prefetchable memory behind bridge: e8000000-e8ffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at 6400

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at 6800

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Flags: medium devsel

00:09.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)
	Flags: bus master, medium devsel, latency 32, IRQ 9
	Memory at ea004000 (32-bit, prefetchable)

00:0a.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
	Subsystem: Texas Instruments: Unknown device 8010
	Flags: bus master, medium devsel, latency 32, IRQ 9
	Memory at ea006000 (32-bit, non-prefetchable)
	Memory at ea000000 (32-bit, non-prefetchable)
	Capabilities: <available only to root>

00:0b.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 10/100] (rev 06)
	Subsystem: D-Link System Inc DFE-530TX
	Flags: bus master, medium devsel, latency 64, IRQ 12
	I/O ports at 6c00
	Memory at ea005000 (32-bit, non-prefetchable)
	Expansion ROM at e9000000 [disabled]

00:0c.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 7000
	Memory at ea007000 (32-bit, non-prefetchable)
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
	Flags: bus master, medium devsel, latency 64
	Memory at e8000000 (32-bit, prefetchable)
	Memory at e4000000 (32-bit, non-prefetchable)
	Memory at e5000000 (32-bit, non-prefetchable)
	Capabilities: <available only to root>


... and here is the OOPS which was captured in single user mode, if I do the same in
multi user mode the problems occurs in the sound driver, which seems to be very odd:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
d08b3669
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d08b3669>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: c149a244   ecx: c149d980   edx: c149a220
esi: c149a240   edi: c149d940   ebp: d08c0090   esp: cfb2fd58
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 52, stackpage=cfb2f000)
Stack: cff24ec0 d08c0000 00000000 00000001 00000246 c149d980 0000ffc0 00000002 
       d08b2715 d08c0000 d08c0000 d08bc1c0 d08b091d d08c0000 cfa98014 d08b79df 
       d08c0000 00000001 00000001 d08b9f00 00000000 c149a200 04000001 00000009 
Call Trace: [<d08c0000>] [<d08b2715>] [<d08c0000>] [<d08c0000>] [<d08bc1c0>] [<d08b091d>] [<d08c0000>] 
       [<d08b79df>] [<d08c0000>] [<d08b9f00>] [<d08c0000>] [<c0109f65>] [<d08bc1c0>] [<c010a0d6>] [<c0108e30>] 
       [<c011871e>] [<c010a109>] [<c0108e30>] [<c0114f86>] [<d08bc180>] [<d08bc374>] [<d08b2281>] [<d08b4180>] 
       [<d08bb42c>] [<d08bc180>] [<d08b9c34>] [<d08bc360>] [<d08b23bf>] [<d08bc180>] [<d08b4280>] [<d08bb42c>] 
       [<d08bc180>] [<d08b6000>] [<d08b9c50>] [<d08bc180>] [<c0115c70>] [<d08b0000>] [<d08b0000>] [<d08bc360>] 
       [<d08b0000>] [<d08b6060>] [<c0108d73>] 
Code: 89 18 ff 74 24 10 9d 57 e8 72 d3 ff ff 83 c4 04 85 c0 75 2e 

>>EIP; d08b3669 <_end+10591855/1070c24c>   <=====
Trace; d08c0000 <_end+1059e1ec/1070c24c>
Trace; d08b2715 <_end+10590901/1070c24c>
Trace; d08c0000 <_end+1059e1ec/1070c24c>
Trace; d08c0000 <_end+1059e1ec/1070c24c>
Trace; d08bc1c0 <_end+1059a3ac/1070c24c>
Trace; d08b091d <_end+1058eb09/1070c24c>
Trace; d08c0000 <_end+1059e1ec/1070c24c>
Trace; d08b79df <_end+10595bcb/1070c24c>
Trace; d08c0000 <_end+1059e1ec/1070c24c>
Trace; d08b9f00 <_end+105980ec/1070c24c>
Trace; d08c0000 <_end+1059e1ec/1070c24c>
Trace; c0109f65 <handle_IRQ_event+31/5c>
Trace; d08bc1c0 <_end+1059a3ac/1070c24c>
Trace; c010a0d6 <do_IRQ+6e/b4>
Trace; c0108e30 <ret_from_intr+0/20>
Trace; c011871e <do_softirq+3e/6c>
Trace; c010a109 <do_IRQ+a1/b4>
Trace; c0108e30 <ret_from_intr+0/20>
Trace; c0114f86 <printk+172/194>
Trace; d08bc180 <_end+1059a36c/1070c24c>
Trace; d08bc374 <_end+1059a560/1070c24c>
Trace; d08b2281 <_end+1059046d/1070c24c>
Trace; d08b4180 <_end+1059236c/1070c24c>
Trace; d08bb42c <_end+10599618/1070c24c>
Trace; d08bc180 <_end+1059a36c/1070c24c>
Trace; d08b9c34 <_end+10597e20/1070c24c>
Trace; d08bc360 <_end+1059a54c/1070c24c>
Trace; d08b23bf <_end+105905ab/1070c24c>
Trace; d08bc180 <_end+1059a36c/1070c24c>
Trace; d08b4280 <_end+1059246c/1070c24c>
Trace; d08bb42c <_end+10599618/1070c24c>
Trace; d08bc180 <_end+1059a36c/1070c24c>
Trace; d08b6000 <_end+105941ec/1070c24c>
Trace; d08b9c50 <_end+10597e3c/1070c24c>
Trace; d08bc180 <_end+1059a36c/1070c24c>
Trace; c0115c70 <sys_init_module+580/620>
Trace; d08b0000 <_end+1058e1ec/1070c24c>
Trace; d08b0000 <_end+1058e1ec/1070c24c>
Trace; d08bc360 <_end+1059a54c/1070c24c>
Trace; d08b0000 <_end+1058e1ec/1070c24c>
Trace; d08b6060 <_end+1059424c/1070c24c>
Trace; c0108d73 <system_call+33/40>
Code;  d08b3669 <_end+10591855/1070c24c>
00000000 <_EIP>:
Code;  d08b3669 <_end+10591855/1070c24c>   <=====
   0:   89 18                     mov    %ebx,(%eax)   <=====
Code;  d08b366b <_end+10591857/1070c24c>
   2:   ff 74 24 10               pushl  0x10(%esp,1)
Code;  d08b366f <_end+1059185b/1070c24c>
   6:   9d                        popf   
Code;  d08b3670 <_end+1059185c/1070c24c>
   7:   57                        push   %edi
Code;  d08b3671 <_end+1059185d/1070c24c>
   8:   e8 72 d3 ff ff            call   ffffd37f <_EIP+0xffffd37f> d08b09e8 <_end+1058ebd4/1070c24c>
Code;  d08b3676 <_end+10591862/1070c24c>
   d:   83 c4 04                  add    $0x4,%esp
Code;  d08b3679 <_end+10591865/1070c24c>
  10:   85 c0                     test   %eax,%eax
Code;  d08b367b <_end+10591867/1070c24c>
  12:   75 2e                     jne    42 <_EIP+0x42> d08b36ab <_end+10591897/1070c24c>

Kernel panic: Aiee, killing interrupt handler!



The machine has an AOPEN AX59 motherboard with the latest BIOS updates, just to rule
out a problem with the newest BIOS I flashed the system with a BIOS version that is
about 1 1/2 years old.

Have a great new year,

Karl Heinz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
