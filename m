Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbUJ1G5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbUJ1G5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbUJ1Gys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:54:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56775 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262787AbUJ1GyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:54:15 -0400
Date: Thu, 28 Oct 2004 08:55:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Magnus Naeslund(t)" <mag@fbab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041028065523.GA10488@elte.hu>
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041027130359.GA6203@elte.hu> <41801622.5040207@fbab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41801622.5040207@fbab.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Magnus Naeslund(t) <mag@fbab.net> wrote:

> I'm testing out this patch on an debian box. There seems to be a
> problem with enable_irq in the e100 driver that makes the network to
> b0rk.

this e100 driver warning seems mostly harmless - i get it too and the
device works just fine.

> What information do you need to get something useful out of this? I
> saw that others have this problem, so I've got an serial console to
> the box, if you want me to do any tests, tell me how.

even just using it and reporting any potential breakages you get during
bootup or normal use would be very useful. I'd suggest to initially
enable all the relevant debugging options:

 CONFIG_DEBUG_PREEMPT=y
 CONFIG_PREEMPT_TIMING=y
 CONFIG_PREEMPT_TRACE=y
 CONFIG_LATENCY_TRACE=y
 CONFIG_MCOUNT=y
 CONFIG_RWSEM_DEADLOCK_DETECT=y
 CONFIG_RWSEM_MAX_OWNERS=32
 CONFIG_DEBUG_INFO=y
 CONFIG_EARLY_PRINTK=y

this will slow the kernel down but in case of problems there is a much
higher chance of getting a useful assert on the serial console and not
some silent lockup.

if things look good for normal use then a bit advanced type of testing
would be to enable the wakeup-latency tracer:

  echo 4 > /proc/sys/kernel/tracing_enabled
  echo 5 > /proc/sys/kernel/preempt_max_latency

this will measure the highest wakeup latency of highprio tasks, starting
at 5 microseconds. You'll get a short 1-line notification of the latest
latency in the syslog, and the latest trace will always be available in
/proc/latency_trace. Depending on the speed of the system, 'larger'
latencies should be reported to me. 'larger' means more than 20 usecs on
a 2 GHz box or more than 40 usecs on a 1 GHz box. (Dont worry about
reporting duplicates, i can skip them quickly.)

then if things are still looking good (i'm not betting on it though :-),
you could try various stesstests, running LTP's:

	./runalltests.sh -x 20

and things like that. If you have a stable system then it would also be
nice to try to trigger as high wakeup-latencies as possible. E.g. run a
couple of thousand tasks on it, or try to start as many mozilla
instances, or make it go into heavy swapping. I.e. if the core is ok,
explore the edges a bit. The kernel is supposed to offer very low
(wakeup-) latencies no matter what the load. [this doesnt mean your
system will necessarily feel fast - if it's running lots of tasks, even
if the highest prio one is woken up quickly, then it's gonna be slow.]

	Ingo
