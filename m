Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbUDBUBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264140AbUDBUBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:01:19 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:18140 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264088AbUDBUBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:01:14 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] lockfs patch for 2.6
Date: Fri, 2 Apr 2004 14:00:18 -0600
User-Agent: KMail/1.6
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       thornber@redhat.com
References: <1078867885.25075.1458.camel@watt.suse.com> <20040326102549.A4248@infradead.org> <1080851723.3547.285.camel@watt.suse.com>
In-Reply-To: <1080851723.3547.285.camel@watt.suse.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404021400.18583.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 2:35 pm, Chris Mason wrote:
> On Fri, 2004-03-26 at 05:25, Christoph Hellwig wrote:
> > On Sun, Mar 14, 2004 at 10:23:31AM -0500, Chris Mason wrote:
> > > > P.S. this patch now kills 16 lines of kernel code summarized :)
> > >
> > > It looks good, I'll give it a try.
> >
> > ping?  I've seen you merged the old patch into the suse tree, and having
> > shipping distros with incompatible APIs doesn't sound exactly like a good
> > idea..
>
> Christoph's vfs patch looks good, I've stripped out the XFS bits (FS
> parts should probably be in different patches) and made one small
> change.  freeze/thaw now check to make sure bdev != NULL.

Does this mean there are patches required for XFS to work properly with
this new VFS-lock patch? I'm getting hangs when suspending a DM device
that contains an XFS filesystem with active I/O. Ext3, Reiser, and JFS
seem to behave as expected.

Backtrace from the "cp" command on the XFS filesystem:

kernel: cp            D C1201BE0     0   784    727               (NOTLB)
kernel: ccf09cd0 00000086 00000000 c1201be0 c1202540 00000017 00000017 ccf09d78
kernel:        00000018 c1201be0 0001d058 bcc411f2 00000040 cf1f2348 cfd3b590 cfd3b79c
kernel:        ccf09000 ccf09d68 00000001 ccf09de4 c0148644 0000d0e4 c2c21000 00000000
kernel: Call Trace:
kernel:  [<c0148644>] generic_file_aio_write_nolock+0xe4/0xe20
kernel:  [<c0124e20>] autoremove_wake_function+0x0/0x50
kernel:  [<c01cb811>] pathrelse+0x31/0x50
kernel:  [<c0124e20>] autoremove_wake_function+0x0/0x50
kernel:  [<c01d722c>] do_journal_end+0x88c/0xbf0
kernel:  [<c0121e80>] default_wake_function+0x0/0x20
kernel:  [<c01d5c3c>] journal_end+0x9c/0xc0
kernel:  [<c02a30c8>] xfs_ichgtime+0xf8/0xfa
kernel:  [<c02cfdc4>] xfs_write+0x264/0x7d0
kernel:  [<c01932ac>] __mark_inode_dirty+0x17c/0x190
kernel:  [<c01471d8>] do_generic_mapping_read+0x128/0x3e0
kernel:  [<c018bfa1>] update_atime+0xd1/0xe0
kernel:  [<c02caff0>] linvfs_write+0xb0/0x120
kernel:  [<c016ba57>] do_sync_write+0x87/0xc0
kernel:  [<c0177ecf>] cp_new_stat64+0x10f/0x130
kernel:  [<c016bb3a>] vfs_write+0xaa/0x130
kernel:  [<c016bc5f>] sys_write+0x3f/0x60
kernel:  [<c043f1cf>] syscall_call+0x7/0xb

Backtrace from the "dmsetup resume" call on that device:

kernel: dm            D C1201BE0     0   788    758               (NOTLB)
kernel: c2f21c58 00000082 00000000 c1201be0 c1202540 00000000 00000000 00000000
kernel:        00000010 c1201be0 00035e9e fd17af8b 00000040 cf85d968 00000000 00000010
kernel:        c0fc210c cf85d7b0 fffeffff c2f21c88 c02e050c c0fa32fc c2f21c98 c0fc2118
kernel: Call Trace:
kernel:  [<c02e050c>] rwsem_down_read_failed+0xbc/0x1b0
kernel:  [<c029d5ec>] .text.lock.xfs_iget+0x71/0x145
kernel:  [<c02bd7bc>] xfs_sync_inodes+0x28c/0xaa0
kernel:  [<c02be2aa>] xfs_syncsub+0x2da/0x2f0
kernel:  [<c02bd526>] xfs_sync+0x26/0x30
kernel:  [<c02d19d1>] vfs_sync+0x41/0x50
kernel:  [<c0296ded>] xfs_fs_freeze+0x3d/0xb0
kernel:  [<c02cd2ac>] xfs_ioctl+0x7bc/0xa60
kernel:  [<c0154d93>] pagevec_lookup_tag+0x33/0x40
kernel:  [<c0146409>] wait_on_page_writeback_range+0x79/0x130
kernel:  [<c018b308>] igrab+0x88/0xa0
kernel:  [<c02d2794>] vn_hold+0x44/0x90
kernel:  [<c02bd32f>] xfs_root+0x1f/0x30
kernel:  [<c02d11e6>] linvfs_freeze_fs+0x66/0x80
kernel:  [<c016d686>] freeze_bdev+0x116/0x140
kernel:  [<c03a747a>] __lock_fs+0x5a/0xb0
kernel:  [<c03a75db>] dm_suspend+0x7b/0x210
kernel:  [<c0121e80>] default_wake_function+0x0/0x20
kernel:  [<c0121e80>] default_wake_function+0x0/0x20
kernel:  [<c03aa164>] __get_name_cell+0x14/0x70
kernel:  [<c03ab26c>] do_resume+0x16c/0x1b0
kernel:  [<c03ac2c6>] ctl_ioctl+0xe6/0x180
kernel:  [<c03ab2b0>] dev_suspend+0x0/0x20
kernel:  [<c0181b82>] sys_ioctl+0x152/0x300
kernel:  [<c043f1cf>] syscall_call+0x7/0xb


-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
