Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbUAaBZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 20:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUAaBZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 20:25:24 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:64145 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S264454AbUAaBZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 20:25:16 -0500
Date: Sat, 31 Jan 2004 02:25:07 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org, nathans@sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040131012507.GQ25833@drinkel.cistron.nl>
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl> <20040130221353.GO25833@drinkel.cistron.nl> <20040130143459.5eed31f0.akpm@osdl.org> <20040130225353.A26383@infradead.org> <20040130151316.40d70ed3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040130151316.40d70ed3.akpm@osdl.org> (from akpm@osdl.org on Sat, Jan 31, 2004 at 00:13:16 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jan 2004 00:13:16, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Jan 30, 2004 at 02:34:59PM -0800, Andrew Morton wrote:
> > > If two CPUs hit i_size_write() at the same time we have a bug.  That
> > > function requires that the caller provide external serialisation, via i_sem.
> > 
> > O_APPEND|O_DIRECT writes could do that under XFS..
> 
> Sigh.
>
> diff -puN mm/filemap.c~i_size_write-check mm/filemap.c
> --- 25/mm/filemap.c~i_size_write-check	Fri Jan 30 15:10:23 2004
> +++ 25-akpm/mm/filemap.c	Fri Jan 30 15:11:41 2004
> @@ -2010,3 +2010,18 @@ out:
>  }
>  
>  EXPORT_SYMBOL_GPL(generic_file_direct_IO);
> +
> +void i_size_write_check(struct inode *inode)
> +{
> +	static int count = 0;
> +
> +	if (down_trylock(&inode->i_sem) == 0) {
> +		if (count < 10) {

You want to set this to 100 at least, since at boot time the message
happens _often_ even without XFS.

It's caused by sysfs:

Jan 31 00:48:33 meghan kernel: i_size_write() called without i_sem
Jan 31 00:48:33 meghan kernel: Call Trace:
Jan 31 00:48:33 meghan kernel:  [i_size_write_check+95/97] i_size_write_check+0x5f/0x61
Jan 31 00:48:33 meghan kernel:  [simple_commit_write+74/148] simple_commit_write+0x4a/0x94
Jan 31 00:48:33 meghan kernel:  [page_symlink+210/414] page_symlink+0xd2/0x19e
Jan 31 00:48:33 meghan kernel:  [sysfs_symlink+107/126] sysfs_symlink+0x6b/0x7e
Jan 31 00:48:33 meghan kernel:  [sysfs_create_link+313/317] sysfs_create_link+0x139/0x13d
Jan 31 00:48:33 meghan kernel:  [bus_add_device+143/161] bus_add_device+0x8f/0xa1
[etc etc]

Also, bd_set_size runs unlocked:

Jan 31 02:02:39 meghan kernel: I am buggy
Jan 31 02:02:39 meghan kernel: Call Trace:
Jan 31 02:02:39 meghan kernel:  [bd_set_size+201/218] bd_set_size+0xc9/0xda
Jan 31 02:02:39 meghan kernel:  [do_open+282/1014] do_open+0x11a/0x3f6
Jan 31 02:02:39 meghan kernel:  [blkdev_get+114/128] blkdev_get+0x72/0x80
Jan 31 02:02:39 meghan kernel:  [do_open+603/1014] do_open+0x25b/0x3f6
Jan 31 02:02:39 meghan kernel:  [blkdev_get+114/128] blkdev_get+0x72/0x80
Jan 31 02:02:39 meghan kernel:  [open_bdev_excl+87/172] open_bdev_excl+0x57/0xacJan 31 02:02:39 meghan kernel:  [get_sb_bdev+55/344] get_sb_bdev+0x37/0x158
Jan 31 02:02:39 meghan kernel:  [ext3_get_sb+47/51] ext3_get_sb+0x2f/0x33
Jan 31 02:02:39 meghan kernel:  [ext3_fill_super+0/2949] ext3_fill_super+0x0/0xb85
Jan 31 02:02:39 meghan kernel:  [do_kern_mount+95/213] do_kern_mount+0x5f/0xd5
Jan 31 02:02:39 meghan kernel:  [do_add_mount+120/334] do_add_mount+0x78/0x14e
Jan 31 02:02:39 meghan kernel:  [do_mount+289/359] do_mount+0x121/0x167
Jan 31 02:02:39 meghan kernel:  [__copy_from_user_ll+104/108] __copy_from_user_ll+0x68/0x6c
Jan 31 02:02:39 meghan kernel:  [copy_mount_options+128/234] copy_mount_options+0x80/0xea
Jan 31 02:02:39 meghan kernel:  [sys_mount+203/309] sys_mount+0xcb/0x135
Jan 31 02:02:39 meghan kernel:  [do_mount_root+47/156] do_mount_root+0x2f/0x9c
Jan 31 02:02:39 meghan kernel:  [mount_block_root+84/285] mount_block_root+0x54/0x11d
Jan 31 02:02:39 meghan kernel:  [mount_root+94/102] mount_root+0x5e/0x66
Jan 31 02:02:39 meghan kernel:  [prepare_namespace+38/195] prepare_namespace+0x26/0xc3
Jan 31 02:02:39 meghan kernel:  [init+80/334] init+0x50/0x14e
Jan 31 02:02:39 meghan kernel:  [init+0/334] init+0x0/0x14e
Jan 31 02:02:39 meghan kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

But the XFS problem appears to be vn_revalidate which calls i_size_write()
without holding i_sem:

Jan 31 02:04:00 meghan kernel: I am buggy
Jan 31 02:04:00 meghan kernel: Call Trace:
Jan 31 02:04:00 meghan kernel:  [__crc_pm_idle+1813107/4617778] vn_revalidate+0x18e/0x1a9 [xfs]
Jan 31 02:04:00 meghan kernel:  [nfsd_commit+205/219] nfsd_commit+0xcd/0xdb
Jan 31 02:04:00 meghan kernel:  [__crc_pm_idle+1798087/4617778] linvfs_getattr+0x39/0x3f [xfs]
Jan 31 02:04:00 meghan kernel:  [vfs_getattr+57/154] vfs_getattr+0x39/0x9a
Jan 31 02:04:00 meghan kernel:  [encode_post_op_attr+104/577] encode_post_op_attr+0x68/0x241
Jan 31 02:04:00 meghan kernel:  [nfs3svc_encode_commitres+42/115] nfs3svc_encode_commitres+0x2a/0x73
Jan 31 02:04:00 meghan kernel:  [nfsd_dispatch+297/485] nfsd_dispatch+0x129/0x1e5
Jan 31 02:04:00 meghan kernel:  [svc_process+1170/1621] svc_process+0x492/0x655
Jan 31 02:04:00 meghan kernel:  [apic_timer_interrupt+26/32] apic_timer_interrupt+0x1a/0x20
Jan 31 02:04:00 meghan kernel:  [nfsd+490/915] nfsd+0x1ea/0x393
Jan 31 02:04:00 meghan kernel:  [nfsd+0/915] nfsd+0x0/0x393
Jan 31 02:04:00 meghan kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

Mike.
