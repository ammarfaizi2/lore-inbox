Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUKPUDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUKPUDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUKPTvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:51:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31886 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261786AbUKPTt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:49:58 -0500
Date: Tue, 16 Nov 2004 13:48:58 -0600
From: Robin Holt <holt@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org, dev@sw.ru,
       wli@holomorphy.com, steiner@sgi.com, sandeen@sgi.com
Subject: Re: 21 million inodes is causing severe pauses.
Message-ID: <20041116194858.GA2549@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com> <20041115145714.3f757012.akpm@osdl.org> <20041116162859.GA5594@lnx-holt.americas.sgi.com> <20041116111321.36a6cd06.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116111321.36a6cd06.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 11:13:21AM -0800, Andrew Morton wrote:
> Robin Holt <holt@sgi.com> wrote:
> >
> > I guess I am very concerned at this point.  If I can do a
> >  release/reacquire, why not just change generic_shutdown_super() so the
> >  lock_kernel() does not happen until the first pass has occurred.  ie:
> > 
> >  --- super.c.orig        2004-11-16 10:22:17 -06:00
> >  +++ super.c     2004-11-16 10:22:41 -06:00
> >  @@ -232,10 +232,10 @@
> >                  dput(root);
> >                  fsync_super(sb);
> >                  lock_super(sb);
> >  -               lock_kernel();
> >                  sb->s_flags &= ~MS_ACTIVE;
> >                  /* bad name - it should be evict_inodes() */
> >                  invalidate_inodes(sb);
> >  +               lock_kernel();
> > 
> >                  if (sop->write_super && sb->s_dirt)
> >                          sop->write_super(sb);
> > 
> >  This at least makes the lock_kernel time much smaller than it is right
> >  now.  It also does not affect any callers that may really need the BKL.
> 
> lock_kernel() is also taken way up in do_umount(), hence the need for
> release_kernel_lock()/reacquire_kernel_lock().

It looks like it is only held very briefly during the early parts of do_umount.

I have moved lock_kernel() as above in addition to the two patches you pointed
to earlier.  This has left me with a system which has 21M inodes and undetectable
delays during heavy mount/umount activity.  I am starting one last test which
attempts a umount of a filesystem which has many inodes associated with it.

At this point, I have checked the entire code path and see no reason the
BKL is held for the first call to invalidate_inodes.
