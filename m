Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbTCYA43>; Mon, 24 Mar 2003 19:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbTCYA43>; Mon, 24 Mar 2003 19:56:29 -0500
Received: from dp.samba.org ([66.70.73.150]:52397 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261306AbTCYA42>;
	Mon, 24 Mar 2003 19:56:28 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] module load notification try 2 
In-reply-to: Your message of "Tue, 18 Mar 2003 15:59:54 -0000."
             <20030318155953.GA97463@compsoc.man.ac.uk> 
Date: Sun, 23 Mar 2003 15:36:26 +1100
Message-Id: <20030325010738.10E762C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030318155953.GA97463@compsoc.man.ac.uk> you write:
> 
> Rusty, any happier with this one ?

Yep, much simpler.  Couple of comments:

> +static inline int register_module_notifier(struct notifier_block * nb)
> +{
> +	return -ENOSYS;
> +}
> +
> +static inline int unregister_module_notifier(struct notifier_block * nb)
> +{
> +	return -ENOSYS;
> +}
> +
>  #endif /* CONFIG_MODULES */

Shouldn't fail just because !CONFIG_MODULES: should just return 0.
Otherwise there's no way to sanely use them without wrapping in #ifdef
CONFIG_MODULES (in which case why have the non-module definition at
all?).

> +static DECLARE_MUTEX(notify_mutex);

Hmm, yes, you need to use your own protection around
notifier_chain_register and notifier_call_chain.  Wierd, because
notifier.c does its own locking for register and unregister, but not
for calling, which AFAICT makes it useless...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
