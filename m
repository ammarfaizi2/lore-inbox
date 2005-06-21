Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVFUICh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVFUICh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVFUIBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:01:17 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:63660 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261734AbVFUGoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:44:23 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Roman Zippel <zippel@linux-m68k.org>
Date: Tue, 21 Jun 2005 08:42:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Message-ID: <42B7D304.25920.5055F4E@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.61.0506202231070.3728@scrub.home>
References: <1119287354.9947.22.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.26/Sophos-P=3.92.0+V=3.92+U=2.07.092+R=04 April 2005+T=103999@20050621.063256Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jun 2005 at 0:05, Roman Zippel wrote:

> Hi,
> 
> On Mon, 20 Jun 2005, john stultz wrote:
> 
> > > I see lots of new u64 variables. I'm especially interested how this code 
> > > scales down to small and slow machines, where such a precision is absolute 
> > > overkill. How do these patches change current and possibly common time 
> > > operations?
> > 
> > 
> > Hey Roman, 
> > 	That's a good issue to bring up. With regards to the timeofday
> > infrastructure, there are two performance concerns (though let me know
> > if I'm forgetting something):
> 
> You don't really answer the core question, why do you change everything to 
> nanoseconds and 64bit values?

Because just multiplying the microseconds by one thousand doesn't really provide a 
nanosecond clock, maybe?

[...]
> With -mm you can now choose the HZ value, so that's not really the 
> problem anymore. A lot of archs even never changed to a higher HZ value. 

Did you ever do an analysis how this affected clock quality? See 
comp.protocols.time.ntp for all the complains about broken kernels (I think Redhat 
had it first, then the others followed).

> So now I still like to know how does the complexity change compared to the 
> old code?

You can have a look at the code. That's the point where you can decide about 
complexity. I haven't looked closely, but I guess it was O(1) before, and now also 
is O(1).

[...]
> Well, AFAICT on slower machines (older and embedded stuff) it's a serious 
> issue. The current code calculates the timeval with some simple 32bit 
> calculations. Your code introduces the nsec step, which means several 
> 64bit calculations and suddenly the overhead explodes on some machines.
> 
> As m68k maintainer I see no reason to ever switch to your new code, which 
> might leave you with the dilemma having to maintain two versions of the 
> timer code. What reason could I have to switch to the new timer code?

I never knew the 68k has such a poor performance.

> 
> I had no problems with a little more overhead, like a _few_ more 64bit 
> operations per second (and preferably add/shifts), but I'm not really 
> enthusiastic about the new code. Why don't you keep the main part 32 bits 
> (or long)? What's wrong with using timeval or timespec?
> 
> I like the concept of the a time source in your patch. m68k already uses a 
> number of timer related callbacks into machine specific code. If I could 
> replace that with a timer driver, I'd be really happy. OTOH if it requires 
> several expensive conversion between different time formats, I rather keep 
> the current code.

If everybody would be keeping the current code, we wouldn't have any problems with 
the new code (as I said before). New features do cost some power unfortunately.

Regards,
Ulrich

