Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRE2WhS>; Tue, 29 May 2001 18:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbRE2WhJ>; Tue, 29 May 2001 18:37:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46493 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262288AbRE2Wg5>;
	Tue, 29 May 2001 18:36:57 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15124.9340.77101.588276@pizda.ninka.net>
Date: Tue, 29 May 2001 15:36:44 -0700 (PDT)
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU, SteveW@ACM.org,
        philb@gnu.org
Subject: Re: [CHECKER] 84 bugs in 2.4.4/2.4.4-ac8 where NULL pointers are deref'd
In-Reply-To: <200105292149.OAA29781@csl.Stanford.EDU>
In-Reply-To: <200105292149.OAA29781@csl.Stanford.EDU>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Steve: Just skim down to the decnet bug, you should have a look
         at it.

  Philip: Similarly, skim down to the econet bug. ]

Dawson Engler writes:
 > [BUG]  sends sk raw to a bunch of other routines.  doesn't seem good.
 > /u2/engler/mc/oses/linux/2.4.4-ac8/net/ipv4/ip_output.c:520:ip_build_xmit_slow: ERROR:INTERNAL_NULL:502:520: [type=set] (set at line 502) Dereferencing NULL ptr "sk" illegally!
 > 
 > 	/*
 > 	 *	Begin outputting the bytes.
 > 	 */
 > 
 > Start --->
 > 	id = (sk ? sk->protinfo.af_inet.id++ : 0);
 > 
 > 	... DELETED 12 lines ...
 > 
 > 
 > 		/*
 > 		 *	Fill in the control structures
 > 		 */
 > 
 > Error --->
 > 		skb->priority = sk->priority;
 > 		skb->dst = dst_clone(&rt->u.dst);
 > 		skb_reserve(skb, hh_len);

Actually, sk is not allowed to be NULL here, the "(sk ?" bit is bogus
and was cut and pasted from elsewhere.  I've removed it in my tree.

And if you look a couple lines previous it is blindly dereferenced,
this should have been a clue :-)

 > ---------------------------------------------------------
 > [BUG]  hard to follow but seems like it.
 > /u2/engler/mc/oses/linux/2.4.4-ac8/net/ipv4/fib_frontend.c:272:fib_validate_source: ERROR:INTERNAL_NULL:239:272: [type=set] (set at line 239) Dereferencing NULL ptr "itag" illegally!
 > 	if (fib_lookup(&key, &res))
 > 		goto last_resort;
 > 	if (res.type != RTN_UNICAST)
 > 		goto e_inval_res;
 > 	*spec_dst = FIB_RES_PREFSRC(res);
 > Start --->
 > 	if (itag)
 > 
 > 	... DELETED 27 lines ...
 > 
 > 
 > last_resort:
 > 	if (rpf)
 > 		goto e_inval;
 > 	*spec_dst = inet_select_addr(dev, 0, RT_SCOPE_UNIVERSE);
 > Error --->
 > 	*itag = 0;
 > 	return 0;

Another case like the previous, no caller sends in a NULL itag.
Check removed in my sources...

 > [BUG] contradiction
 > /u2/engler/mc/oses/linux/2.4.4/net/ipv4/ip_options.c:257:ip_options_compile: ERROR:INTERNAL_NULL:252:257: [type=set] (set at line 252) Dereferencing NULL ptr "skb" illegally! [val=500]
 > 	int l;
 > 	unsigned char * iph;
 > 	unsigned char * optptr;
 > 	int optlen;
 > 	unsigned char * pp_ptr = NULL;
 > Start --->
 > 	struct rtable *rt = skb ? (struct rtable*)skb->dst : NULL;
 > 
 > 	if (!opt) {
 > 		opt = &(IPCB(skb)->opt);
 > 		memset(opt, 0, sizeof(struct ip_options));
 > Error --->
 > 		iph = skb->nh.raw;
 > 		opt->optlen = ((struct iphdr *)iph)->ihl*4 - sizeof(struct iphdr);
 > 		optptr = iph + sizeof(struct iphdr);
 > 		opt->is_data = 0;

How is this a contradiction?  The first thing sets 'rt' to NULL or
not, then we test '!opt' not '!rt' which is what I think you are
seeing :-)

