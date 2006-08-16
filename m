Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWHPM1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWHPM1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWHPM1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:27:08 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:36332 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1751152AbWHPM1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:27:06 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Aug 2006 14:26:44 +0200
MIME-Version: 1.0
Subject: Linux time code
Message-ID: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.06.0+V=4.06+U=2.07.138+R=05 June 2006+T=125540@20060816.122428Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody!

I've been viewing recent changes to the Linux kernel (specifically 2.6.15.1 to 
2.6.17.8), and I felt I'll have to say something:

First there's a new routine in kernel/time.c named "set_normalized_timespec()". 
That routine sets nothing besides the actual argument being passed by reference. 
Thus I feel that routine should rather be named "normalize_timespec()" (just to 
save a few bytes. No, not really ;-). Alternatively that thing could be a pure 
("const") function that returns the normalized timespec. In that case I'd call it 
"normalized_timespec()"...

OK, that issue woun't make anybody feel hot I guess, so here's another one:

The existing routines for measuring time among the various architectures is an 
absolute mess. Well, it always had been, but it didn't become any better, but 
worse it seems. For example there is a POSIX-like sys_clock_gettime() intended to 
server the end-user directly, but there's no counterpart do_clock_gettime() to 
server any in-kernel needs. The implementation of clock_getres() is also hardly 
worth it. I once had implemented a routine like this:

void do_clock_getres(clockid_t sysclock, struct timespec *tsp)
{
	struct timespec ts;
	int retry_limit;

	ts.tv_sec = 0;
	do {
		struct timespec ts1, ts2;

		do_clock_gettime(sysclock, &ts1);
		do_clock_gettime(sysclock, &ts2);
		ts.tv_sec = ts2.tv_sec - ts1.tv_sec;
		ts.tv_nsec = ts2.tv_nsec - ts1.tv_nsec;
	} while (--retry_limit > 0 && (ts.tv_sec != 0 || ts.tv_nsec == 0));
	*tsp = ts;
}

That routine tries to get the typical clock resolution the user is expected to 
see, automatically adjusting to the interpolation method and CPU speed being used. 
I think that's preferrable to just returning 1ns or "tick" or whatever.

Finally I have the personal need for an "unadjusted tick interpolator" 
(preferrably being clocked by the same clock as the timer chip) to estimate the 
frequency error of the system clock (independently from any offset adjustments 
being made).

For those who might wonder: Yes, that's the code that had been thown out recently: 
NTP PPS calibration.

So summarize: I'd wish for fewer, but more useful routines dealing with time. Some 
modules just don't export useful (and otherwise missing) routines, while other 
useful exported routines have different names for each architecture. A mess...

Sorry if you don't like that kind of message, but I just had to say that. It seems 
the time subsystem is already so complex that people are just adding new code 
instead of considering redesign or reuse of the existing code.

Regards,
Ulrich

