Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWG1JTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWG1JTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 05:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWG1JTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 05:19:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51610 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161107AbWG1JTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 05:19:51 -0400
Date: Fri, 28 Jul 2006 18:17:56 +0900 (JST)
Message-Id: <20060728.181756.135980869.jet@gyve.org>
To: deweerdt@free.fr
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [mm-patch] bluetooth: use GFP_ATOMIC in *_sock_create's
 sk_alloc
From: Masatake YAMATO <jet@gyve.org>
In-Reply-To: <20060728083532.GA311@slug>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<20060728083532.GA311@slug>
X-Mailer: Mew version 4.2.53 on Emacs 22.0.50 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that the bluetooth-guard-bt_proto-with-rwlock.patch introduced the following
> BUG:
> [   43.232000] BUG: sleeping function called from invalid context at mm/slab.c:2903
> [   43.232000] in_atomic():1, irqs_disabled():0
> [   43.232000]  [<c0104114>] show_trace_log_lvl+0x197/0x1ba
> [   43.232000]  [<c010415e>] show_trace+0x27/0x29
> [   43.232000]  [<c010426e>] dump_stack+0x26/0x28
> [   43.232000]  [<c011ad1c>] __might_sleep+0xa2/0xaa
> [   43.232000]  [<c0173085>] __kmalloc+0x9c/0xb3
> [   43.232000]  [<c02f9295>] sk_alloc+0x1bc/0x1de
> [   43.232000]  [<c036d689>] hci_sock_create+0x42/0x8a
> [   43.236000]  [<c0366f40>] bt_sock_create+0xb5/0x154
> [   43.236000]  [<c02f69dc>] __sock_create+0x131/0x356
> [   43.236000]  [<c02f6c2f>] sock_create+0x2e/0x30
> [   43.236000]  [<c02f6c88>] sys_socket+0x27/0x53
> [   43.240000]  [<c02f7db5>] sys_socketcall+0xa9/0x277
> [   43.240000]  [<c0103131>] sysenter_past_esp+0x56/0x8d
> [   43.240000]  [<b7f38410>] 0xb7f38410
> 
> 
> This patch makes sk_alloc GFP_ATOMIC, because we are holding the bt_proto_rwlock, for
> the following functions:
> - bnep_sock_create
> - cmtp_sock_create
> - hci_sock_create
> - hidp_sock_create
> - l2cap_sock_create
> - rfcomm_sock_create
> - sco_sock_create

There is very similar code in i net/socket.c(I guess some part of
bluetooth/af_bluetooth.c is derived from net/socket.c):

    static int __sock_create(int family, int type, int protocol, struct socket **res, int kern)
    {
	    ...
	    net_family_read_lock();
	    ...
	    if ((err = net_families[family]->create(sock, protocol)) < 0) {
		    sock->ops = NULL;
		    goto out_module_put;
	    }
	    ...	
	    net_family_read_unlock();
	    return err;
    }

I can find GFP_KERNEL is used to allocate object in 
net_families[family]->create(sock, protocol). e.g.:

    net/ipv4/af_inet.c:
    static int inet_create(struct socket *sock, int protocol)
    {
    ...
	    sk = sk_alloc(PF_INET, GFP_KERNEL, answer_prot, 1);
    ...
    }

Tricks are in net_family_read_lock and net_family_read_unlock:

    net/socket.c:
    static __inline__ void net_family_read_lock(void)
    {
	    atomic_inc(&net_family_lockct);
	    spin_unlock_wait(&net_family_lock);
    }

    static __inline__ void net_family_read_unlock(void)
    {
	    atomic_dec(&net_family_lockct);
    }

So there are two ways to avoid the bug:
1. As proposed by Frederik, use sk_alloc with GFP_ATOMIC or
2. use net_family_{read|writ}_{lock|unlock} in af_bluetooth.c.

I wonder which is better.

Masatake YAMATO
