Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbUKQAeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbUKQAeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUKQAeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:34:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:31399 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262138AbUKQAd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:33:29 -0500
Date: Tue, 16 Nov 2004 16:33:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: holt@sgi.com, linux-kernel@vger.kernel.org, dev@sw.ru, wli@holomorphy.com,
       steiner@sgi.com, sandeen@sgi.com
Subject: Re: 21 million inodes is causing severe pauses.
Message-Id: <20041116163310.34580297.akpm@osdl.org>
In-Reply-To: <20041116194858.GA2549@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com>
	<20041115145714.3f757012.akpm@osdl.org>
	<20041116162859.GA5594@lnx-holt.americas.sgi.com>
	<20041116111321.36a6cd06.akpm@osdl.org>
	<20041116194858.GA2549@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> On Tue, Nov 16, 2004 at 11:13:21AM -0800, Andrew Morton wrote:
> > Robin Holt <holt@sgi.com> wrote:
> > >
> > > I guess I am very concerned at this point.  If I can do a
> > >  release/reacquire, why not just change generic_shutdown_super() so the
> > >  lock_kernel() does not happen until the first pass has occurred.  ie:
> > > 
> > >  --- super.c.orig        2004-11-16 10:22:17 -06:00
> > >  +++ super.c     2004-11-16 10:22:41 -06:00
> > >  @@ -232,10 +232,10 @@
> > >                  dput(root);
> > >                  fsync_super(sb);
> > >                  lock_super(sb);
> > >  -               lock_kernel();
> > >                  sb->s_flags &= ~MS_ACTIVE;
> > >                  /* bad name - it should be evict_inodes() */
> > >                  invalidate_inodes(sb);
> > >  +               lock_kernel();
> > > 
> > >                  if (sop->write_super && sb->s_dirt)
> > >                          sop->write_super(sb);
> > > 
> > >  This at least makes the lock_kernel time much smaller than it is right
> > >  now.  It also does not affect any callers that may really need the BKL.
> > 
> > lock_kernel() is also taken way up in do_umount(), hence the need for
> > release_kernel_lock()/reacquire_kernel_lock().
> 
> It looks like it is only held very briefly during the early parts of do_umount.
> 

OK.

> I have moved lock_kernel() as above in addition to the two patches you pointed
> to earlier.  This has left me with a system which has 21M inodes and undetectable
> delays during heavy mount/umount activity.  I am starting one last test which
> attempts a umount of a filesystem which has many inodes associated with it.

That sounds good.  We need to work out where that null-pointer deref is
coming from.

> At this point, I have checked the entire code path and see no reason the
> BKL is held for the first call to invalidate_inodes.

No, the above change looks fine.  And I have no problem merging up
invalidate_inodes-speedup.patch, really - it's been in -mm for over a year.
I've just been waiting for a decent reason to merge it.

