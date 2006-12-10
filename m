Return-Path: <linux-kernel-owner+w=401wt.eu-S1761291AbWLJPsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761291AbWLJPsY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 10:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761293AbWLJPsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 10:48:24 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:2576 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761291AbWLJPsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 10:48:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=McQz15B42soL3ix/MoQRNHVeZS6I1zZeJkwhCDRnGaEbWV5MSabFRx5gqF1nhf33Pugy/kGn9zQBHmxmCxVi6Ra+KooCciKUNpKAYRvFS2RltxD5WqK6nxGDEtcVu9PxEVA7KA2tQarZeyjR1UXwwXZToITQHwbPF+eKe8WN4yM=
Message-ID: <9a8748490612100748w5caa69c5we3e35c2d18a836e2@mail.gmail.com>
Date: Sun, 10 Dec 2006 16:48:23 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: XFS internal error xfs_trans_cancel at line 1138 of file fs/xfs/xfs_trans.c (kernel 2.6.18.1)
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com, xfs-masters@oss.sgi.com, "Keith Owens" <kaos@sgi.com>
In-Reply-To: <9a8748490611292151m57cdbf4kacebb4dd20b95147@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490611280749k5c97d21bx2e499d2209d27dfe@mail.gmail.com>
	 <20061129013214.GH44411608@melbourne.sgi.com>
	 <9a8748490611290117oc0ba880v1a6407bc4f41088f@mail.gmail.com>
	 <20061130020734.GB37654165@melbourne.sgi.com>
	 <9a8748490611292151m57cdbf4kacebb4dd20b95147@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 30/11/06, David Chinner <dgc@sgi.com> wrote:
> > On Wed, Nov 29, 2006 at 10:17:25AM +0100, Jesper Juhl wrote:
> > > On 29/11/06, David Chinner <dgc@sgi.com> wrote:
> > > >On Tue, Nov 28, 2006 at 04:49:00PM +0100, Jesper Juhl wrote:
> > > >> Filesystem "dm-1": XFS internal error xfs_trans_cancel at line 1138 of
> > > >> file fs/xfs/xfs_trans.c.  Caller 0xffffffff8034b47e
> > > >>

For your information; I just got this again with a different
filesystem (see below).

> > > >> Call Trace:
> > > >> [<ffffffff8020b122>] show_trace+0xb2/0x380
> > > >> [<ffffffff8020b405>] dump_stack+0x15/0x20
> > > >> [<ffffffff80327b4c>] xfs_error_report+0x3c/0x50
> > > >> [<ffffffff803435ae>] xfs_trans_cancel+0x6e/0x130
> > > >> [<ffffffff8034b47e>] xfs_create+0x5ee/0x6a0
> > > >> [<ffffffff80356556>] xfs_vn_mknod+0x156/0x2e0
> > > >> [<ffffffff803566eb>] xfs_vn_create+0xb/0x10
> > > >> [<ffffffff80284b2c>] vfs_create+0x8c/0xd0
> > > >> [<ffffffff802e734a>] nfsd_create_v3+0x31a/0x560
> > > >> [<ffffffff802ec838>] nfsd3_proc_create+0x148/0x170
> > > >> [<ffffffff802e19f9>] nfsd_dispatch+0xf9/0x1e0
> > > >> [<ffffffff8049d617>] svc_process+0x437/0x6e0
> > > >> [<ffffffff802e176d>] nfsd+0x1cd/0x360
> > > >> [<ffffffff8020ab1c>] child_rip+0xa/0x12
> > > >> xfs_force_shutdown(dm-1,0x8) called from line 1139 of file
> > > >> fs/xfs/xfs_trans.c.  Return address = 0xffffffff80359daa
> > > >
> > > >We shut down the filesystem because we cancelled a dirty transaction.
> > > >Once we start to dirty the incore objects, we can't roll back to
> > > >an unchanged state if a subsequent fatal error occurs during the
> > > >transaction and we have to abort it.
> > > >
> > > So you are saying that there's nothing I can do to prevent this from
> > > happening in the future?
> >
> > Pretty much - we need to work out what is going wrong and
> > we can't from teh shutdown message above - the error has
> > occurred in a path that doesn't have error report traps
> > in it.
> >
> > Is this reproducable?
> >
> Not on demand, no. It has happened only this once as far as I know and
> for unknown reasons.
>
This time it *is* reproducible, so if you want me to try something let
me know fast since I have to delete the fs as soon as I have copied
all the data to a new one.


