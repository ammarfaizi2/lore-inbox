Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261984AbSJDXOz>; Fri, 4 Oct 2002 19:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261985AbSJDXOz>; Fri, 4 Oct 2002 19:14:55 -0400
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:4879 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S261984AbSJDXOt>; Fri, 4 Oct 2002 19:14:49 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Kristian Hogsberg <hogsberg@users.sourceforge.net>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
References: <Pine.LNX.4.44.0210032028130.2113-100000@localhost.localdomain>
From: Kristian Hogsberg <hogsberg@users.sf.net>
Date: 05 Oct 2002 01:20:09 +0200
In-Reply-To: <Pine.LNX.4.44.0210032028130.2113-100000@localhost.localdomain>
Message-ID: <m3ofa9vljq.fsf@DK300KRH.bang-olufsen.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.9 |November
 16, 2001) at 05-10-2002 01:20:16,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.9 |November 16, 2001) at
 05-10-2002 01:20:24,
	Serialize complete at 05-10-2002 01:20:24
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

[...]

> > create_workqueue()?  Either create a cpu-bound thread for each cpu, or
> > create one thread that can run on all cpus.
> 
> i understand your point, and i really tried to get this problem solved
> prior sending the multiple-workers patch, but it's not really doable
> without major kludges. Is it really a problem on SMP boxes to have a few
> more kernel threads? Those boxes are supposed to have enough RAM.
> 
> the only other way would be to introduce 1) runtime overhead [this sucks]
> or 2) to split the API into per-CPU and global ones. [this isnt too good
> either i think.]
> 
> there is enough flexibility internally - eg. we can in the future do
> better load-balancing (if the XFS people will ever notice any problems in
> this area), because right now the load-balancing is the simplest and
> fastest variant: purely per-CPU. [in theory we could look at other CPU's
> worker queues and queue there if they are empty or much shorter than this
> CPU's worker queue.]
> 
> I also kept open the possibility of introducing multiple worker threads
> per CPU in the future. But having a single-threaded an per-CPU behavior in
> a single API looks quite hard.
> 
> we could perhaps do the following, add a single branch to the queue_work()
> fastpath:
> 
> 	if (!cwq->thread)
> 		cwq = wq->cpu_wq;

Yeah, that was what I was thinking of... if you want to avoid the
branch in the fastpath, we could do something like

struct workqueue_s {
	cpu_workqueue_t *cpu_wq_ptr[NR_CPUS]
	cpu_workqueue_t cpu_wq[NR_CPUS];
};

and initialize the cpu_wq_ptr entries to 

	cpu_wq_ptr[i] = cpu_wq + i

in the multi-threaded case and to

	cpu_wq_ptr[i] = cpu_wq

in the single thread case.  The lookup in queue_work() becomes 

	cpu_workqueue_t *cwq = wq->cpu_wq[cpu];

which costs an extra pointer deref.  Not sure if it's better though.
Alternatively, the !cwq->thread test you're suggesting could be marked
unlikely() so that the multi threaded case which will be used for
performance critical workqueues will be favoured by the compiler.

> and the single-thread queue variant would thus fall back to using a single
> queue only. Plus some sort of new variant could be used:
> 
> 	struct workqueue_struct *create_single_workqueue(char *name);
> 
> [or a 'flags' argument to create_workqueue();]
> 
> The runtime thing looks slightly ugly, but i think it's acceptable. Has
> anyone any better idea?
> 
> > Another minor comment: why do you kmalloc() the workqueue_t?  Wouldn't
> > it be more flexible to allow the user to provide a pointer to a
> > pre-allocated workqueue_t structure, e.g.:
> > 
> >         static workqueue_t aio_wq;
> > 
> >         [...]
> > 
> >                	create_workqueue(&aio_wq, "aio");
> 
> yes, but every creation/destruction use of workqueues is in some sort of
> init/shutdown very-slow-path, so efficiency is not a factor. But clarity
> of the code is a factor, and in the dynamic allocation case it's much
> cleaner to have this:
> 
> 	wq = create_workqueue("worker");
> 	if (!wq)
> 		goto error;
> 
> than:
> 
> 	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
> 	if (!wq)
> 		goto error;
> 	if (create_workqueue(wq, "worker")) {
> 		kfree(w);
> 		goto error;
> 	}

Sure code clarity is the biggest factor here, but I was thinking we
could cut down the number of dynamic allocations.  My guess is that in
the common case, the workqueue_t is either statically allocated (as in
the case of keventd) or embedded in another struct and allocated as
part of that struct:

        struct hpsb_host {
		char *name;
		/* whatnot */

		workqueue_t wq;
	};

	...

	host = kmalloc(sizeof *host, GFP_KERNEL);
	if (!host)
		goto error:

	host->name = "ohci1394";
	workqueue_init(&host->wq, "ieee1394");

best regards,
Kristian

