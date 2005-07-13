Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVGMAdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVGMAdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVGMAdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:33:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44429 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262321AbVGMAdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:33:16 -0400
Date: Wed, 13 Jul 2005 10:25:56 +1000
From: Nathan Scott <nathans@sgi.com>
To: mingo@elte.hu, Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT and XFS
Message-ID: <20050713002556.GA980@frodo>
References: <1121209293.26644.8.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121209293.26644.8.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 04:01:32PM -0700, Daniel Walker wrote:
> 
> Is there something so odd about the XFS locking, that it can't use the
> rt_lock ?

Not that I know of - XFS does use the downgrade_write interface,
whose use isn't overly common in the rest of the kernel... maybe
that has caused some confusion, dunno.

> --- linux.orig/fs/xfs/linux-2.6/mrlock.h
> +++ linux/fs/xfs/linux-2.6/mrlock.h
> @@ -37,12 +37,12 @@
>  enum { MR_NONE, MR_ACCESS, MR_UPDATE };
>  
>  typedef struct {
> -	struct rw_semaphore	mr_lock;
> -	int			mr_writer;
> +	struct compat_rw_semaphore	mr_lock;
> +	int				mr_writer;
>  } mrlock_t;

The XFS code is also written such that it just releases a mrlock
without tracking whether it had it for access/update in the end
(end lock state is not necessarily how it started out, since it
may have downgraded the lock at some point, or it may not have).
Its a non-trivial change to track that state within XFS itself,
so the above mr_writer field in XFS's mrlock wrapper tracks that
state alongside the rw_semaphore.  It would prefer to be getting
that out of the rw_semaphore itself, alot, but there's not any
mechanism for doing so (its not a particularly nice API change
either, really, for the generic locking code).  I guess that may
have been another reason for the above change in the RT patch, I
don't know all the details there.

cheers.

-- 
Nathan
