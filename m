Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWHCPHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWHCPHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWHCPHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:07:45 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:43163 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932454AbWHCPHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:07:44 -0400
Subject: Re: [PATCH] Fix initialization of runqueues
From: Steven Rostedt <rostedt@goodmis.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060802165742.GI4460@implementation.labri.fr>
References: <20060802122743.GF4460@implementation.labri.fr>
	 <20060802152419.GA31970@elte.hu>
	 <20060802165742.GI4460@implementation.labri.fr>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 03 Aug 2006 11:07:37 -0400
Message-Id: <1154617657.32264.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 18:57 +0200, Samuel Thibault wrote:
> Ingo Molnar, le Wed 02 Aug 2006 17:24:19 +0200, a écrit :
> > 
> > * Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> > 
> > > Hi,
> > > 
> > > There's an odd thing about the nr_active field in arrays of 
> > > runqueue_t: it is actually never initialized to 0!...  This doesn't 
> > > yet trigger a bug probably because the way runqueues are allocated 
> > > make it so that it is already initialized to 0, but that's not a safe 
> > > way.  Here is a patch:
> > 
> > we do rely on zero initialization of bss (and percpu) data in a number 
> > of places.
> 
> The rest of runqueue initialization doesn't rely on that, and as
> a result people might think that it is safe to allocate runqueues
> dynamically.

I don't buy the "safe to allocate runqueues dynamically" bit since they
are local to sched.c and if you do do that (I did for a customer once)
you better know what you're doing.

That said, ...

Hmm, Ingo I guess he's right on the first part:

<sched_init snipit>

		rq->nr_running = 0;
[...]

#ifdef CONFIG_SMP
		rq->sd = NULL;
		for (j = 1; j < 3; j++)
			rq->cpu_load[j] = 0;
		rq->active_balance = 0;
		rq->push_cpu = 0;
		rq->migration_thread = NULL;
</sched_init snipit>


So I guess we should add his zero initializer, or we should remove all
the other zero initializers.  Either way, we should be consistent.

-- Steve


