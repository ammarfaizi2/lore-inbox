Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVGMAlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVGMAlt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVGMAlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:41:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63480 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262488AbVGMAls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:41:48 -0400
Subject: Re: RT and XFS
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Nathan Scott <nathans@sgi.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20050713002556.GA980@frodo>
References: <1121209293.26644.8.camel@dhcp153.mvista.com>
	 <20050713002556.GA980@frodo>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 12 Jul 2005 17:41:43 -0700
Message-Id: <1121215303.29331.1.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 10:25 +1000, Nathan Scott wrote:
> On Tue, Jul 12, 2005 at 04:01:32PM -0700, Daniel Walker wrote:
> > 
> > Is there something so odd about the XFS locking, that it can't use the
> > rt_lock ?
> 
> Not that I know of - XFS does use the downgrade_write interface,
> whose use isn't overly common in the rest of the kernel... maybe
> that has caused some confusion, dunno.

Current RT doesn't implement downgrade_write() , but it's trivial to add
it.

> > --- linux.orig/fs/xfs/linux-2.6/mrlock.h
> > +++ linux/fs/xfs/linux-2.6/mrlock.h
> > @@ -37,12 +37,12 @@
> >  enum { MR_NONE, MR_ACCESS, MR_UPDATE };
> >  
> >  typedef struct {
> > -	struct rw_semaphore	mr_lock;
> > -	int			mr_writer;
> > +	struct compat_rw_semaphore	mr_lock;
> > +	int				mr_writer;
> >  } mrlock_t;
> 
> The XFS code is also written such that it just releases a mrlock
> without tracking whether it had it for access/update in the end
> (end lock state is not necessarily how it started out, since it
> may have downgraded the lock at some point, or it may not have).
> Its a non-trivial change to track that state within XFS itself,
> so the above mr_writer field in XFS's mrlock wrapper tracks that
> state alongside the rw_semaphore.  It would prefer to be getting
> that out of the rw_semaphore itself, alot, but there's not any
> mechanism for doing so (its not a particularly nice API change
> either, really, for the generic locking code).  I guess that may
> have been another reason for the above change in the RT patch, I
> don't know all the details there.

So it calls up_read if it has a read lock ? Or up_write if it has a
write lock? I suppose it would be broken if it didn't though.

Daniel