If SKB is NULL, opt must be non-NULL and also opt->is_data must be
set in this case.  That is the invariant, and even though not %100
explicitly tested, this is what the comment above is trying to say.
At best the missing minor checks should be BUG() checks because they
are illegal states.

 > [BUG] contradiction
 > /u2/engler/mc/oses/linux/2.4.4/net/core/neighbour.c:317:neigh_create: ERROR:INTERNAL_NULL:312:317: [type=set] (set at line 312) Dereferencing NULL ptr "parms" illegally! [val=500]
 > 		return ERR_PTR(error);
 > 	}
 > 
 > 	/* Device specific setup. */
 > 	if (n->parms && n->parms->neigh_setup &&
 > Start --->
 > 	    (error = n->parms->neigh_setup(n)) < 0) {
 > 		neigh_release(n);
 > 		return ERR_PTR(error);
 > 	}
 > 
 > Error --->
 > 	n->confirmed = jiffies - (n->parms->base_reachable_time<<1);
 > 
 > 	hash_val = tbl->hash(pkey, dev);

I've added the obvious check, but I suspect the more correct fix is
to disallow NULL n->parms (and as a consequence disallow NULL
tbl->constructor since that constructor is the thing that hooks
in the n->parms).

Really, I didn't catch anyone sending a NULL parms in during a
quick perusal, and honestly it would crash instantly on non-x86
systems if it were NULL.  (Unfortunately, at least during boot,
the NULL address is actually mapped in the kernel on x86 :-( ).

 > ---------------------------------------------------------
 > [BUG] contradicts
 > /u2/engler/mc/oses/linux/2.4.4/net/ipv4/ip_input.c:325:ip_rcv_finish: ERROR:INTERNAL_NULL:319:325: [type=set] (set at line 319) Dereferencing NULL ptr "dst" illegally! [val=600]
 > 
 > 	/*
 > 	 *	Initialise the virtual path cache for the packet. It describes
 > 	 *	how the packet travels inside Linux networking.
 > 	 */ 
 > Start --->
 > 	if (skb->dst == NULL) {
 > 		if (ip_route_input(skb, iph->daddr, iph->saddr, iph->tos, dev))
 > 			goto drop; 
 > 	}
 > 
 > #ifdef CONFIG_NET_CLS_ROUTE
 > Error --->
 > 	if (skb->dst->tclassid) {
 > 		struct ip_rt_acct *st = ip_rt_acct + 256*smp_processor_id();
 > 		u32 idx = skb->dst->tclassid;
 > 		st[idx&0xFF].o_packets++;

This one is OK.

The side effect of a successful ip_route_input call is that skb->dst
gets set to a non-NULL value.

 > ---------------------------------------------------------
 > [BUG] contradicts.
 > /u2/engler/mc/oses/linux/2.4.4/net/ipv4/devinet.c:544:devinet_ioctl: ERROR:INTERNAL_NULL:537:544: [type=set] (set at line 537) Dereferencing NULL ptr "ifa" illegally! [val=700]
 > 		for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL; ifap=&ifa->ifa_next)
 > 			if (strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
 > 				break;
 > 	}
 > 
 > Start --->
 > 	if (ifa == NULL && cmd != SIOCSIFADDR && cmd != SIOCSIFFLAGS) {
 > 		ret = -EADDRNOTAVAIL;
 > 		goto done;
 > 	}
 > 
 > 	switch(cmd) {
 > 		case SIOCGIFADDR:	/* Get interface address */
 > Error --->
 > 			sin->sin_addr.s_addr = ifa->ifa_local;
 > 			goto rarok;
 > 
 > 		case SIOCGIFBRDADDR:	/* Get the broadcast address */
 > ---------------------------------------------------------
 > [BUG] should be ||?
 > /u2/engler/mc/oses/linux/2.4.4/net/decnet/dn_dev.c:500:dn_dev_ioctl: ERROR:INTERNAL_NULL:493:500: [type=set] (set at line 493) Dereferencing NULL ptr "ifa" illegally! [val=700]
 > 		for (ifap = &dn_db->ifa_list; (ifa=*ifap) != NULL; ifap = &ifa->ifa_next)
 > 			if (strcmp(ifr->ifr_name, ifa->ifa_label) == 0)
 > 				break;
 > 	}
 > 
 > Start --->
 > 	if (ifa == NULL && cmd != SIOCSIFADDR) {
 > 		ret = -EADDRNOTAVAIL;
 > 		goto done;
 > 	}
 > 
 > 	switch(cmd) {
 > 		case SIOCGIFADDR:
 > Error --->
 > 			*((dn_address *)sdn->sdn_nodeaddr) = ifa->ifa_local;
 > 			goto rarok;
 > 
 > 		case SIOCSIFADDR:

Checker is wrong in these two cases.

The "error" code you point to cannot be reached if cmd == SIOCGIFADDR
(for the dn_dev.c, likewise SIOCSIFADDR+SIOCSIFFLAGS in the devinet.c
case). In the dn_dev.c case, SIOCSIFADDR in that switch statement may
run if ifa == NULL.

Something is screwed with checker's flow graphs perhaps?  Else it
isn't doing exhaustive enough reachability determination.

 > ---------------------------------------------------------
 > [BUG] contradicts
 > /u2/engler/mc/oses/linux/2.4.4/net/decnet/dn_route.c:808:dn_route_output_slow: ERROR:INTERNAL_NULL:798:808: [type=set] (set at line 798) Dereferencing NULL ptr "neigh" illegally! [val=1000]
 > 	
 > 	rt->key.saddr  = src;
 > 	rt->rt_saddr   = src;
 > 	rt->key.daddr  = dst;
 > 	rt->rt_daddr   = dst;
 > Start --->
 > 	rt->key.oif    = neigh ? neigh->dev->ifindex : -1;
 > 	rt->key.iif    = 0;
 > 	rt->key.fwmark = 0;
 > 
 > 	rt->u.dst.neighbour = neigh;
 > 	rt->u.dst.dev = neigh ? neigh->dev : NULL;
 > 	rt->u.dst.lastuse = jiffies;
 > 	rt->u.dst.output = dn_output;
 > 	rt->u.dst.input  = dn_rt_bug;
 > 
 > Error --->
 > 	if (dn_dev_islocal(neigh->dev, rt->rt_daddr))
 > 		rt->u.dst.input = dn_nsp_rx;
 > 
 > 	hash = dn_hash(rt->key.saddr, rt->key.daddr);

Yeah, this one is wrong, I'll leave this to Steve Whitehouse though,
the DecNET maintainer.

 > [BUG]  seems like it, unless there is a weird DP going on.
 > /u2/engler/mc/oses/linux/2.4.4/net/econet/af_econet.c:310:econet_sendmsg: ERROR:INTERNAL_NULL:268:310: [type=set] (set at line 268) Dereferencing NULL ptr "saddr" illegally! [val=4200]
 > 
 > 	/*
 > 	 *	Get and verify the address. 
 > 	 */
 > 	 
 > Start --->
 > 	if (saddr == NULL) {
 > 
 > 	... DELETED 36 lines ...
 > 
 > 		skb_reserve(skb, (dev->hard_header_len+15)&~15);
 > 		skb->nh.raw = skb->data;
 > 		
 > 		eb = (struct ec_cb *)&skb->cb;
 > 		
 > Error --->
 > 		eb->cookie = saddr->cookie;
 > 		eb->sec = *saddr;
 > 		eb->sent = ec_tx_done;

Yep, this one is correct.  I don't know enough about econet to fix it
though... Philip?

Later,
David S. Miller
davem@redhat.com
