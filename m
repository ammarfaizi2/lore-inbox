Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267201AbSKUXm1>; Thu, 21 Nov 2002 18:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbSKUXm1>; Thu, 21 Nov 2002 18:42:27 -0500
Received: from palrel10.hp.com ([156.153.255.245]:21120 "HELO palrel10.hp.com")
	by vger.kernel.org with SMTP id <S267201AbSKUXlL>;
	Thu, 21 Nov 2002 18:41:11 -0500
Date: Thu, 21 Nov 2002 15:45:37 -0800
From: Martin Pool <mbp@sourcefrog.net>
To: linux-kernel@vger.kernel.org
Cc: dgibson@samba.org
Subject: oops in 2.4.19 shrink_icache_memory (with orinoco_cs?)
Message-ID: <20021121234536.GA1433@toey.sourcefrog.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG: 1024D/A0B3E88B: AFAC578F 1841EE6B FD95E143 3C63CA3F A0B3E88B
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a series of oopses on an IBM T20 laptop when it was moderately
loaded (running dpkg):

Nov 22 09:42:58 toey kernel: Unable to handle kernel paging request at virtual address 9cae5bf5
Nov 22 09:42:58 toey kernel: c014c392
Nov 22 09:42:58 toey kernel: *pde = 00000000
Nov 22 09:42:58 toey kernel: Oops: 0000
Nov 22 09:42:58 toey kernel: CPU:    0
Nov 22 09:42:58 toey kernel: EIP:    0010:[prune_icache+50/224]    Not tainted
Nov 22 09:42:58 toey kernel: EFLAGS: 00010293
Nov 22 09:42:58 toey kernel: eax: 00000001   ebx: c007f740   ecx: 00000001   edx: c007f740
Nov 22 09:42:58 toey kernel: esi: 9cae5bf1   edi: 9cae5bf1   ebp: 00001177   esp: c147bf40
Nov 22 09:42:58 toey kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 09:42:58 toey kernel: Process kswapd (pid: 5, stackpage=c147b000)
Nov 22 09:42:58 toey kernel: Stack: c007f740 0000211e c007f588 d298e3c8 00000007 000001d0 00000020 00000006 
Nov 22 09:42:58 toey kernel:        c014c464 00003295 c01300f3 00000006 000001d0 c0316fd0 00000006 000001d0 
Nov 22 09:42:58 toey kernel:        c0316fd0 00000000 c0130146 00000020 c0316fd0 00000001 c147a000 c01301ee 
Nov 22 09:42:58 toey kernel: Call Trace:    [shrink_icache_memory+36/64] [shrink_caches+131/160] [try_to_free_pages+54/80] [kswapd_balance_pgdat+94/176] [kswapd_balance+40/64]
Nov 22 09:42:58 toey kernel: Code: 8b 7f 04 8d 5e f8 8b 83 f8 00 00 00 a9 38 00 00 00 75 08 0b 
Using defaults from ksymoops -t elf32-i386 -a i386


>>esp; c147bf40 <_end+10d4ffc/18ca411c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
   3:   8d 5e f8                  lea    0xfffffff8(%esi),%ebx
Code;  00000006 Before first symbol
   6:   8b 83 f8 00 00 00         mov    0xf8(%ebx),%eax
Code;  0000000c Before first symbol
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  00000011 Before first symbol
  11:   75 08                     jne    1b <_EIP+0x1b>
Code;  00000013 Before first symbol
  13:   0b 00                     or     (%eax),%eax

Nov 22 09:53:50 toey kernel:  <1>Unable to handle kernel paging request at virtual address 9cae5bf5
Nov 22 09:53:50 toey kernel: c014c392
Nov 22 09:53:50 toey kernel: *pde = 00000000
Nov 22 09:53:50 toey kernel: Oops: 0000
Nov 22 09:53:50 toey kernel: CPU:    0
Nov 22 09:53:50 toey kernel: EIP:    0010:[prune_icache+50/224]    Not tainted
Nov 22 09:53:50 toey kernel: EFLAGS: 00013293
Nov 22 09:53:50 toey kernel: eax: 00000001   ebx: c007f740   ecx: 00000001   edx: c007f740
Nov 22 09:53:50 toey kernel: esi: 9cae5bf1   edi: 9cae5bf1   ebp: 0000395a   esp: d793be1c
Nov 22 09:53:50 toey kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 09:53:50 toey kernel: Process XFree86 (pid: 6023, stackpage=d793b000)
Nov 22 09:53:50 toey kernel: Stack: c007f740 00000000 d793be24 d793be24 00000012 000001d2 00000020 00000006 
Nov 22 09:53:51 toey kernel:        c014c464 0000395a c01300f3 00000006 000001d2 c0316fd0 00000006 000001d2 
Nov 22 09:53:52 toey kernel:        c0316fd0 c0316fd0 c0130146 00000020 d793a000 00000000 00000010 c0130f39 
Nov 22 09:53:52 toey kernel: Call Trace:    [shrink_icache_memory+36/64] [shrink_caches+131/160] [try_to_free_pages+54/80] [balance_classzone+89/464] [__alloc_pages+247/416]
Nov 22 09:53:53 toey kernel: Code: 8b 7f 04 8d 5e f8 8b 83 f8 00 00 00 a9 38 00 00 00 75 08 0b 


>>esp; d793be1c <_end+17594ed8/18ca411c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
   3:   8d 5e f8                  lea    0xfffffff8(%esi),%ebx
