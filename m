Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWEBN4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWEBN4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWEBN4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:56:20 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:45975 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964831AbWEBN4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:56:19 -0400
Date: Tue, 2 May 2006 16:01:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [netfilter-core] Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup in	sctp_new(), do_basic_checks()
Message-ID: <20060502140102.GA31743@elte.hu>
References: <20060502113454.GA28601@elte.hu> <20060502134053.GA30917@elte.hu> <4457648C.6020100@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4457648C.6020100@trash.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Patrick McHardy <kaber@trash.net> wrote:

> Ingo Molnar wrote:
> > thinking about it, what prevents the SCTP chunk's len field from being 
> > zero, and thus causing an infinite loop in for_each_sctp_chunk()? The 
> > patch below should fix that.
> > 
> > 	Ingo
> > 
> > ----
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > fix infinite loop in the SCTP-netfilter code: check SCTP chunk size to 
> > guarantee progress of for_each_sctp_chunk(). (all other uses of 
> > for_each_sctp_chunk() are preceded by do_basic_checks(), so this fix 
> > should be complete.)
> > 
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > 
> > Index: linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
> > ===================================================================
> > --- linux.orig/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
> > +++ linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
> > @@ -227,6 +227,15 @@ static int do_basic_checks(struct ip_con
> >  	flag = 0;
> >  
> >  	for_each_sctp_chunk (skb, sch, _sch, offset, count) {
> > +		unsigned int len = (htons(sch->length) + 3) & ~3;
> > +
> > +		/*
> > +		 * Dont get into a loop with zero-sized or negative
> > +		 * length values:
> > +		 */
> > +		if (!len || len >= skb->len)
> > +			goto fail;
> > +
> 
> I just came up with a similar fix :) I think I'm going to take my own 
> patch though because its IMO slightly nicer. Thanks anyway.

could you send your patch so that i can start using it instead of mine?

	Ingo
