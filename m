Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265387AbUFRQQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbUFRQQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUFRQNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:13:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:14261 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265387AbUFRQKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:10:34 -0400
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
	mapping
From: Chris Mason <mason@suse.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040618154330.GY12308@parcelfarce.linux.theplanet.co.uk>
References: <1087523668.8002.103.camel@watt.suse.com>
	 <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
	 <1087563810.8002.116.camel@watt.suse.com>
	 <20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk>
	 <1087570031.8002.153.camel@watt.suse.com>
	 <20040618151558.GX12308@parcelfarce.linux.theplanet.co.uk>
	 <1087573303.8002.172.camel@watt.suse.com>
	 <20040618154330.GY12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1087574752.8002.194.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 12:05:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 11:43, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Fri, Jun 18, 2004 at 11:41:43AM -0400, Chris Mason wrote:
> > > And yes, ->i_mapping flips on "normal" bdev inodes will go away - we set
> > > ->f_mapping on open directly.
> > 
> > Fair enough, I'll cook up some code to bump the inode->bdev->bd_inode
> > i_count in __sync_single_inode  It won't be pretty either though, I'll
> > have to drop the inode_lock so that some function can take the bdev_lock
> > to safely use inode->i_bdev.
> 
> *Ugh*
> 
> You do realize that ->i_bdev is not promised to be there either?  Could you
> show the actual code that steps into this mess?
> 
Grin, it won't be pretty, i_bdev can't be trusted without the bdev lock,
and I'll need to check for I_FREEING on it to make sure it isn't in
clear_inode.

The sequence leading up to all of this looks something like this:

CPU 0:					CPU 1: 

pdflush finds				umount /dev/sda1
FS inode for
/dev/sda1 in dirty list,
makes it's way down
to __sync_single_inode

mapping = inode->i_mapping
(this points bdev address
 space)
					kill_block_super
					close_bdev_excl
					blkdev_put
					bdput(bdev)
					iput(bdev->bd_inode)
					...
					clear_inode(bdev inode)
					bdev_clear_inode
					__bd_forget(inode for /dev/sda1)
					...
					destroy_inode(bdev inode)
...
do_writepages(mapping, wbc)

Since mapping on CPU0 still points to the bdev address space, and that
has been freed by the destroy inode, we run into problems.  

Maybe the real bug is the FS inode should never have ended up in the
dirty list.  This should all work fine if the bdev inode were the only
one to ever hit a dirty list.

-chris


