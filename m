Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSLBREk>; Mon, 2 Dec 2002 12:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbSLBREk>; Mon, 2 Dec 2002 12:04:40 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:2758 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264856AbSLBREj>;
	Mon, 2 Dec 2002 12:04:39 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15851.37989.723028.614451@harpo.it.uu.se>
Date: Mon, 2 Dec 2002 18:12:05 +0100
To: Christoph Hellwig <hch@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
In-Reply-To: <20021104223725.A23168@sgi.com>
References: <1033513407.12959.91.camel@phantasy>
	<20021104223725.A23168@sgi.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, Christoph Hellwig wrote:
 > +void set_cpus_allowed(struct task_struct *p, unsigned long new_mask)
 > +{
 > +	new_mask &= cpu_online_map;
 > +	BUG_ON(!new_mask);
 > +
 > +	p->cpus_allowed = new_mask;
 > +
 > +	/*
 > +	 * If the task is on a no-longer-allowed processor, we need to move
 > +	 * it.  If the task is not current, then set need_resched and send
 > +	 * its processor an IPI to reschedule.
 > +	 */
 > +	if (!(p->cpus_runnable & p->cpus_allowed)) {
 > +		if (p != current) {
 > +			p->need_resched = 1;
 > +			smp_send_reschedule(p->processor);
 > +		}
 > +		/*
 > +		 * Wait until we are on a legal processor.  If the task is
 > +		 * current, then we should be on a legal processor the next
 > +		 * time we reschedule.  Otherwise, we need to wait for the IPI.
 > +		 */
 > +		while (!(p->cpus_runnable & p->cpus_allowed))
 > +			schedule();
 > +	}
 > +}

Is this implementation of set_cpus_allowed() Ok for all 2.4 kernels,
even if they (like RH8.0's) use a non-vanilla scheduler?

I'm asking because I need to put a set_cpus_allowed() implementation
in my performance counters driver's compat layer. If it makes any
difference, I'll only use set_cpus_allowed(p, new_mask) when p == current
or p is stopped and under ptrace() control by current.

/Mikael
