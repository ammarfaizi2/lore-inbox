Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbUK1LbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUK1LbP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 06:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUK1LbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 06:31:14 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:43753 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261435AbUK1L32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 06:29:28 -0500
Message-ID: <41A9B693.30905@dgreaves.com>
Date: Sun, 28 Nov 2004 11:29:23 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Phil Dier <phil@dier.us>, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
References: <20041122130622.27edf3e6.phil@dier.us>	<20041122161725.21adb932.akpm@osdl.org>	<20041124094549.4c51d6d5.phil@dier.us> <20041124151234.714f30d4.akpm@osdl.org>
In-Reply-To: <20041124151234.714f30d4.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Phil Dier <phil@dier.us> wrote:
>  
>
>>>Can you rebuild the kernel with CONFIG_4KSTACKS=n?
>>>
>>>      
>>>
>>Looks like 8k stacks did the trick, at least for the oops. Now I'm
>>seeing the stuff below.
>>
>>I got a ton more of this with jfs and xfs, but it seems much less with
>>reiser. Should I be worried, or is this something I can safely ignore?
>>It doesn't lock the system..  Could files be getting corrupted?
>>
>>
>>Nov 23 17:38:20 calculon swapper: page allocation failure. order:0, mode:0x20
>>Nov 23 17:38:20 calculon [<c013c854>] __alloc_pages+0x1b9/0x35e
>>Nov 23 17:38:20 calculon [<c013ca1e>] __get_free_pages+0x25/0x3f
>>Nov 23 17:38:20 calculon [<c013fccb>] kmem_getpages+0x21/0xc9
>>Nov 23 17:38:20 calculon [<c0140813>] alloc_slabmgmt+0x55/0x5f
>>Nov 23 17:38:20 calculon [<c0140992>] cache_grow+0xab/0x14d
>>Nov 23 17:38:20 calculon [<c0140ba8>] cache_alloc_refill+0x174/0x219
>>Nov 23 17:38:20 calculon [<c0140ffe>] __kmalloc+0x85/0x8c
>>Nov 23 17:38:20 calculon [<c03f4f89>] alloc_skb+0x47/0xe0
>>Nov 23 17:38:20 calculon [<c032ebe5>] e1000_alloc_rx_buffers+0x44/0xe3
>>    
>>
>
>You didn't mention the kernel version.  2.6.9 had problems in this area, so
>2.6.10-rc2 should be better.  And there are post-2.6.10-rc2 fixes which
>will provide more headroom.
>  
>
Hi
I have a system that's running 2.6.10rc2
It has libata sata_promise + sata_sil drives in an md raid5 array that's 
used by lvm2 and then xfs; then exported via nfs.
I saw this thread, upgraded to 2.6.10rc2 and I'm posting this in case 
it's related (it's hard to tell)

This oops happened whilst the box was quiet

Hopefully relevant config bits:
Single processor
echo 16384 > /proc/sys/vm/min_free_kbytes
CONFIG_4KSTACKS=n
I've done a memtest.
I haven't applied the inode patch - I'm usually writing a single 1-3Gb 
files whilst reading another.

Can I help by providing anything else?

Nov 28 09:05:03 cu kernel: Unable to handle kernel paging request at 
virtual address 00100104
Nov 28 09:05:03 cu kernel:  printing eip:
Nov 28 09:05:03 cu kernel: c0139a62
Nov 28 09:05:03 cu kernel: *pde = 00000000
Nov 28 09:05:03 cu kernel: Oops: 0002 [#1]
Nov 28 09:05:03 cu kernel: Modules linked in: nfs af_packet ipv6 e100 
mii usblp uhci_hcd usbcore nfsd exportfs lockd sunrpc sk98lin unix
Nov 28 09:05:03 cu kernel: CPU:    0
Nov 28 09:05:03 cu kernel: EIP:    0060:[cache_alloc_refill+210/528]    
Not tainted VLI
Nov 28 09:05:03 cu kernel: EFLAGS: 00010046   (2.6.10-rc2)
Nov 28 09:05:03 cu kernel: EIP is at cache_alloc_refill+0xd2/0x210
Nov 28 09:05:03 cu kernel: eax: 00100100   ebx: dffe2a00   ecx: 
ffffffff   edx: dffe3a6c
Nov 28 09:05:03 cu kernel: esi: c6118020   edi: c6118038   ebp: 
dffe2a10   esp: dd627e40
Nov 28 09:05:03 cu kernel: ds: 007b   es: 007b   ss: 0068
Nov 28 09:05:03 cu kernel: Process nfsd (pid: 2230, threadinfo=dd626000 
task=df1a7a00)
Nov 28 09:05:03 cu kernel: Stack: 0000002c 00000008 ca45dcbc c6118038 
dffe3a6c dffe3a74 00000296 ca45dcbc
Nov 28 09:05:03 cu kernel:        d12c7b7c 00000000 c0139d8e dffe3a60 
000000d0 fffffff4 c0162d8c dffe3a60
Nov 28 09:05:03 cu kernel:        000000d0 dd627ee4 d12c7b7c 00000000 
c015922d d12c7b7c fffffff4 ca45dcbc
Nov 28 09:05:03 cu kernel: Call Trace:
Nov 28 09:05:03 cu kernel:  [kmem_cache_alloc+62/64] 
kmem_cache_alloc+0x3e/0x40
Nov 28 09:05:03 cu kernel:  [d_alloc+28/416] d_alloc+0x1c/0x1a0
Nov 28 09:05:03 cu kernel:  [cached_lookup+125/144] cached_lookup+0x7d/0x90
Nov 28 09:05:03 cu kernel:  [__lookup_hash+139/224] __lookup_hash+0x8b/0xe0
Nov 28 09:05:03 cu kernel:  [lookup_hash+31/48] lookup_hash+0x1f/0x30
Nov 28 09:05:03 cu kernel:  [lookup_one_len+97/112] lookup_one_len+0x61/0x70
Nov 28 09:05:03 cu kernel:  [pg0+550179216/1069196288] 
nfsd_lookup+0x110/0x490 [nfsd]
Nov 28 09:05:03 cu kernel:  [pg0+550211681/1069196288] 
nfsd3_proc_lookup+0xa1/0xe0[nfsd]
Nov 28 09:05:03 cu kernel:  [pg0+550167977/1069196288] 
nfsd_dispatch+0xd9/0x230 [nfsd]
Nov 28 09:05:03 cu kernel:  [pg0+550042452/1069196288] 
svc_process+0x4a4/0x690 [sunrpc]
Nov 28 09:05:03 cu kernel:  [default_wake_function+0/32] 
default_wake_function+0x0/0x20
Nov 28 09:05:03 cu kernel:  [pg0+550167404/1069196288] nfsd+0x18c/0x2f0 
[nfsd]
Nov 28 09:05:03 cu kernel:  [pg0+550167008/1069196288] nfsd+0x0/0x2f0 [nfsd]
Nov 28 09:05:03 cu kernel:  [kernel_thread_helper+5/20] 
kernel_thread_helper+0x5/0x14
Nov 28 09:05:03 cu kernel: Code: 8b 56 10 0f b7 46 14 42 89 56 10 8b 7c 
24 0c 0f b7 04 47 66 89 46 14 8b 44 24 2c 3b 50 3c 73 06 49 83 f9 ff 75 
c3 8b 56 04 8b 06 <89> 50 04 89 02 c7 46 04 00 02 20 00 66 83 7e 14 ff 
c7 06 00 01

