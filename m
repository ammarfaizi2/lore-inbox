Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbSJCS2o>; Thu, 3 Oct 2002 14:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261488AbSJCS2o>; Thu, 3 Oct 2002 14:28:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8399 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261450AbSJCS2m>;
	Thu, 3 Oct 2002 14:28:42 -0400
Date: Thu, 3 Oct 2002 20:44:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <m37kh1vo9d.fsf@DK300KRH.bang-olufsen.dk>
Message-ID: <Pine.LNX.4.44.0210032028130.2113-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Oct 2002, Kristian Hogsberg wrote:

> I read through your patch and I think it looks great.  I'm one of the
> ieee1394 maintainers, and we also a have a worker thread mechanism in
> the ieee1394 subsystem, which could (and will, I'm going to look into
> this) be replaced by your work queue stuff.  We use the thread for
> reading configuration information from ieee1394 devices.  This work
> isn't very performance critical, but the reason we dont just use keventd
> is that we don't want to stall keventd while reading this information.  
> So, my point is, that in this case (I'm sure there are more situations
> like this, usb has a similar worker thread, khubd), the per-cpu worker
> thread is overkill, and it would be sufficient with just one thread,
> running on all cpus.  So maybe this could be an option to
> create_workqueue()?  Either create a cpu-bound thread for each cpu, or
> create one thread that can run on all cpus.

i understand your point, and i really tried to get this problem solved
prior sending the multiple-workers patch, but it's not really doable
without major kludges. Is it really a problem on SMP boxes to have a few
more kernel threads? Those boxes are supposed to have enough RAM.

the only other way would be to introduce 1) runtime overhead [this sucks]
or 2) to split the API into per-CPU and global ones. [this isnt too good
either i think.]

there is enough flexibility internally - eg. we can in the future do
better load-balancing (if the XFS people will ever notice any problems in
this area), because right now the load-balancing is the simplest and
fastest variant: purely per-CPU. [in theory we could look at other CPU's
worker queues and queue there if they are empty or much shorter than this
CPU's worker queue.]

I also kept open the possibility of introducing multiple worker threads
per CPU in the future. But having a single-threaded an per-CPU behavior in
a single API looks quite hard.

we could perhaps do the following, add a single branch to the queue_work()
fastpath:

	if (!cwq->thread)
		cwq = wq->cpu_wq;

and the single-thread queue variant would thus fall back to using a single
queue only. Plus some sort of new variant could be used:

	struct workqueue_struct *create_single_workqueue(char *name);

[or a 'flags' argument to create_workqueue();]

The runtime thing looks slightly ugly, but i think it's acceptable. Has
anyone any better idea?

> Another minor comment: why do you kmalloc() the workqueue_t?  Wouldn't
> it be more flexible to allow the user to provide a pointer to a
> pre-allocated workqueue_t structure, e.g.:
> 
>         static workqueue_t aio_wq;
> 
>         [...]
> 
>                	create_workqueue(&aio_wq, "aio");

yes, but every creation/destruction use of workqueues is in some sort of
init/shutdown very-slow-path, so efficiency is not a factor. But clarity
of the code is a factor, and in the dynamic allocation case it's much
cleaner to have this:

	wq = create_workqueue("worker");
	if (!wq)
		goto error;

than:

	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
	if (!wq)
		goto error;
	if (create_workqueue(wq, "worker")) {
		kfree(w);
		goto error;
	}

[and we might even switch to a workqueue SLAB cache internally anytime.]

	Ingo

