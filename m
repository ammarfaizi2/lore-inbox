Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132688AbRDCH1O>; Tue, 3 Apr 2001 03:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132691AbRDCH1F>; Tue, 3 Apr 2001 03:27:05 -0400
Received: from mfo01.iij.ad.jp ([202.232.2.118]:55300 "EHLO mfo01.iij.ad.jp")
	by vger.kernel.org with ESMTP id <S132688AbRDCH1D>;
	Tue, 3 Apr 2001 03:27:03 -0400
Date: Tue, 03 Apr 2001 16:25:49 +0900 (JST)
Message-Id: <20010403.162549.48535841.okuyamak@dd.iij4u.or.jp>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsd vfs.c does not seems to fsync() with file overwrite, when
 it have to.
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <15049.25226.737278.41390@notabene.cse.unsw.edu.au>
In-Reply-To: <20010403.020756.107318465.okuyamak@dd.iij4u.or.jp>
	<15049.25226.737278.41390@notabene.cse.unsw.edu.au>
X-Mailer: Mew version 1.95b91 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Neil,

First of all, thank you for the answer. You've gave me good enough
hint to make several points clear.

>>>>> "NB" == Neil Brown <neilb@cse.unsw.edu.au> writes:
>> Whether we should call nfsd_sync() or not, should not depend on
>> whether    EX_WGATHER(exp)   is true or not. So,  calling nfsd_sync()
>> should be outside 
>> 
>> if ( EX_WGATHER(exp) ) {...}
>> 
>> statement.
>> 
NB> You've missed an important fact.
NB> A few lines earlier is the code:
NB> 	if (stable && !EX_WGATHER(exp))
NB> 		file.f_flags |= O_SYNC;

NB> so if ! EX_WGATHER, the file has the O_SYNC flag set and all IO to
NB> that file is synchronous (whether the fs was mounted synchronous or
NB> not). 

I think I got your point. You mean O_SYNC flag will be appended in
case of FILESYNC/DATASYNC mode ( or on nfsv2 ) , so it's not
required to call fsync().

But I have questions about this. It's related to write() assumtions
so I'd like to mention little bit later...


>> 
>> Also, it should not depend on whether (inode->i_state & I_DIRTY) is
>> true or not, because   (inode->i_state & I_DIRTY)  is true only when
>> inode is being changed ( i.e. when append write is being held ),
>> while we need to sync written data to filesystem even when we only
>> over wrote already existing data area.
NB> Whenever you write to a file you change the inode - by changing the
NB> modify time at least.  Look at generic_file_write in mm/filemap.c.
NB> Notice the code:
NB>        if (count) {
NB> 		remove_suid(inode);
inode-> i_ctime = inode->i_mtime = CURRENT_TIME;
NB> 		mark_inode_dirty_sync(inode);
NB> 	}

! I see.... 

Well, actually I found three question here.


1st:

Doesn't "calling write with size 0" should cause
	i_mtime = CURRENT_TIME;
?


2nd:
At where will the inode be written to storage in generic_file_write()?

According to very end of this function it says:

	/* For now, when the user asks for O_SYNC, we'll actually
	 * provide O_DSYNC. */
	if ((status >= 0) && (file->f_flags & O_SYNC))
		status = generic_osync_inode(inode, 1); /* 1 means datasync */

This means write() does not write inode here. So it must be written
somewhere before.


But if you think about robust filesystem, any inode update should be
held in "FROM FAR, TO NEAR" rule. I mean, if you have some data
update, you should first store data block, then store indirect
pointing blocks and update, and finally update inode.

# So that when you fail in updating file due to ... something like
# power down ... the very file still will not be crushed unless
# it crushed at very 'inode update' point. If you update from inode
# then write data ( I mean "FROM NEAR TO FAR" rule ), inode may have
# new block pointing but that block not being updated ( which means
# it still contains old data, which might cause security problem.
# Think what will happen if old block was used for /etc/shadow .
	
But I see no i-node update after here.... where is it????



3rd:
Is it really good idea to rely on write() for SYNCRONOUS write, 
rather than relying on fsync()??

At least, if we use fsync(), we can assume that all updates of
current nfsd will be held on file cache on memory. But not only,
we can "WISH" for some "write" request that comes from different
nfsd, or from different process, could be applied too, especially
in case of SMP world.

By calling fsync() all these will be updated to storage at once.
And this can be held without waiting even jiffie.
Yes we can do GATHER WRITE without any waiting tricks.


Semantically, calling SYNCRONOUS write() and calling fsync() is
equivalent.

Then, isn't it better to choose 'better chanced' case?  I mean,
instead of switching write() option, isn't it better to call
fsync()?

# It should make code more simple too, for even if you call
# fsync(), if filesystem is being mounted "sync", fsunc()
# have nothing to do, and will come back quickly anyway.
# All we need to do is check ( status != UNSTABLE ) and 
# call nfsd_sync() right away.


I know that relying to fsync() is bad, if there's known bug in
fsync(), especially about ext2. But I never heard of one. Is there?



>> P.S.  I don't really think we should wait for 10msec At point of
>> Gathered writes. I don't think this will be of any help.
>> It's because fsync() have locking of it's own.
NB> The theory is that you might get 4 write requests inside 10msec.

I know, but if those were all syncronous requiests, all those 4
nfsds will stop for 10msec. And that means performance of nfs server
have to pay 10msec each which means all 4 clients have to pay extra
10msec, even if writing to disk became less.

We're really loosing 40msec with overlaps as total....


Instead, all we need to do GATHER WRITE is to do

	 asyncronous write()
	 fsync()

in this order. Because write() and fsync() contains locking, if
write request is being held in such a quick speed, fsync() will be
stopped by other process(CPU)'s write() request being queued at
entry point of write().

If CPU was not fast enough, and could not treat write() request in
such a speed, or if CPU was too fast that write() runed too quickly,
first fsync() will start running. But other write() request will
wait for fsync() to finish at entry point of write(). This, I think,
is better than simply waiting for fixed time.


NB> I didn't write this code and I don't know how well this code actually
NB> works,  but it doesn't seem *wrong*  or harmful in any way.

This, I agree. I don't think it's wrong, nor is harmful.
Except for perfromance.


best regards,
---- 
Kenichi Okuyama@Tokyo Research Lab. IBM-Japan, Co.
