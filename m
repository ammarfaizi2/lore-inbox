Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbSI2TM1>; Sun, 29 Sep 2002 15:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261752AbSI2TM0>; Sun, 29 Sep 2002 15:12:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13283 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261748AbSI2TMZ>;
	Sun, 29 Sep 2002 15:12:25 -0400
Date: Sun, 29 Sep 2002 21:27:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
In-Reply-To: <3D9748BA.5010704@pobox.com>
Message-ID: <Pine.LNX.4.44.0209292117200.25393-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yes, wrt. keventd i was thinking along the same line - but in a different,
perhaps cleaner and simpler direction.

i'd like to introduce the following interfaces:

	- create_work_queue(wq, handler_fn)

	- destroy_work_queue(wq)

	- queue_work(wq, work_fn, work_data)

	- flush_work_queue(wq)

this is an extension of the keventd concept. A work queue is a simplified
interface to create a kernel thread that gets work queued from IRQ and
process contexts. No more, no less.

there would be a number of 'default' work-queues that would be created
upon bootup:

	- &irq_workqueue
	- &io_workqueue

each work queue would get its own separate kernel thread. schedule_task()  
would simply queue to the irq_workqueue. We could make the irq_workqueue's
kernel thread a highprio RT thread, to make it really softirq-alike. (Or
for the very specific case of BH_IMMEDIATE type of stricly IRQ-safe work,
we could add a tasklet that works down this queue.)

There's tons of code within the kernel that can be streamlined this way,
most of the helper threads do this kind of functionality. (I'll post a
patch soon to show how it would look like.)

	Ingo

