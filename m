Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbUKRAHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbUKRAHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUKRAFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:05:52 -0500
Received: from almesberger.net ([63.105.73.238]:44817 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262680AbUKRAE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:04:58 -0500
Date: Wed, 17 Nov 2004 21:04:10 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Chris Ross <chris@tebibyte.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrea Arcangeli <andrea@novell.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041117210410.R28844@almesberger.net>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <1099706150.2810.147.camel@thomas> <20041117195417.A3289@almesberger.net> <419BDE53.1030003@tebibyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419BDE53.1030003@tebibyte.org>; from chris@tebibyte.org on Thu, Nov 18, 2004 at 12:27:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:
> The operating system has an 
> overview of all the memory and can see when a particular process is 
> basically making the machine unusable.

The underlying hypothesis for suggesting explicitly flagging
candidates for killing is of course that it doesn't see who
exactly is misbehaving :-) Since this issue has been around for
a nummber of years, I think it's fair to assume that the OOM
killers indeed have a problem in that area.

> It's quite likely that the 
> process causing the trouble doesn't know (or hasn't admitted) that it's 
> buggy and hasn't volunteered for early termination.

I guess that depends a lot on your scenario. If your system is
the typical undergrad mainframe where an army of students is
hard at work trying to fork-bomb it out of existence, you're
absolutely right.

However, on a system where new programs are rarely added to the
mix, the distinction should be easier. You can still get
unexpected problems, e.g. vi trying to load a huge file, but
you should be in a much better position to profile your system
behaviour.

It could of course be that this scenario is overly specific.

> As this means the 
> kernel must be able to deal with a problematic process completely 
> irrespective of whether it has set "kill me" flag or not the flag 
> doesn't really buy you anything.

I'd view it as an additional hint that killing that process is
likely to help, a) because it may be the culprit, or b) because
it is likely to hold lots of memory, and its death will not be
mourned.

I'm not suggesting to use this as a replacement for an adaptive
OOM killer. The OOM killer could first make its pick among the
suspects, and only if it runs out of them (or maybe if it finds
overwhelming evidence that it's something else), then it would
go after non-suspects.

> There is the related case where no particular process is faulty as such 
> but the system as a whole can't cope with the demands being made.

Yes, that's yet another scenario. Even then, having a list of
things we can kill to give us some room would be useful.

> The example I have in mind is on my machine when the daily cron 
> run over commits causing standard daemons such as ntpd to be killed to 
> make room. It would be preferable if the daemon was swapped out and just 
> didn't run for minutes, or even hours if need be, but was allowed to run 
> again once the system had settled down.

Ah, now I understand why you'd want to swap. Interesting. Now,
depending on the time if day, you have typically "interactive"
processes, like your idle desktop, turn into "non-interactive"
ones, which can then be subjected to swapping. Nice example
against static classification :-)

> So, the problem breaks down into three parts:
> 
> 	  i) When should the oom killer be invoked.
> 	 ii) How do we pick a victim process
> 	iii) How can we deal with the process in the most useful manner

iii) may also affect i). If you're going to swap, you don't want
to wait until you're fighting for the last available page in the
system.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
