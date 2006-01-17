Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWAQAt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWAQAt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 19:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWAQAt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 19:49:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:12499 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751307AbWAQAt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 19:49:28 -0500
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3
	oops on suspend and more (bonus oops shot!)]
From: john stultz <johnstul@us.ibm.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060116204057.GC3639@inferi.kami.home>
References: <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz>
	 <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org>
	 <20060111184027.GB4735@inferi.kami.home>
	 <20060112220825.GA3490@inferi.kami.home>
	 <1137108362.2890.141.camel@cog.beaverton.ibm.com>
	 <20060114120816.GA3554@inferi.kami.home>
	 <1137442582.27699.12.camel@cog.beaverton.ibm.com>
	 <20060116204057.GC3639@inferi.kami.home>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 16:49:18 -0800
Message-Id: <1137458964.27699.65.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 21:40 +0100, Mattia Dongili wrote:
> On Mon, Jan 16, 2006 at 12:16:21PM -0800, john stultz wrote:
> > I'll try to narrow that window down a bit and see if that doesn't
> > resolve the issue.
> 
> I'll be happy to test new patches if necessary (I'm running -mm4)

See if this patch doesn't resolve the issue. Its a bit hackish, but
basically I'm just holding off installing any clocksources until later
on at boot. This avoids some of the clocksource churn.

You will still see the TSC be installed briefly, since in this cases it
doesn't realize its a bad choice until after its being used for one
interval. However it should be much shorter (only ~50ms) of a window.

thanks
-john


diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -51,13 +51,27 @@ static LIST_HEAD(clocksource_list);
 static DEFINE_SPINLOCK(clocksource_lock);
 static char override_name[32];
 
+static int finished_booting;
+
+/* clocksource_done_booting - Called near the end of bootup
+ *
+ * Hack to avoid lots of clocksource churn at boot time 
+ */
+static int clocksource_done_booting(void)
+{
+	finished_booting = 1;
+	return 0;
+}
+
+late_initcall(clocksource_done_booting);
+
 /**
  * get_next_clocksource - Returns the selected clocksource
  */
 struct clocksource *get_next_clocksource(void)
 {
 	spin_lock(&clocksource_lock);
-	if (next_clocksource) {
+	if (next_clocksource && finished_booting) {
 		curr_clocksource = next_clocksource;
 		next_clocksource = NULL;
 	}


