Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265421AbSKADPf>; Thu, 31 Oct 2002 22:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265524AbSKADPf>; Thu, 31 Oct 2002 22:15:35 -0500
Received: from thunk.org ([140.239.227.29]:34695 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265421AbSKADPe>;
	Thu, 31 Oct 2002 22:15:34 -0500
Date: Thu, 31 Oct 2002 22:22:00 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/11  Ext2/3 Updates: Extended attributes, ACL, etc.
Message-ID: <20021101032159.GA12031@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <E186ZRR-0006tS-00@snap.thunk.org> <3DBEC3E6.9050908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBEC3E6.9050908@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 12:22:46PM -0500, Jeff Garzik wrote:
> tytso@mit.edu wrote:
> 
> >Ext2/3 forward compatibility: on-line resizing
> > 
> >
> Is the interface for this going to be ext2meta?  Al and sct seemed 
> to agree that that was the best way act upon the filesystem metadata 
> while it's online...  I'll probably be updating that for 2.5.x VFS 
> changes in a few weeks, that will provide safe online defrag and a 
> good interface for other metadata interaction.

I'm not sure ext2meta will be sufficient.  It's not just a matter of
modifying the on-disk metadata, as would be needed for defrag, but I
would also need to modify some of the in-core data structions in the
ext2/3 filesystem data structures.  For example, when you resize the
filesystem, you need to increase the number of group descriptors,
which means you need to kmalloc, copy, and then kfree sbi->group_desc
out from under the mounted filesystem.

No doubt ext2meta could be modified so it could "reach out and touch"
internal ext2/3 fileststem data structures in core.  But the locking
issues involved get really messy.

My original plan was to adapt Andreas Dilger's on-line resizing patch
to use the new block group layout, which would obviate the need to
take the filesystem off-line and run ext2prepare first.  I'm not
opposed to trying to do it via ext2meta, but it seems like it might
get complicated and hairy quite quickly.

						- Ted
