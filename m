Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271344AbRIJRzH>; Mon, 10 Sep 2001 13:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271502AbRIJRy5>; Mon, 10 Sep 2001 13:54:57 -0400
Received: from colorfullife.com ([216.156.138.34]:56845 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S271344AbRIJRyr>;
	Mon, 10 Sep 2001 13:54:47 -0400
Message-ID: <3B9CFE6B.1563125D@colorfullife.com>
Date: Mon, 10 Sep 2001 19:54:51 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
        David Mosberger <davidm@hpl.hp.com>
Subject: Re: [patch] proposed fix for ptrace() SMP race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> BTW, checking this stuff I found two bugs, one is the check for
> cpus_allowed before calling reschedule_idle,

The call in linux/kernel.c, around line 348?
348 if (!synchronous || !(p->cpus_allowed & (1 << smp_processor_id())))
349       reschedule_idle(p);

The test was added for wake_up_{,interruptible_}sync(): if the woken up
task is not permitted to run on the current cpu, reschedule() is
necessary, otherwise skip the reschedule.
If ptrace sets cpus_allowed to 0 between wake_up_sync() and schedule(),
the reschedule is lost. But always rescheduling would defeat the purpose
of wake_up_sync().

--
	Manfred
