Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287563AbSAIP00>; Wed, 9 Jan 2002 10:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287578AbSAIP0S>; Wed, 9 Jan 2002 10:26:18 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:1385 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S287563AbSAIP0K>; Wed, 9 Jan 2002 10:26:10 -0500
Date: Wed, 9 Jan 2002 17:26:04 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Jani Forssell <jani.forssell@viasys.com>,
        sak@iki.fi
Subject: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
Message-ID: <20020109172604.N1331@niksula.cs.hut.fi>
In-Reply-To: <20020108215818.J1331@niksula.cs.hut.fi> <E16O2fD-0007Vn-00@the-village.bc.nu> <20020108221315.U1200@niksula.cs.hut.fi> <20020109144549.L1331@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020109144549.L1331@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Wed, Jan 09, 2002 at 02:45:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 02:45:49PM +0200, you [Ville Herva] claimed:
>
> We also got the oops with 2.2.20+patches, so this is not a pre2 thing.
> Rather, the difference is that we now ran ping -f on background.
> 
> The bad news is that all the bios setting configurations we thought stable
> (that had run the hpt370 read/write test without a hitch for days) now give
> oopses and corruption pretty quickly when we run ping -f on background :(.
> 
> Also, ping -f shows "...EEE.EE.EEE.." which I gather means the packets get
> corrupted somewhere.

It also happens with _pristine_ 2.4.18pre2. I ran

cat /dev/hde > /dev/null& cat /dev/hdg > /dev/null& ping -f -s 64000 box2

in single user mode. (hde and hdg are Samsung 80GB disks on HPT370, eth0 is
3c905). After just few seconds I got the following oops:

Unable to handle kernel paging request at virtual address 1d292ee9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131ce0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: 00000000   ebx: 1d292ed1   ecx: 000001d0   edx: 00000000
esi: 00000000   edi: cf12e940   ebp: c10acb80   esp: c1433f0c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1433000)
Stack: c10acb80 cf12ef40 cf12e940 c0131e37 cf12e940 c10acb80 000001d0 00000017 
       00000200 c013066a c10acb80 000001d0 00000000 c10acb80 c01282f7 c10acb80 
       000001d0 00000020 000001d0 00000020 00000006 00000006 000022a5 000001d0 
Call Trace: [<c0131e37>] [<c013066a>] [<c01282f7>] [<c012852b>] [<c012859c>] 
   [<c0128653>] [<c01286c6>] [<c01287e7>] [<c0105000>] [<c0105523>] 
Code: f6 43 18 06 0f 84 7f 00 00 00 b8 07 00 00 00 0f ab 43 18 19 

>>EIP; c0131ce0 <sync_page_buffers+10/b0>   <=====
Trace; c0131e37 <try_to_free_buffers+b7/e0>
Trace; c013066a <try_to_release_page+3a/40>
Trace; c01282f7 <shrink_cache+1b7/2c0>
Trace; c012852b <shrink_caches+5b/90>
Trace; c012859c <try_to_free_pages+3c/60>
Trace; c0128653 <kswapd_balance_pgdat+53/b0>
Trace; c01286c6 <kswapd_balance+16/30>
Trace; c01287e7 <kswapd+a7/d0>
Trace; c0105000 <_stext+0/0>
Trace; c0105523 <kernel_thread+23/30>
Code;  c0131ce0 <sync_page_buffers+10/b0>
00000000 <_EIP>:
Code;  c0131ce0 <sync_page_buffers+10/b0>   <=====
   0:   f6 43 18 06               testb  $0x6,0x18(%ebx)   <=====
Code;  c0131ce4 <sync_page_buffers+14/b0>
   4:   0f 84 7f 00 00 00         je     89 <_EIP+0x89> c0131d69
<sync_page_buffers+99/b0>
Code;  c0131cea <sync_page_buffers+1a/b0>
   a:   b8 07 00 00 00            mov    $0x7,%eax
Code;  c0131cef <sync_page_buffers+1f/b0>
   f:   0f ab 43 18               bts    %eax,0x18(%ebx)
Code;  c0131cf3 <sync_page_buffers+23/b0>
  13:   19 00                     sbb    %eax,(%eax)


