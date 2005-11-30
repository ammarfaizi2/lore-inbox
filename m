Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVK3XvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVK3XvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVK3XvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:51:19 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23970
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751273AbVK3XvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:51:18 -0500
Subject: [patch 00/43] ktimer reworked
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 00:56:58 +0100
Message-Id: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch series is a refactored version of the ktimer-subsystem patch.

firstly, we fixed two bugs noticed by Roman Zippel (and mentioned in the 
ptimer patch-queue):

- clock_nanosleep(): interrupted absolute sleeps are now handled
  correctly

- overrun accounting in posix interval timers is fixed.

furthermore, we have split the ktimer patch series up into 23 patches - 
each stage introduces one new (and mostly small) conceptual step. Each 
stage builds & boots fine. The ktimer design has not been changed 
radically, but some improvements and reshaping has been done in the 
course of the rework.

based on the idea from Roman Zippel, we have eliminated the 'pure scalar 
type' in ktime.h, and have gone for the ktime union for both 32-bit and 
64-bit platforms. This resulted in further simplifications, e.g. the 
ktime_cmp() ugliness has been removed.

to address the naming debate: we do agree that 'struct ktimer' and 
'struct timer_list' is confusing and awkward - both are about timers.  
Same goes for kernel/ktimer.c and kernel/timer.c.

but what we'd like to achieve as an end-result is the clear separation 
of 'timer' vs. 'timeout' APIs. Our proposed end result would be to have 
'struct ktimer' for timers, and 'struct ktimeout' for timeouts.

to prove the feasibility of this separation, we have also included 
another 20 patches ontop of the ktimer patch-queue, which patches 
introduce the 'ktimeout' types and APIs. This is mostly a careful 
renaming and refactoring of the current 'struct timer_list' and APIs 
into a 'struct ktimeout' object and API. (see the patches for details) 
These patches too build & boot at every stage.

we have done this to show that the 'ktimer' vs. 'timer_list' confusion 
is only temporary, and that the intended end-result is 'struct ktimer' 
and 'struct ktimeout' - two separate concepts.

on the other hand, 'struct ptimer' and 'struct ktimeout' [or 'struct 
ptimer' and 'struct timer_list'] would be just as confusing.

here's a list of other differences to the ptimer patchqueue:

- ptimer.c is smaller, for the price of making users of the APIs more
  complex. ktimer.c carries more features and thus more code, so that
  users can have simpler code.

  these features are not unconditional: we tried to be careful to not
  let 'cruft' creep into ktimer.c: e.g. quite some Posix 'special timer
  code' is still kept in posix-timers.c.

  Right now the extra code in ktimer.c is roughly offset by the code
  reduction in posix-timers.c, itimer.c and timer.c/ktimeout.c, and we
  have not converted posix-cpu-timers to ktimers yet. So we believe this
  choice of us is a net win, even with the relative low number of
  ktimer users at this early stage.

- the ktimer subsystem is designed with the extensibility for high
  resolution timers and dynamic ticks in mind, without having to do
  further rewrites. The practical feasibility and cleanliness of the
  ktimer approach has been proven since the very beginning, both the
  -khrt and the -rt trees have carried those patches for months now,
  with a real HRT implementation ontop of it. We believe that some
  details that the ptimers patch-queue chopped off the ktimers codebase
  will have to be reintroduced for HRT timers later on.

- the resolution handling is implemented without any jiffy relations and
  resembles the behaviour of the current implementation. The first view
  of more complexity has to be carefully weighed against the flexibility
  for further extensions.

- ktimer is fully docbook documented and well commented. The ptimer
  patchqueue was based off an older ktimer tree with less comments and
  no documentation.

if there are any other substantial differences between the ptimer
patchqueue and the current ktimer queue then please speak up. (there
was no documentation of all ktimer->ptimer changes, so we might have
missed something)

the patchset has been compiled & booted against recent -linus trees, on 
x86 and x64.

The patch series is also available from 
http://www.tglx.de/projects/ktimers/patch-2.6.15-rc2-kt-rework.tar.bz2

	Thomas, Ingo

--

