Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317519AbSGJPSb>; Wed, 10 Jul 2002 11:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSGJPSa>; Wed, 10 Jul 2002 11:18:30 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:30367 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317519AbSGJPS3>; Wed, 10 Jul 2002 11:18:29 -0400
Date: Wed, 10 Jul 2002 16:21:13 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.25ide24 BUG() in page_alloc.c::prep_new_page()
Message-ID: <Pine.SOL.3.96.1020710161557.22195A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just got the below oops while running 2.5.25ide24 (using ext3). The BUG()
triggered is the BUG_ON(PageDirty(page)); in
mm/page_alloc.c::prep_new_page().

Seems like a dirty page was leaked somehow...

Note this is a highmem machine (1GiB RAM) with smp and preempt enabled
(but hardware uniprocessor, hence the kernel being tainted).

kernel BUG at page_alloc.c:182!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0140367>]    Tainted: G S
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000010   ebx: c16f6b60   ecx: 01000010   edx: 00000000
esi: c03b4e38   edi: 00000001   ebp: c03b4e38   esp: f6bf7dec
ds: 0018   es: 0018   ss: 0018
Stack: 00001000 f6bf6000 00000000 0002b915 00000000 00000282 00000000
c03b4e38
       c03b4fd0 000003fd 00000000 40018000 c014064f c03b4ef0 c03b4fc8
000001d2
       c017deed f6bf6000 ffffe000 ffffe000 40018000 c0132271 f6bf7e8c
00000000
Call Trace: [<c014064f>] [<c017deed>] [<c0132271>] [<c0132647>]
[<c0140a2b>]
   [<c0132cc5>] [<c011584e>] [<c010e4dd>] [<c01555d0>] [<c0115630>]
[<c0108054>]
Code: 0f 0b b6 00 47 68 35 c0 8b 43 14 a9 00 20 00 00 74 08 0f 0b


>>EIP; c0140367 <rmqueue+377/410>   <=====

>>ebx; c16f6b60 <END_OF_CODE+11ce9ac/????>
>>ecx; 01000010 Before first symbol
>>esi; c03b4e38 <contig_page_data+b8/360>
>>ebp; c03b4e38 <contig_page_data+b8/360>
>>esp; f6bf7dec <END_OF_CODE+366cfc38/????>

Trace; c014064f <__alloc_pages+4f/1b0>
Trace; c017deed <ext3_new_inode+88d/8a0>
Trace; c0132271 <do_anonymous_page+101/4a0>
Trace; c0132647 <do_no_page+37/620>
Trace; c0140a2b <get_page_cache_size+b/20>
Trace; c0132cc5 <handle_mm_fault+95/210>
Trace; c011584e <do_page_fault+21e/535>
Trace; c010e4dd <old_mmap+ed/130>
Trace; c01555d0 <sys_fstat64+20/30>
Trace; c0115630 <do_page_fault+0/535>
Trace; c0108054 <error_code+34/40>

Code;  c0140367 <rmqueue+377/410>
00000000 <_EIP>:
Code;  c0140367 <rmqueue+377/410>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0140369 <rmqueue+379/410>
   2:   b6 00                     mov    $0x0,%dh
Code;  c014036b <rmqueue+37b/410>
   4:   47                        inc    %edi
Code;  c014036c <rmqueue+37c/410>
   5:   68 35 c0 8b 43            push   $0x438bc035
Code;  c0140371 <rmqueue+381/410>
   a:   14 a9                     adc    $0xa9,%al
Code;  c0140373 <rmqueue+383/410>
   c:   00 20                     add    %ah,(%eax)
Code;  c0140375 <rmqueue+385/410>
   e:   00 00                     add    %al,(%eax)
Code;  c0140377 <rmqueue+387/410>
  10:   74 08                     je     1a <_EIP+0x1a> c0140381
<rmqueue+391/41
0>
Code;  c0140379 <rmqueue+389/410>
  12:   0f 0b                     ud2a

Note sure if this is useful but it may indicate a problem somewhere so I
thought I would post it...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

