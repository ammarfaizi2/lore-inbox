Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268766AbUI2SQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268766AbUI2SQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268769AbUI2SQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:16:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63627 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268775AbUI2SQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:16:02 -0400
Date: Wed, 29 Sep 2004 11:14:44 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant CLOCK_PROCESS/THREAD_CPUTIME_ID V4
In-Reply-To: <415AF4C3.1040808@mvista.com>
Message-ID: <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, George Anzinger wrote:

> Christoph Lameter wrote:
> > George asked for a test program so I wrote one and debugged the patch.
> > The test program uses syscall to bypass glibc processing. I have been
> > working on a patch for glibc but that gets a bit complicated
> > because backwards compatibility has to be kept. Maybe tomorrow.
> > Found also that glibc allows the setting of these clocks so I also
> > implemented that and used it in the test program.  Setting these
> > clocks modifies stime and utime directly, which may not be such a good
> > idea. Do we really need to be able to set these clocks?
>
> Another way of doing this is to save these values in the task structure.  If
> null, use the direct value of stime, utime, if not, adjust by the saved value
> (i.e. saved value would represent time zero).

But this would require two additional int field in task_t just for that
rarely used functionality.

> Please, when sending patches, attach them.  This avoids problems with mailers,
> on both ends, messing with white space.  They still appear in line, at least in
> some mailers (mozilla in my case).

The custom on lkml, for Linus and Andrew is to send them inline. I also
prefer them inline. Will try to remember sending attachments when sending a
patch to you.

> As to the test program, what happens when you attempt to set up a timer on these
> clocks?  (No, I don't think it should work, but we DO want to properly error
> out.  And the test should verify that this happens.)  By the way, if you use the
> support package from sourceforge, you will find a lot of test harness stuff.

That is an interesting issue. If that would work correctly one could
trigger an signal if more than a certain amount of cputime is used.
It looks though that it will create an interrupt based on real time.

SuS says:

 Each implementation defines a set of clocks that can be used as timing
 bases for per-process timers. All implementations support a clock_id of
 CLOCK_REALTIME.

So restrict timer_create to CLOCK_REALTIME and CLOCK_MONOTONIC? Is it
necessary to be able to derive a timer from a timer derives from those
two?

something like the following (just inlined for the discussion ...)?

--- linux-2.6.9-rc2.orig/kernel/posix-timers.c  2004-09-28 20:29:28.000000000 -0700
+++ linux-2.6.9-rc2/kernel/posix-timers.c       2004-09-29 11:12:37.814713085 -0700
@@ -585,8 +585,8 @@
        sigevent_t event;
        int it_id_set = IT_ID_NOT_SET;

-       if ((unsigned) which_clock >= MAX_CLOCKS ||
-                               !posix_clocks[which_clock].res)
+       if ((unsigned) which_clock != CLOCK_REALTIME &&
+           (unsigned) which_clock != CLOCK_MONOTONIC)
                return -EINVAL;

        new_timer = alloc_posix_timer();

