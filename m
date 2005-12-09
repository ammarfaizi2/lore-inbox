Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVLIRdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVLIRdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVLIRdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:33:21 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:716 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932283AbVLIRdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:33:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume from disk)
Date: Fri, 9 Dec 2005 18:34:38 +0100
User-Agent: KMail/1.9
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <20051204232153.258cd554.akpm@osdl.org> <200512091220.06060.rjw@sisk.pl> <439989A7.76F0.0078.0@novell.com>
In-Reply-To: <439989A7.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091834.38960.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 9 December 2005 13:41, Jan Beulich wrote:
> >>> "Rafael J. Wysocki" <rjw@sisk.pl> 09.12.05 12:20:05 >>>
> >On Friday, 9 December 2005 10:15, Jan Beulich wrote:
> >> It's a possible way to address this, but I'd rather just set a flag
> >> indicating that the last-whatever values should not be considered
> (to
> >> get into a state just like after initial boot). Jan
> >
> >OK, but what is the interrupt handler supposed to do if the
> >vxtime.last* values are invalid?  I guess assume delta = 0?
> 
> As I said, the state should be (re)set to whatever is in effect at
> boot.

Is the appended patch better than the previous one?

Rafael


 arch/x86_64/kernel/time.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: linux-2.6.15-rc5-mm1/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/x86_64/kernel/time.c	2005-12-08 22:57:33.000000000 +0100
+++ linux-2.6.15-rc5-mm1/arch/x86_64/kernel/time.c	2005-12-09 14:37:31.000000000 +0100
@@ -65,6 +65,7 @@ unsigned long hpet_tick;
 static int hpet_use_timer;
 unsigned long vxtime_hz = PIT_TICK_RATE;
 unsigned long long monotonic_base;
+static int vxtime_last_invalid;		/* for the interrupt handler */
 static int report_lost_ticks;			/* command line option */
 
 
@@ -417,6 +418,13 @@ static irqreturn_t timer_interrupt(int i
 
 	rdtscll_sync(&tsc);
 
+	if (vxtime_last_invalid) {
+		if (vxtime.mode == VXTIME_HPET)
+			vxtime.last = offset;
+		vxtime.last_tsc = tsc;
+		vxtime_last_invalid = 0;
+	}
+
 	if (vxtime.mode == VXTIME_HPET) {
 		if (hpet64 > 0) {
 			unsigned long delta = offset - vxtime.last;
@@ -1125,6 +1133,7 @@ static int timer_resume(struct sys_devic
 
 	sec = ctime + clock_cmos_diff;
 	write_seqlock_irqsave(&xtime_lock,flags);
+	vxtime_last_invalid = 1;
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock,flags);
