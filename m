Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264582AbUFZTjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbUFZTjX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 15:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUFZTjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 15:39:23 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:42484 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264582AbUFZTjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 15:39:20 -0400
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
From: Albert Cahalan <albert@users.sf.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       george@galis.org
In-Reply-To: <Pine.LNX.4.58.0406260855080.14449@ppc970.osdl.org>
References: <1088253429.9831.1449.camel@cube>
	 <1088262728.2805.7.camel@laptop.fenrus.com>
	 <Pine.LNX.4.58.0406260855080.14449@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1088270227.8188.1465.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Jun 2004 13:17:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 12:00, Linus Torvalds wrote:
> On Sat, 26 Jun 2004, Arjan van de Ven wrote:
> > 
> > well.... this value is *passed to userspace* via the AT_ attributes ....
> > glibc probably nicely exports this info via sysconf(). I guess/hope your
> > tools are now using that ?
> 
> Even then, it's a bug in my opinion. Yes, procps should be able to just 
> use sysconf(_SC_CLK_TCK), but the fact is, using CLK_TCK and HZ is 
> traditional unix behaviour, and we should just support it.

It's not working right now, likely due to non-integer HZ.
Here's a bug report.......


Even with the 2.6.7 kernel, I'm still getting reports of process
start times wandering. Here is an example:

   "About 12 hours since reboot to 2.6.7 there was already a
   difference of about 7 seconds between the real start time
   and the start time reported by ps. Now, 24 hours since reboot
   the difference is 10 seconds."

The calculation used is:

   now - uptime + process_run_time

The code shown below works great on a 2.4.xx or earlier kernel.
It generally relys on USER_HZ, which is supposedly in our ABI.

I have a feeling we'll forever be chasing bugs related to not
using a PLL to drive the clock tick at exactly HZ ticks per second.
Perhaps the DragonflyBSD code could be stolen. Anyway, the code:

///////////////////////////////////////////////////////////////////////////
unsigned long seconds_since_1970 = time(NULL);
unsigned long seconds_since_boot = uptime(0,0);
unsigned long time_of_boot       = seconds_since_1970 - seconds_since_boot;
int pr_stime(char *restrict const outbuf, const proc_t *restrict const pp){
  struct tm *proc_time;
  struct tm *our_time;
  time_t t;
  const char *fmt;
  int tm_year;
  int tm_yday;
  our_time = localtime(&seconds_since_1970);   /* not reentrant */
  tm_year = our_time->tm_year;
  tm_yday = our_time->tm_yday;
  t = time_of_boot + pp->start_time / Hertz;
  proc_time = localtime(&t); /* not reentrant, this corrupts our_time */
  fmt = "%H:%M";                                   /* 03:02 23:59 */
  if(tm_yday != proc_time->tm_yday) fmt = "%b%d";  /* Jun06 Aug27 */
  if(tm_year != proc_time->tm_year) fmt = "%Y";    /* 1991 2001 */
  return strftime(outbuf, 42, fmt, proc_time);
}
///////////////////////////////////////////////////////////////////////////


