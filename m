Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266743AbUG1ARk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266743AbUG1ARk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 20:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUG1ARk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 20:17:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44456 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266743AbUG1ARf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 20:17:35 -0400
Date: Tue, 27 Jul 2004 17:15:48 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bh_lru_install
Message-Id: <20040727171548.75c3b14c.davem@redhat.com>
In-Reply-To: <20040727160617.321ce504.akpm@osdl.org>
References: <20040723170338.0c9a38ef.davem@redhat.com>
	<20040727160617.321ce504.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 16:06:17 -0700
Andrew Morton <akpm@osdl.org> wrote:

> > It shouldn't be too hard to make the code just work without
> > an on-stack copy, shuffling the lru->bh[] array entries
> > directly.
> 
> Yup, that plus making it a ringbuffer maybe.

It seems implementable using two roving indexes, one for
reading and one for writing.  So it's just like the existing
code sans the on-stack+memcpy stuff :-)

Do you see any logic errors in this new code below?

static void bh_lru_install(struct buffer_head *bh)
{
	struct buffer_head *e = NULL;
	struct bh_lru *lru;

	check_irqs_on();
	bh_lru_lock();
	lru = &__get_cpu_var(bh_lrus);
	if ((e = lru->bhs[0]) != bh) {
		int rd_idx, wr_idx;

		wr_idx = 0;

		get_bh(bh);
		lru->bhs[wr_idx++] = bh;

		for (rd_idx = 1; rd_idx < BH_LRU_SIZE; rd_idx++) {
			struct buffer_head *nxt = lru->bhs[rd_idx];

			if (e != NULL)
				lru->bhs[wr_idx++] = e;
			e = nxt;
			if (e == bh) {
				__brelse(e);
				e = NULL;
			} else if (e == NULL)
				break;
		}

		while (wr_idx < BH_LRU_SIZE)
			lru->bhs[wr_idx++] = NULL;

	}
	bh_lru_unlock();

	if (e)
		__brelse(e);
}
