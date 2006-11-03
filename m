Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753021AbWKCD1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbWKCD1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 22:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbWKCD1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 22:27:46 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:32152 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1753016AbWKCD1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 22:27:45 -0500
Date: Thu, 2 Nov 2006 22:27:02 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fsstack: Generic get/set lower object functions
Message-ID: <20061103032702.GB13499@filer.fsl.cs.sunysb.edu>
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu> <20061102035928.679.5819.stgit@thor.fsl.cs.sunysb.edu> <1162483565.6299.98.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162483565.6299.98.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 11:06:05AM -0500, Trond Myklebust wrote:
> On Wed, 2006-11-01 at 22:59 -0500, Josef Jeff Sipek wrote:
...
> > +/* structs to maintain pointers to the lower VFS objects */
> > +struct fsstack_sb_info {
> > +	union {
> > +		struct super_block *sb;
> > +		struct super_block **sbs;
> > +	};
> > +};
> 
> Why are you defining all these structs that are just wrapping unions?
 
The reason for the union is simple...

1) if you have a linear stackable filesystem (e.g., ecryptfs), your objects
need to point to only one lower object (sb -> lower sb, etc.)

2) if you have a fanout stackable filesystem (e.g., unionfs), your objects
need to point to n lower objects

Since we don't want to hurt linear stacks by declaring arrays of pointers, I
think the best way is to have the lower pointer (e.g., *sb) in a union with
the lower double pointer (e.g., **sbs) - this works simply because linear
stacks will always 
 
> > +/* get the fs dependent data */
> > +static inline void * fsstack_inode_data(struct inode *inode)
> > +{
> > +	return &((struct __fsstack_inode_generic_info*) inode)->info;
> 
> Please make this wrap container_of() instead of rolling your own.

Will do.

> Also note that the naming convention for such a wrapper in almost all
> other filesystems would be FSSTACK_I()

Very true, I'll change it to match.

I suppose the function to get the dentry private data should be called
FSSTACK_D() and for the superblock FSSTACK_SB() ?

> > +static inline struct inode *
> > +__fsstack_lower_inode(struct inode *inode, unsigned long branch_idx)
> > +{
> > +	struct fsstack_inode_info *info = fsstack_inode_data(inode);
> > +		
> > +	return info->inodes[branch_idx];
> > +}
> 
> What is the value of "functions" like the above? They appear just to
> obfuscate the code. Unless your aim is to hide the internals of the
> struct __fsstack_inode_generic_info (sort of futile, since you are
> asking users to include that structure in their private inode structs

Another idea is to move the fsstack_foo_info structure elsewhere...

For stackable filesystems it makes sense to have the pointers right in the
inode, but we don't want to penalize the rest if the filesystems. One
solution would be to have a special stackable_inode which contains the lower
inode pointers. This would still hide the details from the user...

> )
> then it is much more obvious to see what is going on when you write
> 
> 	inode = FSSTACK_I(inode)->inodes[branch];
> 
> rather than
> 
> 	inode = __fsstack_lower_inode(inode, branch);

Point taken. You need to know what's going to anyway, so we might as well
make it painfully obvious.

Josef "Jeff" Sipek.

-- 
If I have trouble installing Linux, something is wrong. Very wrong.
		- Linus Torvalds
