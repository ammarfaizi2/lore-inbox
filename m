Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSFRA5t>; Mon, 17 Jun 2002 20:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSFRA5s>; Mon, 17 Jun 2002 20:57:48 -0400
Received: from [200.203.199.90] ([200.203.199.90]:4882 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S317253AbSFRA5p>; Mon, 17 Jun 2002 20:57:45 -0400
Date: Mon, 17 Jun 2002 21:57:35 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: critson@perlfu.co.uk, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][2.5.22] OOPS in tcp_v6_get_port
Message-ID: <20020618005735.GB1146@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, critson@perlfu.co.uk,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <Pine.LNX.4.44.0206171314460.2496-300000@lain.perlfu.co.uk> <20020617.143319.54623892.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020617.143319.54623892.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 17, 2002 at 02:33:19PM -0700, David S. Miller escreveu:
> 
> This is a known bug introduced by the struct sock splitup into
> external per-protocol pieces done by Arnaldo de Melo.  He is working
> on the proper fix, your proposed change will just paper over the real
> bug.

Carl,

	Can you try this patch?

- Arnaldo

--- orig/net/ipv6/tcp_ipv6.c	Sat May 25 23:13:56 2002
+++ linux/net/ipv6/tcp_ipv6.c	Fri Jun 14 23:23:07 2002
@@ -1240,6 +1240,7 @@
 					  struct dst_entry *dst)
 {
 	struct ipv6_pinfo *newnp, *np = inet6_sk(sk);
+	struct tcp6_sock *newtcp6sk;
 	struct flowi fl;
 	struct inet_opt *newinet;
 	struct tcp_opt *newtp;
@@ -1256,10 +1257,15 @@
 		if (newsk == NULL) 
 			return NULL;
 
+		newtcp6sk = (struct tcp6_sock *)newsk;
+		newtcp6sk->pinet6 = &newtcp6sk->inet6;
+
 		newinet = inet_sk(newsk);
 		newnp = inet6_sk(newsk);
 		newtp = tcp_sk(newsk);
 
+		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
+
 		ipv6_addr_set(&newnp->daddr, 0, 0, htonl(0x0000FFFF),
 			      newinet->daddr);
 
@@ -1336,9 +1342,15 @@
 	ip6_dst_store(newsk, dst, NULL);
 	sk->route_caps = dst->dev->features&~NETIF_F_IP_CSUM;
 
+	newtcp6sk = (struct tcp6_sock *)newsk;
+	newtcp6sk->pinet6 = &newtcp6sk->inet6;
+
 	newtp = tcp_sk(newsk);
 	newinet = inet_sk(newsk);
 	newnp = inet6_sk(newsk);
+
+	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
+
 	ipv6_addr_copy(&newnp->daddr, &req->af.v6_req.rmt_addr);
 	ipv6_addr_copy(&newnp->saddr, &req->af.v6_req.loc_addr);
 	ipv6_addr_copy(&newnp->rcv_saddr, &req->af.v6_req.loc_addr);


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


