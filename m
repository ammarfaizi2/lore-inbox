Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbUKBPfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUKBPfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUKBPc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:32:28 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:8622 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262201AbUKBPQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:16:31 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16775.42190.9404.303359@thebsh.namesys.com>
Date: Tue, 2 Nov 2004 18:16:30 +0300
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add requeue task
In-Reply-To: <41877F2D.6070200@yahoo.com.au>
References: <418707E5.90705@kolivas.org>
	<41877F2D.6070200@yahoo.com.au>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:
 > Con Kolivas wrote:
 > > add requeue task
 > > 
 > > 
 > > 
 > > ------------------------------------------------------------------------
 > > 
 > > We can requeue tasks for cheaper then doing a complete dequeue followed by
 > > an enqueue. Add the requeue_task function and perform it where possible.
 > > 
 > > Change the granularity code to requeue tasks at their best priority
 > > instead of changing priority while they're running. This keeps tasks at
 > > their top interactive level during their whole timeslice.
 > > 
 > 
 > I wonder... these things are all in sufficiently rarely used places,
 > that the icache miss might be more costly than the operations saved.
 > 
 > But....
 > 
 > > Signed-off-by: Con Kolivas <kernel@kolivas.org>
 > > 
 > > Index: linux-2.6.10-rc1-mm2/kernel/sched.c
 > > ===================================================================
 > > --- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-02 14:48:54.686316718 +1100
 > > +++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-02 14:52:51.805763544 +1100
 > > @@ -579,6 +579,16 @@ static void enqueue_task(struct task_str
 > >  }
 > >  
 > >  /*
 > > + * Put task to the end of the run list without the overhead of dequeue
 > > + * followed by enqueue.
 > > + */
 > > +static void requeue_task(struct task_struct *p, prio_array_t *array)
 > > +{
 > > +	list_del(&p->run_list);
 > > +	list_add_tail(&p->run_list, array->queue + p->prio);
 > > +}

Shouldn't this be

list_move_tail(&p->run_list, array->queue + p->prio);

?

Nikita.
