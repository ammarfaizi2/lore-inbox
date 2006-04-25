Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWDYKyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWDYKyD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWDYKyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:54:03 -0400
Received: from [212.33.166.172] ([212.33.166.172]:55053 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932194AbWDYKyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:54:02 -0400
From: Al Boldi <a1426z@gawab.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
Date: Tue, 25 Apr 2006 13:44:58 +0300
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>
References: <200511142327.18510.a1426z@gawab.com> <200604241637.56637.a1426z@gawab.com> <444DCE65.5050906@yahoo.com.au>
In-Reply-To: <444DCE65.5050906@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604251344.58399.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Al Boldi wrote:
> > Nick Piggin wrote:
> >>Al Boldi wrote:
> >>>Could do that by:
> >>>
> >>>	# echo 1 > /proc/sys/kernel/su-pid
> >>>
> >>>which would imply nr-threads = 1
> >>>
> >>>So maybe introduce /proc/sys/kernel/nr-threads to allow that to be
> >>>variable, but this isn't really critical.
> >>
> >>Why not just have su-nr-threads?
> >
> > Unless I am misunderstanding you, even root/root-proc can be hit by a
> > runaway, so the threads-max limits this globally which is great, but
> > this may lock-you out of being able to control the situation based on
> > uid only.
> >
> > Thus this patch gives root the ability to allow a certain pid to exceed
> > the threads-max limit, while all other pids are still limited.
>
> But the point is that root is able to get their pids under control,
> and can't be DoSed by unpriv users. Right?

Or even by root.

> Nothing is going to be perfect, I mean the su-pid pid could get "hit
> bya runaway" and is arguably worse than nr-threads-su, because it has
> no upper limit and coult take down the whole system.

The su-pid is a temporary measure set by root after evaluating the current 
situation, and additionally limiting this by su-nr(pid)-threads may probably 
be a good idea.  Maybe something like this:

	if (nr_threads >= max_threads)
		if ((p->pid != su_pid) || (nr_threads >= (max_threads + su_pid_threads)))
			goto bad_fork_cleanup_count;

But I really don't think this is critical.

Thanks!

--
Al

