Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWE3Bez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWE3Bez (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWE3Bey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:34:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10689 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932115AbWE3Bbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:31:52 -0400
Date: Mon, 29 May 2006 18:36:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 51/61] lock validator: special locking: sock_lock_init()
Message-Id: <20060529183604.324ee331.akpm@osdl.org>
In-Reply-To: <20060529212714.GY3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212714.GY3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:27:14 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> teach special (multi-initialized, per-address-family) locking code to the
> lock validator. Has no effect on non-lockdep kernels.
> 
> Index: linux/include/net/sock.h
> ===================================================================
> --- linux.orig/include/net/sock.h
> +++ linux/include/net/sock.h
> @@ -81,12 +81,6 @@ typedef struct {
>  	wait_queue_head_t	wq;
>  } socket_lock_t;
>  
> -#define sock_lock_init(__sk) \
> -do {	spin_lock_init(&((__sk)->sk_lock.slock)); \
> -	(__sk)->sk_lock.owner = NULL; \
> -	init_waitqueue_head(&((__sk)->sk_lock.wq)); \
> -} while(0)
> -
>  struct sock;
>  struct proto;
>  
> Index: linux/net/core/sock.c
> ===================================================================
> --- linux.orig/net/core/sock.c
> +++ linux/net/core/sock.c
> @@ -739,6 +739,27 @@ lenout:
>    	return 0;
>  }
>  
> +/*
> + * Each address family might have different locking rules, so we have
> + * one slock key per address family:
> + */
> +static struct lockdep_type_key af_family_keys[AF_MAX];
> +
> +static void noinline sock_lock_init(struct sock *sk)
> +{
> +	spin_lock_init_key(&sk->sk_lock.slock, af_family_keys + sk->sk_family);
> +	sk->sk_lock.owner = NULL;
> +	init_waitqueue_head(&sk->sk_lock.wq);
> +}

OK, no code outside net/core/sock.c uses sock_lock_init().

Hopefully the same is true of out-of-tree code...
