Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUHFLvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUHFLvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 07:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUHFLvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 07:51:21 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:30604 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S265800AbUHFLvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 07:51:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 6 Aug 2004 07:51:07 -0400
User-Agent: KMail/1.6.82
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040806073739.GA6617@elte.hu> <20040806004231.143c8bd2.akpm@osdl.org>
In-Reply-To: <20040806004231.143c8bd2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408060751.07605.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.63.211] at Fri, 6 Aug 2004 06:51:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 August 2004 03:42, Andrew Morton wrote:
>Ingo Molnar <mingo@elte.hu> wrote:
>> [btw., it would be nice to dump
>>  instructions prior the crash point so that we could know
>> precisely what prefetch instruction the kernel included.]
>
>I've had a patch (from Keith) to do that in -mm for over a year, and
>ksymoops has supported it for that long.  But I think Linus has some
>problem-which-I-never-understood with the whole idea.
>
>
>
>
>This teaches the i386 oops dumper to dump opcodes preceding and
> after the offending EIP.  Supporting code against ksymoops has been
> tested and produces output like the below.
>
>Support for this was added to ksymoops-2.4.9.
>
>Note that ksymoops will guarantee that the disassembly after the
> <eip> value is always in sync - if the disassembly from the start
> of the Code: line does not sync up with the EIP address ksymoops
> will perform the resync.
>
>
>Warning (merge_maps): no symbols in merged map
>Mar 18 23:47:36 vmm kernel: kernel BUG at fs/open.c:802!
>Mar 18 23:47:36 vmm kernel: invalid operand: 0000 [#1]
>Mar 18 23:47:36 vmm kernel: CPU:    0
>Mar 18 23:47:36 vmm kernel: EIP:    0060:[<c014fedf>] VLI    Not
> tainted Using defaults from ksymoops -t elf32-i386 -a i386
>Mar 18 23:47:36 vmm kernel: EFLAGS: 00010246
>Mar 18 23:47:36 vmm kernel: eax: ccdfb900   ebx: 4001020d   ecx:
> 00000000   edx: 0000007b Mar 18 23:47:36 vmm kernel: esi: 00000000 
>  edi: bfffdd70   ebp: ccdfdfbc   esp: ccdfdfb0 Mar 18 23:47:36 vmm
> kernel: ds: 007b   es: 007b   ss: 0068
>Mar 18 23:47:36 vmm kernel: Stack: 4001020d 00000000 bfffdd70
> ccdfc000 c0109213 4001020d 00000000 00000003 Mar 18 23:47:36 vmm
> kernel:        00000000 bfffdd70 bfffdc88 00000005 0000007b
> 0000007b 00000005 4000ef94 Mar 18 23:47:36 vmm kernel:       
> 00000073 00000206 bfffdbd8 0000007b Mar 18 23:47:36 vmm kernel:
> Call Trace:
>Mar 18 23:47:36 vmm kernel:  [<c0109213>] syscall_call+0x7/0xb
>Mar 18 23:47:36 vmm kernel: Code: 14 98 f0 81 41 04 00 00 00 01 5b
> 89 ec 5d c3 90 b8 00 e0 ff ff 21 e0 55 89 e5 57 56 53 8b 00 81 b8
> e4 01 00 00 0f 27 00 00 75 08 <0f> 0b 22 03 85 18 2f c0 8b 45 08 50
> e8 30 d4 00 00 89 c7 83 c4
>
>>>EIP; c014fedf No symbols available   <=====
>
>Trace; c0109213 No symbols available
>
>This architecture has variable length instructions, decoding before
> eip is unreliable, take these instructions with a pinch of salt.
>
>Code;  c014feb4 No symbols available
>00000000 <_EIP>:
>Code;  c014feb4 No symbols available
>   0:   14 98                     adc    $0x98,%al
>Code;  c014feb6 No symbols available
>   2:   f0 81 41 04 00 00 00      lock addl $0x1000000,0x4(%ecx)
>Code;  c014febd No symbols available
>   9:   01
>Code;  c014febe No symbols available
>   a:   5b                        pop    %ebx
>Code;  c014febf No symbols available
>   b:   89 ec                     mov    %ebp,%esp
>Code;  c014fec1 No symbols available
>   d:   5d                        pop    %ebp
>Code;  c014fec2 No symbols available
>   e:   c3                        ret
>Code;  c014fec3 No symbols available
>   f:   90                        nop
>Code;  c014fec4 No symbols available
>  10:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
>Code;  c014fec9 No symbols available
>  15:   21 e0                     and    %esp,%eax
>Code;  c014fecb No symbols available
>  17:   55                        push   %ebp
>Code;  c014fecc No symbols available
>  18:   89 e5                     mov    %esp,%ebp
>Code;  c014fece No symbols available
>  1a:   57                        push   %edi
>Code;  c014fecf No symbols available
>  1b:   56                        push   %esi
>Code;  c014fed0 No symbols available
>  1c:   53                        push   %ebx
>Code;  c014fed1 No symbols available
>  1d:   8b 00                     mov    (%eax),%eax
>Code;  c014fed3 No symbols available
>  1f:   81 b8 e4 01 00 00 0f      cmpl   $0x270f,0x1e4(%eax)
>Code;  c014feda No symbols available
>  26:   27 00 00
>Code;  c014fedd No symbols available
>  29:   75 08                     jne    33 <_EIP+0x33> c014fee7 No
> symbols available
>
>This decode from eip onwards should be reliable
>
>Code;  c014fedf No symbols available
>00000000 <_EIP>:
>Code;  c014fedf No symbols available   <=====
>   0:   0f 0b                     ud2a      <=====
>Code;  c014fee1 No symbols available
>   2:   22 03                     and    (%ebx),%al
>Code;  c014fee3 No symbols available
>   4:   85 18                     test   %ebx,(%eax)
>Code;  c014fee5 No symbols available
>   6:   2f                        das
>Code;  c014fee6 No symbols available
>   7:   c0 8b 45 08 50 e8 30      rorb   $0x30,0xe8500845(%ebx)
>Code;  c014feed No symbols available
>   e:   d4 00                     aam    $0x0
>Code;  c014feef No symbols available
>  10:   00                        .byte 0x0
>Code;  c014fef0 No symbols available
>  11:   89 c7                     mov    %eax,%edi
>Code;  c014fef2 No symbols available
>  13:   83                        .byte 0x83
>Code;  c014fef3 No symbols available
>  14:   c4                        .byte 0xc4
>
>
>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> 25-akpm/arch/i386/kernel/traps.c |   18 ++++++++++--------
> 1 files changed, 10 insertions(+), 8 deletions(-)
>
>diff -puN arch/i386/kernel/traps.c~oops-dump-preceding-code
> arch/i386/kernel/traps.c ---
> 25/arch/i386/kernel/traps.c~oops-dump-preceding-code	2004-06-28
> 00:47:26.807038944 -0700 +++
> 25-akpm/arch/i386/kernel/traps.c	2004-06-28 00:47:26.812038184
> -0700 @@ -250,7 +250,7 @@ void show_registers(struct pt_regs *regs
> ss = regs->xss & 0xffff;
> 	}
> 	print_modules();
>-	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx"
>+	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\nEFLAGS:
> %08lx" "   (%s) \n",
> 		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
> 		print_tainted(), regs->eflags, UTS_RELEASE);
>@@ -268,23 +268,25 @@ void show_registers(struct pt_regs *regs
> 	 * time of the fault..
> 	 */
> 	if (in_kernel) {
>+		u8 *eip;
>
> 		printk("\nStack: ");
> 		show_stack(NULL, (unsigned long*)esp);
>
> 		printk("Code: ");
>-		if(regs->eip < PAGE_OFFSET)
>-			goto bad;
>
>-		for(i=0;i<20;i++)
>-		{
>+		eip = (u8 *)regs->eip - 43;
>+		for (i = 0; i < 64; i++, eip++) {
> 			unsigned char c;
>-			if(__get_user(c, &((unsigned char*)regs->eip)[i])) {
>-bad:
>+
>+			if (eip < (u8 *)PAGE_OFFSET || __get_user(c, eip)) {
> 				printk(" Bad EIP value.");
> 				break;
> 			}
>-			printk("%02x ", c);
>+			if (eip == (u8 *)regs->eip)
>+				printk("<%02x> ", c);
>+			else
>+				printk("%02x ", c);
> 		}
> 	}
> 	printk("\n");
>_

Veddy veddy Interestink.

Linus, Andrew, should I apply this patch too at the next remake?

FWIW, I'm still up (20:38) this morning, and showing plenty (127+ 
megs) of free memory.  No crash, no odd log (other than samba 
squawking about some option thats been changed & I haven't fixed the 
smb.conf) so far.

I'm beginning to like this test patch, Linus, thanks :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
