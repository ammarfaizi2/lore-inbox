Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTAUBkV>; Mon, 20 Jan 2003 20:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbTAUBkV>; Mon, 20 Jan 2003 20:40:21 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:14067 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266953AbTAUBkT>; Mon, 20 Jan 2003 20:40:19 -0500
Subject: Re: [PATCH][2.5] hangcheck-timer
From: john stultz <johnstul@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200301210135.h0L1ZFa06867@eng2.beaverton.ibm.com>
References: <200301210135.h0L1ZFa06867@eng2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1043113336.32478.97.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Jan 2003 17:42:16 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         Attached is a patch adding hangcheck-timer.  It is used to detect
>  when the system goes out to lunch for a period of time, and then
>  returns.  This is interesting for debugging drivers as well as for
>  clustering environments.
>         The module sets a timer.  When the timer goes off, it then uses
>  get_cycles() to determine how much real time has passed.

get_cycles() is a poor method for determining "real time". 
Please use do_gettimeofday().

>         On a normal system, the real elapsed time will be almost
>  identical to the expected timer duration.  However, if a device decided
>  to udelay for 60 seconds (or some other circumstance), the module takes

I believe you mean "udelay for 60 micro-seconds"

>  + * The hangcheck-timer driver uses the TSC to catch delays that
>  + * jiffies does not notice.  A timer is set.  When the timer fires, it
>  + * checks whether it was delayed and if that delay exceeds a given
>  + * margin of error.  The hangcheck_tick module paramter takes the timer
>  + * duration in seconds.  The hangcheck_margin parameter defines the
>  + * margin of error, in seconds.  The defaults are 60 seconds for the
>  + * timer and 180 seconds for the margin of error.  IOW, a timer is set
>  + * for 60 seconds.  When the timer fires, the callback checks the
>  + * actual duration that the timer waited.  If the duration exceeds the
>  + * alloted time and margin (here 60 + 180, or 240 seconds), the machine
>  + * is restarted.  A healthy machine will have the duration match the
>  + * expected timeout very closely.
>  + */

Wait, so 180 seconds is the margin of error?

[snip]

>  +#define DEFAULT_IOFENCE_MARGIN 60     /* Default fudge factor, in seconds */
>  +#define DEFAULT_IOFENCE_TICK 180      /* Default timer timeout, in seconds */
>  +

ok, time in seconds...


>  +static int hangcheck_tick = DEFAULT_IOFENCE_TICK;
>  +static int hangcheck_margin = DEFAULT_IOFENCE_MARGIN;
>  +static int hangcheck_reboot = 0;  /* Do not reboot */
>  +

so hangcheck_margin's unit is seconds...

[snip]
>  +static void hangcheck_fire(unsigned long data)
>  +{
>  +      unsigned long long cur_tsc, tsc_diff;
>  +
>  +      cur_tsc = get_cycles();
>  +
>  +      if (cur_tsc > hangcheck_tsc)
>  +              tsc_diff = cur_tsc - hangcheck_tsc;
>  +      else
>  +              tsc_diff = (cur_tsc + (~0ULL - hangcheck_tsc)); /* or something */
>  +
[snip]
>  +      
>  +      if (tsc_diff > hangcheck_tsc_margin) {

but now we're using it to compare cycles!  180sec != 180 cycles

Additionally, this code doesn't take systems that have unsync'ed TSCs,
or systems that change cpu frequency into account. Again, please use
do_gettimeofday(). Then you can then talk about the values returned in
secs and usecs, and I believe things will be much more clear. 

thanks
-john

