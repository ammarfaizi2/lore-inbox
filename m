Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317961AbSGPUGW>; Tue, 16 Jul 2002 16:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317968AbSGPUGW>; Tue, 16 Jul 2002 16:06:22 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45725 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317961AbSGPUGT>; Tue, 16 Jul 2002 16:06:19 -0400
Message-ID: <3D347D41.7020803@us.ibm.com>
Date: Tue, 16 Jul 2002 13:08:33 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: oops in  __free_pages_ok
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By counting BUG()s it looks like this is happening at
index = page_idx >> (1 + order);

It popped up when we applied the new 2.5.25 kernprof port.  It could 
be a problem there, but I don't think that kernprof is doing much this 
early in the boot process (while "Initializing CPU#0").

No modules in ksyms, skipping objects
CPU:    0
EIP:    0010:[<c0135d52>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000202
eax: 0fffffff   ebx: c1000130   ecx: c02d78bc   edx: c02d78bc
esi: c1000018   edi: 00000007   ebp: c02f7f6c   esp: c02f7f40
ds: 0018   es: 0018   ss: 0018
Stack: c03b3000 c1000130 00000007 c02f6000 c02d7ba0 c1000018 000007ae 
c02f7f7c
        f0000000 00000282 c02d78bc c02f7f74 c01365d9 c02f7fa4 c0303248 
00000003
        0009b800 c0105000 00000080 ffffff80 c03b3000 00038000 00000000 
00000001
Call Trace: [<c01365d9>] [<c0105000>] [<c0105000>] [<c0105000>]
Code: 8b 45 fc 40 89 fe 89 c1 d3 ee 89 75 f8 8b 4d fc 8d 04 49 8b

 >>EIP; c0135d52 <__free_pages_ok+11e/29c>   <=====
Trace; c01365d9 <__free_pages+29/30>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Code;  c0135d52 <__free_pages_ok+11e/29c>
00000000 <_EIP>:
Code;  c0135d52 <__free_pages_ok+11e/29c>   <=====
    0:   8b 45 fc                  mov    0xfffffffc(%ebp),%eax   <=====
Code;  c0135d55 <__free_pages_ok+121/29c>
    3:   40                        inc    %eax
Code;  c0135d56 <__free_pages_ok+122/29c>
    4:   89 fe                     mov    %edi,%esi
Code;  c0135d58 <__free_pages_ok+124/29c>
    6:   89 c1                     mov    %eax,%ecx
Code;  c0135d5a <__free_pages_ok+126/29c>
    8:   d3 ee                     shr    %cl,%esi
Code;  c0135d5c <__free_pages_ok+128/29c>
    a:   89 75 f8                  mov    %esi,0xfffffff8(%ebp)
Code;  c0135d5f <__free_pages_ok+12b/29c>
    d:   8b 4d fc                  mov    0xfffffffc(%ebp),%ecx
Code;  c0135d62 <__free_pages_ok+12e/29c>
   10:   8d 04 49                  lea    (%ecx,%ecx,2),%eax
Code;  c0135d65 <__free_pages_ok+131/29c>
   13:   8b 00                     mov    (%eax),%eax

  <0>Kernel panic: Attempted to kill the idle task!


<SNIP>
7 BUG()s so far...
0xc0135d1d <__free_pages_ok+233>:	mov    %eax,0xffffffe4(%ebp)
0xc0135d20 <__free_pages_ok+236>:	mov    $0xffffffff,%eax
0xc0135d25 <__free_pages_ok+241>:	mov    0xfffffffc(%ebp),%ecx
0xc0135d28 <__free_pages_ok+244>:	shl    %cl,%eax
0xc0135d2a <__free_pages_ok+246>:	mov    %eax,0xfffffff4(%ebp)
0xc0135d2d <__free_pages_ok+249>:	mov    0xffffffe4(%ebp),%esi
0xc0135d30 <__free_pages_ok+252>:	mov    0xa0(%esi),%esi
0xc0135d36 <__free_pages_ok+258>:	mov    %esi,0xffffffe8(%ebp)
0xc0135d39 <__free_pages_ok+261>:	mov    %ebx,%edi
0xc0135d3b <__free_pages_ok+263>:	sub    %esi,%edi
0xc0135d3d <__free_pages_ok+265>:	imul   $0xcccccccd,%edi,%eax
0xc0135d43 <__free_pages_ok+271>:	mov    %eax,%edi
0xc0135d45 <__free_pages_ok+273>:	sar    $0x3,%edi
0xc0135d48 <__free_pages_ok+276>:	mov    0xfffffff4(%ebp),%eax
0xc0135d4b <__free_pages_ok+279>:	not    %eax
0xc0135d4d <__free_pages_ok+281>:	test   %eax,%edi
0xc0135d4f <__free_pages_ok+283>:	je     0xc0135d52 <__free_pages_ok+286>
8th BUG():
0xc0135d51 <__free_pages_ok+285>:	int3
0xc0135d52 <__free_pages_ok+286>:	mov    0xfffffffc(%ebp),%eax
0xc0135d55 <__free_pages_ok+289>:	inc    %eax
0xc0135d56 <__free_pages_ok+290>:	mov    %edi,%esi
0xc0135d58 <__free_pages_ok+292>:	mov    %eax,%ecx
---Type <return> to continue, or q <return> to quit---
0xc0135d5a <__free_pages_ok+294>:	shr    %cl,%esi
0xc0135d5c <__free_pages_ok+296>:	mov    %esi,0xfffffff8(%ebp)
0xc0135d5f <__free_pages_ok+299>:	mov    0xfffffffc(%ebp),%ecx
0xc0135d62 <__free_pages_ok+302>:	lea    (%ecx,%ecx,2),%eax
0xc0135d65 <__free_pages_ok+305>:	mov    0xffffffe4(%ebp),%esi
0xc0135d68 <__free_pages_ok+308>:	lea    0x18(%esi,%eax,4),%eax
0xc0135d6c <__free_pages_ok+312>:	mov    %eax,0xffffffec(%ebp)
0xc0135d6f <__free_pages_ok+315>:	pushf
0xc0135d70 <__free_pages_ok+316>:	popl   0xfffffff0(%ebp)
0xc0135d73 <__free_pages_ok+319>:	cli
0xc0135d74 <__free_pages_ok+320>:	lock decb (%esi)
0xc0135d77 <__free_pages_ok+323>:	js     0xc01369b0 
<.text.lock.page_alloc>
0xc0135d7d <__free_pages_ok+329>:	mov    0xfffffff4(%ebp),%ecx
0xc0135d80 <__free_pages_ok+332>:	sub    %ecx,0x4(%esi)
0xc0135d83 <__free_pages_ok+335>:	cmp    $0xfffffe00,%ecx
0xc0135d89 <__free_pages_ok+341>:	je     0xc0135ea4 <__free_pages_ok+624>
0xc0135d8f <__free_pages_ok+347>:	nop
0xc0135d90 <__free_pages_ok+348>:	mov    0xffffffe4(%ebp),%eax
0xc0135d93 <__free_pages_ok+351>:	add    $0x90,%eax
0xc0135d98 <__free_pages_ok+356>:	cmp    %eax,0xffffffec(%ebp)
0xc0135d9b <__free_pages_ok+359>:	jb     0xc0135da0 <__free_pages_ok+364>
0xc0135d9d <__free_pages_ok+361>:	int3
0xc0135d9e <__free_pages_ok+362>:	mov    %esi,%esi
0xc0135da0 <__free_pages_ok+364>:	mov    0xffffffec(%ebp),%esi
0xc0135da3 <__free_pages_ok+367>:	mov    0x8(%esi),%edx
0xc0135da6 <__free_pages_ok+370>:	mov    0xfffffff8(%ebp),%ecx
0xc0135da9 <__free_pages_ok+373>:	btc    %ecx,(%edx)
0xc0135dac <__free_pages_ok+376>:	sbb    %eax,%eax
0xc0135dae <__free_pages_ok+378>:	test   %eax,%eax
0xc0135db0 <__free_pages_ok+380>:	je     0xc0135ea4 <__free_pages_ok+624>
<snip again>

If you want the whole thing, you know where my cube is :)  Martin and 
I could chase this further, but you wrote the function, right?

-- 
Dave Hansen
haveblue@us.ibm.com

