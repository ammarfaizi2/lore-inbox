Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUL2PjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUL2PjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 10:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUL2PjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 10:39:16 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:60548 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261360AbUL2PjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 10:39:03 -0500
Message-ID: <41D2CF3B.4040304@colorfullife.com>
Date: Wed, 29 Dec 2004 16:37:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: eliminate rcu_data.last_qsctr
References: <41AA0D5F.21CB9ED3@tv-sign.ru>
In-Reply-To: <41AA0D5F.21CB9ED3@tv-sign.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:

>last_qsctr is used in rcu_check_quiescent_state() exclusively.
>We can reset qsctr at the start of the grace period, and then
>just test qsctr against 0.
>
>  
>
It seems the patch got lost, I've updated it a bit and resent it to Andrew.

But: I think there is the potential for an even larger cleanup, although 
this would be more a rewrite:
Get rid of rcu_check_quiescent_state and instead use something like this 
in rcu_qsctr_inc:

static inline void rcu_qsctr_inc(int cpu)
{
        struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
        if (rdp->quiescbatch != rcp->cur) {
             /* a new grace period is running. And we are at a quiescent
              * point, so complete it
              */
             spin_lock(&rsp->lock);
             rdp->quiescbatch = rcp->cur;
             cpu_quiet(rdp->cpu, rcp, rsp);
            spin_unlock(&rsp->lock);
     }
}

It's just an idea, it needs testing on big systems - does reading from 
the global rcp from every schedule call cause any problems? The cache 
line is virtually read-only, so it shouldn't cause trashing, but who knows?

--
    Manfred
