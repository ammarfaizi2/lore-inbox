Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbTFQXKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264998AbTFQXKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:10:14 -0400
Received: from palrel10.hp.com ([156.153.255.245]:41910 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265002AbTFQXKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:10:10 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16111.41748.667166.867915@napali.hpl.hp.com>
Date: Tue, 17 Jun 2003 16:24:04 -0700
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: davidm@hpl.hp.com, Riley Williams <Riley@Williams.Name>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
In-Reply-To: <20030618011411.A23198@ucw.cz>
References: <16110.4883.885590.597687@napali.hpl.hp.com>
	<BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name>
	<16111.37901.389610.100530@napali.hpl.hp.com>
	<20030618002146.A20956@ucw.cz>
	<16111.38768.926655.731251@napali.hpl.hp.com>
	<20030618004233.B21001@ucw.cz>
	<16111.40816.147471.84610@napali.hpl.hp.com>
	<20030618011411.A23198@ucw.cz>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Jun 2003 01:14:11 +0200, Vojtech Pavlik <vojtech@suse.cz> said:

  >>  Sounds much better to me.  Wouldn't something along the lines of
  >> this make the most sense:

  >> #ifdef __ARCH_PIT_FREQ # define PIT_FREQ __ARCH_PIT_FREQ #else #
  >> define PIT_FREQ 1193182 #endif

  >> After all, it seems like the vast majority of legacy-compatible
  >> hardware _do_ use the standard frequency.

  Vojtech> Now, if this was in some nice include file, along with the
  Vojtech> definition of the i8253 PIT spinlock, that'd be
  Vojtech> great. Because not just the beeper driver uses the PIT,
  Vojtech> also some joystick code uses it if it is available.

ftape, too.  The LATCH() macro should also be moved to such a header
file, I think.  How about just creating asm/pit.h?  Only platforms
that need to (potentially) support legacy hardware would need to
define it.  E.g., on ia64, we could do:

 #ifndef _ASM_IA64_PIT_H
 #define _ASM_IA64_PIT_H

 #include <linux/config.h>

 #ifdef CONFIG_LEGACY_HW
 # define PIT_FREQ	1193182
 # define LATCH		((CLOCK_TICK_RATE + HZ/2) / HZ)
 #endif

 #endif /* _ASM_IA64_PIT_H */

This way, machines that support legacy hardware can define
CONFIG_LEGACY_HW and on others, the macro can be left undefined, so
that any attempt to compile drivers requiring legacy hw would fail to
compile upfront (much better than accessing random ports!).

	--david
