Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVCZLiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVCZLiE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 06:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVCZLiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 06:38:04 -0500
Received: from zahadum.xs4all.nl ([194.109.0.112]:31369 "EHLO
	zahadum.xs4all.nl") by vger.kernel.org with ESMTP id S262043AbVCZLhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 06:37:46 -0500
Date: Sat, 26 Mar 2005 12:37:39 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Erik Horn <eHorn@aad.org>, Erik Horn <Erik_Horn@beavton.k12.or.us>
Subject: syslogd hang / livelock (was: 2.6.10-rc3, syslogd hangs then processes get stuck in schedule_timeout)
Message-ID: <20050326113738.GA6599@xs4all.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-NCC-RegID: nl.xs4all
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References:
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=103392
  http://lkml.org/lkml/2004/12/21/208
  http://lkml.org/lkml/2004/11/2/17

At Tue, 21 Dec 2004 16:39:43 -0800 (PST) Chris Stromsoe wrote:
> I'm still seeing this problem.  It repeats every week or week and a half, 
> usually after logs have been rotated and a dvd has been written.  syslogd 
> stops writing output, then everything that does schedule_timeout() hangs, 
> the process table fills, and everything grinds to a halt.
> 
> If the problem is detected early enough, syslogd can be manually killed 
> and restarted, unwedging everything and returning everything to normal 
> operation.

I'm seeing the same problem here, and it is not a kernel bug. I'm only
Cc'ing this to linux-kernel so that it shows up in the archives, since
there have been postings about the same thing in the past.

There are 2 issues here:

1. syslogd hangs sometimes when running under a 2.6 kernel.

   This is because syslogd set up a timer, called by alarm() every
   20 minutes by default, which writes a "MARK" entry in one of
   the logfiles to show that syslogd is still alive.

   That code calls ctime(), which is not re-entrant - and recent
   glibcs __libc_lock() around ctime() calls, which doesn't do anything
   on a 2.4 kernel, but uses a futex on a 2.6 kernel.

   So if syslogd happens to be inside ctime() in the main routine,
   SIGALRM hits, and ctime() is called again, syslogd locks up.
   A sysrq-T trace will show it hanging in futex_wait.

2. syslog() uses blocking AF_UNIX SOCK_DGRAM sockets.

   When an application calls syslog(), and syslogd is not responding
   and the socket buffers get full, the app will hang in connect()
   or send(). This is different from BSD, where send() will return
   ENOBUFS in this case.

   Try killall -STOP syslogd, then generate some syslog traffic
   (say with while :; do logger hello; done) and try to ssh into
   the system - no go. Everything that uses syslog() hangs.

Solutions:

1. syslogd

    Run syslogd with the -m0 option so that it won't do MARKing.
    The real solution is to fix syslogd to use ctime_r, or better,
    to just let the ALRM handler set a flag and do the MARK
    logging in the main loop.

2. syslog()

    Arguably syslog() shouldn't hang like it does now. But making it
    non-blocking could lead to information loss - a hacker generating
    lots of bogus syslog messages so that real messages get lost.
    On the other hand, she can do that anyway and fill up the disk
    which gives a similar (although more noticable) effect. I'm not
    sure how or if this should be fixed.

Mike.
