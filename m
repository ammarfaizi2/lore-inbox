Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUHQBls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUHQBls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 21:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268066AbUHQBls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 21:41:48 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:7924 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266481AbUHQBlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 21:41:44 -0400
Subject: Re: boot time, process start time, and NOW time
From: Albert Cahalan <albert@users.sf.net>
To: george@mvista.com
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       johnstul@us.ibm.com, david+powerix@blue-labs.org
In-Reply-To: <41215EDA.3070802@mvista.com>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
	 <412151CA.4060902@mvista.com> <1092695544.2301.1227.camel@cube>
	 <41215EDA.3070802@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092697717.2301.1233.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Aug 2004 19:08:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 21:26, George Anzinger wrote:
> Albert Cahalan wrote:
> > On Mon, 2004-08-16 at 20:31, George Anzinger wrote:
> > 
> > 
> >>Hm...  That patch was for a reason...  It seems to me that doing anything short 
> >>of putting "xtime" (or better, clock_gettime() :)) in at fork time is not going 
> >>to fix anything.   As written the start_time in the task_struct is fixed.  If 
> >>"now - uptime + time_from_boot_to_process_start" it is wandering, it must be the 
> >>fault of "now - uptime".  Since this seems to be wandering, and we corrected 
> >>uptime in the referenced patch, is it safe to assume that "now" is actually 
> >>being computed from "jiffies" rather than a gettimeofday()?
> >>
> >>Seems like that is where we should be changing things.
> > 
> > 
> > That's userspace, which works fine on a 2.4.xx kernel.
> > If userspace were to change, it wouldn't work OK for
> > a 2.4.xx kernel anymore. So consider that cast in stone.
> > 
> > "now" is the time() function. Using gettimeofday()
> > would only make sense if I decided to pay the cost
> > of asking for the time every time I look at a task.
> > 
> > Here is the "now - uptime + time_from_boot_to_process_start"
> > calculation, unsimplified, ripped from the procps code:
> > 
> > ////////////////////////////////////////////////////////////////
> > unsigned long   seconds_since_boot = -1;
> > static unsigned long seconds_since_1970;
> > static unsigned long time_of_boot;
> > 
> > some_init_function(){
> >   seconds_since_boot = uptime(0,0);
> >   seconds_since_1970 = time(NULL);
> >   time_of_boot = seconds_since_1970 - seconds_since_boot;
> > }
> > 
> > static int pr_stime(char *restrict const outbuf, const proc_t *restrict const pp){
> >   struct tm *proc_time;
> >   struct tm *our_time;
> >   time_t t;
> >   const char *fmt;
> >   int tm_year;
> >   int tm_yday;
> >   our_time = localtime(&seconds_since_1970);   /* not reentrant */
> >   tm_year = our_time->tm_year;
> >   tm_yday = our_time->tm_yday;
> >   t = time_of_boot + pp->start_time / Hertz;
> >   proc_time = localtime(&t); /* not reentrant, this corrupts our_time */
> >   fmt = "%H:%M";                                   /* 03:02 23:59 */
> >   if(tm_yday != proc_time->tm_yday) fmt = "%b%d";  /* Jun06 Aug27 */
> >   if(tm_year != proc_time->tm_year) fmt = "%Y";    /* 1991 2001 */
> >   return strftime(outbuf, 42, fmt, proc_time);
> > }
> > ////////////////////////////////////////////////////////////////
> > 
> > 
> Hm, I assume time() just returns the seconds part of gettimeofday().  Is 
> uptime() local to procps?  What does it do?  You implied it uses the kernel 
> version of up time, right?  Given all this, I don't see how it can wander.

uptime() returns the first number from /proc/uptime as an int.
(currently it rounds down -- perhaps not the best)

> An interesting question: does it wander if ntp is not in the mix?

I think yes. I just get the bug reports. (well, 1/2 of them)
I'm guessing this is a PC problem; I have a Mac.

 

