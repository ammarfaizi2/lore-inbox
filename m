Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264972AbTFQWWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbTFQWWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:22:05 -0400
Received: from palrel11.hp.com ([156.153.255.246]:2457 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264972AbTFQWUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:20:30 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16111.38768.926655.731251@napali.hpl.hp.com>
Date: Tue, 17 Jun 2003 15:34:24 -0700
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: davidm@hpl.hp.com, Riley Williams <Riley@Williams.Name>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
In-Reply-To: <20030618002146.A20956@ucw.cz>
References: <16110.4883.885590.597687@napali.hpl.hp.com>
	<BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name>
	<16111.37901.389610.100530@napali.hpl.hp.com>
	<20030618002146.A20956@ucw.cz>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Jun 2003 00:21:46 +0200, Vojtech Pavlik <vojtech@suse.cz> said:

  Vojtech> It seems to be used for making beeps, even on that
  Vojtech> architecture.

Don't confuse architecture and implementation.  There are _some_
machines (implementations) which have legacy support.  But the
architecture is explicitly designed to allow for legacy-free machines,
as is the case for the hp zx1-based machines, for example.

It seems to me that input/misc/pcspkr.c is doing the Right Thing:

	count = 1193182 / value;

        spin_lock_irqsave(&i8253_beep_lock, flags);

        if (count) {
                /* enable counter 2 */
                outb_p(inb_p(0x61) | 3, 0x61);
                /* set command for counter 2, 2 byte write */
                outb_p(0xB6, 0x43);
                /* select desired HZ */
                outb_p(count & 0xff, 0x42);
                outb((count >> 8) & 0xff, 0x42);

so if a legacy speaker is present, it assumes a particular frequency.
In other words: it's a driver issue.  On ia64, this frequency
certainly has nothing to do with time-keeping and therefore doesn't
belong in timex.h.

	--david
