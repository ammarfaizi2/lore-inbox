Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVAXM7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVAXM7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVAXM7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:59:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:32683 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261342AbVAXM67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 07:58:59 -0500
Date: Mon, 24 Jan 2005 13:58:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050124125814.GA31471@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124085902.GA8059@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> [...] "how do we give low latencies to audio applications (and other,
> soft-RT alike applications), while not allowing them to lock up the
> system."

ok, here is another approach, against 2.6.10/11-ish kernels:

  http://redhat.com/~mingo/rt-limit-patches/

this patch adds the /proc/sys/kernel/rt_cpu_limit tunable: the maximum
amount of CPU time all RT tasks combined may use, in percent. Defaults
to 80%.

just apply the patch to 2.6.11-rc2 and you should be able to run e.g. 
"jackd -R" as an unprivileged user.

note that this allows the use of SCHED_FIFO/SCHED_RR policies, without
the need to add any new scheduling classes. The RT CPU-limit acts on the
existing RT-scheduling classes, by adding a pretty simple and
straightforward method of tracking their CPU usage, and limiting them if
they exceed the threshold. As long as the treshold is not violated the
scheduling/latency properties of those scheduling classes remains.

It would be very interesting to see how jackd/jack_test performs with
this patch applied, and rt_cpu_limit is set to different percentages,
compared against unpatched SCHED_FIFO performance.

other properties of rt_cpu_limit:

 - if there's idle time in the system then RT tasks will be
   allowed to use more than the limit. Once SCHED_OTHER tasks
   are present again, the limit is enforced.

 - if an RT task goes above the limit all the time then there
   is no guarantee that exactly the limit will be allowed for
   it. (i.e. you should set the limit to somewhat above the real
   needs of the RT task in question.)

 - zero rt_cpu_limit value means unlimited CPU time to all
   RT tasks.

 - a nonzero rt_cpu_limit value also has the effect of allowing
   the use of RT scheduling classes/priorities for nonprivileged
   users. I.e. a value of 100% differs from a value of 0 in that 0 
   doesnt allow RT priorities for ordinary users.

 - on SMP the limit is measured and enforced per-CPU.

 - runtime overhead is minimal, especially if the limit is set to 0. 

 - the CPU-use measurement code has a 'memory' of roughly 300 msecs. 
   I.e. if an RT task runs 100 msecs nonstop then it will increase 
   its CPU use by about 30%. This should be fast enough for users for 
   the limit to be human-inperceptible, but slow enough to allow
   occasional longer timeslices to RT tasks.

have fun,

	Ingo
