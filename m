Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWHXKN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWHXKN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWHXKN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:13:59 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:35970 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751016AbWHXKN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:13:58 -0400
Date: Thu, 24 Aug 2006 18:13:51 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 2/6] BC: beancounters core (API)
Message-ID: <20060824141351.GA101@oleg>
References: <44EC31FB.2050002@sw.ru> <44EC35EB.1030000@sw.ru> <20060823094202.ff3a5573.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823094202.ff3a5573.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23, Andrew Morton wrote:
>
> On Wed, 23 Aug 2006 15:03:07 +0400
> Kirill Korotaev <dev@sw.ru> wrote:
> 
> > +void __put_beancounter(struct beancounter *bc)
> > +{
> > +	unsigned long flags;
> > +
> > +	/* equivalent to atomic_dec_and_lock_irqsave() */
> > +	local_irq_save(flags);
> > +	if (likely(!atomic_dec_and_lock(&bc->bc_refcount, &bc_hash_lock))) {
> > +		local_irq_restore(flags);
> > +		if (unlikely(atomic_read(&bc->bc_refcount) < 0))
> > +			printk(KERN_ERR "BC: Bad refcount: bc=%p, "
> > +					"luid=%d, ref=%d\n",
> > +					bc, bc->bc_id,
> > +					atomic_read(&bc->bc_refcount));
> > +		return;
> > +	}
> > +
> > +	BUG_ON(bc == &init_bc);
> > +	verify_held(bc);
> > +	hlist_del(&bc->hash);
> > +	spin_unlock_irqrestore(&bc_hash_lock, flags);
> > +	kmem_cache_free(bc_cachep, bc);
> > +}
> 
> I wonder if it's safe and worthwhile to optimise away the local_irq_save():

Suppose ->bc_refcount == 1

> 	if (atomic_dec_and_test(&bc->bc_refcount)) {

Yes, preempted or blocks on spin_lock() below.

another cpu locks bc_hash_lock, does get_beancounter() (beancounter_findcreate),
then does put_beancounter(), and frees it.

> 		spin_lock_irqsave(&bc_hash_lock, flags);
> 		if (atomic_read(&bc->bc_refcount) == 0) {

Yes,

> 			free it
>

Already freed.

Oleg.

