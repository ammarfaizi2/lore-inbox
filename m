Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbRE2XJ4>; Tue, 29 May 2001 19:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbRE2XJr>; Tue, 29 May 2001 19:09:47 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:59621 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262406AbRE2XJi>;
	Tue, 29 May 2001 19:09:38 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105292309.QAA00259@csl.Stanford.EDU>
Subject: Re: [CHECKER] 84 bugs in 2.4.4/2.4.4-ac8 where NULL pointers are deref'd
To: davem@redhat.com (David S. Miller)
Date: Tue, 29 May 2001 16:09:21 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU, SteveW@ACM.org,
        philb@gnu.org
In-Reply-To: <15124.9340.77101.588276@pizda.ninka.net> from "David S. Miller" at May 29, 2001 03:36:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And if you look a couple lines previous it is blindly dereferenced,
> this should have been a clue :-)

There's a lot of places where code checks and then blindly
dereferences, so I don't think that's much of a clue ;-)

>  > Start --->
>  > 	struct rtable *rt = skb ? (struct rtable*)skb->dst : NULL;
>  > 
>  > 	if (!opt) {
>  > 		opt = &(IPCB(skb)->opt);
>  > 		memset(opt, 0, sizeof(struct ip_options));
>  > Error --->
>  > 		iph = skb->nh.raw;
> How is this a contradiction?  The first thing sets 'rt' to NULL or

In the absence of knowlege about variable dependencies (in this case
that skb == NULL implies opt != NULL) the code appears contradictory,
since it checks skb against null and then dereferences it downstream.
We'd make the checker read comments to infer such knowlege if there
were more of them ;-)


>  > Start --->
>  > 	if (skb->dst == NULL) {
>  > 		if (ip_route_input(skb, iph->daddr, iph->saddr, iph->tos, dev))
>  > 			goto drop; 
>  > 	}
>  > 
>  > #ifdef CONFIG_NET_CLS_ROUTE
>  > Error --->
>  > 	if (skb->dst->tclassid) {
> 
> This one is OK.
> 
> The side effect of a successful ip_route_input call is that skb->dst
> gets set to a non-NULL value.

Argh.  I was missing the fact that skb was getting passed to a function.
Sorry about the false pos.


>  > Start --->
>  > 	if (ifa == NULL && cmd != SIOCSIFADDR) {
>  > 		ret = -EADDRNOTAVAIL;
>  > 		goto done;
>  > 	}
>  > 
>  > 	switch(cmd) {
>  > 		case SIOCGIFADDR:
>  > Error --->
>  > 			*((dn_address *)sdn->sdn_nodeaddr) = ifa->ifa_local;
>  > 			goto rarok;
>  > 
>  > 		case SIOCSIFADDR:
> 
> Checker is wrong in these two cases.
> 
> The "error" code you point to cannot be reached if cmd == SIOCGIFADDR
> (for the dn_dev.c, likewise SIOCSIFADDR+SIOCSIFFLAGS in the devinet.c
> case). In the dn_dev.c case, SIOCSIFADDR in that switch statement may
> run if ifa == NULL.

Yeah, it's not doing sophisticated false path pruning (yet).  I thought
I would have caught this.

> isn't doing exhaustive enough reachability determination.

Too exhaustive, since it follows impossible paths.

Thanks for the quick feedback!  And apologies for the bogus "errors".

Dawson
