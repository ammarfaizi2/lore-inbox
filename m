Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSKYVqS>; Mon, 25 Nov 2002 16:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSKYVqS>; Mon, 25 Nov 2002 16:46:18 -0500
Received: from fastmail.fm ([209.61.183.86]:56971 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S265700AbSKYVqQ>;
	Mon, 25 Nov 2002 16:46:16 -0500
X-Epoch: 1038261205
X-Sasl-enc: k5frpQ3EUAewH6nj5BHegw
Message-ID: <06fa01c294cc$bcf46e10$1900a8c0@lifebook>
From: "Rob Mueller" <robm@fastmail.fm>
To: <linux-kernel@vger.kernel.org>
Subject: Strange load spikes on 2.4.19 kernel - solved + patch
Date: Tue, 26 Nov 2002 08:50:52 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted a few weeks back about some strange load spikes we were seeing with
2.4.19. We've finally tracked these down, so I thought I'd post a followup
to explain what was happening in case someone experiences a similar issue.

Just to remind, what we were seeing was that load would sit around 0.0-2.0,
but sometimes it would jump to about 20 in an 'instant', with no noticeable
vmstat or other changes... something like this with 5 second intervals...

      procs              memory        io     system   cpu
t   r  b  w  free   buff  cache  bi    bo   in    cs  us  sy  id uptime
--|-------------------------------------------------------------|------
17| 0  0  0 86388 416792 1695824   4   972  445  994   6   7  88| 1.62,
22| 0  0  0 98276 416928 1695868   1  1322  484 1049   9  10  81| 1.49,
27| 0  1  1 94284 417164 1695564  48  1553  527 1205   9  10  81| 1.37,
32| 1  0  0 90336 417340 1695676  18  1243  497 1188   8  10  82| 17.03
37| 4  0  1 84288 417440 1695728   8   812  425 1186   6  10  84| 15.67
42| 0  0  0 89736 417648 1696504 120  1042  539 1340   9  10  81| 14.41
47| 0  1  0 85284 417764 1696692  21   852  452 1329   6  11  83| 13.34

Well, i was using 'uptime' to see the load average most of the time, but at
one stage I was using /proc/loadavg. Using that I'd see something like this:

while true; do cat /proc/loadavg; sleep 1; done
1.02 1.46 1.32 1/2279 15983
1.02 1.46 1.32 1/2285 15996
1.02 1.46 1.32 1/2291 16010
20.35 1.95 1.37 5/2284 16028
20.35 1.95 1.37 4/2285 16048

Hmmm, a big load jump again, but nothing obvious happening, but then leaving
that running, I'd see this later:

while true; do cat /proc/loadavg; sleep 1; done
1.59 1.12 1.16 1/2428 19276
1.59 1.12 1.16 258/2430 19282
1.59 1.12 1.16 1/2430 19289

Interesting. 258 running processes, but only for one time instant, and no
effect on the load. Lets look at how load average is calculated. Looking in
kernel/timer.c, it appears it uses an expontential decay, and recalculates
every 5 seconds. It gets a current count of 'active tasks', and uses
CALC_LOAD() to update the 3 averages.

   #define FSHIFT    11    /* nr of bits of precision */
   #define FIXED_1   (1<<FSHIFT) /* 1.0 as fixed-point */
   #define EXP_1   1884    /* 1/exp(5sec/1min) as fixed-point */

   #define CALC_LOAD(load,exp,n) \
     load *= exp; \
     load += n*(FIXED_1-exp); \
     load >>= FSHIFT;

   active_tasks = count_active_tasks();
   CALC_LOAD(avenrun[0], EXP_1, active_tasks);

[note: active_tasks is actually a fixed point value, so 1 active task means
active_tasks == (1<<11)]

So assume load is 0.00 initially, what happens if there's 250 runnable
processes when the load is recalculated.

(250*(1<<11-1884))>>11 = 250*(2048-1884)/2048 = 20.02

Ah, so this probably explains what is happening. For some reason, around 250
processes are waking up and becoming runnable simultaneously at random
times, but only for a very short instant. If the 250 processes happen to be
awake at the moment the load is recalculated (every 5 seconds), then the
load will appear to jump about 20 points. The problem is that since they're
only awake for a moment, and go back to sleep straight away, it's hard to
see this actually happen!

A bit of searching showed the following config line:

  imap          cmd="imapd" listen="143" prefork=250

Suspicious. A look through the cyrus code showed that immediately after
forking a child, it would set an alarm() call. That might explain it. 250
processes are forked off. Sometime later, all 250 get woken up by an alarm()
signal, do a bit of housekeeping, then go back to sleep, which would explain
what we're seeing above. Yes, that was it. Reducing the prefork value to 10
made the load spike problem go away completely.

This might have been easier to figure out had I been able to see what was
happening with the load average re-calculation. I thought the following
patch might help, which will output in /proc/loadavg the number of "active"
tasks used when the load average was last recalcuated.

Rob

*** include/linux/sched.h       Mon Oct 14 10:01:24 2002
--- /tmp/sched.h        Tue Nov 26 08:24:26 2002
***************
*** 57,62 ****
--- 57,63 ----
   *    11 bit fractions.
   */
  extern unsigned long avenrun[];               /* Load averages */
+ extern unsigned long active_at_last_calc_load;

  #define FSHIFT                11              /* nr of bits of precision
*/
  #define FIXED_1               (1<<FSHIFT)     /* 1.0 as fixed-point */
*** fs/proc/proc_misc.c Sat Aug  3 10:39:45 2002
--- /tmp/proc_misc.c    Tue Nov 26 08:24:31 2002
***************
*** 107,117 ****
        a = avenrun[0] + (FIXED_1/200);
        b = avenrun[1] + (FIXED_1/200);
        c = avenrun[2] + (FIXED_1/200);
!       len = sprintf(page,"%d.%02d %d.%02d %d.%02d %d/%d %d\n",
                LOAD_INT(a), LOAD_FRAC(a),
                LOAD_INT(b), LOAD_FRAC(b),
                LOAD_INT(c), LOAD_FRAC(c),
!               nr_running, nr_threads, last_pid);
        return proc_calc_metrics(page, start, off, count, eof, len);
  }

--- 107,117 ----
        a = avenrun[0] + (FIXED_1/200);
        b = avenrun[1] + (FIXED_1/200);
        c = avenrun[2] + (FIXED_1/200);
!       len = sprintf(page,"%d.%02d %d.%02d %d.%02d %d/%d %d %d\n",
                LOAD_INT(a), LOAD_FRAC(a),
                LOAD_INT(b), LOAD_FRAC(b),
                LOAD_INT(c), LOAD_FRAC(c),
!               nr_running, nr_threads, last_pid, active_at_last_calc_load);
        return proc_calc_metrics(page, start, off, count, eof, len);
  }
*** kernel/timer.c      Sat Aug  3 10:39:46 2002
--- /tmp/timer.c        Tue Nov 26 08:24:35 2002
***************
*** 637,642 ****
--- 637,643 ----
   * all seem to differ on different machines.
   */
  unsigned long avenrun[3];
+ unsigned long active_at_last_calc_load;

  static inline void calc_load(unsigned long ticks)
  {
***************
*** 647,652 ****
--- 648,654 ----
        if (count < 0) {
                count += LOAD_FREQ;
                active_tasks = count_active_tasks();
+               active_at_last_calc_load = active_tasks >> FSHIFT;
                CALC_LOAD(avenrun[0], EXP_1, active_tasks);
                CALC_LOAD(avenrun[1], EXP_5, active_tasks);
                CALC_LOAD(avenrun[2], EXP_15, active_tasks);

