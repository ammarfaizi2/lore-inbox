Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUFWCTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUFWCTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 22:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUFWCTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 22:19:31 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:52931 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266069AbUFWCT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 22:19:29 -0400
Subject: boot time, process start time, and NOW time
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       tim@physik3.uni-rostock.de, george@mvista.com, johnstul@us.ibm.com,
       david+powerix@blue-labs.org, Andrew Morton OSDL <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1087948634.9831.1154.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Jun 2004 19:57:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even with the 2.6.7 kernel, I'm still getting reports of process
start times wandering. Here is an example:

   "About 12 hours since reboot to 2.6.7 there was already a
   difference of about 7 seconds between the real start time
   and the start time reported by ps. Now, 24 hours since reboot
   the difference is 10 seconds."

The calculation used is:

   now - uptime + time_from_boot_to_process_start

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




