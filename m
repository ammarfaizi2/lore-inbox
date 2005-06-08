Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVFHDXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVFHDXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVFHDXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:23:02 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:21406 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262090AbVFHDSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:18:14 -0400
Subject: Re: 2.6.12-rc6-mm1
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, mbligh@mbligh.org,
       lkml <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20050607170853.3f81007a.akpm@osdl.org>
References: <1004450000.1118188239@flay>
	 <20050607165656.2517b417.akpm@osdl.org>
	 <Pine.LNX.4.62.0506071659580.30849@schroedinger.engr.sgi.com>
	 <20050607170853.3f81007a.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 13:17:18 +1000
Message-Id: <1118200638.10122.6.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 17:08 -0700, Andrew Morton wrote: 
> Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> > On Tue, 7 Jun 2005, Andrew Morton wrote:
> > 
> > > > Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).
> > > 
> > > Oh crap, so it does.  That's wrong.
> > 
> > Email by you and Linus indicated that 250 should be the default.
> 
> Oh, OK. hrm.
> 
> Martin, it would be useful if you could determine whether the kernbench
> slowdown was due to the 1000Hz->250Hz change, thanks.
> 
> I'm assuming it was the CPU scheduler patches.  There are 36 of them ;)


I'm looking at some issues with the scheduler patches.

