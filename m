Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317905AbSGKUjH>; Thu, 11 Jul 2002 16:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317906AbSGKUjG>; Thu, 11 Jul 2002 16:39:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53233 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317905AbSGKUjE>; Thu, 11 Jul 2002 16:39:04 -0400
Subject: Re: Q: preemptible kernel and interrupts consistency.
From: Robert Love <rml@tech9.net>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D2DEB91.57FA34E6@tv-sign.ru>
References: <3D2DEB91.57FA34E6@tv-sign.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Jul 2002 13:41:47 -0700
Message-Id: <1026420107.1178.279.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-11 at 13:33, Oleg Nesterov wrote:

> Documentation/preempt-locking.txt states, that
> disabled interrupts prevents preemption.
> 
> Well, unless process does not touch TIF_NEED_RESCHED.

Yes, you are right, if need_resched is set under you, you will preempt
off the last unlock, even if interrupts are disabled.

However, the only places that set need_resched like that are the
scheduler and they do so also under lock so we are safe.

Also, in your example, being in an interrupt handler bumps the
preempt_count so even the scenario you give will not cause a
preemption.  If we did not bump the unlock, then your example would give
a lot of "scheduling in interrupt" BUGs so we would know it ;-)

All that said, there is a bug: the send_reschedule IPI can set
need_resched on another CPU.  If the other CPU happens to have
interrupts disabled, we can in fact preempt.  I have a patch for this I
will submit shortly.

	Robert Love

