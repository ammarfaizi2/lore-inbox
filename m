Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbTFBKLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 06:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbTFBKLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 06:11:06 -0400
Received: from main.gmane.org ([80.91.224.249]:63634 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262144AbTFBKLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 06:11:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Andres Salomon" <dilinger@voxel.net>
Subject: problem w/ 2.5.70-mm3 and modules
Date: Mon, 02 Jun 2003 06:24:21 -0400
Message-ID: <bbf8gc$uc$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.0 (The whole remains beautiful (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On sparc64, loading of modules (dm-mod, at least) triggers a BUG_ON() in
apply_relocate_add() (arch/sparc64/kernel/module.c):


dilinger@lag:~$ ksymoops oops
ksymoops 2.4.8 on sparc64 2.5.70-mm3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.70-mm3/ (default)
     -m /boot/System.map-2.5.70-mm3 (default)
 
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.
 
Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
modprobe(65): Kernel bad sw trap 5 [#1]
TSTATE: 0000000011009606 TPC: 000000000043b1a0 TNPC: 000000000043b1a4 Y: ffffee00    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 00000000005b1c00 g1: 0000000000000000 g2: 00000001400129a4 g3: 0000000000000000
g4: fffff80031c1e080 g5: 0000000000000000 g6: fffff80000ca0000 g7: 0000000000000000
o0: 0000000000000004 o1: 0000000000000001 o2: 0000000000000000 o3: 00000001400129a0
o4: 0000000140014028 o5: 0000000140017c48 sp: fffff80000ca3321 ret_pc: 0000000140017c48
l0: 00000000000019f8 l1: 0000000140018278 l2: 0000000000000116 l3: 0000000000000116
l4: 000000000000fff1 l5: 0000000000000000 l6: 000000000000fff2 l7: 0000000000588ac0
i0: 0000000140013b28 i1: 0000000140019c88 i2: 0000000000000014 i3: 0000000000000006
i4: 00000000020054e8 i5: 0000000000000004 i6: fffff80000ca33e1 i7: 000000000045d948
Instruction DUMP: 8402c008  9330b020  80a26000 <93d03005> d25b6008  d45b2010  97327020  d85b6010  9002c00b
 
 
>>PC;  0043b1a0 <apply_relocate_add+60/2a0>   <=====
 
>>g0; 005b1c00 <init_sighand+618/a08>
>>l7; 00588ac0 <masks.3+28/40>
>>i7; 0045d948 <load_module+668/7c0>
 
Code;  0043b194 <apply_relocate_add+54/2a0>
00000000 <_PC>:
Code;  0043b194 <apply_relocate_add+54/2a0>
   0:   84 02 c0 08       add  %o3, %o0, %g2
Code;  0043b198 <apply_relocate_add+58/2a0>
   4:   93 30 b0 20       unknown
Code;  0043b19c <apply_relocate_add+5c/2a0>
   8:   80 a2 60 00       cmp  %o1, 0
Code;  0043b1a0 <apply_relocate_add+60/2a0>   <=====
   c:   93 d0 30 05       tne  -4091   <=====
Code;  0043b1a4 <apply_relocate_add+64/2a0>
  10:   d2 5b 60 08       unknown
Code;  0043b1a8 <apply_relocate_add+68/2a0>
  14:   d4 5b 20 10       unknown
Code;  0043b1ac <apply_relocate_add+6c/2a0>
  18:   97 32 70 20       unknown
Code;  0043b1b0 <apply_relocate_add+70/2a0>
  1c:   d8 5b 60 10       unknown
Code;  0043b1b4 <apply_relocate_add+74/2a0>
  20:   90 02 c0 0b       add  %o3, %o3, %o0
 
 
1 warning and 1 error issued.  Results may not be reliable.



Here's what's actually happening:

load_module(): relocating section header #1: name='.text', address=0x2000000; section header type=1
load_module(): relocating section header #2: name='.rela.text', address=0x1400140a8; section header type=4
apply_relocate_add(): section header address: 00000001400140a8
apply_relocate_add(): section header size: 0x3738; additional info: 1; number of relocatable symbols: 589
apply_relocate_add(): rel symbol offset=0x4; base: 0x2000000; location=0000000002000004
apply_relocate_add(): rel symbol offset=0x8; base: 0x2000000; location=0000000002000008
load_module(): relocating section header #3: name='.init.text', address=0x2008000; section header type=1
load_module(): relocating section header #4: name='.rela.init.text', address=0x1400177e0; section header type=4
apply_relocate_add(): section header address: 00000001400177e0
apply_relocate_add(): section header size: 0x468; additional info: 3; number of relocatable symbols: 47
apply_relocate_add(): rel symbol offset=0x4; base: 0x2008000; location=0000000002008004
apply_relocate_add(): rel symbol offset=0xc; base: 0x2008000; location=000000000200800c
load_module(): relocating section header #5: name='.exit.text', address=0x1400129a0; section header type=1
load_module(): relocating section header #6: name='.rela.exit.text', address=0x140017c48; section header type=4
apply_relocate_add(): section header address: 0000000140017c48
apply_relocate_add(): section header size: 0x30; additional info: 5; number of relocatable symbols: 2
apply_relocate_add(): rel symbol offset=0x4; base: 0x1400129a0; location=00000001400129a4
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/


That last base (0x1400129a0) is too large; when shifted in the
BUG_ON, the result is 0x1.  The actual BUG_ON is:
BUG_ON(((u64)location >> (u64)32) != (u64)0);

dm-mod's section info:

/lib/modules/2.5.70-mm3/kernel/drivers/md/dm-mod.ko:     file format elf64-sparc/lib/modules/2.5.70-mm3/kernel/drivers/md/dm-mod.ko
architecture: sparc:v9, flags 0x00000011:
HAS_RELOC, HAS_SYMS
start address 0x0000000000000000
                                                                                
Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00004700  0000000000000000  0000000000000000  00000040  2**5
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .init.text    00000260  0000000000000000  0000000000000000  00004740  2**5
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  2 .exit.text    00000040  0000000000000000  0000000000000000  000049a0  2**5
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  3 .rodata.str1.8 000009e0  0000000000000000  0000000000000000  000049e0  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .modinfo      000000d0  0000000000000000  0000000000000000  000053c0  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA

...


RELOCATION RECORDS FOR [.exit.text]:
OFFSET           TYPE              VALUE
0000000000000004 R_SPARC_HI22      .data+0x0000000000000010
000000000000000c R_SPARC_LO10      .data+0x0000000000000010
                                                                                

I'm not sure how to inspect dm-mod's .rela.exit.text; pointers to doing
this (assuming it's not just another name for .exit.text) would be
appreciated.  This was occurring w/ vanilla 2.5.70, as well.

