Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288763AbSADVKo>; Fri, 4 Jan 2002 16:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288769AbSADVKf>; Fri, 4 Jan 2002 16:10:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25542 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288763AbSADVKT>;
	Fri, 4 Jan 2002 16:10:19 -0500
Date: Fri, 4 Jan 2002 16:10:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, Nikita@Namesys.COM, alessandro.suardi@oracle.com,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <UTC200201041924.TAA230416.aeb@cwi.nl>
Message-ID: <Pine.GSO.4.21.0201041601510.27334-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002 Andries.Brouwer@cwi.nl wrote:

> If init_special_inode() has major,minor arguments instead of
> the present rdev, then the line
> 
> 	inode->i_rdev = to_kdev_t(rdev);
> 
> just becomes
> 
> 	inode->i_rdev = mk_kdev(major,minor);
> 
> I consider every occurrence of mk_kdev() and of to_kdev_t()
> a flaw in the kernel, so this change does not make things
> better or worse inside init_special_inode().

Well, to start with, any use of kdev_t for block devices is a flaw
(fortunately most of fs/*/*.c ones are gone by now and buffer cache
will follow).

As for the init_special_inode() I'd rather have le16_to_dev() et.al.
so that ext2_read_inode() and friends would do
	init_special_inode(inode, mode, le16_to_dev(raw->i_rdev));

Reasons:
	a) foo_mknod() - why the hell would we take dev_t, pass it into
->mknod() only to split it into major:minor there and immediately
rebuild dev_t from them?  And that - for _all_ instances of ->mknod()
	b) what happens in ->read_inode() is "here's on-disk encoding,
we want to know which dev_t value it is".  Sure, helpers that do
mapping will need to know encoding.  ->read_inode() itself, though...
Why do we care about major:minor split at that level?

