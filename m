Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVE3SmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVE3SmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVE3SmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:42:05 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:59825 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261696AbVE3Sk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:40:58 -0400
Date: Mon, 30 May 2005 20:40:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andi Kleen <ak@muc.de>, Chris Friesen <cfriesen@nortel.com>,
       john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: spinaphore conceptual draft
Message-ID: <20050530184059.GA2222@ucw.cz>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de> <429B289D.7070308@nortel.com> <20050530164003.GB8141@muc.de> <429B4957.7070405@nortel.com> <m1k6lgwqro.fsf@muc.de> <02485B05-6AE5-4727-8778-D73B2D202772@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02485B05-6AE5-4727-8778-D73B2D202772@mac.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 02:04:36PM -0400, Kyle Moffett wrote:

> On May 30, 2005, at 13:46:35, Andi Kleen wrote:
> >>tsc goes backwards on AMD?  Under what circumstances (I'm curious,
> >>since I'm running one...)
> >
> >It is not synchronized between CPUs and slowly drifts and can even run
> >at completely different frequencies there when you use powernow! on a
> >MP system.
> 
> Unsynchronized is fine, we're only taking differences of short times.

If you ask on two CPUs in a quick succession, you can get a negative
time difference.

> Slow drift is likewise OK too.  As to the different frequencies, how
> different are we talking about? 

1GHz vs 2GHz, for example.

There is cpufreq, which changes the CPU clocks in large steps under the
kernel's control, and there is spread spectrum, which wiggles them just
a tiny bit (1-4%) back and forth (independently on different CPUs) to
minimize EMI.

> Also, on such a system, is there any way to determine a relative
> frequency, even if unreliable or  occasionally off?

You can measure it. With cpufreq you have a good guess when you switch
that the new frequency will have a certain ratio to the old one.

> >It can be used reliably when you only do deltas on same CPU
> >and correct for the changing frequency. However then you run
> >into other problems, like it being quite slow on Intel.
> 
> The deltas here are generally short, always on the same CPU, and can be
> corrected for changing frequency, assuming that said frequency is
> available somehow.

The fact the deltas are on the same CPU helps. The shortness of the
interval doesn't, since on AMD CPUs RDTSC is executed speculatively and
out-of-order, and the order of two close RDTSC instructions isn't
guaranteed, as far as I remember.

> Ideally it would be some sort of CPU cycle-counter, just so I can say
> "In between lock and unlock, the CPU did 1000 cycles", for some value
> of "cycle".

This may be doable if precision isn't required.

> >I suspect any attempt to use time stamps in locks is a bad
> >idea because of this.
> 
> Something like this could be built only for CPUs that do support that
> kind of cycle counter.

RDTSC on older Intel CPUs takes something like 6 cycles. On P4's it
takes much more, since it's decoded to a microcode MSR access.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
