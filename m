Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVK2Bd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVK2Bd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVK2Bd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:33:59 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14782 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932277AbVK2Bd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:33:58 -0500
Date: Tue, 29 Nov 2005 02:33:58 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
cc: tglx@linutronix.de, mingo@elte.hu, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/9] high precision timer
Message-ID: <Pine.LNX.4.61.0511290232300.2758@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(I forgot to Cc: lkml, so I'll only resend the first mail to all and the 
patches only to the list. Sorry for the extra mails.)

This patch series is a reduced and fixed version of the ktimer patch.
Instead of one large patch it introduces the basic infrastructure via a
few patches, which should be a lot easier to review and it implements
the majority of the functionality with less code.

The main differences are:

- I renamed it to ptimer, which stands now for precise timer (or even
  shorter for high precision timer). ktimer is a rather generic term and
  the k prefix is usually only used to describe something unique to the
  kernel or to distinguish it from a user space counterpart, but we have
  now two timer systems, so that ktimer makes it a bit awkward to talk
  about that other timer system - both are kernel timer.

- interval handling: this causes a big increase in the complexity in the
  ktimer, for bascially just one user - posix timer. I left most of the
  interval code in the users and only provided a generic infrastructure,
  which allows simple interval timers, but leaves enough flexibility at
  how they want implement them.

- resolution handling: although ptimer provides now the basic
  infrastructure for higher resolution, posix timer/itimer still provide
  only the current jiffies resolution and it does so as close as
  possible to old behaviour.  OTOH almost all the jiffies conversion are
  gone now and the common path has only relatively simple 64bit math.
  Proper higher resolution require a better clock abstraction than Linux
  currently has.  (More details are in the ktime_t patch.)

Fixes:

- clock_nanosleep(): interrupted absolute sleeps did modify the return
  value.  The old code didn't and the spec agrees with that.
- the overrun count is not properly updated while the signal is
  disabled.

I hope these patches provide a better base for a discussion of what is
needed for full high resolution timers.
I intentionally kept the ptimer code as simple as possible to make it
easier to reuse, e.g. cpu timers can be converted to ktime_t and that
may make it possible to share same code with ptimer.
IMO further development should concentrate on a better clock
abstraction, hopefully I find now a bit more to help John with the ntp
part of his patches.



