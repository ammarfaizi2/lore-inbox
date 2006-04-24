Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWDXKS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWDXKS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 06:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWDXKS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 06:18:56 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:35439 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750709AbWDXKSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 06:18:55 -0400
Date: Mon, 24 Apr 2006 12:18:52 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: shemminger@osdl.org, jgarzik@pobox.com, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       fpavlic@de.ibm.com, davem@sunset.davemloft.net
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
Message-ID: <20060424101852.GA16007@osiris.boeblingen.de.ibm.com>
References: <20060408100213.GA9412@osiris.boeblingen.de.ibm.com> <20060408.031404.111884281.davem@davemloft.net> <20060415072745.GA17011@osiris.boeblingen.de.ibm.com> <20060415.003457.103031290.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060415.003457.103031290.davem@davemloft.net>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Tried to figure out what is causing the delays I experienced when I replaced
> > module_init() in af_inet.c with fs_initcall(). After all it turned out that
> > synchronize_net() which is basicically nothing else than synchronize_rcu()
> > sometimes takes several seconds to complete?! No idea why that is...
> > 
> > callchain: inet_init() -> inet_register_protosw() -> synchronize_net()
> 
> The problem can't be rcu_init(), that gets done very early
> in init/main.c
> 
> Maybe it's some timer or something else specific to s390?
> 
> It could also be that there's perhaps nothing to context
> switch to, thus the RCU takes forever to "happen".

Yes, it's more or less s390 specific.

What happens is the following: synchronize_rcu() enqueues an RCU callback on
cpu 0. Later on cpu 0 handles a bunch of RCU batches, but without handling
this specific request (it's in rdp->curlist). Since this cpu has nothing else
to do it enters cpu_idle() (it's a nohz idle, therefore it might be quite a
long time in idle state).
While cpu 0 is in idle state cpu 2 calls cpu_quiet() which in turn will call
rcu_start_batch(). If cpu 0 would run now, it would notice rdp->curlist moved
to rdp->donelist and that there is something to do. Unfortunately it doesn't
get notified from rcu_start_batch(). That's why I ended up waiting several
seconds until finally some interrupt arrived at cpu 0 which made things go
on finally.

Avoiding this could be done if we look at rdp->curlist before going into
a nohz idle wait, or we could send an interprocessor interrupt to idle
cpus. Sending an interrupt while looking only on nohz_cpu_mask seems to
be a bit racy, since other cpus might have entered cpu idle after
nohz_cpu_mask has been read...

At least the initcall change for inet_init() can go in, since it just
revealed a problem that we have anyway.
