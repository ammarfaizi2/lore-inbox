Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWG1NNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWG1NNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWG1NNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:13:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20929 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751054AbWG1NNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:13:15 -0400
Date: Fri, 28 Jul 2006 22:12:52 +0900 (JST)
Message-Id: <20060728.221252.265353941.jet@gyve.org>
To: deweerdt@free.fr
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [mm-patch] bluetooth: use GFP_ATOMIC in *_sock_create's
 sk_alloc
From: Masatake YAMATO <jet@gyve.org>
In-Reply-To: <20060728123246.GB311@slug>
References: <20060728083532.GA311@slug>
	<20060728.181756.135980869.jet@gyve.org>
	<20060728123246.GB311@slug>
X-Mailer: Mew version 4.2.53 on Emacs 22.0.50 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Fri, Jul 28, 2006 at 06:17:56PM +0900, Masatake YAMATO wrote:
> > > I think that the bluetooth-guard-bt_proto-with-rwlock.patch introduced the following
> > > BUG:
> > > [   43.232000] BUG: sleeping function called from invalid context at mm/slab.c:2903
> > > [   43.232000] in_atomic():1, irqs_disabled():0
> > > [   43.232000]  [<c0104114>] show_trace_log_lvl+0x197/0x1ba
> > > [   43.232000]  [<c010415e>] show_trace+0x27/0x29
> > > [   43.232000]  [<c010426e>] dump_stack+0x26/0x28
> > > [   43.232000]  [<c011ad1c>] __might_sleep+0xa2/0xaa
> > > [   43.232000]  [<c0173085>] __kmalloc+0x9c/0xb3
> > > [   43.232000]  [<c02f9295>] sk_alloc+0x1bc/0x1de
> > > [   43.232000]  [<c036d689>] hci_sock_create+0x42/0x8a
> > > [   43.236000]  [<c0366f40>] bt_sock_create+0xb5/0x154
> > > [   43.236000]  [<c02f69dc>] __sock_create+0x131/0x356
> > > [   43.236000]  [<c02f6c2f>] sock_create+0x2e/0x30
> > > [   43.236000]  [<c02f6c88>] sys_socket+0x27/0x53
> > > [   43.240000]  [<c02f7db5>] sys_socketcall+0xa9/0x277
> > > [   43.240000]  [<c0103131>] sysenter_past_esp+0x56/0x8d
> > > [   43.240000]  [<b7f38410>] 0xb7f38410
> > > 
> > > 
> > > This patch makes sk_alloc GFP_ATOMIC, because we are holding the bt_proto_rwlock, for
> > > the following functions:
> > > - bnep_sock_create
> > > - cmtp_sock_create
> > > - hci_sock_create
> > > - hidp_sock_create
> > > - l2cap_sock_create
> > > - rfcomm_sock_create
> > > - sco_sock_create
> > 
> > There is very similar code in i net/socket.c(I guess some part of
> > bluetooth/af_bluetooth.c is derived from net/socket.c):
> > 
> [... skip net/socket.c code ...]
> > 
> > So there are two ways to avoid the bug:
> > 1. As proposed by Frederik, use sk_alloc with GFP_ATOMIC or
> > 2. use net_family_{read|writ}_{lock|unlock} in af_bluetooth.c.
> > 
> I'd say that using a net_family_* like function set is much better,
> if only in terms of preemptibility. 
> 
> I'll write an implementation that allows to use the same code
> in socket.c and in af_bluetooth.c
> 
> Regards,
> Frederik

I found one more similar code set at net/dccp/ccid.c for the same purpose:

    /*
     * The strategy is: modifications ccids vector are short, do not sleep and
     * veeery rare, but read access should be free of any exclusive locks.
     */
    static void ccids_write_lock(void)
    {
	    spin_lock(&ccids_lock);
	    while (atomic_read(&ccids_lockct) != 0) {
		    spin_unlock(&ccids_lock);
		    yield();
		    spin_lock(&ccids_lock);
	    }
    }

    static inline void ccids_write_unlock(void)
    {
	    spin_unlock(&ccids_lock);
    }

    static inline void ccids_read_lock(void)
    {
	    atomic_inc(&ccids_lockct);
	    spin_unlock_wait(&ccids_lock);
    }

    static inline void ccids_read_unlock(void)
    {
	    atomic_dec(&ccids_lockct);
    }

I'm new to the kernel, however, I think it is better to unify
them into one and to give a good name.

Masatake YAMATO

