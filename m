Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbRCENCV>; Mon, 5 Mar 2001 08:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRCENCM>; Mon, 5 Mar 2001 08:02:12 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:38842 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129257AbRCENCH>; Mon, 5 Mar 2001 08:02:07 -0500
Message-ID: <3AA38E05.549BCF95@uow.edu.au>
Date: Tue, 06 Mar 2001 00:00:53 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: linux-fbdev-devel@sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Brad Douglas <brad@neruo.com>
Subject: Re: [prepatches] removal of console_lock
In-Reply-To: <3AA1EF6C.A9C7613E@uow.edu.au>,
		<3AA1EF6C.A9C7613E@uow.edu.au>; from andrewm@uow.edu.au on Sun, Mar 04, 2001 at 06:31:56PM +1100 <20010304231508.M2565@ftsoj.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cort Dougan wrote:
> 
> I still get huge over-runs with fbdev (much improved, though).

If you're referring to scheduling overruns then yes, you will
still see monstrous ones.  We're still spending great lengths of
time in the kernel, only now we're doing it with interrupts
enabled.  We can still block all tasks for half a second at a time.

This means that if you're telnetting into a machine and someone
cats a big file on the console, the system is completely unusable
until the `cat' completes.

(edit, edit, test, test)

OK, fixed.

> Andrew, are you still working on it?  If so, I'm happy to keep you
> up-to-date on performance WRT Linux/PPC.

Please do.

I don't view this work as part of low-latency, BTW.  Low
latency is a feature.  The interrupt and scheduling
latencies caused by console+fbcon is a bug.


There are new patches at

	http://www.uow.edu.au/~andrewm/linux/console.html

- Fixed a compile warning in i386_ksyms.c

- Include interrupt.h for UP builds

- Fixed a thinko which broke dmesg

- added console_conditional_schedule()

- used console_conditional_schedule() in four places.

  This change allows the kernel to reschedule if needed while
  performing lengthy console operations.   Scheduling latency
  is reduced from 500 milliseconds to 1 millisecond.

- Updated to latest kernels.


I think that's everything fixed.  IWFM with Riva hardware.  If
you still see huge latencies, please let me know how to
reproduce them - it's pretty trivial to fix it with the
new infrastructure.

BTW: the latest lolat patch still applies to 2.4.3-pre2.
People are after me for -ac patches as well, so I'll start
tracking Alan's kernels soon.

BTW2: testing methodology:

- Load netdriver with `debug=7'
- cat many files on VC1
- cat many files on VC2
- run netperf on VC3 to generate vast amounts of console and
  log output in both process and interrupt context
- Madly flick between VCs
  

-
