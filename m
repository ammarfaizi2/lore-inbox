Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132733AbRDDCVH>; Tue, 3 Apr 2001 22:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRDDCU7>; Tue, 3 Apr 2001 22:20:59 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:5394 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S132733AbRDDCUq>; Tue, 3 Apr 2001 22:20:46 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
Date: Wed, 4 Apr 2001 12:19:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15050.33990.943770.80410@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsd vfs.c does not seems to fsync() with file overwrite, when
 it have to.
In-Reply-To: message from Kenichi Okuyama on Tuesday April 3
In-Reply-To: <20010403.020756.107318465.okuyamak@dd.iij4u.or.jp>
	<15049.25226.737278.41390@notabene.cse.unsw.edu.au>
	<20010403.162549.48535841.okuyamak@dd.iij4u.or.jp>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 3, okuyamak@dd.iij4u.or.jp wrote:
> NB> Whenever you write to a file you change the inode - by changing the
> NB> modify time at least.  Look at generic_file_write in mm/filemap.c.
> NB> Notice the code:
> NB>        if (count) {
> NB> 		remove_suid(inode);
> inode-> i_ctime = inode->i_mtime = CURRENT_TIME;
> NB> 		mark_inode_dirty_sync(inode);
> NB> 	}
> 
> ! I see.... 
> 
> Well, actually I found three question here.
> 
> 
> 1st:
> 
> Doesn't "calling write with size 0" should cause
> 	i_mtime = CURRENT_TIME;
> ?

Does it matter?  Ask POSIX, or SUS or some other standard...

> 
> 
> 2nd:
> At where will the inode be written to storage in generic_file_write()?
> 
> According to very end of this function it says:
> 
> 	/* For now, when the user asks for O_SYNC, we'll actually
> 	 * provide O_DSYNC. */
> 	if ((status >= 0) && (file->f_flags & O_SYNC))
> 		status = generic_osync_inode(inode, 1); /* 1 means datasync */
> 
> This means write() does not write inode here. So it must be written
> somewhere before.

Probably not.  I think it gets written after.  Possibly not until
memory pressure or a regular sync() flushes it out.  
This is probably not ideal, but I think that O_SYNC handling is still
a work-in-progress.

> 
> 
> 3rd:
> Is it really good idea to rely on write() for SYNCRONOUS write, 
> rather than relying on fsync()??
> 
> At least, if we use fsync(), we can assume that all updates of
> current nfsd will be held on file cache on memory. But not only,
> we can "WISH" for some "write" request that comes from different
> nfsd, or from different process, could be applied too, especially
> in case of SMP world.
> 
> By calling fsync() all these will be updated to storage at once.
> And this can be held without waiting even jiffie.
> Yes we can do GATHER WRITE without any waiting tricks.
> 
> 
> Semantically, calling SYNCRONOUS write() and calling fsync() is
> equivalent.
> 
> Then, isn't it better to choose 'better chanced' case?  I mean,
> instead of switching write() option, isn't it better to call
> fsync()?

You are probably right.  In practice, fsync is probably better than
O_SYNC, though in theory they should be the same.
But then in practice, almost everybody uses gathered writes, so fsync
is actually used.

> 
> # It should make code more simple too, for even if you call
> # fsync(), if filesystem is being mounted "sync", fsunc()
> # have nothing to do, and will come back quickly anyway.
> # All we need to do is check ( status != UNSTABLE ) and 
> # call nfsd_sync() right away.
> 
> 
> I know that relying to fsync() is bad, if there's known bug in
> fsync(), especially about ext2. But I never heard of one. Is there?
> 

Well, fsync in ext2 in 2.2 is really slow on large files, but that is
an issue of fading significance.
However I am not sure that there is any guarantee that filesystems
will support fsync.  I note that sys_fsync allows for the possibility
that fsync is supported on the file.  NFSd should too.

I would prefer to wait for O_SYNC to be implemented properly than to
change nfsd to always use fsync, but I don't feel very strongly about
it. 

> 
> 
> >> P.S.  I don't really think we should wait for 10msec At point of
> >> Gathered writes. I don't think this will be of any help.
> >> It's because fsync() have locking of it's own.
> NB> The theory is that you might get 4 write requests inside 10msec.
> 
> I know, but if those were all syncronous requiests, all those 4
> nfsds will stop for 10msec. And that means performance of nfs server
> have to pay 10msec each which means all 4 clients have to pay extra
> 10msec, even if writing to disk became less.
> 
> We're really loosing 40msec with overlaps as total....

If they were synchronous, then nfsd_write wouldn't notice concurrent
writes and wouldn't pause the 10msec.

I suggest that you do some benchmarking.  Choose a test.  See how fast
it runs.  Change the code.  See what difference it makes.  I would
definately be interested in those sorts of results.

> 
> 
> Instead, all we need to do GATHER WRITE is to do
> 
> 	 asyncronous write()
> 	 fsync()
> 
> in this order. Because write() and fsync() contains locking, if
> write request is being held in such a quick speed, fsync() will be
> stopped by other process(CPU)'s write() request being queued at
> entry point of write().

I suspect that in most cases the async write would be quite quick, and
the fsync would start before the async write of the next request.  But
try it and tell us what happens.

NeilBrown
