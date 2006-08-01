Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWHAVHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWHAVHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWHAVHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:07:54 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27641 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750748AbWHAVHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:07:53 -0400
Subject: Re: [-rt] Fix race condition and following BUG in PI-futex
From: Steven Rostedt <rostedt@goodmis.org>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200608011322.53638.dvhltc@us.ibm.com>
References: <Pine.LNX.4.64.0608011931560.10605@localhost.localdomain>
	 <1154456580.25983.25.camel@localhost.localdomain>
	 <200608011322.53638.dvhltc@us.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 17:07:36 -0400
Message-Id: <1154466456.30391.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 13:22 -0700, Darren Hart wrote:

> > >
> > >   	list_del_init(&pi_state->owner->pi_state_list);
> > >   	list_add(&pi_state->list, &new_owner->pi_state_list);
> > >   	pi_state->owner = new_owner;
> > > +	atomic_inc(&pi_state->refcount);
> >
> > There really needs to be a get_pi_state() or some variant. Having to do
> > a manual atomic_inc is very dangerous.
> 
> I understand the need to grab the wait_lock in order to serialize 
> rt_mutex_next_owner(), but why the addition of of the atomic_inc() and the 
> free_pi_state() ?  And if we do need them, shouldn't we place them around the 
> use of the pi_state, rather than just before the unlock calls?

Hmm, is the inc really needed?  The hb->lock is held through this and
the pi_state can't go away while that lock is held.

-- Steve


