Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313472AbSEJUhB>; Fri, 10 May 2002 16:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316116AbSEJUhA>; Fri, 10 May 2002 16:37:00 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:20365 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S313472AbSEJUhA>; Fri, 10 May 2002 16:37:00 -0400
Date: Fri, 10 May 2002 16:36:58 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iget_locked [1/6]
Message-ID: <20020510203658.GA23583@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020510160741.GD18065@ravel.coda.cs.cmu.edu> <Pine.GSO.4.21.0205101557380.19226-100000@weyl.math.psu.edu> <20020510160719.GB18065@ravel.coda.cs.cmu.edu> <Pine.GSO.4.21.0205101550290.19226-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 03:53:17PM -0400, Alexander Viro wrote:
> On Fri, 10 May 2002, Jan Harkes wrote:
> > +			if (set)
> > +				err = set(inode, data);
> > +			if (!err) {
> > +				inodes_stat.nr_inodes++;
> > +				list_add(&inode->i_list, &inode_in_use);
> > +				list_add(&inode->i_hash, head);
> > +				inode->i_state = I_LOCK;
> > +			}
> >  			spin_unlock(&inode_lock);
> >  
> > +			if (err) {
> > +				destroy_inode(inode);
> > +				return NULL;
> > +			}
> 
> Please, take that code out of the path - will be cleaner that way.

Ok, a later patch already makes 'set' required, and I was only using the
failure path in Coda. I'll change this so that set never fails.


On Fri, May 10, 2002 at 04:00:54PM -0400, Alexander Viro wrote:
> On Fri, 10 May 2002, Jan Harkes wrote:
> > +	*inode = iget_locked(sb, CTL_INO);
> > +	if ( *inode && ((*inode)->i_state & I_NEW) ) {
> >  		(*inode)->i_op = &coda_ioctl_inode_operations;
> >  		(*inode)->i_fop = &coda_ioctl_operations;
> >  		(*inode)->i_mode = 0444;
> > +		unlock_new_inode(*inode);
> 
> Ehhh....  Do we need this guy hashed, in the first place?

Actually we really don't want this guy hashed, I'll use new_inode(sb)
for this one.


> >    destroy_inode: reiserfs_destroy_inode,
> >    read_inode: reiserfs_read_inode,
> > -  read_inode2: reiserfs_read_inode2,
> 
> Why do we keep ->read_inode() here?

Just in case someone outside of reiser calls 'iget' on a reiserfs inode.
I guess it's not really necessary to have it around.


> > Here we simply add an argument to insert_inode_hash. If at some
> > point a FS specific getattr method is implemented it will be possible to
> > completely remove all uses of i_ino in the VFS.
>
> How about
> 
> static inline void insert_inode_hash(struct inode *inode)
> { 
>         __insert_inode_hash(inode, inode->i_hash);

Ok, will do that.

Should I create one patch that goes in relative to iget_locked-6, or
resubmit updated patches for each step? I guess an additional patch is
the easiest. Or a -6a that replaces the existing -6.

Jan

