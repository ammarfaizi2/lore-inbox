Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVANOOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVANOOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVANOOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:14:45 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:902 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261998AbVANOOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:14:21 -0500
Date: Fri, 14 Jan 2005 14:14:12 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/11] FUSE - core
In-Reply-To: <E1CpS73-0001kC-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.60.0501141409500.18572@hermes-1.csi.cam.ac.uk>
References: <E1CoOpP-0003Jb-00@dorka.pomaz.szeredi.hu>
 <Pine.LNX.4.60.0501141351130.18572@hermes-1.csi.cam.ac.uk>
 <E1CpS73-0001kC-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Miklos Szeredi wrote:
> > > +static struct inode *fuse_alloc_inode(struct super_block *sb)
> > > +{
> > > +	struct inode *inode;
> > > +	struct fuse_inode *fi;
> > > +
> > > +	inode = kmem_cache_alloc(fuse_inode_cachep, SLAB_KERNEL);
> > 
> > This should probably be SLAB_NOFS as FUSE is a file system so you don't 
> > want allocations to go off submitting i/o to your file system.  Much 
> > better to be safe and always use the _NOFS versions in you kernel fs code.
> 
> Well, I don't think it matters in this case, since inode allocation is
> not part of processing I/O, so no deadlock is possible.  See also
> alloc_inode() in fs/inode.c which also uses SLAB_KERNEL.

That may well be possible.  I prefer to take a more cautious approach and 
only use _NOFS variants within NTFS, whether it is strictly necessary or 
not.  That way I never need to worry as to whether a deadlock is or isn't 
possible.  The problem simply goes away...

[snip]
> In actual fact the whole GFP_NOFS argument doesn't apply to FUSE
> _at_all_, since dirty pages are never allowed.  Which is because
> userspace can't easily be taught about GFP_NOFS allocations, and
> otherwise could deadlock on page writeback.

Yes, I remember the thread about the deadlock on page writeback.

I prefer the _NOFS regardless (and others will probably disagree) because 
it also means that if a machine is seriously running out of memory the fs 
will give up with -ENOMEM much more readily with _NOFS rather than 
increasing the memory pressure even further.  As I said, others probably 
disagree with me...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
