Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266386AbSKOQJf>; Fri, 15 Nov 2002 11:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266387AbSKOQJf>; Fri, 15 Nov 2002 11:09:35 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:13582 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266386AbSKOQJe>; Fri, 15 Nov 2002 11:09:34 -0500
Date: Fri, 15 Nov 2002 16:15:36 +0000
To: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Path Name to kdev_t
Message-ID: <20021115161536.GA6654@reti>
References: <000101c28be4$9ff1bf20$e9bba5cc@patni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c28be4$9ff1bf20$e9bba5cc@patni.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 07:19:16PM +0530, chandrasekhar.nagaraj wrote:
> Hi,
> 
> In one of the part of my driver module , I have a path name to a device file
> (for eg:- /dev/hda1) .Now if I want to obtain the associated major number
> and minor number i.e. device ID(kdev_t) of this file what would be the
> procedure?

I think this should be standard function, I'm sure lots of people are
duplicating this code.  For 2.4 kernels:

/*
 * Convert a device path to a kdev_t.
 */
static int lookup_device(const char *path, kdev_t *dev)
{
	int r;
	struct nameidata nd;
	struct inode *inode;

	if (!path_init(path, LOOKUP_FOLLOW, &nd))
		return 0;

	if ((r = path_walk(path, &nd)))
		goto out;

	inode = nd.dentry->d_inode;
	if (!inode) {
		r = -ENOENT;
		goto out;
	}

	if (!S_ISBLK(inode->i_mode)) {
		r = -EINVAL;
		goto out;
	}

	*dev = inode->i_rdev;

 out:
	path_release(&nd);
	return r;
}
