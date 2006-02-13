Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWBMOqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWBMOqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWBMOqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:46:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5010 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751106AbWBMOqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:46:03 -0500
Date: Mon, 13 Feb 2006 15:44:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
Message-ID: <20060213144403.GA21317@elte.hu>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home> <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home> <20060213130143.GA10771@elte.hu> <Pine.LNX.4.61.0602131441110.9696@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602131441110.9696@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Mon, 13 Feb 2006, Ingo Molnar wrote:
> 
> > but there is no 'old behavior' to restore to. The +1 to itimer intervals 
> > caused artifacts that were hitting users and caused 2.4 -> 2.6 itimer 
> > regressions, which hrtimers fixed. E.g.:
> > 
> >   http://bugzilla.kernel.org/show_bug.cgi?id=3289
> 
> Ingo, please read correctly, this is mainly about interval timers, 
> which my patch doesn't change. My patch only fixes the initial start 
> time.

Yeah, i know it's about the start time - what else could it possibly be 
about? As i wrote:

> > so i dont think restoring the first timeout of an interval timer to 
> > be increased by resolution [which your patch does] has any meaning.  
> > It 'restores' to half of what 2.6 did prior hrtimers. Doing that 
> > would be inconsistent and would push the 'sum-up' errors observed 
> > for interval timers above to be again observable in user-space (if 
> > user-space does a series of timeouts). What's the point?

Your change changes the initial start time to be longer by +1 jiffy. My 
"restores to half of what 2.6 did" observation was in reference to the 
start time. The other half is the interval time between timeouts. If you 
add a +1 jiffy to the start time, you ought to do it for the interval 
time too. Or do it for neither - which is what we chose to do.

Yes, the 2.6 regression in the bugzilla was _mainly_ about the intervals 
adding a comulative +1, but obviously the behavior should be symmetric: 
if we use our higher resolution for intervals, we should use it for the 
start time too.

In other words: your patch re-introduces half of the bug on low-res 
platforms. Users doing a series of one-shot itimer calls would be 
exposed to the same kind of (incorrect and unnecessary) summing-up 
errors. What's the point?

	Ingo
