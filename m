Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269772AbUJMSGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269772AbUJMSGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 14:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269771AbUJMSGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 14:06:13 -0400
Received: from blood.actrix.co.nz ([203.96.16.160]:57514 "EHLO
	blood.actrix.co.nz") by vger.kernel.org with ESMTP id S269772AbUJMSGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:06:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Charles Manning <manningc2@actrix.gen.nz>
Reply-To: manningc2@actrix.gen.nz
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Using ilookup?
Date: Thu, 14 Oct 2004 07:07:12 +1300
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <20041013013930.9BB6649E9@blood.actrix.co.nz> <20041013055035.GH2061@schnapps.adilger.int>
In-Reply-To: <20041013055035.GH2061@schnapps.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20041013180358.233046CEA@blood.actrix.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 October 2004 18:50, Andreas Dilger wrote:
> On Oct 13, 2004  14:42 +1300, Charles Manning wrote:
> > YAFFS allocates its own "objectId"s which are used as inode numbers for
> > most purposes. When objects get deleted (== unlinked), the object numbers
> > get recycles.  Sometimes though the Linux cache has an inode after the
> > object has been deleted. Then if that object id gets recycled before the
> > cached inode is released, a problem occurs since iget() gets the old
> > inode instead of creating a new one. We then end up with an
> > inconsistency.
>
> You can use iget4() along with a filesystem-specific comparison function,
> which allows you to distinguish inodes with the same number based on
> some extra data (e.g. generation number, 64-bit inode numbers, etc).  Is
> there a reason to recycle the inode numbers, or could you just have a
> 32-bit counter?

The problem, I believe, with iget4() is that this will make a new inode if 
one does not exist which seems to be more running around than I really want 
(especially since in most cases the inode will not exist).

The number space is 18 bits, but even with 32 bits incrementing through the 
list will not make the problem go away, just reduce it to a very small 
probability.

>
> > 1)  Somehow plug myself into the inode iput() chain so that I know when
> > an inode is removed from the cache. I can then make sure that I don't
> > free up the inode number for reuse until the inode is not in the cache.
> > Any hints on how to do that?
>
> You can use the ->delete_inode method which is a hook to be called
> before/instead of the clear_inode() function in iput(), and is
> the last thing action taken when the inode is being unlinked.  There
> is also the ->clear_inode inode method, which is called when inodes
> are being put away but not only when being unlinked.

It seems to me that delete_inode() is the place to hook into. I already use 
this for regular files, I just need to extend this to directories, pipes and 
other specials.

I knew about the regular file case because you can do things like:

  f= open("xx"...);; /
 unlink("xx");  // file no longer exists in directory, but still exists 
 read(f...)
 write(f...)
 close(f) ; // file disappears from disk.

I did npt realise that you could essentially achieve the same thing with 
directories, pipes and other specials.

Thanks for the help.

-- Charles
