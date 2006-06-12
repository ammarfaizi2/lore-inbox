Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWFLMoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWFLMoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWFLMoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:44:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54401 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750714AbWFLMoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:44:18 -0400
Date: Mon, 12 Jun 2006 08:44:06 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: NPTL mutex and the scheduling priority
Message-ID: <20060612124406.GZ3115@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp> <1150115008.3131.106.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150115008.3131.106.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 02:23:28PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-06-12 at 17:10 +0900, Atsushi Nemoto wrote:
> > # This is a copy of message posted libc-alpha ML.  I want to hear from
> > # kernel people too ...
> > 
> > Hi.  I found that it seems NPTL's mutex does not follow the scheduling
> > parameter.  If some threads were blocked by getting a single
> > mutex_lock, I expect that a thread with highest priority got the lock
> > first, but current NPTL's behaviour is different.
> \
> 
> you want to use the PI futexes that are in 2.6.17-rc5-mm tree

Even for normal mutices pthread_mutex_unlock and
pthread_cond_{signal,broadcast} is supposed to honor the RT priority and
scheduling policy when waking up:
http://www.opengroup.org/onlinepubs/009695399/functions/pthread_mutex_trylock.html
"If there are threads blocked on the mutex object referenced by mutex when
pthread_mutex_unlock() is called, resulting in the mutex becoming available,
the scheduling policy shall determine which thread shall acquire the mutex."
and similarly for condvars.
"Use PI" is not a valid answer for this.
Really FUTEX_WAKE/FUTEX_REQUEUE can't use a FIFO.  I think there was a patch
floating around to use a plist there instead, which is one possibility,
another one is to keep the queue sorted by priority (and adjust whenever
priority changes - one thread can be waiting on at most one futex at a
time).

	Jakub
