Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSGTRv0>; Sat, 20 Jul 2002 13:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSGTRv0>; Sat, 20 Jul 2002 13:51:26 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:268 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S317454AbSGTRv0>;
	Sat, 20 Jul 2002 13:51:26 -0400
Message-ID: <3D39A48C.C0863416@tv-sign.ru>
Date: Sat, 20 Jul 2002 21:57:32 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> - to remove the preemption count increase/decrease code from the lowlevel
>   IRQ assembly code.

So do_IRQ() can start with preempt_count == 0.
Suppose another cpu sets TIF_NEED_RESCHED flag
at the same time.

spin_lock(&desc->lock) sets preempt_count == 1.
Before calling handle_IRQ_event() (which adds IRQ_OFFSET
to preempt_count), do_IRQ() does spin_unlock(&desc->lock)
and falls into schedule().

Am I missed something?

It seems to me that call to irq_enter() must be shifted
from handle_IRQ_event() to do_IRQ().

Oleg.
