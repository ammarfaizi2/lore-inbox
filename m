Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbUKDVO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbUKDVO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbUKDVOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:14:52 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:34010
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262317AbUKDVLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:11:34 -0500
Date: Thu, 4 Nov 2004 13:00:28 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: kaber@trash.net, linux-net@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that
 breaks amanda dumps
Message-Id: <20041104130028.099fc130.davem@davemloft.net>
In-Reply-To: <E1CPoUT-0000sk-00@gondolin.me.apana.org.au>
References: <418A7B0B.7040803@trash.net>
	<E1CPoUT-0000sk-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Nov 2004 07:45:53 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Patrick McHardy <kaber@trash.net> wrote:
> >
> > The data that is changed is only a copy, the actual packet is not touched.
> 
> Does it call skb_ip_make_writable anywhere? If not then it may be
> shared/cloned and can't be written at all.

You're right... the bug was introduced by my skb_header_pointer() changes.
Look at this:

	amp = skb_header_pointer(skb, dataoff,
				 skb->len - dataoff, amanda_buffer);
	BUG_ON(amp == NULL);
	data = amp;
	data_limit = amp + skb->len - dataoff;
	*data_limit = '\0';

It should just use the amanda_buffer always.
