Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVF2OPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVF2OPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVF2OPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:15:12 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20955 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262584AbVF2OO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 10:14:59 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: rostedt@goodmis.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: kmalloc without GFP_xxx?
Date: Wed, 29 Jun 2005 17:14:32 +0300
User-Agent: KMail/1.5.4
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506291714.32990.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 16:44, Steven Rostedt wrote:
> 
> On Wed, 29 Jun 2005, Arjan van de Ven wrote:
> > >
> > > but it sets irqs_disabled() IIRC.
> >
> > only spin_lock_irq() and co do.
> > not the simple spin_lock()
> >
> 
> It may be dangerous to use spin_lock with interrupts enabled, since you
> have to make sure that no interrupt ever grabs that lock.  Although I do
> recall seeing a few locks like this.  But even so, you can transfer the
> latency of the interrupts going off while holding that lock to another CPU
> which IMHO is a bad thing.  Also a simple spin_lock would disable

This is why I always use _irqsave. Less error prone.
And locking is a very easy to get 'slightly' wrong, thus
I trade 0.1% of performance for code simplicity.

> preemption with CONFIG_PREEMPT set and that would make in_atomic fail.
> But to implement a kmalloc_auto you would always need to have a preempt
> count.
> 
> I'm not for a kmalloc_auto, but something like it would be useful for a
> function that can work for either context, and just fail nicely if the
> ATOMIC is set and the malloc can't get memory.  A function like this would
> currently have to always use ATOMIC even if it could have used KERNEL for
> some scenarios, since it would suffer the same pitfalls as a kmalloc_auto
> in determining its context.

This is more or less what I meant. Why think about each kmalloc and when you
eventually did get it right: "Aha, we _sometimes_ get called from spinlocked code,
GFP_ATOMIC then" - you still do atomic alloc even if cases when you
were _not_ called from locked code! Thus you needed to think longer and got
code which is worse.
--
vda


