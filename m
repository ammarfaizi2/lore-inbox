Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTFYHtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 03:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTFYHtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 03:49:10 -0400
Received: from marstons.services.quay.plus.net ([212.159.14.223]:31402 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264082AbTFYHtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 03:49:06 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Vojtech Pavlik" <vojtech@suse.cz>, <davidm@hpl.hp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Date: Wed, 25 Jun 2003 09:03:34 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAIECMEHAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030618013114.A23697@ucw.cz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I have no objection to anything along these lines. The basic scenario
is simply this:

 1. On ALL architectures except for IA64 and ARM there is a SINGLE
    value for CLOCK_TICK_RATE that is used by several GENERIC drivers.
    Currently, that value is used as a MAGIC NUMBER that corresponds
    to the value in the Ix86 case, which is clearly wrong.

 2. According to the IA64 people, those GENERIC drivers are apparently
    irrelevant for that architecture, so making the CORRECT change of
    replacing those magic numbers in the GENERIC drivers with the
    CLOCK_TICK_RATE value will make no difference to IA64.

 3. The ARM architecture has lots of sub-architectures, as was stated
    here. The ARM version of timex.h includes a sub-arch-specific
    header file which, for MOST of the sub-arch's, already defines
    CLOCK_TICK_RATE to what appears to be an appropriate value. The
    only change I made was to apply a catch-all to cover all of the
    sub-arch's that didn't.

The CLOCK_TICK_RATE value should be defined as a result of doing...

	#include <asm/timex.h>

...but I see absolutely nothing wrong with having that file do...

	#include <asm/arch/timex.h>

...and having that in turn include various other include files that
are specific to that architecture, as per your proposal.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.


 > -----Original Message-----
 > From: linux-kernel-owner@vger.kernel.org
 > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Vojtech Pavlik
 > Sent: Wednesday, June 18, 2003 12:31 AM
 > To: davidm@hpl.hp.com
 > Cc: Vojtech Pavlik; Riley Williams; linux-kernel@vger.kernel.org
 > Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ... [8/13]
 >
 >>>>  Sounds much better to me.  Wouldn't something along the lines of
 >>>> this make the most sense:
 >>
 >>>> #ifdef __ARCH_PIT_FREQ # define PIT_FREQ __ARCH_PIT_FREQ #else #
 >>>> define PIT_FREQ 1193182 #endif
 >>
 >>>> After all, it seems like the vast majority of legacy-compatible
 >>>> hardware _do_ use the standard frequency.
 >>
 >>> Now, if this was in some nice include file, along with the
 >>> definition of the i8253 PIT spinlock, that'd be
 >>> great. Because not just the beeper driver uses the PIT,
 >>> also some joystick code uses it if it is available.
 >>
 >> ftape, too.  The LATCH() macro should also be moved to such a header
 >> file, I think.  How about just creating asm/pit.h?  Only platforms
 >> that need to (potentially) support legacy hardware would need to
 >> define it.  E.g., on ia64, we could do:
 >>
 >>	#ifndef _ASM_IA64_PIT_H
 >>	#define _ASM_IA64_PIT_H
 >>
 >>	#include <linux/config.h>
 >>
 >>	#ifdef CONFIG_LEGACY_HW
 >>	# define PIT_FREQ	1193182
 >>	# define LATCH		((CLOCK_TICK_RATE + HZ/2) / HZ)
 >>	#endif
 >>
 >>	#endif /* _ASM_IA64_PIT_H */
 >>
 >> This way, machines that support legacy hardware can define
 >> CONFIG_LEGACY_HW and on others, the macro can be left undefined, so
 >> that any attempt to compile drivers requiring legacy hw would fail to
 >> compile upfront (much better than accessing random ports!).
 >
 > Yes, that looks very good indeed. Riley?

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.491 / Virus Database: 290 - Release Date: 18-Jun-2003

