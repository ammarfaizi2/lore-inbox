Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVDKWpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVDKWpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVDKWpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:45:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6599 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261979AbVDKWoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:44:44 -0400
Date: Mon, 11 Apr 2005 15:45:00 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, Michael A Halcrow <mahalcro@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Keys: Use RCU to manage session keyring pointer
Message-ID: <20050411224500.GB1304@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <29204.1111608899@redhat.com> <29827.1111611346@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29827.1111611346@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 08:55:46PM +0000, David Howells wrote:
> 
> The attached patch uses RCU to manage the session keyring pointer in struct
> signal_struct. This means that searching need not disable interrupts and get a
> the sighand spinlock to access this pointer. Furthermore, by judicious use of
> rcu_read_(un)lock(), this patch also avoids the need to take and put refcounts
> on the session keyring itself, thus saving on even more atomic ops.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

This looks quite good!  A few questions interspersed below.

						Thanx, Paul

PS.  Sorry to be so slow in getting to this one!

> ---
> warthog>diffstat -p1 keys-rcu-session-2612rc1mm1.diff 
>  security/keys/process_keys.c |   42 +++++++++++++++++++++---------------------
>  security/keys/request_key.c  |    7 +++----
>  2 files changed, 24 insertions(+), 25 deletions(-)
> 
> diff -uNrp linux-2.6.12-rc1-mm1-keys-umhelper/security/keys/process_keys.c linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/process_keys.c
> --- linux-2.6.12-rc1-mm1-keys-umhelper/security/keys/process_keys.c	2005-03-23 17:22:46.000000000 +0000
> +++ linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/process_keys.c	2005-03-23 18:27:12.055768099 +0000
> @@ -1,6 +1,6 @@
>  /* process_keys.c: management of a process's keyrings
>   *
> - * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
> + * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
>   * Written by David Howells (dhowells@redhat.com)
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -181,7 +181,7 @@ static int install_process_keyring(struc
>  			goto error;
>  		}
>  
> -		/* attach or swap keyrings */
> +		/* attach keyring */
>  		spin_lock_irqsave(&tsk->sighand->siglock, flags);
>  		if (!tsk->signal->process_keyring) {
>  			tsk->signal->process_keyring = keyring;
> @@ -227,12 +227,14 @@ static int install_session_keyring(struc
>  
>  	/* install the keyring */
>  	spin_lock_irqsave(&tsk->sighand->siglock, flags);
> -	old = tsk->signal->session_keyring;
> -	tsk->signal->session_keyring = keyring;
> +	old = rcu_dereference(tsk->signal->session_keyring);

I don't understand why rcu_dereference() is needed in this case.
Since we are holding the lock, it should not be possible for
this to change, right?  Or am I missing something?  (Quite possible,
am not all that familiar with this code.)

> +	rcu_assign_pointer(tsk->signal->session_keyring, keyring);
>  	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
>  
>  	ret = 0;
>  
> +	/* we're using RCU on the pointer */
> +	synchronize_kernel();

This would want to become synchronize_rcu().

>  	key_put(old);
>   error:
>  	return ret;
> @@ -245,8 +247,6 @@ static int install_session_keyring(struc
>   */
>  int copy_thread_group_keys(struct task_struct *tsk)
>  {
> -	unsigned long flags;
> -
>  	key_check(current->thread_group->session_keyring);
>  	key_check(current->thread_group->process_keyring);
>  
> @@ -254,10 +254,10 @@ int copy_thread_group_keys(struct task_s
>  	tsk->signal->process_keyring = NULL;
>  
>  	/* same session keyring */
> -	spin_lock_irqsave(&current->sighand->siglock, flags);
> +	rcu_read_lock();
>  	tsk->signal->session_keyring =
> -		key_get(current->signal->session_keyring);
> -	spin_unlock_irqrestore(&current->sighand->siglock, flags);
> +		key_get(rcu_dereference(current->signal->session_keyring));
> +	rcu_read_unlock();
>  
>  	return 0;
>  
> @@ -381,8 +381,7 @@ struct key *search_process_keyrings_aux(
>  					key_match_func_t match)
>  {
>  	struct task_struct *tsk = current;
> -	unsigned long flags;
> -	struct key *key, *ret, *err, *tmp;
> +	struct key *key, *ret, *err;
>  
>  	/* we want to return -EAGAIN or -ENOKEY if any of the keyrings were
>  	 * searchable, but we failed to find a key or we found a negative key;
> @@ -436,17 +435,18 @@ struct key *search_process_keyrings_aux(
>  	}
>  
>  	/* search the session keyring last */
> -	spin_lock_irqsave(&tsk->sighand->siglock, flags);
> -
> -	tmp = tsk->signal->session_keyring;
> -	if (!tmp)
> -		tmp = tsk->user->session_keyring;
> -	atomic_inc(&tmp->usage);
> -
> -	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
> +	if (tsk->signal->session_keyring) {
> +		rcu_read_lock();
> +		key = keyring_search_aux(
> +			rcu_dereference(tsk->signal->session_keyring),
> +			type, description, match);
> +		rcu_read_unlock();
> +	}
> +	else {
> +		key = keyring_search_aux(tsk->user->session_keyring,
> +					 type, description, match);

This one is constant, right?  If not, I don't understand the locking design.

> +	}
>  
> -	key = keyring_search_aux(tmp, type, description, match);
> -	key_put(tmp);
>  	if (!IS_ERR(key))
>  		goto found;
>  
> diff -uNrp linux-2.6.12-rc1-mm1-keys-umhelper/security/keys/request_key.c linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/request_key.c
> --- linux-2.6.12-rc1-mm1-keys-umhelper/security/keys/request_key.c	2005-03-23 17:35:16.000000000 +0000
> +++ linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/request_key.c	2005-03-23 18:14:13.908029567 +0000
> @@ -175,13 +175,12 @@ static struct key *__request_key_constru
>  	key->expiry = now.tv_sec + key_negative_timeout;
>  
>  	if (current->signal->session_keyring) {
> -		unsigned long flags;
>  		struct key *keyring;
>  
> -		spin_lock_irqsave(&current->sighand->siglock, flags);
> -		keyring = current->signal->session_keyring;
> +		rcu_read_lock();
> +		keyring = rcu_dereference(current->signal->session_keyring);
>  		atomic_inc(&keyring->usage);
> -		spin_unlock_irqrestore(&current->sighand->siglock, flags);
> +		rcu_read_unlock();
>  
>  		key_link(keyring, key);
>  		key_put(keyring);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
