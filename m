Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263090AbVALE3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbVALE3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 23:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbVALE3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 23:29:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:51176 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263090AbVALE3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 23:29:39 -0500
Date: Tue, 11 Jan 2005 20:29:37 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Matt Mackall <mpm@selenic.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111202937.H24171@build.pdx.osdl.net>
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org> <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu> <87sm57qqlv.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87sm57qqlv.fsf@sulphur.joq.us>; from joq@io.com on Tue, Jan 11, 2005 at 09:21:48PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jack O'Quin (joq@io.com) wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> > you are right, i forgot about kernel threads. If they are nice -10 on
> > Jack's system too then they are within striking range indeed, especially
> > since they are typically idle and if then they are active for short
> > bursts of time and get the maximum boost. Jack, could you renice these
> > to -5, to make sure they dont interfere?
> 
> Sure.  My system does have some of these running at nice -10.  Where
> (how) do I change them?

For a one off test you can brute force it with the plain old renice(8).
Or (depending on which kernel you're using -- Con changed this post
2.6.10) you can apply a patch like:

diff -Nru a/kernel/workqueue.c b/kernel/workqueue.c
--- a/kernel/workqueue.c	2005-01-11 20:26:26 -08:00
+++ b/kernel/workqueue.c	2005-01-11 20:26:26 -08:00
@@ -188,7 +188,7 @@
 
 	current->flags |= PF_NOFREEZE;
 
-	set_user_nice(current, -10);
+	set_user_nice(current, -5);
 
 	/* Block and flush all signals */
 	sigfillset(&blocked);

> BTW, let's not lose sight of the fact that `nice --20 foo' requires
> CAP_SYS_NICE just like SCHED_FIFO does.  From a privilege perspective,
> this recurses to the same (still unsolved) problem.  

Yup, not forgotten ;-)

> Chris's rlimits proposal was the only workable suggestion I've seen
> for that.  Is there any hope of doing something like that in the 2.6.x
> timeframe?  

Yes there is.  We've made other rlimits changes in 2.6, and this one isn't
that invasive.  The main issues are:  getting semantics right, making sure
it actually solves the problem, making sure it keeps sane defaults (not
creating some new ugly hole), and making sure it's in step with the Grand
Plan (TM).  None of these issues are showstoppers, all quite workable.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
