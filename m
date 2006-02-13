Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWBMM30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWBMM30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWBMM30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:29:26 -0500
Received: from mail.gmx.net ([213.165.64.21]:20888 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932415AbWBMM3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:29:25 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139820181.3202.2.camel@mindpipe>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602131637.43335.kernel@kolivas.org> <1139810224.7935.9.camel@homer>
	 <200602131708.52342.kernel@kolivas.org>  <1139812538.7744.8.camel@homer>
	 <1139812725.2739.94.camel@mindpipe>  <1139814504.8124.6.camel@homer>
	 <1139820181.3202.2.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 13:35:06 +0100
Message-Id: <1139834106.7831.115.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 03:43 -0500, Lee Revell wrote:
> On Mon, 2006-02-13 at 08:08 +0100, MIke Galbraith wrote:
> > On Mon, 2006-02-13 at 01:38 -0500, Lee Revell wrote:
> > > Do you know which of those changes fixes the "ls" problem?
> > 
> > No, it could be either, both, or neither.  Heck, it _could_ be a
> > combination of all of the things in my experimental tree for that
> > matter.  I put this patch out there because I know they're both bugs,
> > and strongly suspect it'll cure the worst of the interactivity related
> > delays.
> > 
> > I'm hoping you'll test it and confirm that it fixes yours.
> 
> Nope, this does not fix it.  "time ls" ping-pongs back and forth between
> ~0.1s and ~0.9s.  Must have been something else in the first patch.

Hmm.  Thinking about it some more, it's probably more than this alone,
but it could well be the boost qualifier I'm using...

Instead of declaring a task to be deserving of large quantities of boost
based upon their present shortage of sleep_avg, I based it upon their
not using their full slice.  He who uses the least gets the most.  This
made a large contribution to mitigating the parallel compile over NFS
problem the current scheduler has.  The fact that (current) heuristics
which mandate that any task which sleeps for 5% of it's slice may use
95% cpu practically forever can not only work, but work quite well in
the general case, tells me that the vast majority of all tasks are, and
will forever remain, cpu hogs.

The present qualifier creates positive feedback for cpu hogs by giving
them the most reward for being the biggest hog by our own definition.
If you'll pardon the pun, we gives pigs wings, and hope that they don't
actually use them and fly directly over head.  This is the root problem
as I see it, that and the fact that even if sleep_avg acquisition and
consumption were purely 1:1 as the original O(1) scheduler was, if you
sleep 1 ns longer than you run, you'll eventually be up to you neck in
sleep_avg. (a darn good reason to use something like slice_avg to help
determine when to drain off the excess)

Changing that qualifier would also mean that he who is _getting_ the
least cpu would get the most boost as well, so it should help with
fairness, and things like the test case mentioned in comments in the
patch where one task can end up starving it's own partner.

Is there any reason that "he who uses the least gets the most" would be
inferior to "he who has the least for whatever reason gets the most"?

If I were to put a patch together that did only that (IMHO sensible)
thing, would anyone be interested in trying it?

	-Mike

