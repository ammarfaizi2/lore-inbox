Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278887AbRKIAX2>; Thu, 8 Nov 2001 19:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278890AbRKIAXS>; Thu, 8 Nov 2001 19:23:18 -0500
Received: from [208.129.208.52] ([208.129.208.52]:8452 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278887AbRKIAXO>;
	Thu, 8 Nov 2001 19:23:14 -0500
Date: Thu, 8 Nov 2001 16:31:32 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <Pine.LNX.4.33.0111081341400.8863-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0111081606380.1501-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Ingo Molnar wrote:

[...]

I finally took a look at the patch and i think that it completely change
dynamic priority assignments.
Dynamic priorities will only 1) increase 2) drop to zero
I'm not sure what could be the effect of this on the scheduler behavior.
The patch, as is, has the advantage over CPU history to not add an extra
"if () {}" inside the goodness() function but, without doing something
like :

weight = p->counter;

+if (p->processor != this_cpu)
+	weight -= p->timer_ticks;

you're going to take poor SMP tasks moving decisions, expecially with the
actual :

static inline void add_to_runqueue(struct task_struct * p)
{
    list_add(&p->run_list, &runqueue_head);
    nr_running++;
}

that inserts tasks at runqueue head ( it'll be the first that will be
picked up ).
With this extra "if () {}" you're going to have the same fast path cost of
the CpuHistory patch.




- Davide


