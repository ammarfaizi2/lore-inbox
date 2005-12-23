Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbVLWJjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbVLWJjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 04:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbVLWJjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 04:39:36 -0500
Received: from pat.uio.no ([129.240.130.16]:18654 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030473AbVLWJjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 04:39:36 -0500
Subject: Re: [PATCH] sched: Fix
	adverse	effects	of	NFS	client	on	interactive response
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43AB69B8.4080707@bigpond.net.au>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
	 <1135171280.7958.16.camel@lade.trondhjem.org>
	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
	 <1135172453.7958.26.camel@lade.trondhjem.org>
	 <43AA0EEA.8070205@bigpond.net.au>
	 <1135289282.9769.2.camel@lade.trondhjem.org>
	 <43AB29B8.7050204@bigpond.net.au>
	 <1135292364.9769.58.camel@lade.trondhjem.org>
	 <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>
	 <1135297525.3685.57.camel@lade.trondhjem.org>
	 <43AB69B8.4080707@bigpond.net.au>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 10:39:17 +0100
Message-Id: <1135330757.8167.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.679, required 12,
	autolearn=disabled, AWL 1.27, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 14:06 +1100, Peter Williams wrote:
> > 
> > As far as a filesystem is concerned, there should be 2 scheduling
> > states: running and sleeping. Any scheduling policy beyond that belongs
> > in kernel/*.
> 
> Actually there are currently two kinds of sleep: interruptible and 
> uninterruptible.  This just adds a variation to one of these, 
> interruptible, that says even though I'm interruptible I'm not 
> interactive (i.e. I'm not waiting for human intervention via a key 
> press, mouse action, etc. to initiate the interrupt).  This helps the 
> scheduler to decide whether the task involved is an interactive one or 
> not which in turn improves users' interactive experiences by ensuring 
> snappy responses to keyboard and mouse actions even when the system is 
> heavily loaded.

No! This is not the same thing at all.

You are asking the coder to provide a policy judgement as to whether or
not the users might care.

As far as I'm concerned, other users' MP3 player, X processes, and
keyboard response times can rot in hell whenever I'm busy writing out
data at full blast. I don't give a rats arse about user interactivity,
because my priority is to see the batch jobs complete.

However on another machine, the local administrator may have a different
opinion. That sort of difference in opinion is precisely why we do not
put this sort of policy in the filesystem code but leave it all in the
scheduler code where all the bits and pieces can (hopefully) be treated
consistently as a single policy, and where the user can be given tools
in order to tweak the policy.

TASK_NONINTERACTIVE is basically a piss-poor interface because it moves
the policy into the lower level code where the user has less control.

> There are probably many interruptible sleeps in the kernel that should 
> be marked as non interactive but for most of them it doesn't matter 
> because the duration of the sleep is so short that being mislabelled 
> doesn't materially effect the decision re whether a task is interactive 
> or not.  However, for reasons not related to the quality or efficiency 
> of the code, NFS interruptible sleeps do not fall into that category as 
> they can be quite long due to server load or network congestion.  (N.B. 
> the size of delays that can be significant is quite small i.e. much less 
> than the size of a normal time slice.)
> 
> An alternative to using TASK_NONINTERACTIVE to mark non interactive 
> interruptible sleeps that are significant (probably a small number) 
> would be to go in the other direction and treat all interruptible sleeps 
> as being non interactive and then labelling all the ones that are 
> interactive as such.  Although this would result in no changes being 
> made to the NFS code, I'm pretty sure that this option would involve a 
> great deal more code changes elsewhere as all the places where genuine 
> interactive sleeping were identified and labelled.

That is exactly the same rotten idea, just implemented differently. You
are still asking coders to guess as to what the scheduling policy should
be instead of letting the user decide.

  Trond

