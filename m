Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSLBMHU>; Mon, 2 Dec 2002 07:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSLBMHU>; Mon, 2 Dec 2002 07:07:20 -0500
Received: from pc-62-30-72-146-ed.blueyonder.co.uk ([62.30.72.146]:46721 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261963AbSLBMHT>; Mon, 2 Dec 2002 07:07:19 -0500
Subject: Re: data corrupting bug in 2.4.20 ext3, data=journal
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, lkml <linux-kernel@vger.kernel.org>,
       ext3 users list <ext3-users@redhat.com>
In-Reply-To: <3DEB08EE.CBA49BA@digeo.com>
References: <3DE9C43D.61FF79C5@digeo.com>
	<3DEA0374.2040306@cyberone.com.au>  <3DEB08EE.CBA49BA@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Dec 2002 12:15:05 +0000
Message-Id: <1038831305.1852.102.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 07:17, Andrew Morton wrote:

> Are you sure?  I can't make it happen on 2.4.19.  And disabling the new
> BH_Freed logic (which went into 2.4.20-pre5) makes it go away.
> 
> --- linux-akpm/fs/jbd/commit.c~a	Sun Dec  1 23:10:12 2002
> +++ linux-akpm-akpm/fs/jbd/commit.c	Sun Dec  1 23:10:27 2002
> @@ -695,7 +695,7 @@ skip_commit: /* The journal should be un
> -			clear_bit(BH_JBDDirty, &bh->b_state);
> +//			clear_bit(BH_JBDDirty, &bh->b_state);

Argh.

That's not the right fix --- it reintroduces the bug that BH_Freed was
introduced to solve in the first place. 

The problem is that ext3 is expecting that truncate_inode_pages() (and
hence ext3_flushpage) is only called during a truncate.  That's what the
function is named for, after all, and it's the hint we need to indicate
that future writeback on the data we're discarding should be disabled
(so that we don't get old data written on top of new data should the
block get deallocated.)

But kill_supers() eventually calls truncate_inode_pages() too when we're
doing the invalidate_inodes().  And ext3 is reacting just the way it
would for a normal truncate --- the data still gets written to the
journal (correct, if we reboot before the truncate commits then the old
data is preserved in the journal) but is not queued for writeback.

The solution is to set BH_Freed in ext3_flushpage IFF we're being called
from the truncate, but to avoid it if we're in an umount.  I'm not sure
of the best way to do that right now, but there are some trivial but
hacky methods possible (eg. see if we're in a nested transaction; if so,
it's a truncate, if not, it's a umount.)  MS_ACTIVE might be a possible
flag to test, but I'll need to double-check whether that is 100% safe
--- we can't afford to skip the BH_Freed setting if we're in a truncate
and the filesystem is not yet completely quiesced.

Cheers,
 Stephen

