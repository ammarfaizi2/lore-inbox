Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVANOIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVANOIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVANOIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:08:10 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:37005 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261418AbVANOID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:08:03 -0500
To: aia21@cam.ac.uk
CC: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.60.0501141351130.18572@hermes-1.csi.cam.ac.uk>
	(message from Anton Altaparmakov on Fri, 14 Jan 2005 13:55:46 +0000
	(GMT))
Subject: Re: [PATCH 2/11] FUSE - core
References: <E1CoOpP-0003Jb-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.60.0501141351130.18572@hermes-1.csi.cam.ac.uk>
Message-Id: <E1CpS73-0001kC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jan 2005 15:07:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static struct inode *fuse_alloc_inode(struct super_block *sb)
> > +{
> > +	struct inode *inode;
> > +	struct fuse_inode *fi;
> > +
> > +	inode = kmem_cache_alloc(fuse_inode_cachep, SLAB_KERNEL);
> 
> This should probably be SLAB_NOFS as FUSE is a file system so you don't 
> want allocations to go off submitting i/o to your file system.  Much 
> better to be safe and always use the _NOFS versions in you kernel fs code.

Well, I don't think it matters in this case, since inode allocation is
not part of processing I/O, so no deadlock is possible.  See also
alloc_inode() in fs/inode.c which also uses SLAB_KERNEL.

> > +static struct fuse_conn *new_conn(void)
> > +{
> > +	struct fuse_conn *fc;
> > +
> > +	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
> 
> Same comment as before:  GFP_NOFS is safer.

Same reason as above.

In actual fact the whole GFP_NOFS argument doesn't apply to FUSE
_at_all_, since dirty pages are never allowed.  Which is because
userspace can't easily be taught about GFP_NOFS allocations, and
otherwise could deadlock on page writeback.

Thanks,
Miklos
