Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVA1A7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVA1A7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVA1A4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:56:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:9904 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261352AbVA1Axg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:53:36 -0500
Date: Thu, 27 Jan 2005 16:58:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Advice sought on how to lock multiple pages in ->prepare_write
 and ->writepage
Message-Id: <20050127165822.291dbd2d.akpm@osdl.org>
In-Reply-To: <1106822924.30098.27.camel@imp.csi.cam.ac.uk>
References: <1106822924.30098.27.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> What would you propose can I do to perform the required zeroing in a
> deadlock safe manner whilst also ensuring that it cannot happen that a
> concurrent ->readpage() will cause me to miss a page and thus end up
> with non-initialized/random data on disk for that page?

The only thing I can think of is to lock all the pages.  There's no other
place in the kernel above you which locks multiple pagecache pages, but we
can certainly adopt the convention that multiple-page-locking must proceed
in ascending file offset order.

Which means that you'll need to drop and reacquire the page lock in
->prepare_write and in ->writepage, which could get unpleasant.

For ->prepare_write it should be OK: the caller has a ref on the inode and
you can check ->mapping after locking the page to see if a truncate flew
past (OK, you have i_sem, but writepage will need to do this check).

For writepage() or writepages() with for_reclaim=0 you're OK: the caller
has a ref on the inode and has taken sb->s_umount, so you can safely drop
and retake the page lock.

For ->writepage with for_reclaim=1 the problem is that the inode can
disappear on you altogether: you have no inode ref and if you let go of
that page lock, truncate+reclaim or truncate+umount can zap the inode.

So hrm.  I guess your ->writepage(for_reclaim=1) could do a trylock on
s_umount and fail the writepage if that didn't work out.

That leaves the problem of preventing truncate+reclaim from zapping the
inode when you've dropped the page lock.  I don't think you'll want to take
a ref on the inode because the subsequent iput() can cause a storm of
activity and I have vague memories that iput() inside
->writepage(for_reclaim=1) is a bad deal.  Maybe do a trylock on i_sem and
fail the writepage if that doesn't work out?

That way, once you have i_sem and s_umount you can unlock the target page
then populate+lock all the pages in the 64k segment.

Not very pretty though.
