Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131624AbRCSVfg>; Mon, 19 Mar 2001 16:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbRCSVf1>; Mon, 19 Mar 2001 16:35:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50960 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131624AbRCSVfS>;
	Mon, 19 Mar 2001 16:35:18 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200103192134.VAA01785@raistlin.arm.linux.org.uk>
Subject: Re: gettimeofday question
To: eli.carter@inet.com (Eli Carter)
Date: Mon, 19 Mar 2001 21:34:06 +0000 (GMT)
Cc: lk@tantalophile.demon.co.uk (Jamie Lokier), linux-kernel@vger.kernel.org
In-Reply-To: <3AB662B0.A3FB2135@inet.com> from "Eli Carter" at Mar 19, 2001 01:49:04 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter writes:
> What are you seeing that I'm missing?

Ok, after sitting down and thinking again about this problem, its not
the 9.9999ms case, but the 10.000000001 case:

First time:
	- interrupts disabled
	- read jiffies
	- read counter
	- jiffies_p != jiffies_t
		- set jiffies_p = jiffies_t
		- set counter_p = counter
	- correction of (latch - counter) applied -> almost a full 10ms
	- interrupts enabled
	- counter rolls over
	- jiffies updated
	- counter is at, or near maximum
	- time returned we'll call "0".

10.0000001ms later:
	- interrupts disabled
	- read jiffies
	- counter rolls over
	- read counter
	- jiffies_p != jiffies_t
		- set jiffies_p = jiffies_t
		- set counter_p = counter
	- correction of (latch - counter) applied -> almost nothing
	- interrupts enabled
	- jiffies updated
	- time returned - "0" + almost nothing

Next read immediately after:
	- interrupts disabled
	- read jiffies
	- read counter
	- jiffies_p != jiffies_t
		- set jiffies_p = jiffies_t
		- set counter_p = counter
	- correction of (latch - counter) applied -> slightly more than
							 almost nothing
	- interrupts enabled
	- time returned - "10ms" + slightly more than almost nothing

Like I say, this requires good timing to create, so may not be too much of
a problem, but it does seem to be a problem that could occur.

I'm wondering if something like the following will plug this hole:

	read_lock_xtime_and_ints();
	jiffies_1 = jiffies;
	counter_1 = counter;
	read_unlock_xtime_and_ints();
	read_lock_xtime_and_ints();
	jiffies_2 = jiffies;
	counter_2 = counter;
	read_unlock_xtime_and_ints();

	if (jiffies_1 != jiffies_2) {
		/*
		 * we rolled over while reading counter_1.  Therefore
		 * we can't trust it.  Use *_2 instead.  Note that we
		 * would have received an interrupt between read_unlock
		 * and read_lock.
		 */
		jiffies_1 = jiffies_2;
		counter_1 = counter_1;
	} else {
		/*
		 * we didn't roll over while reading counter_1
		 * we can safely use counter_1 as is.  Neither
		 * did we receive a timer interrupt between the
		 * read_unlock and read_lock.
		 */
	}

	/* apply standard counter correction factor */

The only thing I haven't looked at is whether xtime would be updated.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

