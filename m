Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWBGF2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWBGF2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 00:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWBGF2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 00:28:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750875AbWBGF2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 00:28:16 -0500
Date: Mon, 6 Feb 2006 21:27:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-Id: <20060206212750.2126ca8c.akpm@osdl.org>
In-Reply-To: <20060207013157.GU43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com>
	<20060205202733.48a02dbe.akpm@osdl.org>
	<20060206054815.GJ43335175@melbourne.sgi.com>
	<20060205222215.313f30a9.akpm@osdl.org>
	<20060206115500.GK43335175@melbourne.sgi.com>
	<20060206151435.731b786c.akpm@osdl.org>
	<20060207003410.GS43335175@melbourne.sgi.com>
	<20060206170411.360f3a97.akpm@osdl.org>
	<20060207013157.GU43335175@melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:
>
> > In which case, yes, perhaps leaving big-dirty-expired inode on s_io is the
> > right thing to do.  But should we be checking that it has expired before
> > deciding to do this?
> 
> Well, we are writing it out because it has expired in the first place,
> right? And it remains expired until we actually clean it, so I
> don't see any need for a check such as this....

OK.  I was worried about redirtyings while inode_lock is dropped, but the
I_DIRTY and _LOCK logic looks tight to me.

> > We don't want to get in a situation where continuous
> > overwriting of a large file causes other files on that fs to never be
> > written out.
> 
> Agreed. That's why i proposed the s_more_io queue - it works on those inodes
> that need more work only after all the other inodes have been written out.
> That prevents starvation, and makes large inode flushes background work (i.e.
> occur when there is nothing else to do). it will get much better disk
> utilisation than the method I originally proposed, as well, because it'll keep
> the disk near congestion levels until the data is written out...
> 

Yes, s_more_io does make sense.  So now dirty inodes can be on one of three
lists.  It'll be fun writing the changelog for this one.  And we'll need a
big fat comment describing what the locks do, and the protocol for handling
them.

We need to be extra-careful to not break sys_sync(), umount, etc.  I guess
if !for_kupdate, we splice s_dirty and s_more_io onto s_io and go for it.

So the protocol would be:

s_io: contains expired and non-expired dirty inodes, with expired ones at
the head.  Unexpired ones (at least) are in time order.

s_more_io: contains dirty expired inodes which haven't been fully written. 
Ordering doesn't matter (unless someone goes and changes
dirty_expire_centisecs - but as long as we don't do anything really bad in
response to this we'll be OK).

s_dirty: contains expired and non-expired dirty inodes.  The non-expired
ones are in time-of-dirtying order.



I wonder if it would be saner to have separate lists for expired and
unexpired inodes.  If when writing an expired inode we don't write it all
out, just rotate it to the back of the expired inode list.  On entry to
sync_sb_inodes, do a walk of s_dirty, moving expired inodes onto the
expired list.

