Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbTFQW2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbTFQW2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:28:51 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:25274 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264978AbTFQW2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:28:41 -0400
Date: Wed, 18 Jun 2003 00:42:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: davidm@hpl.hp.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, Riley Williams <Riley@Williams.Name>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030618004233.B21001@ucw.cz>
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <16111.37901.389610.100530@napali.hpl.hp.com> <20030618002146.A20956@ucw.cz> <16111.38768.926655.731251@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16111.38768.926655.731251@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Tue, Jun 17, 2003 at 03:34:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 03:34:24PM -0700, David Mosberger wrote:
> >>>>> On Wed, 18 Jun 2003 00:21:46 +0200, Vojtech Pavlik <vojtech@suse.cz> said:
> 
>   Vojtech> It seems to be used for making beeps, even on that
>   Vojtech> architecture.
> 
> Don't confuse architecture and implementation.  There are _some_
> machines (implementations) which have legacy support.  But the
> architecture is explicitly designed to allow for legacy-free machines,
> as is the case for the hp zx1-based machines, for example.
> 
> It seems to me that input/misc/pcspkr.c is doing the Right Thing:
> 
> 	count = 1193182 / value;
> 
>         spin_lock_irqsave(&i8253_beep_lock, flags);
> 
>         if (count) {
>                 /* enable counter 2 */
>                 outb_p(inb_p(0x61) | 3, 0x61);
>                 /* set command for counter 2, 2 byte write */
>                 outb_p(0xB6, 0x43);
>                 /* select desired HZ */
>                 outb_p(count & 0xff, 0x42);
>                 outb((count >> 8) & 0xff, 0x42);
> 
> so if a legacy speaker is present, it assumes a particular frequency.
> In other words: it's a driver issue.  On ia64, this frequency
> certainly has nothing to do with time-keeping and therefore doesn't
> belong in timex.h.

I'm quite fine with that. However, different (sub)archs, for example the
AMD Elan CPUs have a slightly different base frequency. So it looks like
an arch-dependent #define is needed. I don't care about the location
(timex.h indeed seems inappropriate, maybe the right location is
pcspkr.c ...), or the name, but something needs to be done so that the
beeps have the same sound the same on all archs.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
