Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289110AbSAGDzF>; Sun, 6 Jan 2002 22:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289109AbSAGDy4>; Sun, 6 Jan 2002 22:54:56 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:39954 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289108AbSAGDyn>; Sun, 6 Jan 2002 22:54:43 -0500
Message-ID: <3C391AB1.21F8F48C@zip.com.au>
Date: Sun, 06 Jan 2002 19:49:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd kern el 
 panic woes
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au> <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>, <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>; <20011231010537.K1356@athlon.random> <3C36E6E8.628BF0BF@zip.com.au>,
		<3C36E6E8.628BF0BF@zip.com.au>; from akpm@zip.com.au on Sat, Jan 05, 2002 at 03:43:36AM -0800 <20020107040828.H1561@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > +             ret = filemap_sync(vma, start, end-start, flags);
> >
> > -             if (!error && (flags & MS_SYNC)) {
> > +             if (flags & (MS_SYNC|MS_ASYNC)) {
> 
> ok, it cannot fail but I prefer you either avoid the 'ret =
> filemap_sync' and you make filemap_sync return void, or you also left
> '(!err' over here.

OK, let's leave the test in place - filemap_sync() has global scope.

> >                       struct inode * inode = file->f_dentry->d_inode;
> > +
> >                       down(&inode->i_sem);
> > -                     filemap_fdatasync(inode->i_mapping);
> > -                     if (file->f_op && file->f_op->fsync)
> > -                             error = file->f_op->fsync(file, file->f_dentry, 1);
> > -                     filemap_fdatawait(inode->i_mapping);
> > +                     ret = filemap_fdatasync(inode->i_mapping);
> > +                     if (flags & MS_SYNC) {
> > +                             int err;
> > +
> > +                             if (file->f_op && file->f_op->fsync) {
> > +                                     err = file->f_op->fsync(file, file->f_dentry, 1);
> > +                                     if (err && !ret)
> > +                                             ret = err;
> > +                             }
> > +                             err = filemap_fdatawait(inode->i_mapping);
> > +                             if (err && !ret)
> > +                                     ret = err;
> > +                     }
> 
> sounds right (not something I'd love to do in 2.4 but it's
> strightforward enough so I'll take the risk).

It works OK, but in practice makes little difference compared to MS_ASYNC.
We run out of request slots very easily with this sort of thing.

Another option would be to make MS_ASYNC behave the same as MS_SYNC,
which is probably better than just ignoring it as we do at present.
I'll leave it as shown above unless there be objections.
 
> 
> you forgot return ret here.

Whoop, thanks.  It was returning `err'.
 
> > --- linux-2.4.18-pre1/fs/nfs/file.c   Wed Dec 26 11:47:41 2001
> > +++ linux-akpm/fs/nfs/file.c  Sat Jan  5 03:21:07 2002
> > @@ -244,6 +244,7 @@ nfs_lock(struct file *filp, int cmd, str
> >  {
> >       struct inode * inode = filp->f_dentry->d_inode;
> >       int     status = 0;
> > +     int     status2;
> >
> >       dprintk("NFS: nfs_lock(f=%4x/%ld, t=%x, fl=%x, r=%Ld:%Ld)\n",
> >                       inode->i_dev, inode->i_ino,
> > @@ -278,11 +279,18 @@ nfs_lock(struct file *filp, int cmd, str
> >        * Flush all pending writes before doing anything
> >        * with locks..
> >        */
> > -     filemap_fdatasync(inode->i_mapping);
> > +     /*
> > +      * Shouldn't filemap_fdatasync/wait be inside i_sem?
> > +      */
> 
> I think it's not necessary, because the list browse it's serialized by
> the pagecache_lock and writepage can run outside the i_sem.

Yup.  I've changed this part of the patch based on some discussion
with Trond.


I'll wait until Marcelo looks like he has his head above water and
then send out the final version of the ramdisk, truncate and
fsync/msync patches, cc'ed to yourself and lkml.

Thanks.
