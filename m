Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWIVXLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWIVXLY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWIVXLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:11:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964876AbWIVXLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:11:23 -0400
Date: Fri, 22 Sep 2006 16:10:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Timothy Shimmin <tes@sgi.com>
Cc: Eric Sandeen <sandeen@sandeen.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs mailing list <xfs@oss.sgi.com>
Subject: Re: [PATCH -mm] rescue large xfs preferred iosize from the inode
 diet patch
Message-Id: <20060922161040.609286fa.akpm@osdl.org>
In-Reply-To: <45134472.7080002@sgi.com>
References: <45131334.6050803@sandeen.net>
	<45134472.7080002@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 12:03:30 +1000
Timothy Shimmin <tes@sgi.com> wrote:

> Hi Eric,
> 
> Eric Sandeen wrote:
> > The inode diet patch in -mm unhooked xfs_preferred_iosize from the stat call:
> > 
> > --- a/fs/xfs/linux-2.6/xfs_vnode.c
> > +++ b/fs/xfs/linux-2.6/xfs_vnode.c
> > @@ -122,7 +122,6 @@ vn_revalidate_core(
> >         inode->i_blocks     = vap->va_nblocks;
> >         inode->i_mtime      = vap->va_mtime;
> >         inode->i_ctime      = vap->va_ctime;
> > -       inode->i_blksize    = vap->va_blocksize;
> >         if (vap->va_xflags & XFS_XFLAG_IMMUTABLE)
> > 
> > This in turn breaks the largeio mount option for xfs:
> > 
> >   largeio/nolargeio
> >         If "nolargeio" is specified, the optimal I/O reported in
> >         st_blksize by stat(2) will be as small as possible to allow user
> >         applications to avoid inefficient read/modify/write I/O.
> >         If "largeio" specified, a filesystem that has a "swidth" specified
> >         will return the "swidth" value (in bytes) in st_blksize. If the
> >         filesystem does not have a "swidth" specified but does specify
> >         an "allocsize" then "allocsize" (in bytes) will be returned
> >         instead.
> >         If neither of these two options are specified, then filesystem
> >         will behave as if "nolargeio" was specified.
> > 
> > and the (undocumented?) allocsize mount option as well.
> > 
> > For a filesystem like this with sunit/swidth specified,
> > 
> > meta-data=/dev/sda1              isize=512    agcount=32, agsize=7625840 blks
> >          =                       sectsz=512   attr=0
> > data     =                       bsize=4096   blocks=244026880, imaxpct=25
> >          =                       sunit=16     swidth=16 blks, unwritten=1
> > naming   =version 2              bsize=4096
> > log      =internal               bsize=4096   blocks=32768, version=1
> >          =                       sectsz=512   sunit=0 blks
> > realtime =none                   extsz=65536  blocks=0, rtextents=0
> > 
> > stat on a stock FC6 kernel w/ the largeio mount option returns only the page size:
> > 
> > [root@link-07]# mount -o largeio /dev/sda1 /mnt/test/
> > [root@link-07]# stat -c %o /mnt/test/foo
> > 4096
> > 
> > with the following patch, it does what it should:
> > 
> > [root@link-07]# mount -o largeio /dev/sda1 /mnt/test/
> > [root@link-07]# stat -c %o /mnt/test/foo
> > 65536
> > 
> > same goes for filesystems w/o sunit,swidth but with the allocsize mount option.
> > 
> > stock:
> > [root@link-07]# mount -o largeio,allocsize=32768 /dev/sda1 /mnt/test/
> > [root@link-07]# stat -c %o /mnt/test/foo
> > 4096
> > 
> > w/ patch:
> > [root@link-07# mount -o largeio,allocsize=32768 /dev/sda1 /mnt/test/
> > [root@link-07]# stat -c %o /mnt/test/foo
> > 32768
> > 
> > Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
> > 
> > XFS guys, does this look ok?
> > 
> > Index: linux-2.6.18/fs/xfs/linux-2.6/xfs_iops.c
> > ===================================================================
> > --- linux-2.6.18.orig/fs/xfs/linux-2.6/xfs_iops.c
> > +++ linux-2.6.18/fs/xfs/linux-2.6/xfs_iops.c
> > @@ -623,12 +623,16 @@ xfs_vn_getattr(
> >  {
> >  	struct inode	*inode = dentry->d_inode;
> >  	bhv_vnode_t	*vp = vn_from_inode(inode);
> > +	xfs_inode_t	*ip;
> >  	int		error = 0;
> >  
> >  	if (unlikely(vp->v_flag & VMODIFIED))
> >  		error = vn_revalidate(vp);
> > -	if (!error)
> > +	if (!error) {
> >  		generic_fillattr(inode, stat);
> > +		ip = xfs_vtoi(vp);
> > +		stat->blksize = xfs_preferred_iosize(ip->i_mount);
> > +	}
> >  	return -error;
> >  }
> >  
> 
> Looked at your patch and then at our xfs code in the tree and
> the existing code is different than what yours is based on.
> I then noticed in the logs Nathan has actually made changes for this:
> 
> ----------------------------
> revision 1.254
> date: 2006/07/17 10:46:05;  author: nathans;  state: Exp;  lines: +20 -5
> modid: xfs-linux-melb:xfs-kern:26565a
> Update XFS for i_blksize removal from generic inode structure
> ----------------------------
> I even reviewed the change (and I don't remember it - getting old).
> 
> I looked at the mods scheduled for 2.6.19 and this is one of them.
> 
> So the fix for this is coming soon (and the fix is different from the
> one above).
> 

eh?  Eric's patch is based on -mm, which includes the XFS git tree.  If I
go and merge the inode-diet patches from -mm, XFS gets broken until you
guys merge the above mystery patch.  (I prefer to merge the -mm patches
after all the git trees have gone, but sometimes maintainers dawdle and I
get bored of waiting).

Is git://oss.sgi.com:8090/nathans/xfs-2.6 obsolete, or are you hiding stuff
from me?  ;)


