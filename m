Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVBDBUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVBDBUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbVBDBTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:19:33 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:55963
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263123AbVBDA4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:56:40 -0500
Date: Thu, 3 Feb 2005 16:49:22 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: anton@samba.org, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-Id: <20050203164922.2627a112.davem@davemloft.net>
In-Reply-To: <20050203235044.GA8422@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de>
	<E1CvZo6-0001Bz-00@gondolin.me.apana.org.au>
	<20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
	<20050203203010.GA7081@gondor.apana.org.au>
	<20050203141901.5ce04c92.davem@davemloft.net>
	<20050203235044.GA8422@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 10:50:44 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> So the problem isn't as big as I thought which is good.  sk_buff
> is only in trouble because of the atomic_read optimisation which
> really needs a memory barrier.
> 
> However, instead of adding a memory barrier which makes the optimisation
> less useful, let's just get rid of the atomic_read.

See my other email, the atomic_read() should function just fine.

If we see the count dropped to "1", whoever set it to "1" made
sure that all outstanding memory operations (including things
like __skb_unlink()) are globally visible before the
atomic_dec_and_test() which put the thing to "1" from "2".
(and we did use atomic_dec_and_test() since the refcount was
 not "1")  Example, assuming skb->users is "2":

	cpu 0			cpu 1
				__skb_unlink()
				kfree_skb()
	kfree_skb()

If cpu 0 sees the count at "1", it will always see the
__skb_unlink() as well.

Either my logic is flawed (very possible, I am a pinhead) or something
is amiss in the PPC atomic ops.

I describe all of this more explicitly in my other email.
I'm actually going through all the sparc64 chip manuals to make
sure I have things correct in that implementation :-)))
