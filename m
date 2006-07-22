Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWGVROH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWGVROH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWGVROG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:14:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:30780 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750796AbWGVROF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:14:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=SR+YCtQc0Jbo5jU63RrWQ9awSj+jiuPghlWfaCYkGDNG4V18x0sJLcq22jLbpXmom1GNlAJX5lnf2xj+sgU0GhJr710okEBHYuKDA58bIR75bGH62xVO1pQ2hrLZiapclQFzkY0OEBtvbGuNTZ0lfw4LEPdwfzx6D+/P4sJB/Vg=
Date: Sat, 22 Jul 2006 19:14:22 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
cc: "Paul E. McKenney" <pmckenne@us.ibm.com>, Bill Huey <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NMI reentrant RCU list for -rt kernels
In-Reply-To: <20060722152933.GA17148@Krystal>
Message-ID: <Pine.LNX.4.64.0607221837420.11861@localhost.localdomain>
References: <20060722152933.GA17148@Krystal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006, Mathieu Desnoyers wrote:

> Hi Paul,
>
> Following your presentation on RCU lists for -rt kernel, discussing with Bill
> Huey led me to the following idea that could solve the problem of NMI reentrancy
> of RCU read side in the -rt kernels.
>
> If we consider that the RCU list modification that makes the read side
> lock preemptible is only needed for very long code paths, we could leave the
> original RCU implementation along with the preemptible one, so that very short
> and frequent code paths could benefit of using the very cheap preempt count
> protection without having a too big impact on the scheduler latency.
>
> For instance, my LTTng tracer disables the preemption for about 95 ns, which I
> doubt would be a problem for real-time behavior. I could easily fix maximum
> a maximum list size so it can be run in a constant time.
>
> So, basically, the idea is to have two RCU API that could take names like :
> atomic_rcu_* and rcu_*
>
> Does this idea make sense ?

No,

1) Can you readily identify the very short code pathes? What about future 
code added to the kernel?
2) Having two parellel systems is a bad idea.
3) I believe RCU can be made much cheaper than the 
current implementation which look horrible.

I remember once discussing RCU on the list. I came up with the idea 
rcu_read_lock()/unlock() to be implemented as a per-task counter just as
preempt_disable()/disable(). The run-queue then has a sum of all the 
counters of tasks on that cpu (minus the counter for the current task).
I even made some sample code...
The only reason this wasn't considered working was the migration from CPU 
to CPU. I frankly can't see why this couldn't be fixed.

So the answer to you is: No. Fix the preemptible RCU instead. You have an 
idea above.

Esben


>
> Mathieu
>
>
> OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
> Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
