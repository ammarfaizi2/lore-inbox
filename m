Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbUKQSE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbUKQSE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKQR7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:59:00 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:23749 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262443AbUKQRsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:48:54 -0500
Date: Wed, 17 Nov 2004 09:48:53 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: john stultz <johnstul@us.ibm.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux@brodo.de, lkml <linux-kernel@vger.kernel.org>
Subject: summary (Re: [patch] prefer TSC over PM Timer)
In-Reply-To: <1100705495.32698.38.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0411170946410.9434@twinlark.arctic.org>
References: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>
  <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
 <1100705495.32698.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok thanks everyone... i've been educated, and attempted to summarize the 
situation.

if timer_pm is fixed to read the PM timer only once on non-broken systems 
then it is generally the best choice.  it is only at a ~3x disadvantage 
compared to tsc/lapic in that case.

until/unless C3 and deeper resync tsc then it's best not to default to tsc 
even on transmeta.  it would require some co-ordination between timer_tsc 
and ACPI code to know if C3/etc. are enabled, i don't see that 
co-ordination there now.  so it really does seem like adding "clock=tsc" 
to boot is best left to installers/users/not-the-kernel for now.

here's my device summary:

PIT:
- many slow i/o accesses to read
- works everywhere

PM:
- minimum one slow i/o access to read
- measurements on a handful of systems show one PM timer read
  costs ~3x a TSC read.
- kernel presently uses 3 reads as a bug workaround, but can be
  reduced to one read.
- works on ~all hardware less than a few years old

TSC:
- fast read
- on most systems this varies with power mgmt -- and some power mgmt
  occurs "behind-the-scenes" without kernel awareness
- cpufreq is better and better at tracking the changes (but not on SMP?)
- 2.6.10-rc2 disables even more behind-the-scenes power mgmt
- stops counting in C3 (solved? with PIT/PM/RTC read coming out of C3)
- drift possible across nodes in NUMA

local APIC:
- fast read (approx same as TSC)
- enabling lapic causes some dell laptops to crash
- stops counting in C3 (solvable with PIT/PM/RTC read coming out of C3)
- shared with scheduler -- easy to manage today
- can't be shared with scheduler if we add variable scheduler ticks
  (can't read CCR and write ICR atomically -- potential to drift)
- local apic timer ticks are the best choice for scheduling on SMP
  because it allows all the CPU schedulers to be skewed and avoid
  lock conflicts.
- drift possible across nodes in NUMA?

HPET:
- at the moment i know nothing about it (none of my systems have it)

let me know if i've missed anything.

-dean
