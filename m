Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSCYTwU>; Mon, 25 Mar 2002 14:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312524AbSCYTwB>; Mon, 25 Mar 2002 14:52:01 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:44461 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S312525AbSCYTv7>;
	Mon, 25 Mar 2002 14:51:59 -0500
Message-ID: <001001c1d436$90abdf70$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Paul Clements" <kernel@steeleye.com>, "Andrew Morton" <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18 raid1 - fix SMP locking/interrupt 
Date: Mon, 25 Mar 2002 20:50:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> However a bare spin_unlock_irq() in a function means that
> callers which wish to keep interrupts disabled are subtly
> subverted.   We've had bugs from this before.
>
It is trivial to catch such bugs at runtime. I tried it a year ago, and
immediately run into sleep_on() users that legitimately call
spin_lock_irq() with disabled interrupts. Perhaps they are gone now,
I'll retest my patch.

> So the irqrestore functions are much more robust.  I believe
> that they should be the default choice.  The non-restore
> versions should be viewed as a micro-optimised version,
> to be used with caution.  The additional expense of the save/restore
> is quite tiny - 20-30 cycles, perhaps.

OTHO, if a function doesn't work correctly if it's called with disabled
interrupts, then it should not use spin_lock_irqsave() - it's
misleading.
e.g. if it calls kmalloc(GFP_KERNEL), down(), schedule(), etc.

--
    Manfred

