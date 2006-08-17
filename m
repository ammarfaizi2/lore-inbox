Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWHQHVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWHQHVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWHQHVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:21:10 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:48790 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S932124AbWHQHVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:21:07 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Thu, 17 Aug 2006 09:20:36 +0200
MIME-Version: 1.0
Subject: Re: Linux time code
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       Udo van den Heuvel <udovdh@xs4all.nl>
Message-ID: <44E434E4.3276.FC937A2@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1155758034.5513.69.camel@localhost.localdomain>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.06.0+V=4.06+U=2.07.138+R=05 June 2006+T=125555@20060817.071637Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2006 at 12:53, john stultz wrote:

> On Wed, 2006-08-16 at 14:26 +0200, Ulrich Windl wrote:
> > I've been viewing recent changes to the Linux kernel (specifically 2.6.15.1 to 
> > 2.6.17.8), and I felt I'll have to say something:
> 
> Hey Ulrich,
> 
> If you haven't already (and have the time), please also take a peek at
> the current 2.6.18-rc patch as well as -mm, as a number of timekeeping
> changes have been made since 2.6.17.x.

Hi John,

during the nice weather I was quite lazy here, but the weather recently was so bad 
that I turned on the computer again ;-) I decided to download a "stable" kernel 
release to evaluate (hoping your code was in already). I cannot tell you when, but 
I'll have a look sooner or later ;-)

> 
> > First there's a new routine in kernel/time.c named "set_normalized_timespec()". 
> > That routine sets nothing besides the actual argument being passed by reference. 
> > Thus I feel that routine should rather be named "normalize_timespec()" (just to 
> > save a few bytes. No, not really ;-). Alternatively that thing could be a pure 
> > ("const") function that returns the normalized timespec. In that case I'd call it 
> > "normalized_timespec()"...
> 
> Sounds reasonable.
> 
> > OK, that issue woun't make anybody feel hot I guess, so here's another one:
> > 
> > The existing routines for measuring time among the various architectures is an 
> > absolute mess. Well, it always had been, but it didn't become any better, but 
> > worse it seems. 
> 
> As you know, myself and others are working on this. Its taken quite a
> bit of time to get some of the groundwork in, and cleanups are still
> needed, but I think we're on the right track. However, criticism is
> welcome, and I'd appreciate your input (I did try to keep you CC'ed on
> most of the early discussions, but forgive me as I left you out on some
> of the more recent discussions)

No problem, I was on holiday anyway. The code I tried had a problem with my ADM 
Athlon X2 (Dual core): Both cores run with different frequency, a feature of power 
management, thus making hi-res timing instable. I haven't investigated in-depth, 
but I thought the hpet timer was used.

> 
> > For example there is a POSIX-like sys_clock_gettime() intended to 
> > server the end-user directly, but there's no counterpart do_clock_gettime() to 
> > server any in-kernel needs. 
> 
> Hmmm.. ktime_get(), ktime_get_ts() and ktime_get_real(), provide this
> info. Is there something missing here?

>From memory: Are those exported from posix_timer? I think I saw those, but wasn't 
sure whether they are for general cross-arch use.

> 
> I will agree that the code in kernel/time.c, kernel/timer.c,
> kernel/posix-timers.c, and kernel/hrtimer.c files could be better
> organized so the layered logic is more clear. I am working on this (see
> the ntp-move-all-the-ntp-related-code-to-ntpc-fix patch currently in
> -mm), but untangling the code without breaking anyone (well, that's the
> intent) is a slow process.
> 
> > The implementation of clock_getres() is also hardly 
> > worth it. I once had implemented a routine like this:
> [snip]
> > That routine tries to get the typical clock resolution the user is expected to 
> > see, automatically adjusting to the interpolation method and CPU speed being used. 
> > I think that's preferrable to just returning 1ns or "tick" or whatever.
> 
> Yea. This area could use improvement. The clocksource infrastructure
> should better allow us to export the actual hardware resolution.
> 
> > Finally I have the personal need for an "unadjusted tick interpolator" 
> > (preferrably being clocked by the same clock as the timer chip) to estimate the 
> > frequency error of the system clock (independently from any offset adjustments 
> > being made).
> > 
> > For those who might wonder: Yes, that's the code that had been thown out recently: 
> > NTP PPS calibration.
> 
> The NTP PPS code was dropped because there were no in-kernel users of
> that interface. But as I've always said, I'd be very happy to see your
> PPS work get merged. I know there are a few out-of-tree patches
> currently floating around (Udo mailed me awhile back with some links,
> but I can't find them at the moment), and I'm sure due to the high level
> of activity in this area makes it difficult to keep out of tree patches
> up to date. Is there any reason these patches aren't being pushed into
> mainline?

I'm only waiting for a "pusher" ;-) No actually I have my own quality check, and 
currently the code fails those. It's named "alpha" by myself. Unless it's "beta" I 
won't ask anybody for inclusion.

I don't like the idea of a loadable module, because most of the code accesses 
several timing variables that are (or can be) private now. A module would make 
them public (for misuse). The time machinery should be a sealed black box IMHO.

> 
> > So summarize: I'd wish for fewer, but more useful routines dealing with time. Some 
> > modules just don't export useful (and otherwise missing) routines, while other 
> > useful exported routines have different names for each architecture. A mess...
> 
> I agree, and folks are working to clean this up (I've got a
> get_persistent_clock patch to try to unify all the different
> get_rtc/cmos/boot_time() hooks across the arches coming soon). Again, I
> very much welcome your experience, suggestions and patches to this area.

Regards,
Ulrich

