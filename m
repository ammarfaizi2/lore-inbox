Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbTFSBat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265685AbTFSBat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:30:49 -0400
Received: from fmr02.intel.com ([192.55.52.25]:40684 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265681AbTFSBar convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:30:47 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DD16D38@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>
Cc: "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	sks
Date: Wed, 18 Jun 2003 18:44:42 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Morton [mailto:akpm@digeo.com]
> 
> Various things like character drivers do rely upon keventd services.  So
it
> is possible that bash is stuck waiting on keyboard input, but there is no
> keyboard input because keventd is locked out.
> 
> I'll take a closer look at this, see if there is a specific case which can
> be fixed.
> 
> Arguably, keventd should be running max-prio RT because it is a kernel
> service, providing "process context interrupt service".

Now that we are at that, it might be wise to add a higher-than-anything
priority that the kernel code can use (what would be 100 for user space,
but off-limits), so even FIFO 99 code in user space cannot block out
the migration thread, keventd and friends.

> IIRC, Andrea's kernel runs keventd as SCHED_FIFO.  I've tried to avoid
> making this change for ideological reasons ;) Userspace is more important
> than the kernel and the kernel has no damn right to be saying "oh my stuff
> is so important that it should run before latency-critical user code".

I agree with that, but the consequence is kind of ugly; not that a true
real-time embedded process is going to be printing to the console, but 
it might be outputting to a serial line, so now they rely on the keventd.

BTW, I have seen similar problems wrt to the migration thread, where a
FIFO 20 process would get stuck in CPU1, that is taken by a FIFO 40
while CPU0 was running a FIFO 10 -- however, I am not that positive
that it is a migration thread problem; I blame it more on the scheduler
not taking into account priorities for firing the load balancer. It is
a tricky thingie, though. Affinity helps, in this case.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
