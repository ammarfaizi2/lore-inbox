Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWALFjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWALFjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 00:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWALFjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 00:39:47 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:58315 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964781AbWALFjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 00:39:46 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: paulmck@us.ibm.com
cc: John Hesterberg <jh@sgi.com>, Matt Helsley <matthltc@us.ibm.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors 
In-reply-to: Your message of "Wed, 11 Jan 2006 21:04:53 -0800."
             <20060112050453.GA23673@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Jan 2006 16:38:03 +1100
Message-ID: <13667.1137044283@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" (on Wed, 11 Jan 2006 21:04:53 -0800) wrote:
>On Thu, Jan 12, 2006 at 02:29:52PM +1100, Keith Owens wrote:
>> An alternative patch that requires no locks and does not even require
>> RCU is in http://marc.theaimsgroup.com/?l=linux-kernel&m=113392370322545&w=2
>
>But doesn't notifier_call_chain_lockfree() need to either disable
>preemption or use atomic operations to update notifier_chain_lockfree_inuse[]
>in order to avoid problems with preemption?

Yes it does :(.  Originally the atomic notifier chains were only called
from atomic contexts (typically interrupt context), but if they are
going to be generalized to all contexts, then the code is not good
enough.  These lines either assume no preemption or that preemption is
stacked in LIFO order, which is not guaranteed.

int notifier_call_chain_lockfree(struct notifier_block **list,
				 unsigned long val, void *v)
{
	int ret = NOTIFY_DONE, cpu = smp_processor_id(), nested;
	struct notifier_block *nb;
	nested = notifier_chain_lockfree_inuse[cpu];
	notifier_chain_lockfree_inuse[cpu] = 1;
	wmb();
	nb = *list;
	while (nb) {
		smp_read_barrier_depends();
		ret = nb->notifier_call(nb, val, v);
		if (ret & NOTIFY_STOP_MASK)
			break;
		nb = nb->next;
	}
	barrier();
	notifier_chain_lockfree_inuse[cpu] = nested;
	return ret;
}

So either disable preemption in notifier_call_chain_lockfree (including
all the callbacks that it invokes) or notifier_chain_lockfree_inuse has
to be an atomic_t.  atomic_t would be better, but it could cause a
problem on architectures that implement atomic_t via hashed spinlocks
_and_ have non maskable interrupts that call notifier_call_chain_lockfree().

Going away to think about this ...

