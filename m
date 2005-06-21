Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVFUSac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVFUSac (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFUSab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:30:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16076 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262226AbVFUSaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:30:00 -0400
Date: Tue, 21 Jun 2005 11:29:51 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Domen Puncer <domen@coderock.org>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 04/12] block/xd: replace schedule_timeout() with msleep()
Message-ID: <20050621182951.GB2664@us.ibm.com>
References: <20050620215133.675387000@nd47.coderock.org> <Pine.LNX.4.61L.0506211233490.9446@blysk.ds.pg.gda.pl> <20050621132100.GL3906@nd47.coderock.org> <Pine.LNX.4.61L.0506211451180.9446@blysk.ds.pg.gda.pl> <20050621161452.GA4175@us.ibm.com> <Pine.LNX.4.61L.0506211729160.17779@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506211729160.17779@blysk.ds.pg.gda.pl>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.2005 [17:43:53 +0100], Maciej W. Rozycki wrote:
> On Tue, 21 Jun 2005, Nishanth Aravamudan wrote:
> 
> > schedule_timeout(1) is ambiguous in older/unchanged code since 2.4, as
> > it indicated a 10 millisecond sleep then. Now, in 2.6, it indicates a 1
> > millisecond sleep (HZ==1000). I am trying to prevent issues like this
> > coming up in the future (CONFIG_HZ has hit -mm, e.g.) and msleep() is a
> > good way to do so.
> 
>  Well, HZ has never been consistent across platforms, e.g. 1024 for 
> the Alpha or even within certain platforms, e.g. 128 vs 100 for MIPS for 
> different configurations, so relying on jiffies to provide any absolute 
> time measurement has always been a misconception.  But assuming all code
> authors have failed to observe it is probably going a little bit too far, 
> so I'd always assume a given piece of code is correct unless I had reasons 
> to decide it does something silly.

Right, I agree HZ is inconsistent. That is why I am trying to get users
to use human-time interfaces, that way when HZ becomes dynamic (think
tickless!) or variable at compile-time (already in -mm with efforts to
get it merged to mainline via CONFIG_HZ). I know code authors have
failed to observe the brokenness of ticks as time and am trying my
hardest to fix up as many callers as possible. If nothing else, use

schedule_timeout({msecs,usecs,nsecs}_to_jiffies(some_time_value));

I'm not saying your code is incorrect, by the way, I am just trying to
make it maintainable and work on a kerneljanitor TODO.

> > If you are trying to sleep for the shortest amount of time possible (a
> > tick), though, then the code is fine, I guess. A comment may be useful,
> > though.
> 
>  This is obviously the case -- the code waits for a condition of an I/O 
> device to change and does not want to hog the CPU for the duration as the 
> device is slooow.  I don't think any comment is needed -- it speaks for 
> itself: "I'm giving up now, but let me proceed at the next opportunity."

Ok, there isn't much point in arguing this further then. My point was
simply this: there is *a lot* of code that has not been updated since
2.4 wrt. to sleep times. Thus, I cannot tell by reading the code,
necessarily, whether a schedule_timeout(1) is referring to 1 millisecond
or 1 tick. But that just may be me being confused.

I appreciate all your feedback, Maciej.

Thanks,
Nish
