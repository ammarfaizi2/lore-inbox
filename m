Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266135AbUA2GY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 01:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUA2GY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 01:24:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:9962 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266135AbUA2GYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 01:24:55 -0500
Date: Wed, 28 Jan 2004 22:25:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-Id: <20040128222521.75a7d74f.akpm@osdl.org>
In-Reply-To: <bv8qr7$m2v$1@news.cistron.nl>
References: <bv8qr7$m2v$1@news.cistron.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
>
> I have a Linux 2.6.2-rc2 NFS file server and another similar
> box as client. Kernel is compiled for SMP (hyperthreading).
> 
> On the NFS server I'm exporting an XFS filesystem to the client
> over Gigabit ethernet. The client mounts using
> mount -o nfsvers=3,intr,rsize=32768,wsize=32768 server:/export/hwr /mnt
> 
> On the client I then run a large dd to a file on the server,
> like dd if=/dev/zero of=/mnt/file bs=4096 count=800000
> 
> In a few seconds, the server locks up. It spins in
> generic_fillattr(), apparently in the i_size_read() inline function.
> Server responds to pings and sysrq, but nothing else.
> 
> 2.6.1 doesn't show this behaviour. I tested several kernels:
> 
> 2.6.1           	OK!
> 2.6.1-bk4		OK!
> 2.6.1-bk5		doesn't boot
> 2.6.1-bk6		hangs
> 2.6.2-rc1		hangs
> 2.6.2-rc2		hangs
> 2.6.2-rc2-gcc-2.95	hangs
> 2.6.2-rc1-mm3		OK!
> 2.6.2-rc2-mm1		OK!
> 
> I can't reproduce it on the local filesystem on the NFS server
> directly, and I can't reproduce it on other filesystems than XFS.
> But NFSD+XFS locks up every time.
> 
> Unfortunately the diff between 2.6.1-bk4 and bk6 is too large
> for me to see what the difference is, likewise 2.6.2-rc2-mm1,
> but perhaps someone has an idea what could be causing this ?
> 
> Here's the sysrq output:
> 
> Pid: 531, comm:                 nfsd
> EIP: 0060:[<c01577c2>] CPU: 0
> EIP is at generic_fillattr+0x82/0xa0
>  EFLAGS: 00000246    Not tainted
> EAX: 00000000 EBX: 07ae7200 ECX: f650a0a0 EDX: 000113eb
> ESI: 00000000 EDI: f66cfed4 EBP: f66e5804 DS: 007b ES: 007b
> CR0: 8005003b CR2: 40019000 CR3: 37245000 CR4: 000006d0
> Call Trace:
>  [<f8ab1f6b>] linvfs_getattr+0x2b/0x34 [xfs]
>  [<c0157805>] vfs_getattr+0x25/0x84
>  [<c01c19a3>] encode_post_op_attr+0x53/0x238
>  [<c01c1e27>] encode_wcc_data+0x29f/0x2a8
>  [<c01c4521>] nfs3svc_encode_commitres+0x19/0x5c
>  [<c01b709d>] nfsd_dispatch+0x14d/0x1a3
>  [<c02fb79b>] svc_process+0x3b3/0x640
>  [<c01b6ddc>] nfsd+0x1e4/0x358
>  [<c01b6bf8>] nfsd+0x0/0x358
>  [<c0107251>] kernel_thread_helper+0x5/0xc
> 

Is the EIP _always_ inside generic_fillattr()?

If so then yes, your analysis look right.  I'd say that the inode has been
corrupted and the seqcount counter has assumed an non-even value.  That
will cause i_size_read() to lock up.

Are you using slab debugging?  Is so, does the lockup go away if you change
mm/slab.c:POISON_FREE to an even value, say 0x6a?  That would tend to
confirm a use-after-free problem.  Or a totally wild pointer.




