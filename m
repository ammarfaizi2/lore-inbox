Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266469AbUG0R02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbUG0R02 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266482AbUG0R02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:26:28 -0400
Received: from zero.aec.at ([193.170.194.10]:12556 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266469AbUG0R0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:26:09 -0400
To: xiphmont@xiph.org (Monty)
cc: linux-kernel@vger.kernel.org
Subject: Re: large, spurious[?] TSC skews on AMD 760MPX boards
References: <2kECV-3a0-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 27 Jul 2004 19:26:04 +0200
In-Reply-To: <2kECV-3a0-3@gated-at.bofh.it> (xiphmont@xiph.org's message of
 "Thu, 22 Jul 2004 07:50:05 +0200")
Message-ID: <m3isc9mker.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xiphmont@xiph.org (Monty) writes:

> Ever since getting my first dual Athlon, the system timer was 'not
> quite right' when running at stock speed.  Selects, alarms, etc, had a
> strange way of firing fractions of a second or several seconds 'too
> late'.  I discovered that overclocking by about 10% made the problem

That points away from the TSC actually. select and alarm use the jiffies
clock, which is managed by the PIT timer in the southbridge. AFAIK
they never rely on the TSC. 

> magically go away.  I've never been entirely comfortable doing that,
> but three dual athlons later (all 760MPX-B2 based boards of different
> makes), it was always the only way to make the problem disappear and I
> didn't think more about it.
>
> Now that I'm on #3, it is not stable at the overclock I need to make
> the system timer problem disappear, so I finally started hunting for
> the cause.  Whenever I run the system stock, I see:
>
> Jul 20 21:48:26 Snotfish kernel: checking TSC synchronization across CPUs: 
> Jul 20 21:48:26 Snotfish kernel: BIOS BUG: CPU#0 improperly initialized, has 6282588 usecs TSC skew! FIXED.
> Jul 20 21:48:26 Snotfish kernel: BIOS BUG: CPU#1 improperly initialized, has -6282588 usecs TSC skew! FIXED.
>
> When the system is running 'properly', that is to say, overclocked:
>
> Jul 21 22:08:01 Snotfish kernel: checking TSC synchronization across CPUs: passed.
>
> This behavior is reproducable on all three of my 760MPX systems (One
> Gigabyte GA-7DPXDW-P, and two MSI K7D Master-L).  The amount of the
> reported skew varies in the stock case, but it's always large.  Note
> that once in a blue moon, the system will come up with no TSC skew at
> stock timings, and the system timer issues seem to disappear.
>
> What is the proper route to go about debugging this problem, as I have
> it bottled up here in a reproducability cage?

Assuming it is the TSC: 

You could write a multithreaded program that polls the TSCs
on your both CPU for a long time and check out the drift rate. 
The kernel will try to fix it at boot time, but it cannot do that when the TSCs
are drifting later.

One way to work around it would be to boot with "notsc". This will
make your gettimeofday() slower and more inaccurate though.

In theory you could resync the TSC in a regularly running timer,
but this would probably be quite some overhead.

Assuming it is not: 

Something is wrong with your PIT timer in the southbridge. Maybe
just run ntpd ?

I know that later AMD chipsets - in particular the 8111 - are somewhat
bad time keepers, which makes it a good idea to run NTP always.

-Andi

