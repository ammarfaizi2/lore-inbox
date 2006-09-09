Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWIIMpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWIIMpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 08:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWIIMpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 08:45:40 -0400
Received: from novell.stoldgods.nu ([83.150.147.20]:44756 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP id S932120AbWIIMpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 08:45:39 -0400
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc6-mm1
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Disposition: inline
Date: Sat, 9 Sep 2006 14:45:32 +0200
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200609091445.32744.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Sorry, forgot to CC lkml when I sent the first one.

Andrew Morton wrote:
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> 
> - autofs4 mounting of NFS is still sick.

I got this oops on my machine when I ran df on another one which have 
mounted a few NFS shares from my machine. I got 5 more pretty much 
identical ones within 10 seconds after the first one (haven't seen 
any more after these though). Also, dmesg is filled with, about a 
gazillion of these:
[15164.017991] RPC request reserved 9136 but used 9268
[15164.037431] RPC request reserved 9136 but used 9268
[15164.052988] RPC request reserved 9136 but used 9268

Files are also getting corrupted when transfered from my machine, but 
using my machine as client works fine.

oops here:

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
BUG: unable to handle kernel NULL pointer dereference at virtual 
address 00000000
c04ad300
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c04ad300>]    Tainted: P      VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210212   (2.6.18-rc6-mm1 #1)
eax: 00000000   ebx: e5299000   ecx: 00000000   edx: e8843620
esi: e5299070   edi: ffff84de   ebp: e52a0fb0   esp: e52a0f70
ds: 007b   es: 007b   ss: 0068
Stack: 00200046 eb499aa0 00000001 eb499a84 00000000 e52a0f9c c04eaa1b 
eb499a84
       00000001 e8843620 e529904c e52a0fb0 c012d70b 00000002 ffff84de 
ffff84de
       e52a0fe0 c02784ba e5299000 e52a0fc4 00000000 fffffeff ffffffff 
fffffef8
Call Trace:
 [<c01041bf>] show_trace_log_lvl+0x2f/0x50
 [<c01042a7>] show_stack_log_lvl+0x97/0xc0
 [<c0104532>] show_registers+0x1f2/0x2a0
 [<c01047dd>] die+0x12d/0x240
 [<c011735c>] do_page_fault+0x3ac/0x650
 [<c04eaeef>] error_code+0x3f/0x44
 [<c02784ba>] nfsd+0x18a/0x2b0
 [<c0103fb7>] kernel_thread_helper+0x7/0x10
Code: 89 45 e8 8b 52 28 83 c6 70 89 55 e4 8b 40 04 83 f8 17 0f 86 6d 
04 00 00 8b 5d 08 8b 83 9c 04 00 00 c7 83 a0 04 00 00 01 00 00 00 
<8b> 00 89 04 24 e8 06 d4 ca ff c7 46 04 00 00 00 00 89 c1 89 43


>>EIP; c04ad300 <svc_process+40/6a0>   <=====

Trace; c01041bf <show_trace_log_lvl+2f/50>
Trace; c01042a7 <show_stack_log_lvl+97/c0>
Trace; c0104532 <show_registers+1f2/2a0>
Trace; c01047dd <die+12d/240>
Trace; c011735c <do_page_fault+3ac/650>
Trace; c04eaeef <error_code+3f/44>
Trace; c02784ba <nfsd+18a/2b0>
Trace; c0103fb7 <kernel_thread_helper+7/10>

This architecture has variable length instructions, decoding before 
eip
is unreliable, take these instructions with a pinch of salt.

Code;  c04ad2d5 <svc_process+15/6a0>
00000000 <_EIP>:
Code;  c04ad2d5 <svc_process+15/6a0>
   0:   89 45 e8                  mov    %eax,0xffffffe8(%ebp)
Code;  c04ad2d8 <svc_process+18/6a0>
   3:   8b 52 28                  mov    0x28(%edx),%edx
Code;  c04ad2db <svc_process+1b/6a0>
   6:   83 c6 70                  add    $0x70,%esi
Code;  c04ad2de <svc_process+1e/6a0>
   9:   89 55 e4                  mov    %edx,0xffffffe4(%ebp)
Code;  c04ad2e1 <svc_process+21/6a0>
   c:   8b 40 04                  mov    0x4(%eax),%eax
Code;  c04ad2e4 <svc_process+24/6a0>
   f:   83 f8 17                  cmp    $0x17,%eax
Code;  c04ad2e7 <svc_process+27/6a0>
  12:   0f 86 6d 04 00 00         jbe    485 <_EIP+0x485>
Code;  c04ad2ed <svc_process+2d/6a0>
  18:   8b 5d 08                  mov    0x8(%ebp),%ebx
Code;  c04ad2f0 <svc_process+30/6a0>
  1b:   8b 83 9c 04 00 00         mov    0x49c(%ebx),%eax
Code;  c04ad2f6 <svc_process+36/6a0>
  21:   c7 83 a0 04 00 00 01      movl   $0x1,0x4a0(%ebx)
Code;  c04ad2fd <svc_process+3d/6a0>
  28:   00 00 00 

This decode from eip onwards should be reliable

Code;  c04ad300 <svc_process+40/6a0>
00000000 <_EIP>:
Code;  c04ad300 <svc_process+40/6a0>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c04ad302 <svc_process+42/6a0>
   2:   89 04 24                  mov    %eax,(%esp)
Code;  c04ad305 <svc_process+45/6a0>
   5:   e8 06 d4 ca ff            call   ffcad410 <_EIP+0xffcad410>
Code;  c04ad30a <svc_process+4a/6a0>
   a:   c7 46 04 00 00 00 00      movl   $0x0,0x4(%esi)
Code;  c04ad311 <svc_process+51/6a0>
  11:   89 c1                     mov    %eax,%ecx
Code;  c04ad313 <svc_process+53/6a0>
  13:   89                        .byte 0x89
Code;  c04ad314 <svc_process+54/6a0>
  14:   43                        inc    %ebx

EIP: [<c04ad300>] svc_process+0x40/0x6a0 SS:ESP 0068:e52a0f70
Warning (Oops_read): Code line not seen, dumping what data is 
available


>>EIP; c04ad300 <svc_process+40/6a0>   <=====


2 warnings and 1 error issued.  Results may not be reliable.
