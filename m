Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVBCW3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVBCW3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbVBCW3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:29:50 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:51609
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261164AbVBCW0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:26:25 -0500
Date: Thu, 3 Feb 2005 14:19:01 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: anton@samba.org, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-Id: <20050203141901.5ce04c92.davem@davemloft.net>
In-Reply-To: <20050203203010.GA7081@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de>
	<E1CvZo6-0001Bz-00@gondolin.me.apana.org.au>
	<20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
	<20050203203010.GA7081@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 07:30:10 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Fri, Feb 04, 2005 at 01:27:05AM +1100, Anton Blanchard wrote:
> > 
> > Architectures should guarantee that any of the atomics and bitops that
> > return values order in both directions. So you dont need the
> > smp_mb__before_atomic_dec here.
> 
> I wasn't aware of this requirement before.  However, if this is so,
> why don't we get rid of the smp_mb__* macros?

They are for cases where you want strict ordering even for the
non-return-value-giving atomic_t ops.

Actually.... Herbert has a point.  By Anton's specification, several
uses in 2.6.x I see of these smp_mb__*() routines are bogus.  Case
in point, look at mm/filemap.c:

void fastcall unlock_page(struct page *page)
{
	smp_mb__before_clear_bit();
	if (!TestClearPageLocked(page))
		BUG();
	smp_mb__after_clear_bit(); 
	wake_up_page(page, PG_locked);
}

TestClearPageLocked() uses one of the bitops returning a value, so
must be providing the explicit memory barriers in it's implementation.

void end_page_writeback(struct page *page)
{
	if (!TestClearPageReclaim(page) || rotate_reclaimable_page(page)) {
		if (!test_clear_page_writeback(page))
			BUG();
	}
	smp_mb__after_clear_bit();
	wake_up_page(page, PG_writeback);
}

Same thing there.

Looking at include/linux/sunrpc/sched.h, those uses are legitimate,
correct, and needed.  As is the put_bh() use in include/linux/buffer_head.h
There are several other correct and necessary uses in:

	include/linux/interrupt.h
	include/linux/netdevice.h
	include/linux/nfs_page.h
	include/linux/spinlock.h
	net/core/dev.c
	net/sunrpc/sched.c
	sound/pci/bt87x.c
	fs/buffer.c
	fs/nfs/pagelist.c
	drivers/block/ll_rw_blk.c
	arch/ppc64/kernel/smp.c
	arch/i386/kernel/smp.c
	arch/i386/mach-voyager/smp.c

I'm working on a rough but rather complete draft Anton said needs
to be written to explicitly spell out the atomic_t and bitops
stuff.
