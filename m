Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVAFBnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVAFBnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVAFBnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:43:16 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:63879 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262699AbVAFBm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:42:57 -0500
To: "K.R. Foley" <kr@cybsft.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
From: Mark_H_Johnson@raytheon.com
Subject: Re: Real-Time Preemption, comparison to 2.6.10-mm1
Date: Wed, 5 Jan 2005 16:58:38 -0600
Message-ID: <OF904F641A.CB09BC81-ON86256F80.007E3761-86256F80.007E37F5@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/05/2005 05:23:17 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have a simple way of triggering and trapping the starvation? That
> of course is probably asking for a lot. :)

What I have been doing is now recorded as bug #3997 at
  http://bugme.osdl.org/show_bug.cgi?id=3997
Running latencytest has the advantage of generating some charts
that I can show others how well (or poorly) the system runs.

I just rebooted in SMP and did a few other tests with the following
steps that should be simpler to set up and run.

[1] Create cpu_test.c as follows:

#define LOOPS 100000000
int main() {
  int u, v, k, l;
  for (v=0; v<100; v++) {
    for (u=0; u<LOOPS; u++) {
      k += 1;
      if (!(u%100)) {
      l += 1;
      k = 0;
      }
    }
  }
  return k;
}

On my 866 Mhz Pentium III, it runs for about 3 minutes, 45 seconds.
Adjust the outer loop in the code if you need to run shorter or
longer. I would not run more than 5 minutes - you should easily
get the symptom before then. This also puts a limit of how long
you have to wait if the system gets "stuck" and does not respond
to your keyboard or mouse.

[2] Build the application
  gcc -o cpu_test cpu_test.c

[3] On a two CPU system (or repeat this step N-1 times for
your N cpu system). Run in a separate window...
  chrt -f 10 ./cpu_test

[4] In a separate window...
  nice ./cpu_test

At this point, you should have the system 100% utilized with N-1
real time applications & 1 nice application. I used top to confirm
this result.

[5] In a separate window do one or more of the following:
  a. head -c $1 /dev/zero >tmpfile
  (replacing $1 with about 1.5x your physical memory size
   - this is my "disk write" test)
  b. cp tmpfile tmpfile2
  (this is my "disk copy" test)
  c. cat tmpfile tmpfile2 >/dev/null
  (this is my "disk read" test)
delete the files when done.

It appears (at least on my system) that disk I/O triggers the
problem more than the other tests (x11perf, top [with no delay]).

I was however in an odd situation [just before I sent this message]
where it appeared that the disk copy was OK but I could not
type on any of my windows - mouse entries were OK but not the
keyboard. That may be a different variant of my "starvation
problem".

  --Mark

