Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSGKU16>; Thu, 11 Jul 2002 16:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSGKU15>; Thu, 11 Jul 2002 16:27:57 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:54281 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S315806AbSGKU14>;
	Thu, 11 Jul 2002 16:27:56 -0400
Message-ID: <3D2DEB91.57FA34E6@tv-sign.ru>
Date: Fri, 12 Jul 2002 00:33:21 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rml@tech9.net
Subject: Q: preemptible kernel and interrupts consistency.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Documentation/preempt-locking.txt states, that
disabled interrupts prevents preemption.

Well, unless process does not touch TIF_NEED_RESCHED.
Consider:

        // preempt_count == 0
        local_irq_disable();
        set_tsk_need_resched(current);
        preempt_disable();
        preempt_enable();

We fall into the schedule() - possible preemtion,
interruppts ENABLED in any case.

Note that this may be implicit, for example:

        __cli();
        wake_up(q);
                // spin_lock_irqsave(&q->lock, flags)
                // __wake_up_common() - sets need_resched                
                // spin_unlock_irqrestore(q->lock, flags)
                //      spin_unlock()
                //              preempt_enable()
                //                      irq_handler: I WAS HERE!!!
                //                      possible preemtion
                //      local_irq_restore() - too late

Or I am just stupid?

Oleg.
