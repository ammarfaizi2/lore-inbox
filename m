Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293277AbSCRXeS>; Mon, 18 Mar 2002 18:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293285AbSCRXd7>; Mon, 18 Mar 2002 18:33:59 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:39415 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293277AbSCRXdt>;
	Mon, 18 Mar 2002 18:33:49 -0500
Date: Mon, 18 Mar 2002 15:33:47 -0800
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: Killing tasklet from interrupt
Message-ID: <20020318153347.A26715@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <Pine.LNX.3.95.1020318153650.29558B-100000@chaos.analogic.com> <20020318115313.A26490@bougret.hpl.hp.com> <Pine.LNX.3.95.1020318153650.29558B-100000@chaos.analogic.com> <20020318125743.A26532@bougret.hpl.hp.com> <5.1.0.14.2.20020318151528.02ed4d70@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 03:20:50PM -0800, Maksim Krasnyanskiy wrote:
> 
> > > You have the tasklet kill itself the next time it executes. Set some
> > > flag so it knows it should give up its timer-slot and expire. The
> > > interrupt sets the flag. It doesn't do anything else.
> >
> >         I already have this flag and my code mostly work like this, so
> >that would be trivial to do.
> >         I looked at the code, and you are right, killing the tasklet
> >within itself is by far the safest way to do it.
> Sounds like what you need is tasklet_disable.
> tasklet_kill needs process context so you can't use it in timer.
> 
> >It's a shame that the code doesn't explitely allow for it (i.e. you will 
> >deadlock every time
> >in tasklet_unlock_wait(t);).
> Use tasklet_disable_nosync within the tasklet itself.
> 
> Max

	Well. I thought about that. Not possible.
	tasklet_disable is not the answer, because if the tasklet was
scheduled, it will stay forever in the tasklet queue. Also, I need to
forget forever about getting rid of the tasklet within the tasklet
itself, because it will just crash.
	Look below, comments by me (you've got to love uncommented
code). So, it's not today that I will use tasklets.

	Regards,

	Jean

P.S. : By the way, regarding flow control between TCP and netdevice
(our previous e-mail exchange with Paul), have you investigated the
effect of skb->destructor; (for example sock_wfree()).

-------------------------------------------------------------

static void tasklet_action(struct softirq_action *a)
{
	int cpu = smp_processor_id();
	struct tasklet_struct *list;

	local_irq_disable();
	list = tasklet_vec[cpu].list;
	tasklet_vec[cpu].list = NULL;
	local_irq_enable();

	while (list) {
		struct tasklet_struct *t = list;

		list = list->next;

		if (tasklet_trylock(t)) {
			if (!atomic_read(&t->count)) {
				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
					BUG();
	// Call tasklet handler
				t->func(t->data);
	// If tasklet was killed/destroyed/kfree above, we will die
				tasklet_unlock(t);
				continue;
			}
			tasklet_unlock(t);
		}

	// Tasklet is disabled, put back in tasklet queue
		local_irq_disable();
		t->next = tasklet_vec[cpu].list;
		tasklet_vec[cpu].list = t;
		__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
		local_irq_enable();
	}
}

