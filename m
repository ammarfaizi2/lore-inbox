Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752029AbWFLPTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbWFLPTm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbWFLPTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:19:42 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:60060 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1752029AbWFLPTm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:19:42 -0400
Subject: Re: NPTL mutex and the scheduling priority
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Pierre PEIFFER <pierre.peiffer@bull.net>
In-Reply-To: <20060612124406.GZ3115@devserv.devel.redhat.com>
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp>
	 <1150115008.3131.106.camel@laptopd505.fenrus.org>
	 <20060612124406.GZ3115@devserv.devel.redhat.com>
Date: Mon, 12 Jun 2006 17:24:28 +0200
Message-Id: <1150125869.3835.12.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/06/2006 17:23:21,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/06/2006 17:23:22,
	Serialize complete at 12/06/2006 17:23:22
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 08:44 -0400, Jakub Jelinek wrote:
> On Mon, Jun 12, 2006 at 02:23:28PM +0200, Arjan van de Ven wrote:
> > On Mon, 2006-06-12 at 17:10 +0900, Atsushi Nemoto wrote:
> > > # This is a copy of message posted libc-alpha ML.  I want to hear from
> > > # kernel people too ...
> > > 
> > > Hi.  I found that it seems NPTL's mutex does not follow the scheduling
> > > parameter.  If some threads were blocked by getting a single
> > > mutex_lock, I expect that a thread with highest priority got the lock
> > > first, but current NPTL's behaviour is different.
> > \
> > 
> > you want to use the PI futexes that are in 2.6.17-rc5-mm tree
> 
> Even for normal mutices pthread_mutex_unlock and
> pthread_cond_{signal,broadcast} is supposed to honor the RT priority and
> scheduling policy when waking up:
> http://www.opengroup.org/onlinepubs/009695399/functions/pthread_mutex_trylock.html
> "If there are threads blocked on the mutex object referenced by mutex when
> pthread_mutex_unlock() is called, resulting in the mutex becoming available,
> the scheduling policy shall determine which thread shall acquire the mutex."
> and similarly for condvars.
> "Use PI" is not a valid answer for this.
> Really FUTEX_WAKE/FUTEX_REQUEUE can't use a FIFO.  I think there was a patch
> floating around to use a plist there instead, which is one possibility,
> another one is to keep the queue sorted by priority (and adjust whenever
> priority changes - one thread can be waiting on at most one futex at a
> time).
> 

  The patch you refer to is at
http://marc.theaimsgroup.com/?l=linux-kernel&m=114725326712391&w=2

  But maybe a better solution for condvars would be to implement
something like a futex_requeue_pi() to handle the broadcast and
only use PI futexes all along in glibc.

  Any ideas?

  Sébastien.