Which is pretty similar to the 2.2.20 oopses (here's one:)

Unable to handle kernel paging request at virtual address 4d7ebf3e
current->tss.cr3 = 0e912000, %cr3 = 0e912000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0120631>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: ccf0efe0   ebx: ccf0efe0   ecx: 4d7ebf3e   edx: ccf0ee00
esi: 00000800   edi: cffef740   ebp: 00000282   esp: cf05fc9c
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 708, process nr: 29, stackpage=cf05f000)
Stack: 00000000 00000400 c0126db5 cffef740 00000005 ccf0ee00 00000000 c0126e42 
       00000000 00000400 00000400 cc908000 00002100 cf05fcdc cf05fcdc cf05e000 
       cf05e000 00000000 c0127615 cc908000 00000400 00000000 00000000 00000400 
Call Trace: [<c0126db5>] [<c0126e42>] [<c0127615>] [<c012679e>] [<c012695a>]
[<c0129ac1>] [<c0111fb6>] 
       [<c0111fb6>] [<c011255b>] [<c017e988>] [<c018015d>] [<c0196ad9>]
[<c0181bad>] [<c0196a7c>] [<c015dc19>] 
       [<c0165a18>] [<c015dc19>] [<c0165a18>] [<c01661a9>] [<c016560b>]
[<c01659d6>] [<c015f5a1>] [<c0124fc9>] 
       [<c0124ece>] [<c0108924>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 73 04 85 f6 75 10 89 19 89 c8 2b 

>>EIP; c0120631 <kmem_cache_alloc+31/124>   <=====
Trace; c0126db5 <get_unused_buffer_head+55/a0>
Trace; c0126e42 <create_buffers+42/198>
Trace; c0127615 <grow_buffers+55/fc>
Trace; c012679e <refill_freelist+a/38>
Trace; c012695a <getblk+11e/144>
Trace; c0129ac1 <block_read+2c1/4f4>
Trace; c0111fb6 <wake_up_process+3a/44>
Trace; c0111fb6 <wake_up_process+3a/44>
Trace; c011255b <__wake_up+4f/6c>
Trace; c017e988 <end_that_request_last+28/2c>
Trace; c018015d <ide_end_request+61/6c>
Trace; c0196ad9 <ide_dma_intr+5d/94>
Trace; c0181bad <ide_intr+111/130>
Trace; c0196a7c <ide_dma_intr+0/94>
Trace; c015dc19 <alloc_skb+71/dc>
Trace; c0165a18 <ip_frag_create+18/60>
Trace; c015dc19 <alloc_skb+71/dc>
Trace; c0165a18 <ip_frag_create+18/60>
Trace; c01661a9 <ip_defrag+2f9/360>
Trace; c016560b <ip_local_deliver+2f/1c4>
Trace; c01659d6 <ip_rcv+236/260>
Trace; c015f5a1 <net_bh+181/1dc>
Trace; c0124fc9 <sys_write+e5/118>
Trace; c0124ece <sys_read+ae/c4>
Trace; c0108924 <system_call+34/38>
Code;  c0120631 <kmem_cache_alloc+31/124>
00000000 <_EIP>:
Code;  c0120631 <kmem_cache_alloc+31/124>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0120633 <kmem_cache_alloc+33/124>
   2:   89 03                     mov    %eax,(%ebx)
Code;  c0120635 <kmem_cache_alloc+35/124>
   4:   85 c0                     test   %eax,%eax
Code;  c0120637 <kmem_cache_alloc+37/124>
   6:   74 2b                     je     33 <_EIP+0x33> c0120664
<kmem_cache_all
oc+64/124>
Code;  c0120639 <kmem_cache_alloc+39/124>
   8:   8b 73 04                  mov    0x4(%ebx),%esi
Code;  c012063c <kmem_cache_alloc+3c/124>
   b:   85 f6                     test   %esi,%esi
Code;  c012063e <kmem_cache_alloc+3e/124>
   d:   75 10                     jne    1f <_EIP+0x1f> c0120650
<kmem_cache_all
oc+50/124>
Code;  c0120640 <kmem_cache_alloc+40/124>
   f:   89 19                     mov    %ebx,(%ecx)
Code;  c0120642 <kmem_cache_alloc+42/124>
  11:   89 c8                     mov    %ecx,%eax
Code;  c0120644 <kmem_cache_alloc+44/124>
  13:   2b 00                     sub    (%eax),%eax


This is with the bios settings we thought stable. 

Any ideas?


-- v --

v@iki.fi
