Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267563AbRGXPU5>; Tue, 24 Jul 2001 11:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267565AbRGXPUr>; Tue, 24 Jul 2001 11:20:47 -0400
Received: from [216.156.138.34] ([216.156.138.34]:63748 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S267563AbRGXPUi>;
	Tue, 24 Jul 2001 11:20:38 -0400
Message-ID: <000b01c11454$233a0d60$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Russ Lewis" <russ@deming-os.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Safely giving up a lock before sleeping
Date: Tue, 24 Jul 2001 17:20:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> If I implement this by calling spin_unlock_irqrestore() immediately
> followed by interruptible_sleep_on(), then I have a race condition
> where I could release the lock and immediately have a bottom half
> handler on another processor grab it, put data in the queue, and wake
> the wait queue.  My original (user-side) process then happily goes
> to sleep, unaware that new information is available.

DO NOT use sleep_on in new code.
The correct replacement is wait_event() in <linux/wait.h> if the
spinlock is a normal (i.e. non-irq) spinlock.

Your spinlock is probably a spin_lock_irq() or spin_lock_bh() lock, then
you must build your own wait_event() wrapper.
check <linux/raid/md_k.h> for a wrapper with spin_lock_irq
(wait_event_lock_irq)

The mouse driver sample in linux/documentation also explains the correct
way to release a lock and schedule.

--
    Manfred



