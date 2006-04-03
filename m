Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWDCIqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWDCIqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWDCIqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:46:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48296 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751414AbWDCIqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:46:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200604020850.k328oUFC000624@baham.cs.pdx.edu> 
References: <200604020850.k328oUFC000624@baham.cs.pdx.edu> 
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [RFC] install_session_keyring 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Mon, 03 Apr 2006 09:45:35 +0100
Message-ID: <1279.1144053935@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzanne Wood <suzannew@cs.pdx.edu> wrote:

> In a study of the control flow graph dumps to check that 
> an rcu_assign_pointer() with a given argument type has 
> preceded a call to rcu_dereference(), I've come across 
> install_session_keyring() of security/keys/process_keys.c.  
> We note that although no rcu_read_lock() is in place 
> locally or in the function's kernel callers, siglock 
> likely addresses that.  While the rcu_dereference() would 
> indicate a desire for 'old' to persist, synchronize_rcu() 
> is called prior to key_put(old) which "disposes of 
> reference to a key."  The order of events with a use of 
> the copy of the pointer following synchronize_rcu() is 
> what I question.

Are you simply suggesting that the rcu_dereference() in:

	/* install the keyring */
       	spin_lock_irqsave(&tsk->sighand->siglock, flags);
       	old = rcu_dereference(tsk->signal->session_keyring);
       	rcu_assign_pointer(tsk->signal->session_keyring, keyring);
       	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);

is unnecessary?

If so, I think you are right since the pointer is only changed with the
siglock held[*], and so modify/modify conflict isn't a problem and doesn't
need memory barriers.

[*] Apart from during the exit() cleanup, when I don't think this should be a
problem anyway.

David

