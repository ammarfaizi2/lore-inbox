Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUHQAW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUHQAW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUHQAW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:22:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58503 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268036AbUHQAVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:21:44 -0400
Subject: Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       george anzinger <george@mvista.com>, david+powerix@blue-labs.org
In-Reply-To: <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1092702077.2429.88.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 16 Aug 2004 17:21:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 16:08, Tim Schmielau wrote:
> On Mon, 16 Aug 2004, Andrew Morton wrote:
> 
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> > >
> > > Albert Cahalan <albert@users.sf.net> writes:
> > > 
> > > > Even with the 2.6.7 kernel, I'm still getting reports of process
> > > > start times wandering. Here is an example:
> > > > 
> > > >    "About 12 hours since reboot to 2.6.7 there was already a
> > > >    difference of about 7 seconds between the real start time
> > > >    and the start time reported by ps. Now, 24 hours since reboot
> > > >    the difference is 10 seconds."
> > > > 
> > > > The calculation used is:
> > > > 
> > > >    now - uptime + time_from_boot_to_process_start
> > > 
> > > Start-time and uptime is using different source. Looks like the
> > > jiffies was added bogus lost counts.
> > > 
> > > quick hack. Does this change the behavior?
> > 
> > Where did this all end up?  Complaints about wandering start times are
> > persistent, and it'd be nice to get some fix in place...
> 
> 
> 
> The trouble seems to be due to the patch below, part of a larger cleanup
> (http://linus.bkbits.net:8080/linux-2.5/cset%403ef4851dGg0fxX58R9Zv8SIq9fzNmQ?nav=index.html|src/.|src/fs|src/fs/proc|related/fs/proc/proc_misc.c)
> by George.
> 
> Quoting from the changelog entry:
> 
> "Changes the uptime code to use the posix_clock_monotonic notion of 
> uptime instead of the jiffies.  This time will track NTP changes and so should 
> be better than your standard wristwatch (if your using ntp)."
> 
> George is absolutely right that it's more precise. However, it's also 
> inconsistent with the process start times which use plain uncorrected 
> jiffies. ps stumbles over this inconsistency.
> 
> Simple fix: revert the patch below.
> Complicated fix: correct process start times in fork.c (no patch provided, 
> too complicated for me to do).

Hmm. While that patch fixed the uptime proc entry, I thought the issue
was with process start times. I'm looking at fixing the start_time
assignment in proc_pid_stat(). My suspicion is that we need to use ACTHZ
in jiffies64_to_clock_t().

Something like the patch below.

thanks
-john

===== include/linux/times.h 1.6 vs edited =====
--- 1.6/include/linux/times.h	2004-05-10 04:25:49 -07:00
+++ edited/include/linux/times.h	2004-08-16 16:22:13 -07:00
@@ -48,6 +48,7 @@
 	 * but even this doesn't overflow in hundreds of years
 	 * in 64 bits, so..
 	 */
+	x = (x * ACT_HZ)>>8;  /* compensate for ACT_HZ != HZ */
 	x *= TICK_NSEC;
 	do_div(x, (NSEC_PER_SEC / USER_HZ));
 #endif


