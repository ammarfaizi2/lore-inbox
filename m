Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTD1XBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTD1XBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:01:17 -0400
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:8355
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S261409AbTD1XBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:01:10 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Mon, 28 Apr 2003 16:12:17 -0700
MIME-Version: 1.0
Subject: Crash in vm86() on SMP boxes with vesa driver?
Message-ID: <3EAD52E1.8313.19D8E33B@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

We ran into a problem with the VESA services crashing in our code on SMP 
machines, and as a test we checked the XFree86 vesa driver module and 
found that it has the same problem. The machine in question is a Red Hat 
8.0 box with the latest 2.4.20 kernel on it (but the problem happened 
with the stock kernel and kernels lower then .20 as well). Unfortunately 
I don't have access to the box (it is in Australia), but I have access to 

the bug report information (and will try to configure a box soon to 
reproduce it here). Anyway the folowing is the error log produced by 
XFree86 when the crash occurs:

  (II) VESA(0): VBESetVBEMode failed(EE) VESA(0): vm86() syscall 
generated
  signal 11.

I guess this answers your question ... ;)

(II) VESA(0): initializing int10
(WW) VESA(0): Bad V_BIOS checksum
(II) VESA(0): Primary V_BIOS segment is: 0xc000
(II) VESA(0): VESA BIOS detected
(II) VESA(0): VESA VBE Version 2.0
(II) VESA(0): VESA VBE Total Mem: 32768 kB
(II) VESA(0): VESA VBE OEM: ATI RAGE128
(II) VESA(0): VESA VBE OEM Software Rev: 1.0
(II) VESA(0): VESA VBE OEM Vendor: ATI Technologies Inc.
(II) VESA(0): VESA VBE OEM Product: R128
(II) VESA(0): VESA VBE OEM Product Rev: 01.00
(==) VESA(0): Write-combining range (0xf0000000,0x2000000)
(II) VESA(0): virtual address = 0x402d7000,
        physical address = 0xf0000000, size = 33554432
(II) VESA(0): VBESetVBEMode failed(EE) VESA(0): vm86() syscall generated
signal 11. 
(II) VESA(0): EAX=0x00000150, EBX=0x00000ba0, ECX=0x00000000, 
EDX=0x00000000
(II) VESA(0): ESP=0x00000fba, EBP=0x00000001, ESI=0x00000bc3, 
EDI=0x00003ad7
(II) VESA(0): CS=0xc000, SS=0x0100, DS=0x0000, ES=0xc000, FS=0x0000, 
GS=0x0000 (II) VESA(0): EIP=0x0000800f, EFLAGS=0x00033006 
(II) VESA(0): code at 0x000c800f:
 62 18 91 60 09 fa 03 85 27 11 27 11 9d 0f f4 81
 fe 06 d0 1a 68 74 99 a9 c6 39 f9 6d 04 b4 d6 6b
(II) stack at 0x00001fba:
 df 15 00 20 00 00 37 3e 00 00 b0 0f 00 00 dc 0f
 00 00 00 04 00 00 9f 00 00 00 1b 80 00 00 e2 00
 00 00 00 00 00 c0 87 4b 20 14 00 c0 1a 42 1b c1
 00 00 00 01 00 00 00 00 00 20 40 00 00 00 86 4b
 00 06 00 00 00 32

(EE) VESA(0): Set VBE Mode failed!

Also from debugging our own code we have a bit more information about 
where the problem occurs, and it occurs on the return from the vm86() 
system call when the code tries to pop the EBX register from the stack. 
Which kind of indicates that the kernel screwed up the return stack of 
the program for some reason:

Program received signal SIGSEGV, Segmentation fault.
0x4007cafb in vm86 (vm=0x4016d9cc) at linux/pm.c:102

(gdb) bt

#0  0x4007cafb in vm86 (vm=0x4016d9cc) at linux/pm.c:102
#1  0x4007fb0f in run_vm86 () at linux/pm.c:1610
#2  0x4007fd0a in PM_int86 (intno=16, in=0xbffff260, out=0xbffff260) at
#linux/pm.c:1653 3  0x400afcaa in DRV_configure (forcedMem=0) at
#config.c:210 4  0x400af176 in DRV_initDriver () at
#/a/scitech/private/src/snap/graphics/drivers/gdetect.c:524 5  0x400944f4
#in _GA_initInternal (dc=0x4019fd40, device=0)
    at /a/scitech/private/src/snap/graphics/gainit.c:1231
#6  0x4009651d in LoadDriver (deviceIndex=0, shared=0, info=0x8072550,
    drivername=0xbffff780 "null.drv", busType=5) at
    /a/scitech/private/src/snap/graphics/gainit.c:2255
#7  0x40096d56 in __GA_loadDriver (deviceIndex=0, shared=0)
    at /a/scitech/private/src/snap/graphics/gainit.c:2808
#8  0x4009712e in GA_loadDriver (deviceIndex=0, shared=0)
    at /a/scitech/private/src/snap/graphics/gainit.c:2919
#9  0x0804c9d0 in main ()
#10 0x401fc907 in __libc_start_main () from /lib/libc.so.6

