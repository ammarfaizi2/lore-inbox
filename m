Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265604AbUATREb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265605AbUATREb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:04:31 -0500
Received: from mail36.messagelabs.com ([193.109.254.211]:34975 "HELO
	mail36.messagelabs.com") by vger.kernel.org with SMTP
	id S265604AbUATRE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:04:26 -0500
X-VirusChecked: Checked
X-Env-Sender: okiddle@yahoo.co.uk
X-Msg-Ref: server-4.tower-36.messagelabs.com!1074618264!3229078
X-StarScan-Version: 5.1.15; banners=-,-,-
X-VirusChecked: Checked
X-StarScan-Version: 5.0.7; banners=.,-,-
In-reply-to: <20040119193837.6369d498.akpm@osdl.org> 
From: Oliver Kiddle <okiddle@yahoo.co.uk>
References: <7641.1074512162@gmcs3.local> <20040119193837.6369d498.akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure 
Date: Tue, 20 Jan 2004 18:08:34 +0100
Message-ID: <30705.1074618514@gmcs3.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Does the machine actually recover, or does it grind to a halt and need
> resetting?

It needs resetting.

Today, I noticed that I could still ping it, though. I also had the
magic sysrq key stuff in the kernel and did a showTasks, Sync, Unmount
and kIll. That allowed me to briefly log in as root and save the output
of dmesg before an attempt to run vi caused it to die again.

> Is there much network receive happening at the time?

Not a lot I don't think. Is there anything like vmstat for measuring
network activity?

> Are you using gig-E with large MTU's?

No. 100Mbps full duplex, e1000 driver.

Again this time, I didn't get the "page allocation failure" message so
your patch couldn't print anything. The console was blank apart from
the message about the tape device. As suggested by Mike Fedyk, I had
the nmi_watchdog stuff enabled. Didn't see any output from it though.
Would that have displayed its output to the console?

I've put a few chunks of the saved dmesg output below incase they're
useful. All I have is some of the sysrq showTasks output. xfsdump seems
to be a reliable way to trigger the problem (perhaps once the tape
fills up) and I had run patch imediately before it died. Most other
processes seem to be in schedule_timeout.

I'm away next week and as other people use this machine I'll have to
switch it to 2.4. I'll still have opportunities to reboot to 2.6 and
try to find out what's going on, though.

Oliver

patch         D 00000000     0 11620    966                     (NOTLB)
d7bb7aa8 00000082 c03676c0 00000000 0000000c 00000050 00000000 c03677d4 
       c0138240 00001fec 536f5e97 00000bc6 f6d0f2e0 f6d0f4a0 00c029db d7bb7abc 
       c041dedc d7bb7ae8 c0121b9c d7bb7abc 00c029db 0000007b c040e460 f6c41920 
Call Trace:
 [<c0138240>] try_to_free_pages+0x9f/0x15f
 [<c0121b9c>] schedule_timeout+0x63/0xb7
 [<c0121b30>] process_timeout+0x0/0x9
 [<c01186f4>] io_schedule_timeout+0x11/0x19
 [<c024e343>] blk_congestion_wait+0x7e/0x8d
 [<c0118cd6>] autoremove_wake_function+0x0/0x4f
 [<c0118cd6>] autoremove_wake_function+0x0/0x4f
 [<c0132cd1>] __alloc_pages+0x294/0x319
 [<c012f3d5>] find_or_create_page+0xa0/0xaa
 [<c0214daf>] _pagebuf_lookup_pages+0x2fa/0x398
 [<c0215131>] pagebuf_get+0xba/0x135
 [<c0208a70>] xfs_trans_read_buf+0x32f/0x38b
 [<c01d8df1>] xfs_da_do_buf+0x6b1/0x9a6
 [<c01d9198>] xfs_da_read_buf+0x57/0x5b
 [<c01dcf5c>] xfs_dir2_block_lookup_int+0x52/0x192
 [<c01dcf5c>] xfs_dir2_block_lookup_int+0x52/0x192
 [<c01dce71>] xfs_dir2_block_lookup+0x2f/0xc8
 [<c01db3a8>] xfs_dir2_lookup+0xc4/0x13b
 [<c01db401>] xfs_dir2_lookup+0x11d/0x13b
 [<c0209afe>] xfs_dir_lookup_int+0x4c/0x12b
 [<c020f3d6>] xfs_lookup+0x50/0x88
 [<c021cae0>] linvfs_lookup+0x67/0x9f
 [<c0152ea2>] real_lookup+0xc8/0xea
 [<c01530f3>] do_lookup+0x96/0xa1
 [<c0153508>] link_path_walk+0x40a/0x7db
 [<c0154116>] open_namei+0x83/0x3e1
 [<c0146b0f>] filp_open+0x3e/0x64
 [<c0146e98>] sys_open+0x5b/0x8b
 [<c0108ab7>] syscall_call+0x7/0xb


xfsdump       D 9855CCF6  2760   676    673                     (NOTLB)
ece09b04 00000082 f7f9e080 9855ccf6 00000baf 00000000 9855ccf6 00000baf 
       f7f9e080 000012f8 9855d254 00000baf f51106a0 f5110860 f7ffe760 00000000 
       f7ffe778 ece09b0c c01186db ece09b3c c0131c2b 00000000 00000000 00000000 
Call Trace:
 [<c01186db>] io_schedule+0xe/0x16
 [<c0131c2b>] mempool_alloc+0xfa/0x117
 [<c0118cd6>] autoremove_wake_function+0x0/0x4f
 [<c021789b>] linvfs_get_block_core+0x87/0x2ab
 [<c0118cd6>] autoremove_wake_function+0x0/0x4f
 [<c0139296>] __blk_queue_bounce+0x1a1/0x232
 [<c013935d>] blk_queue_bounce+0x36/0x4d
 [<c024e510>] __make_request+0x4c/0x537
 [<c0162ff5>] do_mpage_readpage+0x1a9/0x32a
 [<c024eb04>] generic_make_request+0x109/0x18a
 [<c022765b>] radix_tree_node_alloc+0x1f/0x5a
 [<c02277f4>] radix_tree_insert+0x82/0xb8
 [<c024ebc2>] submit_bio+0x3d/0x6b
 [<c0162d26>] mpage_bio_submit+0x23/0x32
 [<c016324b>] mpage_readpages+0xd5/0x162
 [<c0217abf>] linvfs_get_block+0x0/0x43
 [<c0134460>] read_pages+0x134/0x13d
 [<c0217abf>] linvfs_get_block+0x0/0x43
 [<c0132ae3>] __alloc_pages+0xa6/0x319
 [<c010adcd>] do_IRQ+0xc4/0xdf
 [<c0109424>] common_interrupt+0x18/0x20
 [<c013469c>] do_page_cache_readahead+0xbf/0x109
 [<c0134852>] page_cache_readahead+0x16c/0x198
 [<c012f8d7>] do_generic_mapping_read+0x3c1/0x3d3
 [<c012f8e9>] file_read_actor+0x0/0xec
 [<c012fb91>] __generic_file_aio_read+0x1bc/0x1ee
 [<c012f8e9>] file_read_actor+0x0/0xec
 [<c021dcb2>] xfs_read+0x15a/0x26c
 [<c0117d92>] wait_for_completion+0x65/0x95
 [<c02181af>] linvfs_read_invis+0x90/0xa2
 [<c0147549>] do_sync_read+0x8b/0xb7
 [<c01217fa>] update_process_times+0x46/0x52
 [<c0121674>] update_wall_time+0xd/0x36
 [<c0121a6c>] do_timer+0xdf/0xe4
 [<c0147625>] vfs_read+0xb0/0x119
 [<c01478a0>] sys_read+0x42/0x63
 [<c0108ab7>] syscall_call+0x7/0xb

