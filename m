Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWHCEsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWHCEsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHCEsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:48:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:21980 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932225AbWHCEsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:48:06 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: Esben Nielsen <nielsen.esben@googlemail.com>
Subject: Re: [-rt] Fix race condition and following BUG in PI-futex
Date: Wed, 2 Aug 2006 21:48:00 -0700
User-Agent: KMail/1.9.1
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0608011931560.10605@localhost.localdomain> <1154466456.30391.12.camel@localhost.localdomain> <Pine.LNX.4.64.0608020007350.10605@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0608020007350.10605@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608022148.01297.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 16:28, you wrote:
> On Tue, 1 Aug 2006, Steven Rostedt wrote:
> > On Tue, 2006-08-01 at 13:22 -0700, Darren Hart wrote:
> >>>>   	list_del_init(&pi_state->owner->pi_state_list);
> >>>>   	list_add(&pi_state->list, &new_owner->pi_state_list);
> >>>>   	pi_state->owner = new_owner;
> >>>> +	atomic_inc(&pi_state->refcount);
> >>>
> >>> There really needs to be a get_pi_state() or some variant. Having to do
> >>> a manual atomic_inc is very dangerous.
> >>
> >> I understand the need to grab the wait_lock in order to serialize
> >> rt_mutex_next_owner(), but why the addition of of the atomic_inc() and
> >> the free_pi_state() ?  And if we do need them, shouldn't we place them
> >> around the use of the pi_state, rather than just before the unlock
> >> calls?
> >
> > Hmm, is the inc really needed?  The hb->lock is held through this and
> > the pi_state can't go away while that lock is held.
>
> I was going to ask about that... If you say so they can go. I just added
> the inc/dec to be sure.

So the only thing that frees the pi_state is free_pi_state and it's only 
caller is unqueue_me_pi() which must be called with hb->lock held, so since
we already hold it, I think we're fine without the inc/free lines (as Steven
already said).  The following patch has the lines removed.

The direct use of the rt_mutex wait_lock seems a little out of place here, as
it "ought to be" restricted to rt_mutex.c.  Perhaps some kind of an "atomic"
rt_mutex_set_next_owner() call could abstract this away from futex.c?  I 
confess I don't see a way to do that without putting futex internals into
rt_mutex.c... so not really any better.


Index: 2.6.17-rt8/kernel/futex.c
===================================================================
--- 2.6.17-rt8.orig/kernel/futex.c	2006-08-02 20:29:42.000000000 -0700
+++ 2.6.17-rt8/kernel/futex.c	2006-08-02 21:39:17.000000000 -0700
@@ -565,6 +565,7 @@
 	if (!pi_state)
 		return -EINVAL;
 
+	spin_lock(&pi_state->pi_mutex.wait_lock);
 	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
 
 	/*
@@ -598,6 +599,8 @@
 	list_del_init(&pi_state->owner->pi_state_list);
 	list_add(&pi_state->list, &new_owner->pi_state_list);
 	pi_state->owner = new_owner;
+
+	spin_unlock(&pi_state->pi_mutex.wait_lock);
 	rt_mutex_unlock(&pi_state->pi_mutex);
 
 	return 0;



-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
