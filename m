Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264694AbTFYRHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbTFYRHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:07:48 -0400
Received: from palrel13.hp.com ([156.153.255.238]:31467 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264694AbTFYRGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:06:55 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16121.55803.509760.869572@napali.hpl.hp.com>
Date: Wed, 25 Jun 2003 10:20:59 -0700
To: "Riley Williams" <Riley@Williams.Name>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <davidm@hpl.hp.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
In-Reply-To: <BKEGKPICNAKILKJKMHCAIECMEHAA.Riley@Williams.Name>
References: <20030618013114.A23697@ucw.cz>
	<BKEGKPICNAKILKJKMHCAIECMEHAA.Riley@Williams.Name>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 25 Jun 2003 09:03:34 +0100, "Riley Williams" <Riley@Williams.Name> said:

  Riley> Hi all.
  Riley> I have no objection to anything along these lines. The basic scenario
  Riley> is simply this:

  Riley> 1. On ALL architectures except for IA64 and ARM there is a SINGLE
  Riley> value for CLOCK_TICK_RATE that is used by several GENERIC drivers.
  Riley> Currently, that value is used as a MAGIC NUMBER that corresponds
  Riley> to the value in the Ix86 case, which is clearly wrong.

What do you mean be "generic"?  AFAIK, the drivers you're talking
about all depend on there being an 8259-style PIT.  As such, they
depend on the 8259 and are not generic.  This dependency should be
made explicit.

BTW: I didn't think Alpha derived its clock-tick from the PIT either,
but I could be misremembering.  Could someone more familiar with Alpha
confirm or deny?

  Riley> 2. According to the IA64 people, those GENERIC drivers are apparently
  Riley> irrelevant for that architecture, so making the CORRECT change of
  Riley> replacing those magic numbers in the GENERIC drivers with the
  Riley> CLOCK_TICK_RATE value will make no difference to IA64.

That's not precise: _some_ ia64 machies do have legacy hardware and
those should be able to use 8259-dependent drivers if they choose to
do so.

Moreover, the current drivers would compile just fine on ia64, even
though they could not possibly work correctly with the current use of
CLOCK_TICK_RATE.  With a separate header file (and a config option),
these dependencies would be made explicit and that would improve
overall cleanliness.

In other words, I still think the right way to go about this is to
have <asm/pit.h>.  On x86, this could be:

--
#include <asm/timex.h>

#define PIT_FREQ	CLOCK_TICK_RATE
#define PIT_LATCH	((PIT_FREQ + HZ/2) / HZ)
--

If you insist, you could even put this in asm-generic, though
personally I don't think that's terribly elegant.

On ia64, <asm/pit.h> could be:

#ifdef CONFIG_PIT
# define PIT_FREQ	1193182
# define PIT_LATCH	((PIT_FREQ + HZ/2) / HZ)
#endif

	--david