> > > >If I understand historic occurrences of this correctly, there is
> > > >a possibility that it can be triggered in ENOMEM situations. Was your
> > > >machine running out of memoy when this occurred?
> > > >
> > > Not really. I just checked my monitoring software and, at the time
> > > this happened, the box had ~5.9G RAM free (of 8G total) and no swap
> > > used (but 11G available).
> >
> > Ok. Sounds like we need more error reporting points inserted
> > into that code so we dump an error earlier and hence have some
> > hope of working out what went wrong next time.....
> >
> > OOC, there weren't any I/O errors reported before this shutdown?
> >
> No. I looked but found none.
>

This time the server was running 2.6.19 :

Dec 10 15:09:21 nfsserver2 kernel: Filesystem "dm-6": XFS internal
error xfs_trans_cancel at line 1138 of file fs/xfs/xfs_trans.c.
Caller 0xffffffff8034263c
Dec 10 15:09:21 nfsserver2 kernel:
Dec 10 15:09:21 nfsserver2 kernel: Call Trace:
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8020aefc>] dump_trace+0xb3/0x42e
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8020b2b3>] show_trace+0x3c/0x55
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8020b2e1>] dump_stack+0x15/0x17
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8031e91f>]
xfs_error_report+0x3c/0x3e
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8033975b>]
xfs_trans_cancel+0x65/0x109
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8034263c>] xfs_create+0x5bb/0x613
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8034b43e>]
xfs_vn_mknod+0x141/0x2b6
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8034b5ce>] xfs_vn_create+0xb/0xd
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff80278721>] vfs_create+0x7a/0xb1
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff802e0a9f>]
nfsd_create_v3+0x300/0x548
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff802e69f9>]
nfsd3_proc_create+0x152/0x164
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff802daf4a>]
nfsd_dispatch+0xea/0x1bd
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8049cdb3>] svc_process+0x3ee/0x6fb
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff802db54b>] nfsd+0x198/0x2bd
Dec 10 15:09:21 nfsserver2 kernel:  [<ffffffff8020a7a8>] child_rip+0xa/0x12
Dec 10 15:09:21 nfsserver2 kernel:
Dec 10 15:09:21 nfsserver2 kernel: xfs_force_shutdown(dm-6,0x8) called
from line 1139 of file fs/xfs/xfs_trans.c.  Return address =
0xffffffff8034e9ed
Dec 10 15:09:21 nfsserver2 kernel: Filesystem "dm-6": Corruption of
in-memory data detected.  Shutting down filesystem: dm-6
Dec 10 15:09:21 nfsserver2 kernel: Please umount the filesystem, and
rectify the problem(s)
Dec 10 15:12:23 nfsserver2 kernel: nfsd: last server has exited
Dec 10 15:12:23 nfsserver2 kernel: nfsd: unexporting all filesystems
Dec 10 15:12:26 nfsserver2 kernel: xfs_force_shutdown(dm-6,0x1) called
from line 424 of file fs/xfs/xfs_rw.c.  Return addres s =
0xffffffff8034e9ed

If I unmount and then remount the filesystem the log gets replayed OK,
I can then unmount it and run xfs_repair on it and it finds no
problems, *but* when I then mount it again and the webserver that uses
the filesystem access it via NFS it explodes again - every single
time, it's quite reproducible.
I'm currently in the process of copying all the data to a new XFS
filesystem in the hope that the new filesystem will be OK - the copy
seems to be proceeding fine.
Unfortunately I can't keep the current filesystem around for
diagnostics work since it's a production server and I don't have space
available to let the old and new copy co-exist, so I have to delete
the current one as soon as I have copied all the data off.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
