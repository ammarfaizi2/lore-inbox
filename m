Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRBEMjA>; Mon, 5 Feb 2001 07:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbRBEMit>; Mon, 5 Feb 2001 07:38:49 -0500
Received: from mail.inup.com ([194.250.46.226]:20745 "EHLO www.inup.com")
	by vger.kernel.org with ESMTP id <S129290AbRBEMio>;
	Mon, 5 Feb 2001 07:38:44 -0500
Date: Mon, 5 Feb 2001 13:38:37 +0100
From: christophe barbe <christophe.barbe@inup.com>
To: linux-kernel@vger.kernel.org
Subject: IRQ and sleep_on
Message-ID: <20010205133837.A485@pc8.inup.com>
In-Reply-To: <20010205131154.I31876@pc8.inup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010205131154.I31876@pc8.inup.com>; from 
 christophe.barbe@inup.com on lun, fév 05, 200
 1 at 13:11:54 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've missed the thread "avoiding bad sleeps" last week. I've had a similar problem and I would like to discuss the solution I've used to avoid it.

I want to wake up a sleeping process from an IRQ handler. In the process, if I use a interruptible_sleep_on(), I need first to restore flags (otherwise the process will sleep forever). 

restore_flags(flags);
// <<== here IRQ handler possibly call wake_up()
interruptible_sleep_on(&my_queue);

If I first enable interrupts and then call sleep_on, sometimes (often) the wake_up is called (due to a pending interrupt) when the wait_queue is empty.
I've written a modified version of  interruptible_sleep_on which takes an additionnal argument : flags to be restored.

my_interruptible_sleep_on(&my_queue, flags);

It seems to be ok. I've no more bad sleeps or more exactly rarely and that why I submit this to you. Is my way to do it correct ?
I've joined at the end of this mail the modified function.

Thanks,
Christophe Barbé

long my_interruptible_sleep_on_timeout(struct wait_queue **p, long timeout, unsigned long oflags)
{
	unsigned long flags;
	struct wait_queue wait;

	current->state = TASK_INTERRUPTIBLE;

// SLEEP_ON_HEAD
	wait.task = current;
	write_lock_irq(&waitqueue_lock);
	__add_wait_queue(p, &wait);
	write_unlock(&waitqueue_lock);

	restore_flags(oflags);
	timeout = schedule_timeout(timeout);

// SLEEP_ON_TAIL
	write_lock_irqsave(&waitqueue_lock,flags);
	__remove_wait_queue(p, &wait);
	write_unlock_irqrestore(&waitqueue_lock,flags);

	return timeout;
}

-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
