Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbWG1Mc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWG1Mc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbWG1Mc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:32:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:47949 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161138AbWG1Mc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:32:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=MFh9YIq6l/f4EXFY3fOCIxW0VDDYyMWC8xxvZQXQGj2vpphf7Ahu/x/li0EMpQyfBCZcVc54wuU8YAJBDGKz3C1SqBYb8s4ndy0ThnOqeUlux9pVtDop1U7n2+u/n3h6Hi+QNGq5GMeNLxPj6CV3P+OdBQvwaLyqo5D9sohKE1o=
Date: Fri, 28 Jul 2006 14:32:46 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Masatake YAMATO <jet@gyve.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [mm-patch] bluetooth: use GFP_ATOMIC in *_sock_create's sk_alloc
Message-ID: <20060728123246.GB311@slug>
References: <20060727015639.9c89db57.akpm@osdl.org> <20060728083532.GA311@slug> <20060728.181756.135980869.jet@gyve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728.181756.135980869.jet@gyve.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 06:17:56PM +0900, Masatake YAMATO wrote:
> > I think that the bluetooth-guard-bt_proto-with-rwlock.patch introduced the following
> > BUG:
> > [   43.232000] BUG: sleeping function called from invalid context at mm/slab.c:2903
> > [   43.232000] in_atomic():1, irqs_disabled():0
> > [   43.232000]  [<c0104114>] show_trace_log_lvl+0x197/0x1ba
> > [   43.232000]  [<c010415e>] show_trace+0x27/0x29
> > [   43.232000]  [<c010426e>] dump_stack+0x26/0x28
> > [   43.232000]  [<c011ad1c>] __might_sleep+0xa2/0xaa
> > [   43.232000]  [<c0173085>] __kmalloc+0x9c/0xb3
> > [   43.232000]  [<c02f9295>] sk_alloc+0x1bc/0x1de
> > [   43.232000]  [<c036d689>] hci_sock_create+0x42/0x8a
> > [   43.236000]  [<c0366f40>] bt_sock_create+0xb5/0x154
> > [   43.236000]  [<c02f69dc>] __sock_create+0x131/0x356
> > [   43.236000]  [<c02f6c2f>] sock_create+0x2e/0x30
> > [   43.236000]  [<c02f6c88>] sys_socket+0x27/0x53
> > [   43.240000]  [<c02f7db5>] sys_socketcall+0xa9/0x277
> > [   43.240000]  [<c0103131>] sysenter_past_esp+0x56/0x8d
> > [   43.240000]  [<b7f38410>] 0xb7f38410
> > 
> > 
> > This patch makes sk_alloc GFP_ATOMIC, because we are holding the bt_proto_rwlock, for
> > the following functions:
> > - bnep_sock_create
> > - cmtp_sock_create
> > - hci_sock_create
> > - hidp_sock_create
> > - l2cap_sock_create
> > - rfcomm_sock_create
> > - sco_sock_create
> 
> There is very similar code in i net/socket.c(I guess some part of
> bluetooth/af_bluetooth.c is derived from net/socket.c):
> 
[... skip net/socket.c code ...]
> 
> So there are two ways to avoid the bug:
> 1. As proposed by Frederik, use sk_alloc with GFP_ATOMIC or
> 2. use net_family_{read|writ}_{lock|unlock} in af_bluetooth.c.
> 
I'd say that using a net_family_* like function set is much better,
if only in terms of preemptibility. 

I'll write an implementation that allows to use the same code
in socket.c and in af_bluetooth.c

Regards,
Frederik
