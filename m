Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbTJQUFp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 16:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTJQUFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 16:05:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:41406 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263602AbTJQUFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 16:05:42 -0400
Date: Fri, 17 Oct 2003 13:05:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: thornber@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: online resizing of devices/filesystems (2.6)
Message-Id: <20031017130543.0e01d862.akpm@osdl.org>
In-Reply-To: <200310171116.07362.kevcorry@us.ibm.com>
References: <200310171116.07362.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> On August 21, 2003, Joe Thornber wrote:
> > Hi,
> > 
> > Should genhd.h:set_capacity() find and update the i_size field of the
> > inode for the device ?
> > 
> > The BLKGETSIZE and BLKGETSIZE64 ioctls report the size in the devices
> > inode:
> > 
> > 	case BLKGETSIZE:
> > 		if ((bdev->bd_inode->i_size >> 9) > ~0UL)
> > 			return -EFBIG;
> > 		return put_ulong(arg, bdev->bd_inode->i_size >> 9);
> > 	case BLKGETSIZE64:
> > 		return put_u64(arg, bdev->bd_inode->i_size);
> > 
> > Currently people have to close and reopen the device in order for a
> > size change to take effect.  This is a problem if people want to do
> > online resizing of a filesystem (supported by xfs and resier).
> 
> Has anyone had any thoughts about this issue?

Resizing a blockdev while someone has a filesystem mounted on it is a bit
rude, but I guess that as long as it is being expanded, not much can go
wrong.

bd_set_size() isn't quite what you want because it fiddles with the
blocksize as well.

So one approach would be to do what NBD does, and just write i_size directly.

You could create a little helper library function which takes i_sem and
then writes i_size.  But the VFS tends to avoid taking i_sem on blockdevs
because it doesn't expect i_size to change ;)

