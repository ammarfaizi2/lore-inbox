Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753023AbWKCDpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbWKCDpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 22:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbWKCDpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 22:45:23 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:52901 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1753023AbWKCDpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 22:45:22 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH 2/3] fsstack: Generic get/set lower object functions
Date: Fri, 3 Nov 2006 03:45:50 +0000
User-Agent: KMail/1.9.5
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu> <1162483565.6299.98.camel@lade.trondhjem.org> <20061103032702.GB13499@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20061103032702.GB13499@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611030345.51167.mark.williamson@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why are you defining all these structs that are just wrapping unions?
>
> The reason for the union is simple...

I think the query was more about why you'd need a struct which contains only 
an anonymous union - why not just have a named union?  Or do you anticipate 
adding extra fields to the struct later?

I guess that having a union foo * rather than a struct foo * would be a bit 
unconventional in the kernel.  The named struct / anonymous union combo does 
hide the union as merely an implementation detail, which is nice.  Was this 
your motivation?

Cheers,
Mark

> 1) if you have a linear stackable filesystem (e.g., ecryptfs), your objects
> need to point to only one lower object (sb -> lower sb, etc.)
>
> 2) if you have a fanout stackable filesystem (e.g., unionfs), your objects
> need to point to n lower objects
>
> Since we don't want to hurt linear stacks by declaring arrays of pointers,
> I think the best way is to have the lower pointer (e.g., *sb) in a union
> with the lower double pointer (e.g., **sbs) - this works simply because
> linear stacks will always
>
> > > +/* get the fs dependent data */
> > > +static inline void * fsstack_inode_data(struct inode *inode)
> > > +{
> > > +	return &((struct __fsstack_inode_generic_info*) inode)->info;
> >
> > Please make this wrap container_of() instead of rolling your own.
>
> Will do.
>
> > Also note that the naming convention for such a wrapper in almost all
> > other filesystems would be FSSTACK_I()
>
> Very true, I'll change it to match.
>
> I suppose the function to get the dentry private data should be called
> FSSTACK_D() and for the superblock FSSTACK_SB() ?
>
> > > +static inline struct inode *
> > > +__fsstack_lower_inode(struct inode *inode, unsigned long branch_idx)
> > > +{
> > > +	struct fsstack_inode_info *info = fsstack_inode_data(inode);
> > > +
> > > +	return info->inodes[branch_idx];
> > > +}
> >
> > What is the value of "functions" like the above? They appear just to
> > obfuscate the code. Unless your aim is to hide the internals of the
> > struct __fsstack_inode_generic_info (sort of futile, since you are
> > asking users to include that structure in their private inode structs
>
> Another idea is to move the fsstack_foo_info structure elsewhere...
>
> For stackable filesystems it makes sense to have the pointers right in the
> inode, but we don't want to penalize the rest if the filesystems. One
> solution would be to have a special stackable_inode which contains the
> lower inode pointers. This would still hide the details from the user...
>
> > )
> > then it is much more obvious to see what is going on when you write
> >
> > 	inode = FSSTACK_I(inode)->inodes[branch];
> >
> > rather than
> >
> > 	inode = __fsstack_lower_inode(inode, branch);
>
> Point taken. You need to know what's going to anyway, so we might as well
> make it painfully obvious.
>
> Josef "Jeff" Sipek.

-- 
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
