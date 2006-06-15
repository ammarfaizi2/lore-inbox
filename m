Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWFOF30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWFOF30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 01:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWFOF30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 01:29:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:13696 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964922AbWFOF3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 01:29:25 -0400
Date: Thu, 15 Jun 2006 07:28:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, davem@davemloft.net,
       jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, fpavlic@de.ibm.com
Subject: Re: [patch] ipv4: fix lock usage in udp_ioctl
Message-ID: <20060615052806.GA19803@elte.hu>
References: <20060614194305.GB10391@osiris.ibm.com> <E1FqeXX-0008OE-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FqeXX-0008OE-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> This is bogus.  These two locks belong to two different queues and 
> they never intersect.

yeah - qeth does its own skb-queue management here, and it's done in an 
irq-safe manner.

Heiko, in qeth_main.c, could you do something like:

+ static struct lockdep_type_key qdio_out_skb_queue_key;

...
		skb_queue_head_init(&card->qdio.out_qs[i]->bufs[j].
				     skb_list);
+		lockdep_reinit_key(&card->qdio.out_qs[i]->bufs[j].skb_list,
				   &qdio_out_skb_queue_key)

	Ingo
