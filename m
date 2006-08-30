Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWH3KeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWH3KeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 06:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWH3KeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 06:34:05 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:51084 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750701AbWH3KeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 06:34:02 -0400
Date: Wed, 30 Aug 2006 18:57:59 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Alexey Dobriyan <adobriyan@mail.ru>,
       Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH 1/7] introduce atomic_dec_and_lock_irqsave()
Message-ID: <20060830145759.GA163@oleg>
References: <44F45045.70402@sw.ru> <44F4540C.8050205@sw.ru> <Pine.LNX.4.64.0608301156010.6762@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608301156010.6762@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30, Roman Zippel wrote:
> Hi,
> 
> On Tue, 29 Aug 2006, Kirill Korotaev wrote:
> 
> > --- ./kernel/user.c.dlirq	2006-07-10 12:39:20.000000000 +0400
> > +++ ./kernel/user.c	2006-08-28 11:08:56.000000000 +0400
> > @@ -108,15 +108,12 @@ void free_uid(struct user_struct *up)
> > 	if (!up)
> > 		return;
> > 
> > -	local_irq_save(flags);
> > -	if (atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
> > +	if (atomic_dec_and_lock_irqsave(&up->__count, &uidhash_lock, flags)) {
> > 		uid_hash_remove(up);
> > 		spin_unlock_irqrestore(&uidhash_lock, flags);
> > 		key_put(up->uid_keyring);
> > 		key_put(up->session_keyring);
> > 		kmem_cache_free(uid_cachep, up);
> > -	} else {
> > -		local_irq_restore(flags);
> > 	}
> > }
> 
> Why does this need protection against interrupts?

uidhash_lock can be taken from irq context. For example, delayed_put_task_struct()
does __put_task_struct()->free_uid().

Oleg.