To start with, it looks like the smp-nice patches are broken. Even if
they weren't I think it might be a good idea just to put them on hold
until we work out what to do with the other sched patches... we're
only just starting to get some interesting tests (ie. regressions) being
run on -mm (at least that I've been made aware of). So give me a bit of
time to work though that.

Anyway, Con, this is what it is doing on a 64-way Altix running aim7:
(compare imbalances, task move rates, wakeup move rates, etc).


--- wakeup statistics ---
  269.174 task wakes / s
    31.704% of them from the local CPU
    14.190% of remote wakeups come from domain0
      0.000% are moved to the local CPU via passive load balancing
      26.660% are moved to the local CPU via affine wakeups
    46.672% of remote wakeups come from domain1
      10.359% are moved to the local CPU via passive load balancing
      0.000% are moved to the local CPU via affine wakeups
    39.012% of remote wakeups come from domain2
      10.659% are moved to the local CPU via passive load balancing
      0.000% are moved to the local CPU via affine wakeups

--- load balancing statistics ---
  for domain0
    4368.652 load balance calls / s move 137.083 tasks / s
      96.456% calls and 1.174% task moves came from idle balancing
        0.042% were imbalanced with an average imbalance of 566.708
        0.038% found an imbalance but failed
        6.165% of tasks moved were cache hot
      1.818% calls and 73.086% task moves came from busy balancing
        47.694% were imbalanced with an average imbalance of 335.932
        4.704% found an imbalance but failed
        0.140% of tasks moved were cache hot
      1.726% calls and 25.740% task moves came from new-idle balancing
        26.938% were imbalanced with an average imbalance of 198.054
        9.136% found an imbalance but failed
        0.151% of tasks moved were cache hot
    0.000 active balances / s  move 0.000 tasks / s
    0.000 exec balances / s  move 0.000 tasks / s
    0.000 fork balances / s  move 0.000 tasks / s
                                                                                                                                                             
  for domain1
    102.002 load balance calls / s move 180.344 tasks / s
      85.398% calls and 17.496% task moves came from idle balancing
        5.920% were imbalanced with an average imbalance of 386.172
        2.103% found an imbalance but failed
        0.920% of tasks moved were cache hot
      14.602% calls and 82.504% task moves came from busy balancing
        69.017% were imbalanced with an average imbalance of 702.928
        5.849% found an imbalance but failed
        0.075% of tasks moved were cache hot
      0.000% calls and 0.000% task moves came from new-idle balancing
    0.048 active balances / s  move 0.002 tasks / s
      %95.000 attempts failed
    0.000 exec balances / s  move 0.000 tasks / s
    0.000 fork balances / s  move 0.000 tasks / s
                                                                                                                                                             
  for domain2
    9.496 load balance calls / s move 13.070 tasks / s
      91.335% calls and 32.327% task moves came from idle balancing
        21.094% were imbalanced with an average imbalance of 115.513
        16.936% found an imbalance but failed
        2.978% of tasks moved were cache hot
      8.665% calls and 67.673% task moves came from busy balancing
        64.118% were imbalanced with an average imbalance of 503.867
        17.353% found an imbalance but failed
        0.383% of tasks moved were cache hot
      0.000% calls and 0.000% task moves came from new-idle balancing
    0.007 active balances / s  move 0.007 tasks / s
      %0.000 attempts failed
    0.000 exec balances / s  move 0.000 tasks / s
    0.000 fork balances / s  move 0.000 tasks / s

And this is what it looks like with smpnice #if'ed out: 
--- wakeup statistics ---
  331.734 task wakes / s
    25.492% of them from the local CPU
    13.601% of remote wakeups come from domain0
      0.000% are moved to the local CPU via passive load balancing
      1.674% are moved to the local CPU via affine wakeups
    44.484% of remote wakeups come from domain1
      3.139% are moved to the local CPU via passive load balancing
      0.000% are moved to the local CPU via affine wakeups
    42.088% of remote wakeups come from domain2
      0.000% are moved to the local CPU via passive load balancing
      0.000% are moved to the local CPU via affine wakeups
 
--- load balancing statistics ---
  for domain0
    3940.070 load balance calls / s move 3.671 tasks / s
      96.488% calls and 48.889% task moves came from idle balancing
        0.068% were imbalanced with an average imbalance of 1.132
        0.029% found an imbalance but failed
        3.135% of tasks moved were cache hot
      1.339% calls and 33.563% task moves came from busy balancing
        2.319% were imbalanced with an average imbalance of 1.037
        0.069% found an imbalance but failed
        0.228% of tasks moved were cache hot
      2.173% calls and 17.548% task moves came from new-idle balancing
        1.259% were imbalanced with an average imbalance of 1.008
        0.516% found an imbalance but failed
        3.057% of tasks moved were cache hot
    0.006 active balances / s  move 0.006 tasks / s
      %0.000 attempts failed
    0.000 exec balances / s  move 0.000 tasks / s
    0.000 fork balances / s  move 0.000 tasks / s
 
  for domain1
    86.378 load balance calls / s move 2.644 tasks / s
      94.236% calls and 89.468% task moves came from idle balancing
        4.116% were imbalanced with an average imbalance of 1.123
        1.597% found an imbalance but failed
        4.281% of tasks moved were cache hot
      5.764% calls and 10.532% task moves came from busy balancing
        6.667% were imbalanced with an average imbalance of 1.008
        1.130% found an imbalance but failed
        0.000% of tasks moved were cache hot
      0.000% calls and 0.000% task moves came from new-idle balancing
    0.082 active balances / s  move 0.017 tasks / s
      %79.310 attempts failed
    0.000 exec balances / s  move 0.000 tasks / s
    0.000 fork balances / s  move 0.000 tasks / s
 
  for domain2
    9.024 load balance calls / s move 0.343 tasks / s
      95.293% calls and 88.525% task moves came from idle balancing
        12.103% were imbalanced with an average imbalance of 1.003
        8.701% found an imbalance but failed
        14.815% of tasks moved were cache hot
      4.707% calls and 11.475% task moves came from busy balancing
        16.556% were imbalanced with an average imbalance of 1.000
        7.285% found an imbalance but failed
        21.429% of tasks moved were cache hot
      0.000% calls and 0.000% task moves came from new-idle balancing
    0.008 active balances / s  move 0.008 tasks / s
      %0.000 attempts failed
    0.000 exec balances / s  move 0.000 tasks / s
    0.000 fork balances / s  move 0.000 tasks / s


-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
