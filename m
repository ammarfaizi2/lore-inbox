Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVBWMAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVBWMAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 07:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVBWMAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 07:00:37 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:45621 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261471AbVBWMAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 07:00:20 -0500
Date: Wed, 23 Feb 2005 13:00:13 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Help tracking down problem --- endless loop in __find_get_block_slow
Message-ID: <20050223120013.GA28169@zensonic.dk>
References: <4219BC1A.1060007@zensonic.dk> <20050222011821.2a917859.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222011821.2a917859.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: zensonic@zensonic.dk (Thomas S. Iversen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  dd if=/dev/zero of=/mnt/testfile count=N, N>6

It turns out N>6 is variable. But large enough and it will hang. Sugests
some kind of race I am afraid.

> >  I get into an endless loop in __find_get_block_slow. 
> 
> The only way in which __find_get_block_slow() can loop is if something
> wrecked the buffer_head ring at page->private: something caused an internal
> loop via bh->b_this_page.
> 
> Are you sure that's where things are hanging?  That it's not stuck on a
> spinlock?

I get the same message again and again all over (this trace with
count=100 and a BUG() and panic inserted into buffer.c)

Feb 23 13:38:34 localhost kernel: __find_get_block_slow() failed.
block=101, b_blocknr=100
Feb 23 13:38:34 localhost kernel: b_state=0x00000010, b_size=2048
Feb 23 13:38:34 localhost kernel: device blocksize: 2048

Ad inf. The output of the BUG() is show below. My questions remain:

1. Whos fault is this?
2. How do I fix/avoid this problem?

Regards Thomas


__find_get_block_slow() failed. block=101, b_blocknr=100
b_state=0x00000010, b_size=2048
device blocksize: 2048
------------[ cut here ]------------
DEBUG_PAGEALLOC
Modules linked in: ufs sha512 aes_i586 dm_bde md5 ipv6 af_packet evdev ehci_hcd usbcore agpgart dm_mod rtc unix
CPU:    0
EIP: 0060:[__find_get_block_slow+202/304]    Not tainted
EFLAGS: 00010286   (2.6.8) 
EIP is at __find_get_block_slow+0xca/0x130
eax: 00000017   ebx: dcd21208   ecx: c02c6950   edx: 000041e4
esi: c138d600   edi: 00000065   ebp: da63aed0   esp: da7e9c54
ds: 007b   es: 007b   ss: 0068
Process dd (pid: 1742, threadinfo=da7e8000 task=dc76da70)
Stack: c029a003 00000800 00000800 00000064 00000000 00000000 00000000 da63ae6c 
       00000065 00000800 c014ab5f da63ae6c 00000065 00000800 00000800 00000065 
       da63ae6c da764df8 c014abdb da63ae6c 00000065 00000800 00000000 00000000 
Call Trace:
 [__find_get_block+95/176] __find_get_block+0x5f/0xb0
 [__getblk+43/96] __getblk+0x2b/0x60
 [pg0+542048932/1070055424] ufs_new_fragments+0x1c4/0x740 [ufs]
 [pg0+542070875/1070055424] ufs_inode_getfrag+0x23b/0x3f0 [ufs]
 [pg0+542072873/1070055424] ufs_getfrag_block+0x349/0x3b0 [ufs]
 [create_empty_buffers+37/128] create_empty_buffers+0x25/0x80
 [__block_prepare_write+467/960] __block_prepare_write+0x1d3/0x3c0
 [kernel_map_pages+40/144] kernel_map_pages+0x28/0x90
 [inode_update_time+167/224] inode_update_time+0xa7/0xe0
 [block_prepare_write+52/80] block_prepare_write+0x34/0x50
 [pg0+542072032/1070055424] ufs_getfrag_block+0x0/0x3b0 [ufs]
 [generic_file_aio_write_nolock+821/2624] generic_file_aio_write_nolock+0x335/0xa40
 [pg0+542072032/1070055424] ufs_getfrag_block+0x0/0x3b0 [ufs]
 [do_no_page+99/688] do_no_page+0x63/0x2b0 
 [generic_file_write_nolock+116/144] generic_file_write_nolock+0x74/0x90
 [clear_user+51/80] clear_user+0x33/0x50
 [read_zero+452/528] read_zero+0x1c4/0x210
 [generic_file_write+85/112] generic_file_write+0x55/0x70
 [generic_file_write+0/112] generic_file_write+0x0/0x70
 [vfs_write+184/304] vfs_write+0xb8/0x130
 [copy_to_user+62/80] copy_to_user+0x3e/0x50
 [sys_write+81/128] sys_write+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 0f 0b 15 02 c2 9f 29 c0 8b 06 f6 c4 08 75 17 8b 46 04 40 74 

