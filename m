Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161199AbVIPRhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbVIPRhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbVIPRhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:37:37 -0400
Received: from mail-ash.bigfish.com ([206.16.192.253]:42866 "EHLO
	mail8-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161199AbVIPRhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:37:36 -0400
X-BigFish: V
Message-ID: <432B02DE.7060308@am.sony.com>
Date: Fri, 16 Sep 2005 10:37:34 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: jesper.juhl@gmail.com, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: early printk timings way off
References: <9a87484905091515495f435db7@mail.gmail.com> <432AFB01.3050809@am.sony.com> <Pine.LNX.4.61.0509161909500.31820@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.61.0509161909500.31820@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> So, one jump (probably the first) happens when time_init sets use_tsc.
> Do we understand the other jump as well?

I haven't specifically tested, but I'd put good money on it being
a result of the initialization of cyc2ns_scale.  Before this
is set, cycles_2_ns() returns 0 (which would explain the _exactly_
0 value).  The value of 27.<something> seconds is very likely the
real value based on the TSC (which would mean the BIOS took
a good long time during boot).

So, in summary, this is probably what's happening:

 * from start_kernel - sched_clock() returns jiffies_64 (which
  is pre-initialized high and is not incrementing yet)
 * when use_tsc is set, sched_clock returns 0, until
 * when cyc2ns_scale is set, sched_clock returns TSC-based values,
  representing time from cold machine start

On other platforms, I have sometimes replaced the call to sched_clock()
in printk() with something else that gives valid data from the very first
kernel instruction.

A while ago Andrew Morton said that maybe the clock used here should be
replaceable, using something like the code below.  Does anyone know
if someone worked on this.  If not I'll take a stab at submitting it.

--- devel/kernel/printk.c~printk_clock	2005-08-21 02:14:05.000000000
-0700
+++ devel-akpm/kernel/printk.c	2005-08-21 02:15:14.000000000 -0700
@@ -488,6 +488,11 @@ static int __init printk_time_setup(char

 __setup("time", printk_time_setup);

+__attribute__((weak)) unsigned long long printk_clock(void)
+{
+	return sched_clock();
+}
+
 /*
  * This is printk.  It can be called from any context.  We want it to
work.
  *
@@ -558,7 +563,7 @@ asmlinkage int vprintk(const char *fmt,
 					loglev_char =
default_message_loglevel
 						+ '0';
 				}
-				t = sched_clock();
+				t = printk_clock();
 				nanosec_rem = do_div(t, 1000000000);
 				tlen = sprintf(tbuf,
 						"<%c>[%5lu.%06lu] ",

Regards,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

