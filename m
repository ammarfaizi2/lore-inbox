Return-Path: <linux-kernel-owner+w=401wt.eu-S932461AbXAGJnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbXAGJnR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXAGJnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:43:17 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:13436 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbXAGJnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:43:15 -0500
X-AuditID: d80ac287-a475abb000002548-a0-45a0c1ac290d 
Date: Sun, 7 Jan 2007 09:43:27 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: David Brownell <david-b@pacbell.net>
cc: phdm@macqel.be, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: RTC subsystem and fractions of seconds
In-Reply-To: <20070107025425.0A7C21FAC07@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Message-ID: <Pine.LNX.4.64.0701070938500.13947@blonde.wat.veritas.com>
References: <200701051949.00662.david-b@pacbell.net> <20070106232633.GA8535@ingate.macqel.be>
 <200701061552.43654.david-b@pacbell.net> <Pine.LNX.4.64.0701070108001.1428@blonde.wat.veritas.com>
 <20070107025425.0A7C21FAC07@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Jan 2007 09:43:12.0820 (UTC) FILETIME=[3F831740:01C73240]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007, David Brownell wrote:
> > > Hmm ... "looping" fights against "quickly"; as would "wait for next
> > > update IRQ" (on RTCs that support that).  But it would improve precision,
> > > at least in the sense of having the system clock and that RTC spending
> > > less time with the lowest "seconds" digit disagreeing.
> > > 
> > > This is something you could write a patch for, n'est-ce pas?
> >
> > If you're thinking of going that way,
> 
> Philippe seemed to be ...
> 
> >	it'd be courteous to CC Matt,
> > who devoted some effort to removing just that loop in 2.6.17 ;)
> 
> Hmm ... "git whatchanged drivers/rtc/hctosys.c" shows no such change.
> So I can't find any record of such a change or its rationale.

Perhaps I'm muddled - I was thinking of this and its associates:

commit 63732c2f37093d63102d53e70866cf87bf0c0479
Author: Matt Mackall <mpm@selenic.com>
Date:   Tue Mar 28 01:55:58 2006 -0800

    [PATCH] RTC: Remove RTC UIP synchronization on x86
    
    Reading the CMOS clock on x86 and some other arches currently takes up to one
    second because it synchronizes with the CMOS second tick-over.  This delay
    shows up at boot time as well a resume time.
    
    This is the currently the most substantial boot time delay for machines that
    are working towards instant-on capability.  Also, a quick back of the envelope
    calculation (.5sec * 2M users * 1 boot a day * 10 years) suggests it has cost
    Linux users in the neighborhood of a million man-hours.
    
    An earlier thread on this topic is here:
    
    http://groups.google.com/group/linux.kernel/browse_frm/thread/8a24255215ff6151/2aa97e66a977653d?hl=en&lr=&ie=UTF-8&rnum=1&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DUTF-8%26selm%3D1To2R-2S7-11%40gated-at.bofh.it#2aa97e66a977653d
    
    ..from which the consensus seems to be that it's no longer desirable.
    
    In my view, there are basically four cases to consider:
    
    1) networked, need precise walltime: use NTP
    2) networked, don't need precise walltime: use NTP anyway
    3) not networked, don't need sub-second precision walltime: don't care
    4) not networked, need sub-second precision walltime:
       get a network or a radio time source because RTC isn't good enough anyway
    
    So this patch series simply removes the synchronization in favor of a simple
    seqlock-like approach using the seconds value.
    
    Note that for purposes of timer accuracy on wakeup, this patch will cause us
    to fire timers up to one second late.  But as the current timer resume code
    will already sync once (or more!), it's no worse for short timers.
    
    Signed-off-by: Matt Mackall <mpm@selenic.com>
    Cc: Andi Kleen <ak@muc.de>
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Russell King <rmk@arm.linux.org.uk>
    Cc: Ralf Baechle <ralf@linux-mips.org>
    Cc: Paul Mundt <lethal@linux-sh.org>
    Cc: Kazumoto Kojima <kkojima@rr.iij4u.or.jp>
    Cc: Alessandro Zummo <a.zummo@towertech.it>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/include/asm-i386/mach-default/mach_time.h b/include/asm-i386/mach-default/mach_time.h
index b749aa4..ff03cf0 100644
--- a/include/asm-i386/mach-default/mach_time.h
+++ b/include/asm-i386/mach-default/mach_time.h
@@ -82,21 +82,8 @@ static inline int mach_set_rtc_mmss(unsi
 static inline unsigned long mach_get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int i;
 
-	/* The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+	do {
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
 		hour = CMOS_READ(RTC_HOURS);
@@ -104,6 +91,7 @@ static inline unsigned long mach_get_cmo
 		mon = CMOS_READ(RTC_MONTH);
 		year = CMOS_READ(RTC_YEAR);
 	} while (sec != CMOS_READ(RTC_SECONDS));
+
 	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
 	  {
 	    BCD_TO_BIN(sec);
