Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUCaHi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 02:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUCaHi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 02:38:29 -0500
Received: from gizmo02bw.bigpond.com ([144.140.70.12]:54669 "HELO
	gizmo02bw.bigpond.com") by vger.kernel.org with SMTP
	id S261798AbUCaHiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 02:38:18 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: debugging kswapd oops 2.4.26-pre6
Date: Wed, 31 Mar 2004 17:41:00 +1000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403311741.00422.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am trying to debug a reproducable oops in kmem_cache_reap.
Kernel is patched with 64 bit jiffies patch with 500HZ ticks.

System is nforce2 Albatron KM18G pro with bt878 tv card and
matrox meteorII mc rgb capture cards and some other in house
code modules to tie together gps compass etc with images.

Earlier postings
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/7341.html

Oh yeah - have run memtest86 overnight OK and can reproduce Oops
on another KM18G Pro machine with different memory, capture cards and cpu.
I forcibly power off machine, on reboot it fscks the storage drive, runs the
imaging progs and bang Oops shortly after memfree hits low watermark.

I am new to kernel debugging but have picked up on a code difference
as follows and am unsure what to make of it.

Here is my most common Oops report.

ksymoops 2.4.8 on i686 2.4.26-rd3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.4.26-rd3/ (default)
     -m /boot/System.map (specified)

 Unable to handle kernel paging request at virtual address 7e857f92
c0132357
 *pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0132357>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010897
eax: 7e857f82   ebx: 000009df   ecx: c121e1d8   edx: 00000000
esi: 00000002   edi: 00000000   ebp: 00000000   esp: c13f5f38
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c13f5000)
Stack: c110b0c0 000001d0 00000000 c121e1c8 00000000 00000000 00000020 000001d0
       c031c5f8 c031c5f8 c013362c c13f5f84 000001d0 0000003c 00000020 c01336c3
       c13f5f84 c13f4000 00000000 00000000 c031c5f8 c13f4000 c031c520 00000000 
Call Trace:    [<c013362c>] [<c01336c3>] [<c013386e>] [<c01338c9>] [<c01339ed>]
  [<c0133960>] [<c0105000>] [<c010578b>] [<c0133960>]
Code: 8b 50 10 85 d2 74 08 0f 0b ff 06 1c f1 2c c0 8b 00 43 39 c8


>>EIP; c0132357 <kmem_cache_reap+77/1f0>   <=====

>>ecx; c121e1d8 <_end+e6462c/1e4e84d4>
>>esp; c13f5f38 <_end+103c38c/1e4e84d4>

Trace; c013362c <shrink_caches+1c/60>
Trace; c01336c3 <try_to_free_pages_zone+53/e0>
Trace; c013386e <kswapd_balance_pgdat+5e/a0>
Trace; c01338c9 <kswapd_balance+19/30>
Trace; c01339ed <kswapd+8d/b0>
Trace; c0133960 <kswapd+0/b0>
Trace; c0105000 <_stext+0/0>
Trace; c010578b <arch_kernel_thread+2b/40>
Trace; c0133960 <kswapd+0/b0>

Code;  c0132357 <kmem_cache_reap+77/1f0>
00000000 <_EIP>:(gdb) disassemble kmem_cache_reap

Code;  c0132357 <kmem_cache_reap+77/1f0>   <=====
   0:   8b 50 10                  mov    0x10(%eax),%edx   <=====
Code;  c013235a <kmem_cache_reap+7a/1f0>
   3:   85 d2                     test   %edx,%edx
Code;  c013235c <kmem_cache_reap+7c/1f0>
   5:   74 08                     je     f <_EIP+0xf>
Code;  c013235e <kmem_cache_reap+7e/1f0>
   7:   0f 0b                     ud2a   
Code;  c0132360 <kmem_cache_reap+80/1f0>
   9:   ff 06                     incl   (%esi)
Code;  c0132362 <kmem_cache_reap+82/1f0>
   b:   1c f1                     sbb    $0xf1,%al
Code;  c0132364 <kmem_cache_reap+84/1f0>
   d:   2c c0                     sub    $0xc0,%al
Code;  c0132366 <kmem_cache_reap+86/1f0>
   f:   8b 00                     mov    (%eax),%eax
Code;  c0132368 <kmem_cache_reap+88/1f0>
  11:   43                        inc    %ebx
Code;  c0132369 <kmem_cache_reap+89/1f0>
  12:   39 c8                     cmp    %ecx,%eax

Here is relevant code from same running kernel on epox 8rga+ machine
matches above (no capture cards and no custom kern modules). 

gdb vmlinux /proc/kcore
(gdb) disassemble kmem_cache_reap


0xc0132357 <kmem_cache_reap+119>:       mov    0x10(%eax),%edx
0xc013235a <kmem_cache_reap+122>:       test   %edx,%edx
0xc013235c <kmem_cache_reap+124>:       je     0xc0132366 <kmem_cache_reap+134>
0xc013235e <kmem_cache_reap+126>:       ud2a
0xc0132360 <kmem_cache_reap+128>:       incl   (%esi)
0xc0132362 <kmem_cache_reap+130>:       sbb    $0xf1,%al
0xc0132364 <kmem_cache_reap+132>:       sub    $0xc0,%al
0xc0132366 <kmem_cache_reap+134>:       mov    (%eax),%eax
0xc0132368 <kmem_cache_reap+136>:       inc    %ebx
0xc0132369 <kmem_cache_reap+137>:       cmp    %ecx,%eax



Here is result of objdump of slab.o in kernel source tree.

   d97:       8b 50 10                mov    0x10(%eax),%edx
     d9a:       85 d2                   test   %edx,%edx
     d9c:       74 08                   je     da6 <kmem_cache_reap+0x86>
     d9e:       0f 0b                   ud2a
     da0:       ff 06                   incl   (%esi)
     da2:       00 00                   add    %al,(%eax)
     da4:       00 00                   add    %al,(%eax)
     da6:       8b 00                   mov    (%eax),%eax
     da8:       43                      inc    %ebx
     da9:       39 c8                   cmp    %ecx,%eax

I note the differences? Oops and running kernel have sbb and sub,
slab.o does not and has add add instead?
Is this expected? perhaps some normal fixup on relocation?

Regards
Ross Dickson





