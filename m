Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUCDJgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 04:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUCDJgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 04:36:05 -0500
Received: from foo.ardendo.se ([212.32.189.9]:7 "EHLO foo.ardendo.se")
	by vger.kernel.org with ESMTP id S261568AbUCDJf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 04:35:57 -0500
Subject: Re: Filesystem kernel hangup, 2.6.3 (bad: scheduling while atomic!)
From: Mikael Wahlberg <mikael.wahlberg@ardendo.se>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Per Lejontand <pele@ardendo.se>,
       Jonas =?ISO-8859-1?Q?Engstr=F6m?= <jonas@ardendo.se>
In-Reply-To: <20040223131331.A8778@infradead.org>
References: <20040222164941.D6046@foo.ardendo.se>
	 <20040223121959.A8354@infradead.org> <1077541689.1247.12.camel@harrier>
	 <20040223131331.A8778@infradead.org>
Content-Type: text/plain
Organization: Ardendo
Message-Id: <1078392951.643.6.camel@harrier>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 10:35:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-23 at 14:13, Christoph Hellwig wrote:
> On Mon, Feb 23, 2004 at 02:08:09PM +0100, Mikael Wahlberg wrote:
> > If you need any more information please tell us, it is quite urgent for
> > us, since we really don't want to go back to 2.4, the performance
> > increase with 2.6 is really impressive (Except when it crashes :) 
> 
> Can you check whether the small patch below gets rid of you problems?
> It still wouldn't explain the JFS problems, though.
> 
> --- 1.59/fs/xfs/linux/xfs_aops.c	Mon Feb  9 05:39:27 2004
> +++ edited/fs/xfs/linux/xfs_aops.c	Mon Feb 23 15:11:33 2004
> @@ -1170,7 +1170,7 @@
>  	if (!delalloc && !unwritten)
>  		goto free_buffers;
>  
> -	if (!(gfp_mask & __GFP_FS))
> +	if ((gfp_mask & (__GFP_FS|__GFP_WAIT)) != (__GFP_FS|__GFP_WAIT))
>  		return 0;
>  
>  	/* If we are already inside a transaction or the thread cannot


Unfortunately yesterday evening during peak load we got another
filesystem hang, the oops looks like below:

We feel a bit sad to have do downgrade to a 2.4 kernel, with the
performance loss that would imply. So any ideas would be very helpful.



Mar  3 18:27:35 c-serv kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Mar  3 18:27:35 c-serv kernel:  printing eip:
Mar  3 18:27:36 c-serv kernel: c025c9a2
Mar  3 18:27:36 c-serv kernel: *pde = 00000000
Mar  3 18:27:36 c-serv kernel: Oops: 0000 [#1]
Mar  3 18:27:36 c-serv kernel: CPU:    0
Mar  3 18:27:36 c-serv kernel: EIP:    0060:[<c025c9a2>]    Not tainted
Mar  3 18:27:36 c-serv kernel: EFLAGS: 00010206
Mar  3 18:27:36 c-serv kernel: EIP is at _pagebuf_find+0xd2/0x2c0
Mar  3 18:27:37 c-serv kernel: eax: 7930e000   ebx: 00000000   ecx:
7930e187   edx: 0003f000
Mar  3 18:27:37 c-serv kernel: esi: 00000000   edi: f63a5260   ebp:
c04cd068   esp: c6897b94
Mar  3 18:27:37 c-serv kernel: ds: 007b   es: 007b   ss: 0068
Mar  3 18:27:37 c-serv kernel: Process proftpd (pid: 15349,
threadinfo=c6896000 task=d479b900)
Mar  3 18:27:37 c-serv kernel: Stack: f7fe2740 0003f000 00000008
00000000 c02098c8 f638ae50 0000008e 0003f000
Mar  3 18:27:37 c-serv kernel:        00000008 c0e84980 0080003f
040001f8 0000a005 c025cc75 f7942fc0 040001f8
Mar  3 18:27:37 c-serv kernel:        00000000 00001000 0000a005
c0e84980 040001f8 00000000 0000a005 0080003f
Mar  3 18:27:37 c-serv kernel: Call Trace:
Mar  3 18:27:37 c-serv kernel:  [<c02098c8>] xfs_bmapi_single+0xf8/0x1c0
Mar  3 18:27:37 c-serv kernel:  [<c025cc75>] pagebuf_get+0xa5/0x180
Mar  3 18:27:37 c-serv kernel:  [<c024d1df>]
xfs_trans_read_buf+0x32f/0x390
Mar  3 18:27:37 c-serv kernel:  [<c021670f>] xfs_da_do_buf+0x7ef/0x9e0
Mar  3 18:27:37 c-serv kernel:  [<c033f5a7>] nf_hook_slow+0xf7/0x160
Mar  3 18:27:37 c-serv kernel:  [<c02169b7>] xfs_da_read_buf+0x57/0x60
Mar  3 18:27:37 c-serv kernel:  [<c021451c>]
xfs_da_node_lookup_int+0x8c/0x390
Mar  3 18:27:37 c-serv kernel:  [<c021451c>]
xfs_da_node_lookup_int+0x8c/0x390
Mar  3 18:27:37 c-serv kernel:  [<c0221b2f>]
xfs_dir2_node_lookup+0x3f/0xc0
Mar  3 18:27:37 c-serv kernel:  [<c0218ebf>] xfs_dir2_lookup+0x13f/0x150
Mar  3 18:27:37 c-serv kernel:  [<c01a3d10>]
ext3_journal_dirty_data+0x0/0x70
Mar  3 18:27:37 c-serv kernel:  [<c033041c>] memcpy_toiovec+0x5c/0x90
Mar  3 18:27:37 c-serv kernel:  [<c024e44c>]
xfs_dir_lookup_int+0x4c/0x130
Mar  3 18:27:37 c-serv kernel:  [<c02541d5>] xfs_lookup+0x65/0x90
Mar  3 18:27:37 c-serv kernel:  [<c0261c27>] linvfs_lookup+0x67/0xa0
Mar  3 18:27:38 c-serv kernel:  [<c016d65f>] real_lookup+0xcf/0x100
Mar  3 18:27:38 c-serv kernel:  [<c016d956>] do_lookup+0xa6/0xc0
Mar  3 18:27:38 c-serv kernel:  [<c016dee3>] link_path_walk+0x573/0xad0
Mar  3 18:27:38 c-serv kernel:  [<c0174beb>] locks_delete_lock+0x8b/0xf0
Mar  3 18:27:38 c-serv kernel:  [<c01756a5>]
__posix_lock_file+0x435/0x660
Mar  3 18:27:38 c-serv kernel:  [<c016ea09>] __user_walk+0x49/0x60
Mar  3 18:27:38 c-serv kernel:  [<c0168dbc>] vfs_lstat+0x1c/0x60
Mar  3 18:27:38 c-serv kernel:  [<c0176d7d>] fcntl_setlk64+0x11d/0x2c0
Mar  3 18:27:38 c-serv kernel:  [<c012be68>] del_timer_sync+0x38/0x140
Mar  3 18:27:38 c-serv kernel:  [<c016953b>] sys_lstat64+0x1b/0x40
Mar  3 18:27:38 c-serv kernel:  [<c01720e7>] sys_fcntl64+0x57/0xa0
Mar  3 18:27:38 c-serv kernel:  [<c010b08b>] syscall_call+0x7/0xb
Mar  3 18:27:38 c-serv kernel:
Mar  3 18:27:38 c-serv kernel: Code: 8b 1b 0f 18 03 90 39 ee 75 e4 8b 5c
24 4c 85 db 0f 84 85 00
Mar  3 18:27:38 c-serv kernel:  <6>note: proftpd[15349] exited with
preempt_count 1
Mar  3 18:27:38 c-serv kernel: bad: scheduling while atomic!
Mar  3 18:27:38 c-serv kernel: Call Trace:
Mar  3 18:27:38 c-serv kernel:  [<c011e48e>] schedule+0x6ee/0x700
Mar  3 18:27:38 c-serv kernel:  [<c014cdeb>] zap_pmd_range+0x4b/0x70
Mar  3 18:27:38 c-serv kernel:  [<c01591ba>]
free_pages_and_swap_cache+0x6a/0xa0
Mar  3 18:27:38 c-serv kernel:  [<c014d0cc>] unmap_vmas+0x23c/0x2f0
Mar  3 18:27:38 c-serv kernel:  [<c0151774>] exit_mmap+0xf4/0x250
Mar  3 18:27:39 c-serv kernel:  [<c0120d2d>] mmput+0x6d/0xa0
Mar  3 18:27:39 c-serv kernel:  [<c0125a33>] do_exit+0x1a3/0x500
Mar  3 18:27:39 c-serv kernel:  [<c010c1ac>] die+0xfc/0x100
Mar  3 18:27:39 c-serv kernel:  [<c011b349>] do_page_fault+0x1f9/0x523
Mar  3 18:27:39 c-serv kernel:  [<c0333fe1>] process_backlog+0x81/0x120
Mar  3 18:27:39 c-serv kernel:  [<c0334164>] net_rx_action+0xe4/0x130
Mar  3 18:27:39 c-serv kernel:  [<c010d9dd>] do_IRQ+0x15d/0x1d0
Mar  3 18:27:39 c-serv kernel:  [<c011b150>] do_page_fault+0x0/0x523
Mar  3 18:27:39 c-serv kernel:  [<c010baf5>] error_code+0x2d/0x38
Mar  3 18:27:39 c-serv kernel:  [<c025c9a2>] _pagebuf_find+0xd2/0x2c0
Mar  3 18:27:39 c-serv kernel:  [<c02098c8>] xfs_bmapi_single+0xf8/0x1c0
Mar  3 18:27:39 c-serv kernel:  [<c025cc75>] pagebuf_get+0xa5/0x180
Mar  3 18:27:39 c-serv kernel:  [<c024d1df>]
xfs_trans_read_buf+0x32f/0x390
Mar  3 18:27:39 c-serv kernel:  [<c021670f>] xfs_da_do_buf+0x7ef/0x9e0
Mar  3 18:27:39 c-serv kernel:  [<c033f5a7>] nf_hook_slow+0xf7/0x160
Mar  3 18:27:39 c-serv kernel:  [<c02169b7>] xfs_da_read_buf+0x57/0x60
Mar  3 18:27:39 c-serv kernel:  [<c021451c>]
xfs_da_node_lookup_int+0x8c/0x390
Mar  3 18:27:39 c-serv kernel:  [<c021451c>]
xfs_da_node_lookup_int+0x8c/0x390
Mar  3 18:27:40 c-serv kernel:  [<c0221b2f>]
xfs_dir2_node_lookup+0x3f/0xc0
Mar  3 18:27:40 c-serv kernel:  [<c0218ebf>] xfs_dir2_lookup+0x13f/0x150
Mar  3 18:27:40 c-serv kernel:  [<c01a3d10>]
ext3_journal_dirty_data+0x0/0x70
Mar  3 18:27:40 c-serv kernel:  [<c033041c>] memcpy_toiovec+0x5c/0x90
Mar  3 18:27:40 c-serv kernel:  [<c024e44c>]
xfs_dir_lookup_int+0x4c/0x130
Mar  3 18:27:40 c-serv kernel:  [<c02541d5>] xfs_lookup+0x65/0x90
Mar  3 18:27:40 c-serv kernel:  [<c0261c27>] linvfs_lookup+0x67/0xa0
Mar  3 18:27:40 c-serv kernel:  [<c016d65f>] real_lookup+0xcf/0x100
Mar  3 18:27:40 c-serv kernel:  [<c016d956>] do_lookup+0xa6/0xc0
Mar  3 18:27:40 c-serv kernel:  [<c016dee3>] link_path_walk+0x573/0xad0
Mar  3 18:27:40 c-serv kernel:  [<c0174beb>] locks_delete_lock+0x8b/0xf0
Mar  3 18:27:40 c-serv kernel:  [<c01756a5>]
__posix_lock_file+0x435/0x660
Mar  3 18:27:40 c-serv kernel:  [<c016ea09>] __user_walk+0x49/0x60
Mar  3 18:27:40 c-serv kernel:  [<c0168dbc>] vfs_lstat+0x1c/0x60
Mar  3 18:27:40 c-serv kernel:  [<c0176d7d>] fcntl_setlk64+0x11d/0x2c0
Mar  3 18:27:40 c-serv kernel:  [<c012be68>] del_timer_sync+0x38/0x140
Mar  3 18:27:40 c-serv kernel:  [<c016953b>] sys_lstat64+0x1b/0x40
Mar  3 18:27:40 c-serv kernel:  [<c01720e7>] sys_fcntl64+0x57/0xa0
Mar  3 18:27:40 c-serv kernel:  [<c010b08b>] syscall_call+0x7/0xb
Mar  3 18:27:40 c-serv kernel:


/Mikael
-- 
-----------------------------------------------------------------------
 Mikael Wahlberg,  M.Sc.                  Ardendo
 Unit Manager Professional Services/      e-mail: mikael@ardendo.se
 Technical Project Manager                GSM:    +46 733 279 274

