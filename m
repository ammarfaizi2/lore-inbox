Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWDDCNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWDDCNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWDDCNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:13:46 -0400
Received: from lead.cat.pdx.edu ([131.252.208.91]:54400 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751437AbWDDCNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:13:46 -0400
Date: Mon, 3 Apr 2006 19:13:09 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200604040213.k342D9kT001230@baham.cs.pdx.edu>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [RFC] install_session_keyring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  > From David Howells Mon Apr  3 12:08:16 2006

  > Suzanne Wood <suzannew@cs.pdx.edu> wrote:

  > > Since RCU is applicable in read intensive environments and I
  > > look for rcu_dereference() on the read side to be paired with
  > > rcu_assign_pointer() on the update side, I wonder if key_put()
  > > might be redundant or risky after synchronize_rcu(),

  > No, it's not redundant, and neither is it risky, at least, not as far as I can
  > tell from the RCU docs.

  > > because key_put() opens with if(key)

  > That's just to permit key_put(NULL) to avoid going splat.

  > > and employs atomic_dec_and_test(&key->usage)) before
  > > schedule_work(&key_cleanup_task).

  > How else does the cleaner-upper know to dispose of the key? And which key?

  > The cleaner scans the entire key tree and weeds out any key that is dead.

  > > If the memory referenced by old has already been reclaimed which appears is
  > > made possible by synchronize_rcu(), it seems that there is a contention
  > > here.

>From P. McKenney's 'What is RCU?': "synchronize_rcu() marks the end of updater 
code and the beginning of reclaimer code. It does this by blocking until all 
pre-existing RCU read-side critical sections on all CPUs have completed. Note 
that synchronize_rcu() will not necessarily wait for any subsequent RCU read-side 
critical sections to complete."

It seems that once synchronize_rcu() is called, the rcu-protected memory
can be reclaimed which means available for reuse, so a NULL check wouldn't be
reliable.

  > It will not be reclaimed until after its refcount is zero, and once that
  > happens, there can't be any other valid links to it.

  > > Yes, so I guess you mean to get rid of 'old' altogether and the three
  > > lines that refer to it.  But I think the original intent was to have
  > > the former session keyring persist to some extent.

  > Sorry, I'm not sure what you mean.

We do find rcu_dereference(tsk->signal->session_keyring) within 
rcu_read_lock()/unlock() pairs (and similarly current->signal->session_keyring 
and context->signal->session_keyring) in security/keys/process_keys.c and 
request_key.c.

  > I can't get rid of "old". I have to exchange the new pointer for the old
  > pointer and then release the old object, otherwise there's a resource leak.

  > However, I think the code should probably be:

  > 	spin_lock_irqsave(&tsk->sighand->siglock, flags);
  > 	old = tsk->signal->session_keyring;
  > 	rcu_assign_pointer(tsk->signal->session_keyring, keyring);
  > 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);

  > The code then calls synchronize_rcu() to make sure no one can then follow that
  > pointer and then releases the reference on it.  Anyone who wants the object to
  > persist beyond the rcu_read_lock()'d region must have incremented the refcount
  > whilst inside that region.  But once the synchronize_rcu() completes, it must
  > be safe for me to release the reference.

When synchronize_rcu() reclaims memory, it's because the old references to stale
data were retained just for the duration of the rcu readside critical sections.

  > It's possible, if not probable, that a memory barrier is required before the
  > atomic_dec_and_test() in key_put().

  > I don't think one is required after an atomic_inc() between rcu_read_lock()
  > and rcu_read_unlock() because I think those need to imply LOCK/UNLOCK barrier
  > semantics.  Maybe Paul McKenney thinks otherwise, though I think I convinced
  > him to agree with me.

  > By the way, the use of schedule_work() to dispose of keys is so that the key
  > destroyer can be relatively slow; it also keeps the latency of key_get() as
  > minimal as possible in the slow case, but that's a lesser consideration.  It
  > also makes the locking simpler.  Note that there is no intention for the key
  > to persist any great length of time after its usage count reaches zero.

  > Note also that the replacement of the session keyring does not suggest that
  > the session keyring will most likely be destroyed; in fact the likelyhood is
  > that it won't.  It's a _session_ keyring, and is most probably going to be
  > shared by quite a few processes.


  > So, to sum up, I think there's three potential problems with my code:

  >  (1) key_put() probably needs smp_mb__before_atomic_dec().

  >  (2) key_get() may need smp_mb__after_atomic_inc() inside of rcu_read_lock()'d
  >      sections, but I don't think that's necessary as the mere fact it's inside
  >      a locked section should obviate that need.

  >  (3) rcu_dereference() is a waste of processing time inside the spinlocks in
  >      install_session_keyring().  It should be a direct dereference.  The
  >      semantics of spin_unlock() should obviate the need for the
  >      smp_read_barrier_depends().

  > But thanks for pointing out the potential problems in my code.  That's much
  > appreciated.  The kernel needs a good memory barrier audit.

  > David

I'm hoping to develop rules to automate a correct application
of the RCU-API and appreciate your help.  And memory barrier issues 
specific to different architectures provide complexity.

Thanks.
Suzanne
