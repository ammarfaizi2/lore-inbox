Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317303AbSFRD62>; Mon, 17 Jun 2002 23:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317304AbSFRD61>; Mon, 17 Jun 2002 23:58:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29459 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317303AbSFRD60>; Mon, 17 Jun 2002 23:58:26 -0400
Date: Tue, 18 Jun 2002 00:58:04 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>, critson@perlfu.co.uk,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [BKPATCH] Re: [PATCH][2.5.22] OOPS in tcp_v6_get_port
Message-ID: <20020618035804.GA18759@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, critson@perlfu.co.uk,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <Pine.LNX.4.44.0206171314460.2496-300000@lain.perlfu.co.uk> <20020617.143319.54623892.davem@redhat.com> <20020618005735.GB1146@conectiva.com.br> <20020617.191726.55300824.davem@redhat.com> <20020618024934.GA4274@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020618024934.GA4274@conectiva.com.br>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 17, 2002 at 11:49:34PM -0300, Arnaldo C. Melo escreveu:
> Em Mon, Jun 17, 2002 at 07:17:26PM -0700, David S. Miller escreveu:
> >    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> >    Date: Mon, 17 Jun 2002 21:57:35 -0300
> > 
> >    --- orig/net/ipv6/tcp_ipv6.c	Sat May 25 23:13:56 2002
> >    +++ linux/net/ipv6/tcp_ipv6.c	Fri Jun 14 23:23:07 2002
> > 
> > I've installed this change into my tree in the meantime.
> > If we find a better fix, we can just revert this.
> 
> OK, I found a better fix, I think, that allowed me to kill inet6_sk_generic
> in af_inet6.c, using a constructor for the tcpv6, udpv6 and raw6 slab caches,
> as suggested by Russel King, I'll be sending RSN.

Here it is, David, please consider pulling it from:

http://kernel-acme.bkbits.net:8080/tcpv6-pinet6

Best Regards,

- Arnaldo


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.656   -> 1.657  
#	 net/ipv6/tcp_ipv6.c	1.17    -> 1.18   
#	 net/ipv6/af_inet6.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/18	acme@conectiva.com.br	1.657
# net/ipv6/af_inet6.c
# net/ipv6/tcp_ipv6.c
# 
# 	- Add constructors for the tcp6_sk_cachep, udp6_sk_cachep and raw6_sk_cachep slab caches,
#           to initialize ->pinet6 to the respective &->inet6, this simplifies inet6_create,
#           making ipv6_sk_generic not needed and fixing a bug where we create a new tcpv6 socket
#           outside inet6_create and we were not initializing ->pinet6 properly, thanks to
#           Russell King for pointing out the bug and doing the initial analisys that made the
#           fix easy to make.
# --------------------------------------------
#
diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	Mon Mar 11 11:13:05 2002
+++ b/net/ipv6/af_inet6.c	Tue Jun 18 00:27:30 2002
@@ -134,23 +134,11 @@
         return rc;
 }
 
-static __inline__ struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
-{
-	struct ipv6_pinfo *rc = (&((struct tcp6_sock *)sk)->inet6);
-
-        if (sk->protocol == IPPROTO_UDP)
-                rc = (&((struct udp6_sock *)sk)->inet6);
-        else if (sk->protocol == IPPROTO_RAW)
-                rc = (&((struct raw6_sock *)sk)->inet6);
-        return rc;
-}
-
 static int inet6_create(struct socket *sock, int protocol)
 {
 	struct inet_opt *inet;
 	struct ipv6_pinfo *np;
 	struct sock *sk;
-	struct tcp6_sock* tcp6sk;
 	struct list_head *p;
 	struct inet_protosw *answer;
 
@@ -212,8 +200,7 @@
 
 	sk->backlog_rcv		= answer->prot->backlog_rcv;
 
-	tcp6sk		= (struct tcp6_sock *)sk;
-	tcp6sk->pinet6 = np = inet6_sk_generic(sk);
+	np		= inet6_sk(sk);
 	np->hop_limit	= -1;
 	np->mcast_hops	= -1;
 	np->mc_loop	= 1;
@@ -632,6 +619,30 @@
 	inet_unregister_protosw(p);
 }
 
+static void tcp6_pinet6_init(void *foo, kmem_cache_t *cachep,
+			     unsigned long flags)
+{
+	struct tcp6_sock *tcp6sk = (struct tcp6_sock *)foo;
+
+	tcp6sk->pinet6 = &tcp6sk->inet6;
+}
+
+static void udp6_pinet6_init(void *foo, kmem_cache_t *cachep,
+			     unsigned long flags)
+{
+	struct udp6_sock *udp6sk = (struct udp6_sock *)foo;
+
+	udp6sk->pinet6 = &udp6sk->inet6;
+}
+
+static void raw6_pinet6_init(void *foo, kmem_cache_t *cachep,
+			     unsigned long flags)
+{
+	struct raw6_sock *raw6sk = (struct raw6_sock *)foo;
+
+	raw6sk->pinet6 = &raw6sk->inet6;
+}
+
 static int __init inet6_init(void)
 {
 	struct sk_buff *dummy_skb;
@@ -655,13 +666,16 @@
 	/* allocate our sock slab caches */
         tcp6_sk_cachep = kmem_cache_create("tcp6_sock",
 					   sizeof(struct tcp6_sock), 0,
-                                           SLAB_HWCACHE_ALIGN, 0, 0);
+                                           SLAB_HWCACHE_ALIGN,
+					   tcp6_pinet6_init, NULL);
         udp6_sk_cachep = kmem_cache_create("udp6_sock",
 					   sizeof(struct udp6_sock), 0,
-                                           SLAB_HWCACHE_ALIGN, 0, 0);
+                                           SLAB_HWCACHE_ALIGN,
+					   udp6_pinet6_init, NULL);
         raw6_sk_cachep = kmem_cache_create("raw6_sock",
 					   sizeof(struct raw6_sock), 0,
-                                           SLAB_HWCACHE_ALIGN, 0, 0);
+                                           SLAB_HWCACHE_ALIGN,
+					   raw6_pinet6_init, NULL);
         if (!tcp6_sk_cachep || !udp6_sk_cachep || !raw6_sk_cachep)
                 printk(KERN_CRIT __FUNCTION__
                         ": Can't create protocol sock SLAB caches!\n");
diff -Nru a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
--- a/net/ipv6/tcp_ipv6.c	Wed May 22 15:16:37 2002
+++ b/net/ipv6/tcp_ipv6.c	Tue Jun 18 00:27:30 2002
@@ -1260,6 +1260,8 @@
 		newnp = inet6_sk(newsk);
 		newtp = tcp_sk(newsk);
 
+		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
+
 		ipv6_addr_set(&newnp->daddr, 0, 0, htonl(0x0000FFFF),
 			      newinet->daddr);
 
@@ -1339,6 +1341,7 @@
 	newtp = tcp_sk(newsk);
 	newinet = inet_sk(newsk);
 	newnp = inet6_sk(newsk);
+	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 	ipv6_addr_copy(&newnp->daddr, &req->af.v6_req.rmt_addr);
 	ipv6_addr_copy(&newnp->saddr, &req->af.v6_req.loc_addr);
 	ipv6_addr_copy(&newnp->rcv_saddr, &req->af.v6_req.loc_addr);
