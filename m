Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUA2XVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUA2XVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:21:40 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:53217 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S261928AbUA2XVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:21:36 -0500
Date: Fri, 30 Jan 2004 00:20:33 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040129232033.GA10541@cistron.nl>
References: <bv8qr7$m2v$1@news.cistron.nl> <20040129063009.GD2474@frodo> <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129063009.GD2474@frodo> <20040128222521.75a7d74f.akpm@osdl.org>
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Andrew Morton:
> "Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
> >
> > On the NFS server I'm exporting an XFS filesystem to the client
> > over Gigabit ethernet. The client mounts using
> > mount -o nfsvers=3,intr,rsize=32768,wsize=32768 server:/export/hwr /mnt
> > 
> > On the client I then run a large dd to a file on the server,
> > like dd if=/dev/zero of=/mnt/file bs=4096 count=800000
> > 
> > In a few seconds, the server locks up. It spins in
> > generic_fillattr(), apparently in the i_size_read() inline function.
> > Server responds to pings and sysrq, but nothing else.
> > 
> > 2.6.1 doesn't show this behaviour. I tested several kernels:

Okay so I did some more tests today. As it turns out, all stock
2.6 kernels lock up - it's just that 2.6.2-rc* locks up faster
than earlier versions. I tested 2.6.1-rc1-mm3 and 2.6.2-rc2-mm1,
these do not lock up (test on -mm has been running for 8 hours
straight now, 2.6.* vanilla locks up in a few minutes).

> > Here's the sysrq output:
> > 
> > Pid: 531, comm:                 nfsd
> > EIP: 0060:[<c01577c2>] CPU: 0
> > EIP is at generic_fillattr+0x82/0xa0
> >  EFLAGS: 00000246    Not tainted
> > EAX: 00000000 EBX: 07ae7200 ECX: f650a0a0 EDX: 000113eb
> > ESI: 00000000 EDI: f66cfed4 EBP: f66e5804 DS: 007b ES: 007b
> > CR0: 8005003b CR2: 40019000 CR3: 37245000 CR4: 000006d0
> > Call Trace:
> >  [<f8ab1f6b>] linvfs_getattr+0x2b/0x34 [xfs]
> >  [<c0157805>] vfs_getattr+0x25/0x84
> >  [<c01c19a3>] encode_post_op_attr+0x53/0x238
> >  [<c01c1e27>] encode_wcc_data+0x29f/0x2a8
> >  [<c01c4521>] nfs3svc_encode_commitres+0x19/0x5c
> >  [<c01b709d>] nfsd_dispatch+0x14d/0x1a3
> >  [<c02fb79b>] svc_process+0x3b3/0x640
> >  [<c01b6ddc>] nfsd+0x1e4/0x358
> >  [<c01b6bf8>] nfsd+0x0/0x358
> >  [<c0107251>] kernel_thread_helper+0x5/0xc
> > 
> 
> Is the EIP _always_ inside generic_fillattr()?

Yes, if a keep on doing BREAK-p the output is alway the same.
EIP varies a few bytes, ofcourse, not much.

> If so then yes, your analysis look right.  I'd say that the inode has been
> corrupted and the seqcount counter has assumed an non-even value.  That
> will cause i_size_read() to lock up.
> 
> Are you using slab debugging?  Is so, does the lockup go away if you change
> mm/slab.c:POISON_FREE to an even value, say 0x6a?  That would tend to
> confirm a use-after-free problem.  Or a totally wild pointer.

I turned on slab debugging but it didn't help, and it didn't make
any difference. Well actually it made it take longer to show the
effect - at first I thought that the problem dissapeared when I turned
on slab debugging, but when I removed the "count=bignumber" from the
dd command, it locked up eventually (in a few minutes).

I also changed the debug constanst from odd to even and the
other way around, but that had no effect - no messages logged,
and the kernel still locked up.

Note that at this heavy load, there are up to 8 nfsd's running
on the server concurrently. There must be some lock or race ...

According to Nathan Scott:
> Hmmmm... I don't think Andrew has any XFS fixes in his tree that
> might help there; and I can't think of any XFS change in -rc1 that
> might have caused this (does the fs/xfs subdir from 2.6.1 plonked
> down in place of the 2.6.2-rc1/2 version still have the problem?)

Yes, sorry for the confusion - all 2.6 (non-mm) shows this behaviour.
I tried -mm1 XFS in 2.6.1-rc2, but that did't help, it still
locks up (the diff is just a one-liner, so that was to be expected).
So it doesn't look like an XFS problem, perse.

> i_size_read seems to have a fair bit of config dependency - are you
> CONFIG_SMP / CONFIG_PREEMPT / neither?  and is your BITS_PER_LONG
> 32 or 64?  thanks.

CONFIG_SMP (for P IV hyperthreading), 32 bits.

Mike.
