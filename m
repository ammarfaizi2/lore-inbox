Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbSKOQV6>; Fri, 15 Nov 2002 11:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbSKOQV6>; Fri, 15 Nov 2002 11:21:58 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:32012 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266473AbSKOQVy>; Fri, 15 Nov 2002 11:21:54 -0500
Date: Fri, 15 Nov 2002 16:28:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Path Name to kdev_t
Message-ID: <20021115162845.A10146@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>,
	"chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>,
	linux-kernel@vger.kernel.org
References: <000101c28be4$9ff1bf20$e9bba5cc@patni.com> <20021115161536.GA6654@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115161536.GA6654@reti>; from joe@fib011235813.fsnet.co.uk on Fri, Nov 15, 2002 at 04:15:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 04:15:36PM +0000, Joe Thornber wrote:
> On Thu, Nov 14, 2002 at 07:19:16PM +0530, chandrasekhar.nagaraj wrote:
> > Hi,
> > 
> > In one of the part of my driver module , I have a path name to a device file
> > (for eg:- /dev/hda1) .Now if I want to obtain the associated major number
> > and minor number i.e. device ID(kdev_t) of this file what would be the
> > procedure?
> 
> I think this should be standard function, I'm sure lots of people are
> duplicating this code.  For 2.4 kernels:
> 
> /*
>  * Convert a device path to a kdev_t.
>  */
> static int lookup_device(const char *path, kdev_t *dev)
> {
> 	int r;
> 	struct nameidata nd;
> 	struct inode *inode;
> 
> 	if (!path_init(path, LOOKUP_FOLLOW, &nd))
> 		return 0;

missing LOOKUP_POSITIVE

> 
> 	if ((r = path_walk(path, &nd)))
> 		goto out;
> 
> 	inode = nd.dentry->d_inode;
> 	if (!inode) {
> 		r = -ENOENT;
> 		goto out;
> 	}
> 
> 	if (!S_ISBLK(inode->i_mode)) {
> 		r = -EINVAL;
> 		goto out;
> 	}

shouldb be -ENOTBLK

new check here:

	if (nd.mnt->mnt_flags & MNT_NODEV)
		r = -EACCES;

> 
> 	*dev = inode->i_rdev;
> 
>  out:
> 	path_release(&nd);
> 	return r;

I also think that this doesn not make much sense, you really want
name to properly opened struct block_device * instead, i.e. the firsdt halve
of get_sb_bdev()

