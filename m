Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266431AbUGBDiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266431AbUGBDiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 23:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266436AbUGBDiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 23:38:24 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:20755 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266431AbUGBDiW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 23:38:22 -0400
Date: Fri, 2 Jul 2004 14:35:24 +1000
From: Nathan Scott <nathans@sgi.com>
To: Yichen Xie <yxie@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary database
Message-ID: <20040702043524.GA1203@frodo>
References: <Pine.LNX.4.44.0407011747040.4015-100000@kaki.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.44.0407011747040.4015-100000@kaki.stanford.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 06:01:00PM -0700, Yichen Xie wrote:
> Hi all, 

Hi there,

> We are a group of researchers at Stanford working on program analysis
> algorithms.  We have been building a precision enhanced program analysis
> engine at Stanford, and our first application was to derive mutex/lock
> behavior in the linux kernel. In the process, we found 99 likely
> synchronization errors in linux kernel version 2.6.5:
> 
>     http://glide.stanford.edu/linux-lock/err1.html (69 errors)
>     http://glide.stanford.edu/linux-lock/err2.html (30 errors)
> 
>  ...
> 
> As always, feedbacks and confirmations will be greatly appreciated!

>From looking through the XFS reports, I suspect your tools aren't
following the sv_wait semantics correctly (or else I'm misreading
the code).  Many of the reported XFS items stem from this - e.g.
this one...
[NOTE] BUG forgot to unlock before "goto try_again" (line 2293)
ERROR: fs/xfs/xfs_log.c:2948: lock check failed!
ERROR: fs/xfs/xfs_log.c:xlog_state_sync

the code in question does this:

  try_again:
	s = LOG_LOCK(log); /* spin_lock(&log->l_icloglock); */
	    ...
		sv_wait(&iclog->ic_prev->ic_writesema, PSWP,
			&log->l_icloglock, s);
		already_slept = 1;
		goto try_again;

and the tools seem to be missing that the log->l_icloglock is
unlocked by the sv_wait routine.  Well, that or I've overlooked
something that the tools have not. :)

A couple of the others were definately missed unlocks on error
paths though (fixed now) - thanks!

cheers.

-- 
Nathan
