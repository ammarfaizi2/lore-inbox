Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVLIJPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVLIJPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 04:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVLIJPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 04:15:11 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:60009
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750786AbVLIJPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 04:15:09 -0500
Message-Id: <43995957.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Dec 2005 10:15:51 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Rafael Wysocki" <rjw@sisk.pl>, <discuss@x86-64.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume
	from disk)
References: <20051204232153.258cd554.akpm@osdl.org>  <43980058.76F0.0078.0@novell.com>  <200512081153.51397.rjw@sisk.pl> <200512082335.50417.rjw@sisk.pl>
In-Reply-To: <200512082335.50417.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a possible way to address this, but I'd rather just set a flag
indicating that the last-whatever values should not be considered (to
get into a state just like after initial boot). Jan

>>> "Rafael J. Wysocki" <rjw@sisk.pl> 08.12.05 23:35:49 >>>
Update:

On Thursday, 8 December 2005 11:53, Rafael J. Wysocki wrote:
> On Thursday, 8 December 2005 09:43, Jan Beulich wrote:
> > I don't know how resume normally handles the re-syncing of the
wall
> > clock, but the problem here is obvious: do_timer runs a loop to
> > increment jiffies, which may require significant amounts of time
> > (depending how long the system was sleeping).
> > 
> > Whatever mechanism was previously used to adjust the wall clock
during
> > resume, this (a) has to happen before enabling interrupts and (b)
has to
> > communicate to the timer interrupt handler to adjust its last time
stamp
> > taken (to compare against in the next run). Clearly, the code was
broken
> > already before, as it doesn't handle the resume case (where the
HPET
> > value read is entirely unrelated to the one read during the last
timer
> > interrupt before suspend) at all, and even in the TSC timer case
it
> > simply checks whether the TSC delta is negative (which is not a
valid
> > condition, as, between the booting of the system and the OS resume
there
> > may elapse more time than the system was running altogether prior
to
> > suspend).
> 
> Well, I'm not an expert, but I think I understand your
argumentation.
> However, the problem is that resume _works_ without the patch
> and doesn't work with it, which is a regression.  (BTW, without
> the patch the wall clock is evidently correct after resume.)
> 
> Frankly I don't know who should fix the broken code,

FWIW, I have tried to fix it myself.

The appended patch seems to work on my box, but I'm afraid
it's not the right fix (at least in general).  Please advise.

Greetings,
Rafael


 arch/x86_64/kernel/time.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

Index: linux-2.6.15-rc5-mm1/arch/x86_64/kernel/time.c
===================================================================
---
linux-2.6.15-rc5-mm1.orig/arch/x86_64/kernel/time.c	2005-12-08
21:39:29.000000000 +0100
+++ linux-2.6.15-rc5-mm1/arch/x86_64/kernel/time.c	2005-12-08
22:44:48.000000000 +0100
@@ -1117,6 +1117,7 @@
 	unsigned long sec;
 	unsigned long ctime = get_cmos_time();
 	unsigned long sleep_length = (ctime - sleep_start) * HZ;
+	long offset = 0;
 
 	if (vxtime.hpet_address)
 		hpet_reenable();
@@ -1125,6 +1126,20 @@
 
 	sec = ctime + clock_cmos_diff;
 	write_seqlock_irqsave(&xtime_lock,flags);
+	if (vxtime.hpet_address)
+		offset = hpet_readl(HPET_COUNTER);
+	if (hpet_use_timer) {
+		unsigned int hi1 = hpet64 > 0 ?
hpet_readl(HPET_COUNTER+4) : 0;
+
+		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
+		if (hpet64 > 0)
+			offset += (long)(offset >= 0 ? hi1 :
hpet_readl(HPET_COUNTER+4)) << 32;
+		else
+			offset = (unsigned int)offset;
+	}
+	if (vxtime.mode == VXTIME_HPET)
+		vxtime.last = offset;
+	rdtscll_sync(&vxtime.last_tsc);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock,flags);
