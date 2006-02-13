Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWBMNDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWBMNDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWBMNDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:03:42 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:12488 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751204AbWBMNDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:03:42 -0500
Date: Mon, 13 Feb 2006 14:01:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
Message-ID: <20060213130143.GA10771@elte.hu>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home> <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602131208050.30994@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > This adds an artificial offset to the expiry time, for what reason? The
> > expiry code makes sure that timers can not expire early. See:
> > 
> > 	timer = rb_entry(node, struct hrtimer, node);
> > 	if (now.tv64 <= timer->expires.tv64)
> > 		break;
> > 
> > in kernel/hrtimers.c:run_hrtimer_queue(), where now is already tick
> > aligned.
> > 
> > Please provide a testcase (or detailed use-case) which proves that this
> > is necessary.
> 
> Let's assume a get_time() which simply returns xtime and so has a 
> resolution of around TICK_NSEC. This means the real time when one 
> calls get_time() is somewhere between xtime and xtime+TICK_NSEC.  
> Assuming the real time is xtime+TICK_NSEC-1, get_time() will return 
> xtime and a relative timer with TICK_NSEC-1 will expire immediately. 
> The old code did this correctly. For most hardware this is not a real 
> issue, as the delivery time is larger than the clock resolution, but 
> unless you can guarantee it's not an issue on _any_ supported 
> hardware, this fix is needed. As I already said this can be better 
> fixed as soon as we have a better clock abstraction, until then this 
> is only restores the old behaviour.

but there is no 'old behavior' to restore to. The +1 to itimer intervals 
caused artifacts that were hitting users and caused 2.4 -> 2.6 itimer 
regressions, which hrtimers fixed. E.g.:

  http://bugzilla.kernel.org/show_bug.cgi?id=3289

so i dont think restoring the first timeout of an interval timer to be 
increased by resolution [which your patch does] has any meaning. It 
'restores' to half of what 2.6 did prior hrtimers. Doing that would be 
inconsistent and would push the 'sum-up' errors observed for interval 
timers above to be again observable in user-space (if user-space does a 
series of timeouts). What's the point?

	Ingo
