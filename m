Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbUK1S3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbUK1S3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUK1S3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:29:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:53672 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261559AbUK1S2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:28:18 -0500
Date: Sun, 28 Nov 2004 10:27:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Greaves <david@dgreaves.com>
Cc: phil@dier.us, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041128102751.2dac71f7.akpm@osdl.org>
In-Reply-To: <41A9B693.30905@dgreaves.com>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
	<20041124094549.4c51d6d5.phil@dier.us>
	<20041124151234.714f30d4.akpm@osdl.org>
	<41A9B693.30905@dgreaves.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves <david@dgreaves.com> wrote:
>
> ...
> I have a system that's running 2.6.10rc2
> It has libata sata_promise + sata_sil drives in an md raid5 array that's 
> used by lvm2 and then xfs; then exported via nfs.
> I saw this thread, upgraded to 2.6.10rc2 and I'm posting this in case 
> it's related (it's hard to tell)
> 
> This oops happened whilst the box was quiet
> 
> Hopefully relevant config bits:
> Single processor
> echo 16384 > /proc/sys/vm/min_free_kbytes
> CONFIG_4KSTACKS=n
> I've done a memtest.
> I haven't applied the inode patch - I'm usually writing a single 1-3Gb 
> files whilst reading another.
> 
> Can I help by providing anything else?
> 
> Nov 28 09:05:03 cu kernel: Unable to handle kernel paging request at 
> virtual address 00100104

That's the list_del() poisoning pattern.

> Nov 28 09:05:03 cu kernel:  printing eip:
> Nov 28 09:05:03 cu kernel: c0139a62
> Nov 28 09:05:03 cu kernel: *pde = 00000000
> Nov 28 09:05:03 cu kernel: Oops: 0002 [#1]
> Nov 28 09:05:03 cu kernel: Modules linked in: nfs af_packet ipv6 e100 
> mii usblp uhci_hcd usbcore nfsd exportfs lockd sunrpc sk98lin unix
> Nov 28 09:05:03 cu kernel: CPU:    0
> Nov 28 09:05:03 cu kernel: EIP:    0060:[cache_alloc_refill+210/528]    
> Not tainted VLI
> Nov 28 09:05:03 cu kernel: EFLAGS: 00010046   (2.6.10-rc2)
> Nov 28 09:05:03 cu kernel: EIP is at cache_alloc_refill+0xd2/0x210
> Nov 28 09:05:03 cu kernel: eax: 00100100   ebx: dffe2a00   ecx: 
> ffffffff   edx: dffe3a6c
> Nov 28 09:05:03 cu kernel: esi: c6118020   edi: c6118038   ebp: 
> dffe2a10   esp: dd627e40
> Nov 28 09:05:03 cu kernel: ds: 007b   es: 007b   ss: 0068
> Nov 28 09:05:03 cu kernel: Process nfsd (pid: 2230, threadinfo=dd626000 
> task=df1a7a00)
> Nov 28 09:05:03 cu kernel: Stack: 0000002c 00000008 ca45dcbc c6118038 
> dffe3a6c dffe3a74 00000296 ca45dcbc
> Nov 28 09:05:03 cu kernel:        d12c7b7c 00000000 c0139d8e dffe3a60 
> 000000d0 fffffff4 c0162d8c dffe3a60
> Nov 28 09:05:03 cu kernel:        000000d0 dd627ee4 d12c7b7c 00000000 
> c015922d d12c7b7c fffffff4 ca45dcbc
> Nov 28 09:05:03 cu kernel: Call Trace:
> Nov 28 09:05:03 cu kernel:  [kmem_cache_alloc+62/64] 
> kmem_cache_alloc+0x3e/0x40
> Nov 28 09:05:03 cu kernel:  [d_alloc+28/416] d_alloc+0x1c/0x1a0
> Nov 28 09:05:03 cu kernel:  [cached_lookup+125/144] cached_lookup+0x7d/0x90
> Nov 28 09:05:03 cu kernel:  [__lookup_hash+139/224] __lookup_hash+0x8b/0xe0
> Nov 28 09:05:03 cu kernel:  [lookup_hash+31/48] lookup_hash+0x1f/0x30
> Nov 28 09:05:03 cu kernel:  [lookup_one_len+97/112] lookup_one_len+0x61/0x70
> Nov 28 09:05:03 cu kernel:  [pg0+550179216/1069196288] 
> nfsd_lookup+0x110/0x490 [nfsd]
> Nov 28 09:05:03 cu kernel:  [pg0+550211681/1069196288] 
> nfsd3_proc_lookup+0xa1/0xe0[nfsd]
> Nov 28 09:05:03 cu kernel:  [pg0+550167977/1069196288] 
> nfsd_dispatch+0xd9/0x230 [nfsd]
> Nov 28 09:05:03 cu kernel:  [pg0+550042452/1069196288] 
> svc_process+0x4a4/0x690 [sunrpc]
> Nov 28 09:05:03 cu kernel:  [default_wake_function+0/32] 
> default_wake_function+0x0/0x20
> Nov 28 09:05:03 cu kernel:  [pg0+550167404/1069196288] nfsd+0x18c/0x2f0 
> [nfsd]
> Nov 28 09:05:03 cu kernel:  [pg0+550167008/1069196288] nfsd+0x0/0x2f0 [nfsd]
> Nov 28 09:05:03 cu kernel:  [kernel_thread_helper+5/20] 

It appears that the dentry cache's slab freelists have become corrupted. 
Odd, because everyone uses that code a lot.  I'd suggest that you enable
CONFIG_DEBUG_SLAB, see if that catches anything.

