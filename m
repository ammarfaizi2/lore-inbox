Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVBDBei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVBDBei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVBDBbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:31:35 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:60060
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263223AbVBDBbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:31:13 -0500
Date: Thu, 3 Feb 2005 17:23:57 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: anton@samba.org, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-Id: <20050203172357.670c3402.davem@davemloft.net>
In-Reply-To: <20050204012053.GA8949@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de>
	<E1CvZo6-0001Bz-00@gondolin.me.apana.org.au>
	<20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
	<20050203203010.GA7081@gondor.apana.org.au>
	<20050203141901.5ce04c92.davem@davemloft.net>
	<20050203235044.GA8422@gondor.apana.org.au>
	<20050203164922.2627a112.davem@davemloft.net>
	<20050204012053.GA8949@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 12:20:53 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> This is true if CPU 0 reads the count before reading skb->list.
> Without a memory barrier, atomic_read and reading skb->list can
> be reordered.  Put it another way, reading skb->list could return
> a cached value that was read from the main memory prior to the
> atomic_read.
> 
> So in order for CPU 0 to always see an up-to-date value of skb->list,
> it needs to do an smp_rmb() between the atomic_read and reading
> skb->list.

You're absolutely right.  Ok, so we do need to change kfree_skb().
I believe even with the memory barrier, the atomic_read() optimization
is still worth it.  atomic ops on sparc64 take a minimum of 40 some odd
cycles on UltraSPARC-III and later, whereas the memory barrier will
take up a single cycle most of the time.

So it'll look something like:

	if (atomic_read(&skb->users) == 1)
		smb_rmb();
	else if (!atomic_dec_and_test(&skb->users))
		return;
	__kfree_skb(skb);
