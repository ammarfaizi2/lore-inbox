Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312915AbSDKUln>; Thu, 11 Apr 2002 16:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312920AbSDKUlm>; Thu, 11 Apr 2002 16:41:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28049 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312915AbSDKUll>;
	Thu, 11 Apr 2002 16:41:41 -0400
Date: Thu, 11 Apr 2002 16:41:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <a94r5k$m23$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0204111629370.21089-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Apr 2002, Linus Torvalds wrote:

> >As long as your patches don't break that is possible to have I am happy... 
> >But from what you are saying above I have a bad feeling you are somehow 
> >assuming that a mapping's host is an inode...
> 
> It's not Andrew who is assuming anything: it _is_. Look at <linux/fs.h>,
> and notice the
> 
> 	struct inode            *host;

True.  However, Andrew _is_ assuming that you can get from inode->i_mapping to 
&FOOFS_I(inode)->secondary_address_space, which is simply not true.

Consider a filesystem that uses address_space to store, say it, EA of inode.
Now look at device node on such fs.  What we have is

inode_1: sits on our fs, has i_mapping pointing to inode_2->i_data and
EA_address_space in fs-private part of inode;

inode_2: block device inode, sits on bdev.

inode_1->i_mapping == &inode_2->i_data
inode_1->i_mapping->host == inode2
FOOFS_I(inode_1)->EA_address_space.host = inode_1

Looks OK?  Now look at Andrew's proposal - he suggests to have
method of inode_1->i_mapping to be responsible for writing out
&FOOFS_I(inode_1)->EA_address_space.

See where it breaks?  After we'd followed ->i_mapping we lose information
about private parts of inode.  And that's OK - that's precisely what we
want for, say it, block devices.  There ->i_mapping should be the same
for _all_ inodes with this major:minor.  However, that makes "scan all
superblocks, for each of them scan dirty inodes, for each of them do
some work on ->i_mapping" hopeless as a way to reach all address_spaces
in the system.

FWIW, correct solution might be to put dirty address_spaces on a list -
per-superblock or global.

