Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269612AbTGJTAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 15:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269614AbTGJTAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 15:00:00 -0400
Received: from dnsc6804027.pnl.gov ([198.128.64.39]:44426 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S269612AbTGJS7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:59:53 -0400
Date: Thu, 10 Jul 2003 12:14:22 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] minor optimization for EXT3
Message-ID: <20030710121422.Q4482@schatzie.adilger.int>
Mail-Followup-To: Alex Tomas <bzzz@tmi.comex.ru>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <87smpeigio.fsf@gw.home.net> <20030710042016.1b12113b.akpm@osdl.org> <87isqaiegy.fsf@gw.home.net> <20030710085155.40c78883.akpm@osdl.org> <877k6qgldo.fsf@gw.home.net> <20030710100102.32950703.akpm@osdl.org> <874r1ugkcn.fsf@gw.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <874r1ugkcn.fsf@gw.home.net>; from bzzz@tmi.comex.ru on Thu, Jul 10, 2003 at 09:09:12PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 10, 2003  21:09 +0000, Alex Tomas wrote:
> >>>>> Andrew Morton (AM) writes:
> 
>  AM> Alex Tomas <bzzz@tmi.comex.ru> wrote:
>  >> 
>  >> OK. fixed version:
> 
>  AM> Looks nice.  Now, Andreas did mention a while back that the locking
>  AM> rework added an additional complexity to this optimization.  Perhaps
>  AM> he can remind us of the details there?
> 
> he meant than 2.5 don't use lock_sb() for inode allocation. this patch is
> safe from this point of view.

I sent a private email to Alex mentioning this also, before I noticed this
patch was posted here also.  Basically, the issue is that the inode selection
in ext3_new_inode() is using the atomic bitops to pick inodes which are free.

The itable reading code locks the buffer head, and then checks the bitmap,
but there is nothing to prevent another thread from marking another inode
for that itable block in-use while the first thread is still checking the
bitmap.  That would prevent the no-read optimization from happening, but
would not otherwise cause an error.

I think the race window is not huge, between the ext3_set_bit_atomic()
near the start of ext3_new_inode(), and the ext3_mark_inode_dirty() at the
end.  It could be made a lot smaller by moving the ext3_mark_inode_dirty()
call up, and splitting it into ext3_get_inode_iloc() and ext3_mark_iloc_dirty()
so that we can grab the itable buffer lock and decide whether we want to
read it or zero it, without having any unnecessary blocking in between.

Alternately, if we wanted to eliminate the race window entirely, we could
do the ext3_get_inode_iloc() after we find a candidate inode/itable block
with ext3_find_first_zero_bit(), but before we call ext3_set_bit_atomic().
That means we would grab the buffer lock and (maybe) zero the itable block
under lock before any thread could set a bit in the bitmap for that itable
block.  This isn't a scalability issue, since we essentially get one lock
per 32 inodes, and even though we are "blocking" other threads we are in
fact speeding things up because we won't be doing a read.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

