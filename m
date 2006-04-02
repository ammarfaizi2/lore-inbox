Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWDBIus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWDBIus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWDBIus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:50:48 -0400
Received: from lead.cat.pdx.edu ([131.252.208.91]:58873 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S932178AbWDBIur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:50:47 -0400
Date: Sun, 2 Apr 2006 00:50:30 -0800 (PST)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200604020850.k328oUFC000624@baham.cs.pdx.edu>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: [RFC] install_session_keyring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
In a study of the control flow graph dumps to check that 
an rcu_assign_pointer() with a given argument type has 
preceded a call to rcu_dereference(), I've come across 
install_session_keyring() of security/keys/process_keys.c.  
We note that although no rcu_read_lock() is in place 
locally or in the function's kernel callers, siglock 
likely addresses that.  While the rcu_dereference() would 
indicate a desire for 'old' to persist, synchronize_rcu() 
is called prior to key_put(old) which "disposes of 
reference to a key."  The order of events with a use of 
the copy of the pointer following synchronize_rcu() is 
what I question.

Thanks.
Suzanne

/******************************************************/
/*
 * install a session keyring, discarding the old one
 * - if a keyring is not supplied, an empty one is invented
 */
static int install_session_keyring(struct task_struct *tsk,
                                   struct key *keyring)
{
        unsigned long flags;
        struct key *old;
        char buf[20];
        int ret;

        /* create an empty session keyring */
        if (!keyring) {
                sprintf(buf, "_ses.%u", tsk->tgid);

                keyring = keyring_alloc(buf, tsk->uid, tsk->gid, 1, NULL);
                if (IS_ERR(keyring)) {
                        ret = PTR_ERR(keyring);
                        goto error;
                }
        }
        else {
                atomic_inc(&keyring->usage);
        }

        /* install the keyring */
        spin_lock_irqsave(&tsk->sighand->siglock, flags);
        old = rcu_dereference(tsk->signal->session_keyring);
        rcu_assign_pointer(tsk->signal->session_keyring, keyring);
        spin_unlock_irqrestore(&tsk->sighand->siglock, flags);

        ret = 0;

        /* we're using RCU on the pointer */
        synchronize_rcu();
        key_put(old);
error:
        return ret;

} /* end install_session_keyring() */

