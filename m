Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbVIPREI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbVIPREI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbVIPREI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:04:08 -0400
Received: from mail-res.bigfish.com ([63.161.60.61]:20276 "EHLO
	mail69-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161190AbVIPREG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:04:06 -0400
X-BigFish: V
Message-ID: <432AFB01.3050809@am.sony.com>
Date: Fri, 16 Sep 2005 10:04:01 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jesper.juhl@gmail.com
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       tim@physik3.uni-rostock.de
Subject: Re: early printk timings way off
References: <9a87484905091515495f435db7@mail.gmail.com>
In-Reply-To: <9a87484905091515495f435db7@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
>>>>>Early during boot the printk timings are way off :
>>>>>
>>>>>[4294667.296000] Linux version 2.6.14-rc1-git1 (juhl@dragon)
>
> (gcc version 3.3.6) #1 PREEMPT Thu Sep 15 22:25:37 CEST 2005
>
>>>>>[4294667.296000] BIOS-provided physical RAM map:
>>>>>[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f800

> It doesn't really bother me much, I just find the behaviour odd. I
> haven't bothered to actually look at the code responsible for it yet
> (since it really is not that big of a deal), but I just wanted to
> point it out and hoped that maybe someone could give me a reason for
> why it is as it is...
>

Since I was the one that put this code there, I can explain some of it,
and the rationale for why it works the way it does.

On most platforms, this code uses sched_clock(), which may or may not
be initialized until after init_time().  On x86 (a common platform),
this usually ends up calling read_tsc(), which uses the current
TSC value for the machine.  On a reboot (or warm reset), this
value is not re-initialized, so you see really high values.
If you're seeing this high number on a cold boot, then I'm not sure
where it's coming from.

The reason this was not normalized to 0 on x86 was because during
a cold boot, you can use the value to determine time from actual
cold start, rather than just kernel start.  This is useful for
measuring firmware startup time.  There are other platforms which
use a firmware-initialized timer source, for the same purpose.

In my own usage of this, I usually post-process the data with
scripts/show_delta, which gives reasonable deltas for all of the
lines except where there are anomolies due to clock initialization,
etc. Thus, the bogus absolutes on startup didn't bother me too much.

I know that this timing data is now being used for lots of other
purposes (which I think is great), so if improvements are desired
in the early handling of this, I would be happy to see changes
and/or help out.

UPDATE:
[Based on Tim Schmielau's analysis, maybe it's not the raw TSC
value, but an unititialized jiffy value coming back from sched_clock().
In this case, the value is worthless until after time_init().
This may be why you're seeing a jump in the first "real" value
returned.
Previously on x86, the pre-time_init() value was useful (wrong as an absolute
number, but right in relatives values.)

I'll try to take a look at this.]

Regards,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

