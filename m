Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWDDJLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWDDJLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWDDJLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:11:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13535 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932396AbWDDJLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:11:14 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200604040213.k342D9kT001230@baham.cs.pdx.edu> 
References: <200604040213.k342D9kT001230@baham.cs.pdx.edu> 
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [RFC] install_session_keyring 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 04 Apr 2006 10:10:41 +0100
Message-ID: <29255.1144141841@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzanne Wood <suzannew@cs.pdx.edu> wrote:

> From P. McKenney's 'What is RCU?': "synchronize_rcu() marks the end of
> updater code and the beginning of reclaimer code. It does this by blocking
> until all pre-existing RCU read-side critical sections on all CPUs have
> completed. Note that synchronize_rcu() will not necessarily wait for any
> subsequent RCU read-side critical sections to complete."
> 
> It seems that once synchronize_rcu() is called, the rcu-protected memory can
> be reclaimed which means available for reuse, so a NULL check wouldn't be
> reliable.

I'm not sure why you think it wouldn't be reliable.

Look at it this way:

 (1) In install_session_keyring(), before going into the critical section, we
     elevate the reference count on the new keyring by one.  This ensures that
     the signal_struct will hold a reference on the new keyring.

 (2) Then, whilst under lock, we replace the pointer to the old session
     keyring with a pointer to the new session keyring, and we leave the
     critical section with a pointer in a local variable to the old keyring.

     On leaving the critical section, the local variable "old" will be NULL if
     there wasn't an old session keyring, and will point to the old session
     keyring if there was one.

     If there _was_ an old session keyring, then there will still be an extra
     reference on it that was used to pin it on behalf of the signal_struct.

 (3) We then wait for all other current RCU-readers to finish doing stuff with
     the old session keyring by calling synchronize_rcu()[*].

     [*] This could probably be skipped if old == NULL.

     Future RCU readers are irrelevant as they'll see the new keyring and not
     the old.

 (4) Then:

     (a) If there _was_ an old session keyring, there'll still be that extra
     	 reference to deal with - so we will need to decrement the reference
     	 count and destroy the keyring if the refcount reaches zero.

     (b) If there _wasn't_ an old session keyring, the old pointer will be
     	 NULL, and we don't do anything more.

> "synchronize_rcu() marks the end of updater code

That's steps (2) and (3) above.

>  and the beginning of reclaimer code

That's step (4).

Why should the NULL-pointer check not be reliable?  Either old is NULL or it
isn't.  This isn't going to change when we call synchronize_rcu() - if it
does, then we've got real problems all over the place, not just here.

synchronize_rcu() acts as a full memory barrier, thus preventing the
atomic_dec_and_test() in key_put() from seeping into the critical section,
though I think this should probably have an smp_mb__before_atomic_dec()
anyway.

> We do find rcu_dereference(tsk->signal->session_keyring) within
> rcu_read_lock()/unlock() pairs (and similarly
> current->signal->session_keyring and context->signal->session_keyring) in
> security/keys/process_keys.c and request_key.c.

Yes, so?

> When synchronize_rcu() reclaims memory, it's because the old references to
> stale data were retained just for the duration of the rcu readside critical
> sections.

synchronize_rcu() doesn't reclaim memory.

And in this specific case, there's no guarantee that the old keyring will be
deleted after synchronize_rcu() is called.  It's quite likely the old keyring
will persist because it's attached to some other task.

The reason that we jump through these hoops here is that it _might_ be the
last reference, but some other thread in the same process may be attempting to
look up a key whilst we're doing this.

> I'm hoping to develop rules to automate a correct application
> of the RCU-API and appreciate your help.  And memory barrier issues 
> specific to different architectures provide complexity.

Don't forget: you should assume the minimum specification anywhere that's
outside of arch specific code.

David
