Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVJVPaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVJVPaG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 11:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVJVPaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 11:30:06 -0400
Received: from smtp.bredband2.net ([82.209.166.4]:60446 "EHLO
	smtp.bredband2.net") by vger.kernel.org with ESMTP id S1751364AbVJVPaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 11:30:04 -0400
Message-ID: <435A5AEC.8020807@home.se>
Date: Sat, 22 Oct 2005 17:29:48 +0200
From: =?ISO-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Subject: 2.6.14-rc5 e1000 and page allocation failures.. still
Content-Type: multipart/mixed;
 boundary="------------060903060407020000050202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060903060407020000050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Im seeing a massive amount of page allocation failures with 2.6.14-rc5, 
and also earlier kernels, see "E1000 - page allocation failure - saga 
continues :(". Machine is a 1Ghz Athlon with 256MB RAM. Attached is 
example dmesg output. The stack traces come in many variants. Killing 
processes using RAM only seems to help temporarily. Ive also tried 
setting vm.min_free_kbytes=16384, which used to work pretty well, but 
this does not help (atleast not in the state the machine is currently 
in, without rebooting).

free currently gives:

              total       used       free     shared    buffers     cached
Mem:        256520     239128      17392          0       5372      67500
-/+ buffers/cache:     166256      90264
Swap:       506036      21248     484788


I havent yet tried rebooting and using the vm.min_free_kbytes=16384 from 
scratch, but I think something with the default for this is wrong if it 
results in this many page allocation errors. The machine is serving 
files from an encrypted partition with reiserfs on it, and I obivously 
use the e1000 driver.

---
John Bäckstrand

--------------060903060407020000050202
Content-Type: text/plain;
 name="pagealloc.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pagealloc.txt"

[149649.847890] kcryptd/0: page allocation failure. order:3, mode:0x20
[149649.847945]  [<c01419d8>] __alloc_pages+0x318/0x440
[149649.848002]  [<c0144b0d>] kmem_getpages+0x2d/0xa0
[149649.848043]  [<c0141858>] __alloc_pages+0x198/0x440
[149649.848078]  [<c0145936>] cache_grow+0x96/0x1c0
[149649.848116]  [<c0145c99>] cache_alloc_refill+0x239/0x270
[149649.848156]  [<c0145fb3>] __kmalloc+0x73/0x80
[149649.848190]  [<c027300f>] __alloc_skb+0x5f/0x160
[149649.848233]  [<d099afcc>] e1000_alloc_rx_buffers+0x1dc/0x3a0 [e1000]
[149649.848318]  [<d099a81d>] e1000_clean_rx_irq+0x30d/0x480 [e1000]
[149649.848366]  [<d099afcc>] e1000_alloc_rx_buffers+0x1dc/0x3a0 [e1000]
[149649.848419]  [<d0999f5d>] e1000_intr+0x4d/0x100 [e1000]
[149649.848465]  [<c013b5cd>] handle_IRQ_event+0x3d/0x70
[149649.848512]  [<c013b65d>] __do_IRQ+0x5d/0xc0
[149649.848549]  [<c0105199>] do_IRQ+0x19/0x30
[149649.848590]  [<c0103a72>] common_interrupt+0x1a/0x20
[149649.848628]  [<c011f540>] __do_softirq+0x30/0x90
[149649.848676]  [<c011f5c6>] do_softirq+0x26/0x30
[149649.848710]  [<c010519e>] do_IRQ+0x1e/0x30
[149649.848743]  [<c0103a72>] common_interrupt+0x1a/0x20
[149649.848783]  [<d0a1e8f1>] aes_decrypt+0x121/0x13b0 [aes]
[149649.848865]  [<c01cd966>] cbc_process_decrypt+0xe6/0x160
[149649.848919]  [<c01cde50>] xor_128+0x0/0x20
[149649.848952]  [<d0a1e7d0>] aes_decrypt+0x0/0x13b0 [aes]
[149649.848999]  [<c01cd50c>] crypt+0x12c/0x2b0
[149649.849044]  [<c01cd6d1>] crypt_iv_unaligned+0x41/0x120
[149649.849082]  [<d0a1d320>] aes_encrypt+0x0/0x14b0 [aes]
[149649.849119]  [<c01cd9e0>] ecb_process+0x0/0x60
[149649.849156]  [<c01cdcc5>] cbc_decrypt_iv+0x55/0x60
[149649.849193]  [<d0a1e7d0>] aes_decrypt+0x0/0x13b0 [aes]
[149649.849227]  [<c01cd880>] cbc_process_decrypt+0x0/0x160
[149649.849264]  [<d0a12611>] crypt_convert+0x251/0x2d0 [dm_crypt]
[149649.849314]  [<d08bd2a1>] clone_endio+0x101/0x150 [dm_mod]
[149649.849392]  [<d0a12930>] kcryptd_do_work+0x0/0x70 [dm_crypt]
[149649.849428]  [<d0a12980>] kcryptd_do_work+0x50/0x70 [dm_crypt]
[149649.849474]  [<c012a451>] worker_thread+0x1b1/0x260
[149649.849526]  [<c0117670>] default_wake_function+0x0/0x20
[149649.849566]  [<c012a2a0>] worker_thread+0x0/0x260
[149649.849605]  [<c012e336>] kthread+0xb6/0xc0
[149649.849643]  [<c012e280>] kthread+0x0/0xc0
[149649.849679]  [<c0101379>] kernel_thread_helper+0x5/0xc
[149649.849727] Mem-info:
[149649.849748] DMA per-cpu:
[149649.849773] cpu 0 hot: low 2, high 6, batch 1 used:2
[149649.849799] cpu 0 cold: low 0, high 2, batch 1 used:0
[149649.849824] Normal per-cpu:
[149649.849849] cpu 0 hot: low 62, high 186, batch 31 used:147
[149649.849876] cpu 0 cold: low 0, high 62, batch 31 used:31
[149649.849903] HighMem per-cpu: empty
[149649.849933] Free pages:       16148kB (0kB HighMem)
[149649.849961] Active:5092 inactive:16489 dirty:2 writeback:0 unstable:0 free:4037 slab:36782 mapped:4533 pagetables:175
[149649.850014] DMA free:1340kB min:1024kB low:1280kB high:1536kB active:316kB inactive:4252kB present:16384kB pages_scanned:0 all_unreclaimable? no
[149649.850067] lowmem_reserve[]: 0 239 239
[149649.850106] Normal free:14808kB min:15356kB low:19192kB high:23032kB active:20052kB inactive:61704kB present:245680kB pages_scanned:0 all_unreclaimable? no
[149649.850161] lowmem_reserve[]: 0 0 0
[149649.850198] HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[149649.850249] lowmem_reserve[]: 0 0 0
[149649.850284] DMA: 1*4kB 1*8kB 9*16kB 1*32kB 10*64kB 4*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1340kB
[149649.850370] Normal: 102*4kB 772*8kB 468*16kB 1*32kB 1*64kB 3*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 14808kB
[149649.850461] HighMem: empty
[149649.850496] Swap cache: add 465981, delete 465217, find 393848/474450, race 0+5
[149649.850537] Free swap  = 484784kB
[149649.850558] Total swap = 506036kB
[149649.850581] Free swap:       484784kB
[149649.856900] 65516 pages of RAM
[149649.856929] 0 pages of HIGHMEM
[149649.856951] 1386 reserved pages
[149649.856972] 10836 pages shared
[149649.856993] 764 pages swap cached
[149649.857016] 2 pages dirty
[149649.857036] 0 pages writeback
[149649.857056] 4533 pages mapped
[149649.857076] 36784 pages slab
[149649.857097] 175 pages pagetables
[149649.857425] kcryptd/0: page allocation failure. order:3, mode:0x20
[149649.857692]  [<c01419d8>] __alloc_pages+0x318/0x440
[149649.857743]  [<c0144b0d>] kmem_getpages+0x2d/0xa0
[149649.857782]  [<c0145936>] cache_grow+0x96/0x1c0
[149649.859033]  [<c0145c99>] cache_alloc_refill+0x239/0x270
[149649.859072]  [<c0145fb3>] __kmalloc+0x73/0x80
[149649.859105]  [<c027300f>] __alloc_skb+0x5f/0x160
[149649.859148]  [<d099afcc>] e1000_alloc_rx_buffers+0x1dc/0x3a0 [e1000]
[149649.859225]  [<d099a81d>] e1000_clean_rx_irq+0x30d/0x480 [e1000]
[149649.859272]  [<d099afcc>] e1000_alloc_rx_buffers+0x1dc/0x3a0 [e1000]
[149649.859325]  [<d0999f5d>] e1000_intr+0x4d/0x100 [e1000]
[149649.859371]  [<c013b5cd>] handle_IRQ_event+0x3d/0x70
[149649.859416]  [<c013b65d>] __do_IRQ+0x5d/0xc0
[149649.859451]  [<c0105199>] do_IRQ+0x19/0x30
[149649.859485]  [<c0103a72>] common_interrupt+0x1a/0x20
[149649.859523]  [<c011f540>] __do_softirq+0x30/0x90
[149649.859565]  [<c011f5c6>] do_softirq+0x26/0x30
[149649.859596]  [<c010519e>] do_IRQ+0x1e/0x30
[149649.859626]  [<c0103a72>] common_interrupt+0x1a/0x20
[149649.859663]  [<d0a1e8f1>] aes_decrypt+0x121/0x13b0 [aes]
[149649.859735]  [<c01cd966>] cbc_process_decrypt+0xe6/0x160
[149649.859786]  [<c01cde50>] xor_128+0x0/0x20
[149649.859817]  [<d0a1e7d0>] aes_decrypt+0x0/0x13b0 [aes]
[149649.859865]  [<c01cd50c>] crypt+0x12c/0x2b0
[149649.859909]  [<c01cd6d1>] crypt_iv_unaligned+0x41/0x120
[149649.859947]  [<d0a1d320>] aes_encrypt+0x0/0x14b0 [aes]
[149649.859981]  [<c01cd9e0>] ecb_process+0x0/0x60
[149649.860015]  [<c01cdcc5>] cbc_decrypt_iv+0x55/0x60
[149649.860052]  [<d0a1e7d0>] aes_decrypt+0x0/0x13b0 [aes]
[149649.860087]  [<c01cd880>] cbc_process_decrypt+0x0/0x160
[149649.860123]  [<d0a12611>] crypt_convert+0x251/0x2d0 [dm_crypt]
[149649.860171]  [<d08bd2a1>] clone_endio+0x101/0x150 [dm_mod]
[149649.860247]  [<d0a12930>] kcryptd_do_work+0x0/0x70 [dm_crypt]
[149649.860283]  [<d0a12980>] kcryptd_do_work+0x50/0x70 [dm_crypt]
[149649.860333]  [<c012a451>] worker_thread+0x1b1/0x260
[149649.860383]  [<c0117670>] default_wake_function+0x0/0x20
[149649.860422]  [<c012a2a0>] worker_thread+0x0/0x260
[149649.860454]  [<c012e336>] kthread+0xb6/0xc0
[149649.860492]  [<c012e280>] kthread+0x0/0xc0
[149649.860525]  [<c0101379>] kernel_thread_helper+0x5/0xc
[149649.860560] Mem-info:
[149649.860581] DMA per-cpu:
[149649.860603] cpu 0 hot: low 2, high 6, batch 1 used:2
[149649.860629] cpu 0 cold: low 0, high 2, batch 1 used:0
[149649.860655] Normal per-cpu:
[149649.860678] cpu 0 hot: low 62, high 186, batch 31 used:145
[149649.860705] cpu 0 cold: low 0, high 62, batch 31 used:31
[149649.860739] HighMem per-cpu: empty
[149649.860765] Free pages:       16148kB (0kB HighMem)
[149649.860794] Active:5092 inactive:16489 dirty:2 writeback:0 unstable:0 free:4037 slab:36784 mapped:4533 pagetables:175
[149649.860843] DMA free:1340kB min:1024kB low:1280kB high:1536kB active:316kB inactive:4252kB present:16384kB pages_scanned:0 all_unreclaimable? no
[149649.860896] lowmem_reserve[]: 0 239 239
[149649.860932] Normal free:14808kB min:15356kB low:19192kB high:23032kB active:20052kB inactive:61704kB present:245680kB pages_scanned:0 all_unreclaimable? no
[149649.860986] lowmem_reserve[]: 0 0 0
[149649.861022] HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[149649.861071] lowmem_reserve[]: 0 0 0
[149649.861104] DMA: 1*4kB 1*8kB 9*16kB 1*32kB 10*64kB 4*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1340kB
[149649.861189] Normal: 102*4kB 772*8kB 468*16kB 1*32kB 1*64kB 3*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 14808kB
[149649.861270] HighMem: empty
[149649.861294] Swap cache: add 465981, delete 465217, find 393848/474450, race 0+5
[149649.861331] Free swap  = 484784kB
[149649.861351] Total swap = 506036kB
[149649.861371] Free swap:       484784kB
[149649.867621] 65516 pages of RAM
[149649.867650] 0 pages of HIGHMEM
[149649.867670] 1386 reserved pages
[149649.867692] 10836 pages shared
[149649.867713] 764 pages swap cached
[149649.867734] 2 pages dirty
[149649.867764] 0 pages writeback
[149649.867783] 4533 pages mapped
--------------060903060407020000050202--
