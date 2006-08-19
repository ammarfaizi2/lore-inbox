Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWHSCri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWHSCri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 22:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHSCri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 22:47:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:38847 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751376AbWHSCrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 22:47:37 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
From: Matt Helsley <matthltc@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44E5A637.1020407@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33BB6.3050504@sw.ru>
	 <1155866328.2510.247.camel@stark>  <44E5A637.1020407@sw.ru>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 19:38:36 -0700
Message-Id: <1155955116.2510.445.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 15:36 +0400, Kirill Korotaev wrote:
> Matt Helsley wrote:

<snip>

> >>+		spin_unlock_irqrestore(&ub_hash_lock, flags);
> >>+		return;
> >>+	}
> >>+
> >>+	verify_held(ub);
> >>+	hlist_del(&ub->hash);
> >>+	spin_unlock_irqrestore(&ub_hash_lock, flags);
> >>+
> >>+	kmem_cache_free(ub_cachep, ub);
> >>+
> >>+	ub = parent;
> >>+	if (ub != NULL)
> >>+		goto again;
> > 
> > 
> > Couldn't this be replaced by a do { } while (ub != NULL); loop?
> this is ugly from indentation POV. also restarts are frequently used everywhere...

Then perhaps the body could be made into a small function or set of
functions.

I know the retry pattern is common. Though, as I remember it the control
flow was much more complex when goto was used for retry. Also, I seem to
recall do {} while () has favorable properties that goto lacks when it
comes to compiler optimization.

<snip>

> >>+int charge_beancounter(struct user_beancounter *ub,
> >>+		int resource, unsigned long val, enum severity strict)
> >>+{
> >>+	int retval;
> >>+	struct user_beancounter *p, *q;
> >>+	unsigned long flags;
> >>+
> >>+	retval = -EINVAL;
> >>+	BUG_ON(val > UB_MAXVALUE);
> >>+
> >>+	local_irq_save(flags);
> > 
> > 
> > <factor>
> > 
> >>+	for (p = ub; p != NULL; p = p->parent) {
> > 
> > 
> > Seems rather expensive to walk up the tree for every charge. Especially
> > if the administrator wants a fine degree of resource control and makes a
> > tall tree. This would be a problem especially when it comes to resources
> > that require frequent and fast allocation.
> in heirarchical accounting you always have to update all the nodes :/
> with flat UBC this doesn't introduce significant overhead.

Except that you eventually have to lock ub0. Seems that the cache line
for that spinlock could bounce quite a bit in such a hot path.

Chandra, doesn't Resource Groups avoid walking more than 1 level up the
hierarchy in the "charge" paths?

> >>+		spin_lock(&p->ub_lock);
> >>+		retval = __charge_beancounter_locked(p, resource, val, strict);
> >>+		spin_unlock(&p->ub_lock);
> >>+		if (retval)
> >>+			goto unroll;
> > 
> > 
> > This can be factored by passing a flag that breaks the loop on an error:
> > 
> > 		if (retval && do_break_err)
> > 			return retval;
> how about uncharge here?
> didn't get your idea, sorry...

	The only structural difference between this loop and another you have
is the "break" here. I was saying that you could pass a parameter into
the factored portion that tells it to return early if there is an error.

Cheers,
	-Matt Helsley

