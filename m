Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288816AbSAEOFM>; Sat, 5 Jan 2002 09:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288815AbSAEOFC>; Sat, 5 Jan 2002 09:05:02 -0500
Received: from pat.uio.no ([129.240.130.16]:46562 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S288813AbSAEOEv>;
	Sat, 5 Jan 2002 09:04:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15415.2041.170842.557212@charged.uio.no>
Date: Sat, 5 Jan 2002 15:04:41 +0100
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd kern  
 el panic woes
In-Reply-To: <3C36E6E8.628BF0BF@zip.com.au>
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au>
	<Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>
	<20011231010537.K1356@athlon.random>
	<3C36E6E8.628BF0BF@zip.com.au>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

     >   out_ok:
     >  	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type
     >  	!= F_UNLCK) {
     > - filemap_fdatasync(inode->i_mapping);
     > + status2 = filemap_fdatasync(inode->i_mapping);
     > + if (status2 && !status)
     > + status = status2;
     >  		down(&inode->i_sem);
     > - nfs_wb_all(inode); /* we may have slept */
     > + status2 = nfs_wb_all(inode); /* we may have slept */
     > + if (status2 && !status)
     > + status2 = status;
     >  		up(&inode->i_sem);
     > - filemap_fdatawait(inode->i_mapping);
     > + status2 = filemap_fdatawait(inode->i_mapping);
     > + if (status2 && !status)
     > + status = status2;
     >  		nfs_zap_caches(inode);
     >  	} return status;

Hmm. I'm not sure about this hunk...

At this point in the code, we already know that we've been granted a
lock by the server. All we are doing is to try to sync any data that
may have been committed while we were waiting on the lock, in order to
ensure that the act of locking provides a cache coherency point.

IMHO it would be wrong to signal that the lock itself has failed just
because some other process has lost data in the filemap_fdata* calls.
It's a different matter with the nfs_wb_all() call: that indicates
that the process has been signalled, so it may indeed make sense to
return that particular error.

Cheers,
  Trond
