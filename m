Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVLAVTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVLAVTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVLAVTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:19:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55965 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932481AbVLAVTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:19:47 -0500
Date: Thu, 1 Dec 2005 22:19:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, ray-gmail@madrabbit.org,
       zippel@linux-m68k.org, mrmacman_g4@mac.com, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
Message-ID: <20051201211933.GA25142@elte.hu>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com> <Pine.LNX.4.61.0512011352590.1609@scrub.home> <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com> <20051201165144.GC31551@flint.arm.linux.org.uk> <20051201122455.4546d1da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201122455.4546d1da.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> The whole concept of separating "timers" from "timeouts" seems a step 
> backward to me.  A large one.  Why was it done, and can it be undone?

i had a very similar opinion when i first talked to Thomas about HRES 
timers a couple of months ago. I told him that the only sane way to add 
HRES timers to the -rt tree is to integrate them into the existing timer 
wheel, and to avoid a duality of APIs. I told him that adding a separate 
HRES implementation is pretty much a 'non-starter'.

then many months of experimentation followed. We (well, Thomas mostly) 
patiently tried a sub-jiffy method, a split-lists method, all sorts of 
ways to merge high-res timers into the timer wheel. We got HRES timers 
work in every such design, but it looked way too ugly and had bad 
performance and latencies - and we wanted upsteam integration.

so after many months we realized that the core issue is that the 
requirements of 'timers' are unmixable with the requirements of 
'timeouts'. See a more detailed analysis at:

  http://lwn.net/Articles/152436/

i'll try to sum it up again very briefly: the timer wheel is a very 
well-optimized data structure geared towards 'timeout' type of use.  But 
it is at the very edge of its 'feature reach', and we found no workable 
way to extend it into the directions we wanted to go. The moment we 
tried to extend it in one direction (e.g. to increase HZ to 1000000 to 
get 1 usec resolution), it started creaking in some other spots.

the only clean solution we found was to totally separate them, and to 
use the natural data structures for both of them: to keep the highly 
scalable timer wheel on the timeout side, and to use the slower but more 
flexible [and deterministic] timer trees on the timer side. [ktimers are 
still very fast - but they cannot possibly be as fast as the single 
list_add() of add_timer()!]. The two usage scenarios (timeouts and 
timers) do not care about each other.

we could merge the two by driving 'timeouts' via ktimers too - but there 
would be some unavoidable overhead to things like the TCP stack. But 
ktimers cannot be merged into timeouts, that's sure.

	Ingo
