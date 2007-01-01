Return-Path: <linux-kernel-owner+w=401wt.eu-S1754694AbXAAT2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbXAAT2v (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbXAAT2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:28:51 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:42269 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694AbXAAT2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:28:50 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC] HZ free ntp
Date: Mon, 1 Jan 2007 19:29:28 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061204204024.2401148d.akpm@osdl.org> <1166578357.5594.3.camel@localhost> <1166579658.5594.6.camel@localhost>
In-Reply-To: <1166579658.5594.6.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011929.28546.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 02:54, john stultz wrote:

> And here would be the follow on patch (again *untested*) for
> CONFIG_NO_HZ slowing the time accumulation down to once per second.

Changing it to one creates a potential problem with calling second_overflow(). 
It should be called every NTP_INTERVAL_FREQ times, but occasionally it's off 
by one (when xtime is close to a full second and the tick length is different 
from 1sec). At a higher frequency that's not much of a problem, but at one it 
means second_overflow() is occasionally called twice a second or skipped for 
a second. Usually the error should be quite small, but sometimes it can be 
significant.
So in this case the loop in update_wall_time() should rather look like this:

	while (offset >= clock->cycle_interval) {
		...
		second_overflow();
		while (clock->xtime_nsec >= (u64)NSEC_PER_SEC << clock->shift) {
			clock->xtime_nsec -= (u64)NSEC_PER_SEC << clock->shift;
			xtime.tv_sec++;
		}
		...
	}

(Also note the change from "if" to "while".)

Another problem area is that the clock shift value might need adjustments, 
since when you reduce the update frequency, it also increases the error 
adjustment steps and thus influences the jitter. This is especially important 
if we want to synchronize the TSC on multiple cpu's.

bye, Roman
