Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbTFYSff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbTFYSff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:35:35 -0400
Received: from palrel11.hp.com ([156.153.255.246]:30848 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264860AbTFYSfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:35:21 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16121.61110.19751.332978@napali.hpl.hp.com>
Date: Wed, 25 Jun 2003 11:49:26 -0700
To: "Riley Williams" <Riley@Williams.Name>
Cc: <davidm@hpl.hp.com>, "Vojtech Pavlik" <vojtech@suse.cz>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
In-Reply-To: <BKEGKPICNAKILKJKMHCAKEDPEHAA.Riley@Williams.Name>
References: <16121.55803.509760.869572@napali.hpl.hp.com>
	<BKEGKPICNAKILKJKMHCAKEDPEHAA.Riley@Williams.Name>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 25 Jun 2003 18:56:43 +0100, "Riley Williams" <Riley@Williams.Name> said:

  >> AFAIK, the drivers you're talking about all depend on there
  >> being an 8259-style PIT. As such, they depend on the 8259
  >> and are not generic. This dependency should be made explicit.

  Riley> In that case, ALL of the drivers in question need to be moved
  Riley> under the linux/arch tree. Very few are currently there.

Not at all.  It's completely standard to have drivers in
linux/drivers/ which may never be enabled for certain platforms.  Or
what's the last time an x86 PC used an Sun SBUS driver?

  >>> 2. According to the IA64 people, those GENERIC drivers
  >>> are apparently irrelevant for that architecture, so
  >>> making the CORRECT change of replacing those magic
  >>> numbers in the GENERIC drivers with the CLOCK_TICK_RATE
  >>> value will make no difference to IA64.

  >> That's not precise: _some_ ia64 machines do have legacy hardware
  >> and those should be able to use 8259-dependent drivers if they
  >> choose to do so.

  Riley> My comment as quoted above is a summary of the comments made by
  Riley> the IA64 developers in this thread. I know ZILCH about the IA64
  Riley> architecture because, as with the ALPHA architecture, I've never
  Riley> even seen one. I thus have to assume that comments made by the
  Riley> IA64 maintainers are accurate.

You seem to fail to realize that I _am_ the ia64 linux tree maintainer.
What does it take for you to believe me?

  >> Moreover, the current drivers would compile just fine on ia64,
  >> even though they could not possibly work correctly with the
  >> current use of CLOCK_TICK_RATE. With a separate header file
  >> (and a config option), these dependencies would be made
  >> explicit and that would improve overall cleanliness.

  Riley> I agree that the dependencies need to be made explicit.

Good.

  Riley> However, I'm not convinced that a separate header file is
  Riley> justified, much less needed.

timex.h definitely is the wrong place.  If you know of a better place
(other than <asm/pit.h>), I'm all ears.

  >> In other words, I still think the right way to go about this
  >> is to have <asm/pit.h>. On x86, this could be:
  >>
  >> --
  >> #include <asm/timex.h>
  >>
  >> #define PIT_FREQ	CLOCK_TICK_RATE
  >> #define PIT_LATCH	((PIT_FREQ + HZ/2) / HZ)
  >> --
  >>
  >> If you insist, you could even put this in asm-generic, though
  >> personally I don't think that's terribly elegant.

  Riley> The important details are...

  Riley> 1. The relevant values are in a known header file.

  Riley> 2. That header file is referenced and the values therein
  Riley> are used rather than just using magic numbers.

I have no problem with that.

  Riley> Personally, I have no problem with which header files are used.
  Riley> What matters is that inclusion of a specified header file always
  Riley> defines the relevant values.

Can we then agree to just create <asm/pit.h> and be done with it?

  >> On ia64, <asm/pit.h> could be:

  >> #ifdef CONFIG_PIT
  >> # define PIT_FREQ	1193182
  >> # define PIT_LATCH	((PIT_FREQ + HZ/2) / HZ)
  >> #endif

  Riley> You would then need to ensure that if CONFIG_PIT was not defined,
  Riley> no reference was ever made to either PIT_FREQ or PIT_LATCH which
  Riley> can easily become ugly code that the maintainers won't touch.

Thanks to the new Kbuild, it's very easy: just add a "depends on PIT"
for drivers that depend on the PIT (I think that's primarily ftape and
the drivers/input/misc/{pc,98}spkr.c.

	--david