Program received signal SIGSEGV, Segmentation fault.
0x4007cafb in vm86 (vm=0x4016d9cc) at linux/pm.c:102
102         asm volatile (
(gdb) list
97      static int
98      vm86(struct vm86_struct *vm)
99          {
100         int r;
101     #ifdef __PIC__
102         asm volatile (
103          "pushl %%ebx\n\t"
104          "movl %2, %%ebx\n\t"
105          "int $0x80\n\t"
106          "popl %%ebx"

Dump of assembler code for function vm86:
0x4007cae0 <vm86>:      push   %ebp
0x4007cae1 <vm86+1>:    mov    %esp,%ebp
0x4007cae3 <vm86+3>:    sub    $0x8,%esp
0x4007cae6 <vm86+6>:    mov    $0x71,%edx
0x4007caeb <vm86+11>:   mov    0x8(%ebp),%eax
0x4007caee <vm86+14>:   mov    %eax,0xfffffff8(%ebp)
0x4007caf1 <vm86+17>:   mov    %edx,%eax
0x4007caf3 <vm86+19>:   mov    0xfffffff8(%ebp),%ecx
0x4007caf6 <vm86+22>:   push   %ebx
0x4007caf7 <vm86+23>:   mov    %ecx,%ebx
0x4007caf9 <vm86+25>:   int    $0x80
0x4007cafb <vm86+27>:   pop    %ebx
0x4007cafc <vm86+28>:   mov    %eax,0xfffffff8(%ebp)
0x4007caff <vm86+31>:   mov    0xfffffff8(%ebp),%eax
0x4007cb02 <vm86+34>:   mov    %eax,0xfffffffc(%ebp)
0x4007cb05 <vm86+37>:   mov    0xfffffffc(%ebp),%eax
0x4007cb08 <vm86+40>:   mov    %eax,%eax
0x4007cb0a <vm86+42>:   mov    %ebp,%esp
0x4007cb0c <vm86+44>:   pop    %ebp
0x4007cb0d <vm86+45>:   ret
End of assembler dump.

(gdb) info frame
Stack level 0, frame at 0xbffff208:
 eip = 0x4007cafb in vm86 (linux/pm.c:102); saved eip 0x4007fb0f
 called by frame at 0xbffff238
 source language c.
 Arglist at 0xbffff208, args: vm=0x4016d9cc
 Locals at 0xbffff208, Previous frame's sp is 0x0
 Saved registers:
  ebp at 0xbffff208, eip at 0xbffff20c

(gdb) info args
vm = (struct vm86_struct *) 0x4016d9cc

(gdb) info locals
r = 1

(gdb) info reg
eax            0x0      0
ecx            0x4016d9cc       1075239372
edx            0x71     113
ebx            0x4016d9cc       1075239372
esp            0xbffff1fc       0xbffff1fc
ebp            0xbffff208       0xbffff208
esi            0x4019c4e0       1075430624
edi            0x17c    380
eip            0x4007cafb       0x4007cafb
eflags         0x203286 2110086
cs             0x23     35
ss             0x2b     43
ds             0x2b     43
es             0x2b     43
fs             0x0      0
gs             0x0      0
fctrl          0x37f    895
fstat          0x0      0
ftag           0xffff   65535
fiseg          0x0      0
fioff          0x0      0
foseg          0x0      0
fooff          0x0      0
fop            0x0      0
xmm0           {f = {0x0, 0x0, 0x0, 0x0}}       {f = {0, 0, 0, 0}}
xmm1           {f = {0x0, 0x0, 0x0, 0x0}}       {f = {0, 0, 0, 0}}
xmm2           {f = {0x0, 0x0, 0x0, 0x0}}       {f = {0, 0, 0, 0}}
xmm3           {f = {0x0, 0x0, 0x0, 0x0}}       {f = {0, 0, 0, 0}}
xmm4           {f = {0x0, 0x0, 0x0, 0x0}}       {f = {0, 0, 0, 0}}
xmm5           {f = {0x0, 0x0, 0x0, 0x0}}       {f = {0, 0, 0, 0}}
xmm6           {f = {0x0, 0x0, 0x0, 0x0}}       {f = {0, 0, 0, 0}}
xmm7           {f = {0x0, 0x0, 0x0, 0x0}}       {f = {0, 0, 0, 0}}
mxcsr          0x1f80   8064
orig_eax       0x71     113

(gdb) x/32w $esp-64
0xbffff1bc:     0x401c4598      0x00000001      0x00000000      
0x400355e4
0xbffff1cc:     0x00004000      0x40321da0      0x40321cfc      
0x00000089
0xbffff1dc:     0x08075198      0x000000e9      0x042801bf      
0xbffff218
0xbffff1ec:     0x4007f6d0      0x40259010      0x40259004      
0xbffff218
0xbffff1fc:     0x4017dc54      0x4016d9cc      0x00000001      
0xbffff238
0xbffff20c:     0x4007fb0f      0x4016d9cc      0x4017dc54      
0xbffff238
0xbffff21c:     0x4007fbd5      0x4016d9cc      0x4017dc54      
0xbffff248
0xbffff22c:     0x4007fd02      0x00000001      0x4017dc54      
0xbffff248

Any ideas? I am not sure how to start debuging this (assuming I can get 
my SMP machine up and running and reproduce it) in the kernel. Also the 
machine that the problem occurs on goes to the customer tomorrow, so we 
won't be able to debug this much ourselves until I can get a new machine 
to reproduce it. But, it would seem to me that others may well have seen 
this problem already?

Note that I have also posted this message to the XFree86 developer 
mailing list since I am not sure if this is a Linux kernel issue or some 
other issue.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

