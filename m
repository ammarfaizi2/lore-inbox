Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVCKQHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVCKQHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVCKQGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:06:05 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:43177 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263450AbVCKQBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:01:16 -0500
Date: Fri, 11 Mar 2005 11:01:12 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050311153817.GA32020@elte.hu>
Message-ID: <Pine.LNX.4.58.0503111050270.22043@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net>
 <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> <20050311095747.GA21820@elte.hu>
 <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain> <20050311101740.GA23120@elte.hu>
 <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
 <20050311024322.690eb3a9.akpm@osdl.org> <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
 <20050311153817.GA32020@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Mar 2005, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Here's the patch. It's probably more of an overkill wrt buffer heads,
> > but it seems to be the easiest solution.
>
> isnt there some ext3-private journal structure (journal-bh) linked off
> the bh? If the lock is in that structure then the overhead would only
> affect ext3.
>

Yes, there is, and I was trying to use it before you mentioned trying this
(which works for now).  The locks are called before and after the private
pointer of the bh is set and removed.  The journal_head lock, I was going
to make global, and the state lock would go on this structure. I would
have to do some hack in journal.c to flag the state lock when it was
removing the journal head so that it didn't do the remove there, but did
it after the state lock was released. But this still had a few crashes.

The journal_head lock was used to lock when to add or remove the private
data from the bh, so you can see why this structure can't be used for this
purpose. But the state lock seemed to be ok for this. I need to know more
about the journaling system.

 I'll look into doing this too, but this fix should due for now.

-- Steve