Code;  00000006 Before first symbol
   6:   8b 83 f8 00 00 00         mov    0xf8(%ebx),%eax
Code;  0000000c Before first symbol
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  00000011 Before first symbol
  11:   75 08                     jne    1b <_EIP+0x1b>
Code;  00000013 Before first symbol
  13:   0b 00                     or     (%eax),%eax

Nov 22 09:57:19 toey kernel:  <1>Unable to handle kernel paging request at virtual address 9cae5bf5
Nov 22 09:57:19 toey kernel: c014c392
Nov 22 09:57:19 toey kernel: *pde = 00000000
Nov 22 09:57:19 toey kernel: Oops: 0000
Nov 22 09:57:19 toey kernel: CPU:    0
Nov 22 09:57:19 toey kernel: EIP:    0010:[prune_icache+50/224]    Not tainted
Nov 22 09:57:19 toey kernel: EFLAGS: 00010293
Nov 22 09:57:19 toey kernel: eax: 00000001   ebx: c007f740   ecx: 00000001   edx: c007f740
Nov 22 09:57:19 toey kernel: esi: 9cae5bf1   edi: 9cae5bf1   ebp: 00003d9f   esp: cdaade18
Nov 22 09:57:19 toey kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 09:57:19 toey kernel: Process dpkg-deb (pid: 12350, stackpage=cdaad000)
Nov 22 09:57:19 toey kernel: Stack: c007f740 0000000c c6467048 c61f7ac8 00000001 000001d2 00000020 00000006 
Nov 22 09:57:19 toey kernel:        c014c464 00003dab c01300f3 00000006 000001d2 c0316fd0 00000006 000001d2 
Nov 22 09:57:19 toey kernel:        c0316fd0 c0316fd0 c0130146 00000020 cdaac000 00000000 00000010 c0130f39 
Nov 22 09:57:19 toey kernel: Call Trace:    [shrink_icache_memory+36/64] [shrink_caches+131/160] [try_to_free_pages+54/80] [balance_classzone+89/464] [__alloc_pages+247/416]
Nov 22 09:57:20 toey kernel: Code: 8b 7f 04 8d 5e f8 8b 83 f8 00 00 00 a9 38 00 00 00 75 08 0b 


>>esp; cdaade18 <_end+d706ed4/18ca411c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
   3:   8d 5e f8                  lea    0xfffffff8(%esi),%ebx
Code;  00000006 Before first symbol
   6:   8b 83 f8 00 00 00         mov    0xf8(%ebx),%eax
Code;  0000000c Before first symbol
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  00000011 Before first symbol
  11:   75 08                     jne    1b <_EIP+0x1b>
Code;  00000013 Before first symbol
  13:   0b 00                     or     (%eax),%eax

Nov 22 09:57:20 toey kernel:  <1>Unable to handle kernel paging request at virtual address 9cae5bf5
Nov 22 09:57:20 toey kernel: c014c392
Nov 22 09:57:20 toey kernel: *pde = 00000000
Nov 22 09:57:21 toey kernel: Oops: 0000
Nov 22 09:57:22 toey kernel: CPU:    0
Nov 22 09:57:22 toey kernel: EIP:    0010:[prune_icache+50/224]    Not tainted
Nov 22 09:57:22 toey kernel: EFLAGS: 00010293
Nov 22 09:57:22 toey kernel: eax: 00000001   ebx: c007f740   ecx: 00000001   edx: c007f740
Nov 22 09:57:22 toey kernel: esi: 9cae5bf1   edi: 9cae5bf1   ebp: 000041b5   esp: cdaafe1c
Nov 22 09:57:22 toey kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 09:57:22 toey kernel: Process install-info (pid: 12358, stackpage=cdaaf000)
Nov 22 09:57:22 toey kernel: Stack: c007f740 00000000 cdaafe24 cdaafe24 00000007 000001d2 00000020 00000006 
Nov 22 09:57:22 toey kernel:        c014c464 000041b5 c01300f3 00000006 000001d2 c0316fd0 00000006 000001d2 
Nov 22 09:57:22 toey kernel:        c0316fd0 c0316fd0 c0130146 00000020 cdaae000 00000000 00000010 c0130f39 
Nov 22 09:57:22 toey kernel: Call Trace:    [shrink_icache_memory+36/64] [shrink_caches+131/160] [try_to_free_pages+54/80] [balance_classzone+89/464] [__alloc_pages+247/416]
Nov 22 09:57:22 toey kernel: Code: 8b 7f 04 8d 5e f8 8b 83 f8 00 00 00 a9 38 00 00 00 75 08 0b 


>>esp; cdaafe1c <_end+d708ed8/18ca411c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
   3:   8d 5e f8                  lea    0xfffffff8(%esi),%ebx
Code;  00000006 Before first symbol
   6:   8b 83 f8 00 00 00         mov    0xf8(%ebx),%eax
Code;  0000000c Before first symbol
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  00000011 Before first symbol
  11:   75 08                     jne    1b <_EIP+0x1b>
Code;  00000013 Before first symbol
  13:   0b 00                     or     (%eax),%eax


This machine has previously been quite stable running this kernel, but
I just got a Netgear MA401 wireless card and started using it with the
2.4.19 orinoco_cs driver.  The card and module weren't installed at
the time of the crash, but they had been earlier in the day.  Could it
be a bug in that driver?

http://groups.google.com/groups?q=shrink_icache_memory&hl=en&lr=&ie=UTF-8&scoring=d&selm=20021028102439.GB13490%40carfax.org.uk&rnum=4

-- 
Martin
