Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTFYRmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTFYRmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:42:24 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:62711 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264890AbTFYRmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:42:12 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: <davidm@hpl.hp.com>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Date: Wed, 25 Jun 2003 18:56:43 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAKEDPEHAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <16121.55803.509760.869572@napali.hpl.hp.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

 >> I have no objection to anything along these lines. The 
 >> basic scenario is simply this:
 >>
 >> 1. On ALL architectures except for IA64 and ARM there is
 >>    a SINGLE value for CLOCK_TICK_RATE that is used by
 >>    several GENERIC drivers. Currently, that value is used
 >>    as a MAGIC NUMBER that corresponds to the value in the
 >>    Ix86 case, which is clearly wrong.

 > What do you mean be "generic"?

Not specific to any particular architecture as far as the
location of the file containing the driver code is concerned.
More simply, not located under linux/arch in the kernel tree.

 > AFAIK, the drivers you're talking about all depend on there
 > being an 8259-style PIT. As such, they depend on the 8259
 > and are not generic. This dependency should be made explicit.

In that case, ALL of the drivers in question need to be moved
under the linux/arch tree. Very few are currently there.

 > BTW: I didn't think Alpha derived its clock-tick from the
 > PIT either, but I could be misremembering. Could someone
 > more familiar with Alpha confirm or deny?

I know ZILCH about ALPHA as I've never had or seen one.

 >> 2. According to the IA64 people, those GENERIC drivers
 >>    are apparently irrelevant for that architecture, so
 >>    making the CORRECT change of replacing those magic
 >>    numbers in the GENERIC drivers with the CLOCK_TICK_RATE
 >>    value will make no difference to IA64.

 > That's not precise: _some_ ia64 machines do have legacy hardware
 > and those should be able to use 8259-dependent drivers if they
 > choose to do so.

My comment as quoted above is a summary of the comments made by
the IA64 developers in this thread. I know ZILCH about the IA64
architecture because, as with the ALPHA architecture, I've never
even seen one. I thus have to assume that comments made by the
IA64 maintainers are accurate.

 > Moreover, the current drivers would compile just fine on ia64,
 > even though they could not possibly work correctly with the
 > current use of CLOCK_TICK_RATE. With a separate header file
 > (and a config option), these dependencies would be made
 > explicit and that would improve overall cleanliness.

I agree that the dependencies need to be made explicit. However,
I'm not convinced that a separate header file is justified, much
less needed.

 > In other words, I still think the right way to go about this
 > is to have <asm/pit.h>. On x86, this could be:
 >
 > --
 > #include <asm/timex.h>
 >
 > #define PIT_FREQ	CLOCK_TICK_RATE
 > #define PIT_LATCH	((PIT_FREQ + HZ/2) / HZ)
 > --
 >
 > If you insist, you could even put this in asm-generic, though
 > personally I don't think that's terribly elegant.

The important details are...

 1. The relevant values are in a known header file.

 2. That header file is referenced and the values therein
    are used rather than just using magic numbers.

Personally, I have no problem with which header files are used.
What matters is that inclusion of a specified header file always
defines the relevant values.

 > On ia64, <asm/pit.h> could be:
 > 
 > #ifdef CONFIG_PIT
 > # define PIT_FREQ	1193182
 > # define PIT_LATCH	((PIT_FREQ + HZ/2) / HZ)
 > #endif

You would then need to ensure that if CONFIG_PIT was not defined,
no reference was ever made to either PIT_FREQ or PIT_LATCH which
can easily become ugly code that the maintainers won't touch.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.491 / Virus Database: 290 - Release Date: 18-Jun-2003

