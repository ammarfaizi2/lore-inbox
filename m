Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVAELJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVAELJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVAELJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:09:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57797 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262323AbVAELJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:09:07 -0500
Date: Wed, 5 Jan 2005 12:08:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, rusty@rustcorp.com.au,
       paulus@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] mm_struct leak on cpu hotplug (s390/ppc64)
Message-ID: <20050105110833.GA14956@elte.hu>
References: <20050104131101.GA3560@osiris.boeblingen.de.ibm.com> <1104892877.8954.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104892877.8954.27.camel@localhost.localdomain>
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


* Nathan Lynch <nathanl@austin.ibm.com> wrote:

> What about something like this?  Tested on ppc64.

>  		migrate_nr_uninterruptible(rq);
>  		BUG_ON(rq->nr_running != 0);
>  
> +		/* Must manually drop reference to avoid leaking mm_structs. */
> +		mmdrop(rq->idle->active_mm);
> +
>  		/* No need to migrate the tasks: it was best-effort if
>  		 * they didn't do lock_cpu_hotplug().  Just wake up
>  		 * the requestors. */

this doesnt look correct to me, because we might end up pulling the rug
(the pagetables) from under the idle task on that CPU. This can happen
in two ways: 1) there's no direct synchronization between a dead CPU
having called into cpu_die() and the downing CPU doing the mmdrop(), so
we might end up dropping it before the idle has entered the final loop
and is still executing kernel code, 2) even when the dead idle task is
already in its final loop there's no generic guarantee that an mmdrop()
can be done - e.g. on x86 the kernel pagetables are mixed up with the
user pagetables and an mmdrop() in case of lazy-TLB might end up zapping
the idle task's pagetables which might break in subtle ways.

the correct solution i think would be to call back into the scheduler
from cpu_die():

void cpu_die(void)
{
        if (ppc_md.cpu_die)
                ppc_md.cpu_die();
+	idle_task_exit();
        local_irq_disable();
        for (;;);
}

and then in idle_task_exit(), do something like:

void idle_task_exit(void)
{
	struct mm_struct *mm = current->active_mm;

	if (mm != &init_mm)
		switch_mm(mm, &init_mm, current);
	mmdrop(mm);
}

(completely untested.) This makes sure that the idle task uses the
init_mm (which always has valid pagetables), and also ensures correct
reference-counting. Hm?

	Ingo
