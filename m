Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbVLHEPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbVLHEPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 23:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVLHEPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 23:15:42 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:46479 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1030446AbVLHEPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 23:15:41 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200512080411.jB84BAPX010214@sprite.physics.adelaide.edu.au>
Subject: Re: 2.6.14-rt21: slow-running clock
To: johnstul@us.ibm.com (john stultz)
Date: Thu, 8 Dec 2005 14:41:10 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1134012141.10613.81.camel@cog.beaverton.ibm.com> from "john stultz" at Dec 07, 2005 07:22:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2005-12-08 at 13:32 +1030, Jonathan Woithe wrote:
> > > > I'm also wondering whether this might be related to one other thing I
> > > > noticed a week or so back (also reported to the list, but thus far no
> > > > followups). If I enabled the (new) "High resolution timers" feature (as
> > > > distinct from HPET), things like /usr/bin/sleep run for far longer than
> > > > they should irrespective of machine load.  For example, "sleep 1" from bash
> > > > actually delays 38 seconds, not 1 second as expected.
> > > 
> > > Does disabling the "High resolution timers" feature change the behavior
> > > all?
> > 
> > I should clarify.  Everything I've given you thus far has been with the
> > "high resolution timers" feature disabled.  Two or so weeks ago I tried
> > enabling it and that's when "sleep 1" took 38 seconds to complete. 
> > Disabling "high resoltion timers" at least made "sleep 1" behave somewhat
> > saner.  I don't know if having the high res timers enabled affects the
> > accuracy of the system clock however.  I'll test this tonight.
> 
> Ok. I think I've reproduced the issue on my laptop as well. It seems to
> be a -rt issue only (I need to go back and test HRT too) as I do not see
> the problem w/ my B13 patchset. 
> 
> Possibly we are getting preempted before entering or exiting C3 mode?
> I'll need to look further. It isn't directly related to cpu load or
> idleness (a cpu pegged box doesn't drift that badly), but it might be
> io-related. 

Being IO-related is believable based on what I've seen.  In the fault
condition, the system clock averages 5 seconds behind the CMOS clock
immediately after the system has booted (which requires a large amount of
IO).  If the system sits idle not doing anything the drift is almost
non-existant.  Jackd is really good at slowing the system clock down though,
but then again jackd is doing a lot of IO.

All this seems to confirm earlier idea that there are two issues: a slowdown
in the c3tsc timer, and something in RT which causes the selection of the
c3tsc timer ahead of the acpi_pm timer.

Regards
  jonathan
