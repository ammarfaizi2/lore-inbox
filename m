Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132602AbRDCGAg>; Tue, 3 Apr 2001 02:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132613AbRDCGA1>; Tue, 3 Apr 2001 02:00:27 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:36617 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S132602AbRDCGAR>; Tue, 3 Apr 2001 02:00:17 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: okuyamak@dd.iij4u.or.jp
Date: Tue, 3 Apr 2001 15:41:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15049.25226.737278.41390@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsd vfs.c does not seems to fsync() with file overwrite, when it
 have to.
In-Reply-To: message from okuyamak@dd.iij4u.or.jp on Tuesday April 3
In-Reply-To: <20010403.020756.107318465.okuyamak@dd.iij4u.or.jp>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 3, okuyamak@dd.iij4u.or.jp wrote:
> Dear Neil,
> 
> I think I've found bug in nfsd. Here's patch for fixing.
> I'd like to explain what's problem and what's changed, after patch.

snip

> 
> Because 
> 
> L710:	err = file.f_op->write(&file, buf, cnt, &file.f_pos);
> 
> does not store dirty pages to storage in case of async, we need to
> call fsync() in case if variable stable is non 0.
> 
> 
> Whether we should call nfsd_sync() or not, should not depend on
> whether    EX_WGATHER(exp)   is true or not. So,  calling nfsd_sync()
> should be outside 
> 
>        if ( EX_WGATHER(exp) ) {...}
> 
> statement.
> 

You've missed an important fact.
A few lines earlier is the code:
	if (stable && !EX_WGATHER(exp))
		file.f_flags |= O_SYNC;


so if ! EX_WGATHER, the file has the O_SYNC flag set and all IO to
that file is synchronous (whether the fs was mounted synchronous or
not). 
If EX_WGATHER, the flag isn't set, and explicitly call fsync after a
short delay.

> 
> Also, it should not depend on whether (inode->i_state & I_DIRTY) is
> true or not, because   (inode->i_state & I_DIRTY)  is true only when
> inode is being changed ( i.e. when append write is being held ),
> while we need to sync written data to filesystem even when we only
> over wrote already existing data area.

Whenever you write to a file you change the inode - by changing the
modify time at least.  Look at generic_file_write in mm/filemap.c.
Notice the code:
       if (count) {
		remove_suid(inode);
		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
		mark_inode_dirty_sync(inode);
	}

If a non-zero amount of data is being written, the inode is marked dirty.
If don't think the test actually serves the purpose as an fsync
doesn't cause the inode to be marked clean. I'm not sure when that happens.

> 
> P.S.  I don't really think we should wait for 10msec At point of
> Gathered writes. I don't think this will be of any help.
> It's because fsync() have locking of it's own.

The theory is that you might get 4 write requests inside 10msec.
Each of them enter data into the cache, but don't flush it to disc.
10ms after the first arrives, it causes a fsync on the file.  This
writes out all the data for the 4 requests.  The other requests
eventually finish their 10ms wait, and fsync finds that there is
nothing to write out and so complete quickly.

I didn't write this code and I don't know how well this code actually
works,  but it doesn't seem *wrong*  or harmful in any way.

NeilBrown
