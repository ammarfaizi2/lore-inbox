Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933097AbWF3T0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097AbWF3T0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933126AbWF3T0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:26:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:45276 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933097AbWF3T0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:26:21 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
	 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606281218130.12900@scrub.home>
	 <Pine.LNX.4.64.0606281335380.17704@scrub.home>
	 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 12:26:09 -0700
Message-Id: <1151695569.5375.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 19:07 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 28 Jun 2006 13:44:12 +0200, Roman Zippel said:
> 
> > Valdis, could you please add a call to the function below in 
> > __get_realtime_clock_ts() when the problem triggers to print the complete 
> > internal clock state.
> 
> Sorry for the delay, I got distracted by other stuff I'm paid to do.. ;)

Very much understand :) Thanks for the testing!

> Here's what a test reboot got:
> 
>    26.578105] audit(1151617213.106:2): policy loaded auid=4294967295
> [   26.597401] audit(1151617213.070:3): avc:  granted  { load_policy } for  pid=1 comm="init" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r
> :security_t:s0 tclass=security
> [   26.683670] unexpected nsec: -840940811,1655512912
> [   26.704096] clock tsc: m:4290198220,s:22,cl:42659140158,ci:1595067,xn:18158513697558798592,xi:18446736466713803524,e:3648592523541009408

> That tell you anything?

Its a little after the fact (since things have already gone awry), but
it does show the multiplier is way out of bound.

I suspect the following patch will resolve it. The update callback
hasn't kept up with the changes from Roman, and is a bit useless anyway.
If the TSC is changing frequency, its unstable and we don't want to use
it, so lets just mark it as such and move along.

I'll work on a patch to cleanup the update_callback code, but if this
resolves the issue, it should be the safe short term fix for 2.6.18.

thanks again!
-john

diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index 7e0d8da..68d23f0 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -348,22 +348,19 @@ static int tsc_update_callback(void)
 {
 	int change = 0;
 
-	/* check to see if we should switch to the safe clocksource: */
-	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
-		clocksource_tsc.rating = 50;
-		clocksource_reselect();
-		change = 1;
-	}
-
 	/* only update if tsc_khz has changed: */
 	if (current_tsc_khz != tsc_khz) {
 		current_tsc_khz = tsc_khz;
-		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
-							clocksource_tsc.shift);
-		change = 1;
+		/* TSC is chnaging freq, mark tsc as bad */
+		mark_tsc_unstable();
 	}
 
-	return change;
+	/* check to see if we should switch to the safe clocksource: */
+	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
+		clocksource_tsc.rating = 50;
+		clocksource_reselect();
+	}
+	return 0;
 }
 
 static int __init dmi_mark_tsc_unstable(struct dmi_system_id *d)



