Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWDCQLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWDCQLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWDCQLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:11:54 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:22982 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751749AbWDCQLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:11:54 -0400
Date: Mon, 3 Apr 2006 09:11:16 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200604031611.k33GBGAF022737@murzim.cs.pdx.edu>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [RFC] install_session_keyring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  > From David Howells Mon Apr  3 01:46:08 2006

  > Suzanne Wood <suzannew@cs.pdx.edu> wrote:

  > > In a study of the control flow graph dumps to check that 
  > > an rcu_assign_pointer() with a given argument type has 
  > > preceded a call to rcu_dereference(), I've come across 
  > > install_session_keyring() of security/keys/process_keys.c.  
  > > We note that although no rcu_read_lock() is in place 
  > > locally or in the function's kernel callers, siglock 
  > > likely addresses that.  While the rcu_dereference() would 
  > > indicate a desire for 'old' to persist, synchronize_rcu() 
  > > is called prior to key_put(old) which "disposes of 
  > > reference to a key."  The order of events with a use of 
  > > the copy of the pointer following synchronize_rcu() is 
  > > what I question.

  > Are you simply suggesting that the rcu_dereference() in:

  > 	/* install the keyring */
  >        	spin_lock_irqsave(&tsk->sighand->siglock, flags);
  >        	old = rcu_dereference(tsk->signal->session_keyring);
  >        	rcu_assign_pointer(tsk->signal->session_keyring, keyring);
  >        	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);

  > is unnecessary?

Since RCU is applicable in read intensive environments and I
look for rcu_dereference() on the read side to be paired with
rcu_assign_pointer() on the update side, I wonder if key_put()
might be redundant or risky after synchronize_rcu(), because 
key_put() opens with if(key) and employs atomic_dec_and_test(&key->usage)) 
before schedule_work(&key_cleanup_task).  If the memory referenced 
by old has already been reclaimed which appears is made possible by 
synchronize_rcu(), it seems that there is a contention here.

Yes, so I guess you mean to get rid of 'old' altogether and the three
lines that refer to it.  But I think the original intent was to have
the former session keyring persist to some extent.
Thanks.
Suzanne 

  > If so, I think you are right since the pointer is only changed with the
  > siglock held[*], and so modify/modify conflict isn't a problem and doesn't
  > need memory barriers.

  > [*] Apart from during the exit() cleanup, when I don't think this should be a
  > problem anyway.

  > David

