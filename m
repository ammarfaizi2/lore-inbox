Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVBCOso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVBCOso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVBCOkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:40:02 -0500
Received: from ozlabs.org ([203.10.76.45]:53446 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262713AbVBCOaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:30:00 -0500
Date: Fri, 4 Feb 2005 01:27:05 +1100
From: Anton Blanchard <anton@samba.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Olaf Kirch <okir@suse.de>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-ID: <20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
References: <20050131102920.GC4170@suse.de> <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> For example, in this particular case, a more sinister (but probably
> impossible for sk_buff objects) problem would be for the list removal
> itself to be delayed until after the the kfree_skb.  This could
> potentially mean that we're reading/writing memory that's already
> been freed.
> 
> Perhaps we should always add a barrier to such operations.  So
> kfree_skb would become
> 
> 	if (atomic_read(&skb->users) != 1) {
> 		smp_mb__before_atomic_dec();
> 		if (!atomic_dec_and_test(&skb->users))
> 			return;
> 	}
> 	__kfree_skb(skb);

Architectures should guarantee that any of the atomics and bitops that
return values order in both directions. So you dont need the
smp_mb__before_atomic_dec here.

It is, however, required on the atomics and bitops that dont return
values. Its difficult stuff, everyone gets it wrong and Andrew keeps
hassling me to write up a document explaining it.

Anton
