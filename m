Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTAAAXF>; Tue, 31 Dec 2002 19:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbTAAAXF>; Tue, 31 Dec 2002 19:23:05 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:61348
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S264908AbTAAAXD> convert rfc822-to-8bit; Tue, 31 Dec 2002 19:23:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: scott thomason <scott@thomasons.org>
Reply-To: scott@thomasons.org
To: Robert Love <rml@tech9.net>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Impact of scheduler tunables on interactive response (was Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio)
Date: Tue, 31 Dec 2002 18:31:29 -0600
User-Agent: KMail/1.4.3
References: <200212200850.32886.conman@kolivas.net> <3E0253D9.94961FB@digeo.com> <1040341293.2521.71.camel@phantasy>
In-Reply-To: <1040341293.2521.71.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212311831.29124.scott@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Around mid-December, Con, rml, & akpm had a discussion about whether 
or not the scheduler tunables were a good thing for interactive 
responsiveness. Andrew was of the opinion that the interactivity 
estimator judged poorly too often and introduced noticeable lags to 
the interactive experience. To combat this, he fiddled with the 
tunable knobs in an attempt to basicly turn off the interactive 
estimation.

I wrote a program that emulates a varying but constant set of loads 
with a fixed amount of sleep() time in the hopes that it would appear 
"interactive" to the estimator. The program measures the time it 
takes to process each iteration (minus the time it spends sleeping). 
Then I tried seven different configurations of the tunables while the 
system was under load. The kernel was 2.5.53-mm2. The load was a 
continuously looping kernel make -j4 clean/make -j4 bzImage, and a 
continuously looping copy of a 100MB file. My system is a dual AMD 
MP2000 with 1GB RAM.

*IF* the test program is valid--something I would like feedback 
on!--the results show that you can attack the background load with 
aggressive tunable settings to achieve low interactive response 
times, contrary to the direction Andrew had suggested taking for 
tunable settings.

The seven tunable configurations, a graph of the results, and the raw 
data are here:

    http://www.thomasons.org/int_res.html

Tab-delimited text and OpenOffice spreadsheets of the data are here:

    http://www.thomasons.org/int_res.txt
    http://www.thomasons.org/int_res.sxc

I would like to assemble a small suite of tools that can be used to 
measure the impact of kernel changes on interactive performance, 
starting with Mark Hahn's/Andrew's "realfeel" microbenchmark and 
moving up thru whatever else may be necessary to gauge real-life 
impact. Your comments and direction are very welcome.

This test program is:

#!/usr/bin/perl

use strict;
use warnings;

use Time::HiRes qw/sleep time/;
use IO::File;

use constant OBS    => 5000;
use constant SLEEP  => 0.3;
use constant MEMLOW => 04 * 1024 * 1024;
use constant MEMINC => 2  * 1024 * 1024;
use constant MEMHI  => 30 * 1024 * 1024;

my $m     = MEMHI;

for (my $x = 0; $x < OBS; $x++) {
  my $start = time();
  
  $m += MEMINC;
  if ($m > MEMHI) { 
    $m = MEMLOW;
  }
  my $mem   = 'x' x $m; ## Touch a little memory

  sleep(SLEEP);
  
  $mem = undef;         ## Release the memory
  my $fh = IO::File->new_tmpfile or die "Can't get temp file handle!";
  my $m2 = $m * .02;    ## Write 2% of the memory allocation to disk
  print $fh 'x' x $m2;
  $fh = undef;

  my $elapsed = (time() - $start) - SLEEP;
  printf("%07.4f\n", $elapsed);  ## Capture to tenths of ms - sleep
}

exit 0;



On Thursday 19 December 2002 05:41 pm, Robert Love wrote:
> On Thu, 2002-12-19 at 18:18, Andrew Morton wrote:
> > That is too often not the case.
>
> I knew you would say that!
>
> > I can get the desktop machine working about as comfortably
> > as 2.4.19 with:
> >
> > # echo 10 > max_timeslice
> > # echo 0 > prio_bonus_ratio
> >
> > ie: disabling all the fancy new scheduler features :(
> >
> > Dropping max_timeslice fixes the enormous stalls which happen
> > when an interactive process gets incorrectly identified as a
> > cpu hog.  (OK, that's expected)
>
> Curious why you need to drop max_timeslice, too.  Did you do that
> _before_ changing the interactivity estimator?  Dropping
> max_timeslice closer to min_timeslice would do away with a lot of
> effect of the interactivity estimator, since bonuses and penalties
> would be less apparent.
>
> There would still be (a) the improved priority given to interactive
> processes and (b) the reinsertion into the active away done to
> interactive processes.
>
> Setting prio_bonus_ratio to zero would finish off (a) and (b).  It
> would also accomplish the effect of setting max_timeslice low,
> without actually doing it.
>
> Thus, can you try putting max_timeslice back to 300?  You would
> never actually use that range, mind you, except for niced/real-time
> processes.  But at least then the default timeslice would be a
> saner 100ms.
>
> > I don't expect the interactivity/cpuhog estimator will ever work
> > properly on the desktop, frankly.  There will always be failure
> > cases when a sudden swing in load causes it to make the wrong
> > decision.
> >
> > So it appears that to stem my stream of complaints we need to
> > merge scheduler_tunables.patch and edit my /etc/rc.local.
>
> I am glad sched-tune helped identify and fix the issue.  I would
> have no problem merging this to Linus.  I actually have a 2.5.52
> patch out which is a bit cleaner - it removes the defines
> completely and uses the new variables.  More proper for the long
> term.  Feel free to push what you have, too.
>
> But that in no way precludes not fixing what we have, because good
> algorithms should not require tuning for common cases.  Period.
>
> 	Robert Love
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

