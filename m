Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265459AbSIRGm2>; Wed, 18 Sep 2002 02:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265485AbSIRGm2>; Wed, 18 Sep 2002 02:42:28 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:59793 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S265459AbSIRGmY>;
	Wed, 18 Sep 2002 02:42:24 -0400
Message-ID: <3D88217A.6070702@candelatech.com>
Date: Tue, 17 Sep 2002 23:47:22 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Networking:  send-to-self
Content-Type: multipart/mixed;
 boundary="------------010703030901020509080500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010703030901020509080500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch allows one to use the SO_BINDTODEVICE and a new ioctl against
net_device objects to send and receive regular routed traffic between two
interfaces on the same machine.  It also fixes a problem when using BINDTODEVICE:
the old code does not set the bound_if correctly when sending back the
syn-ack during TCP connection initialization.

I'm not sure how useful others will find it, but it amuses me ;)

Comments and suggestions welcome.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


--------------010703030901020509080500
Content-Type: text/plain;
 name="sts_2.4.19.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sts_2.4.19.patch"

--- linux-2.4.19/include/linux/sockios.h	Wed Nov  7 15:39:36 2001
+++ linux-2.4.19.dev/include/linux/sockios.h	Sun Sep 15 21:10:00 2002
@@ -114,6 +114,16 @@
 #define SIOCBONDINFOQUERY      0x8994	/* rtn info about bond state    */
 #define SIOCBONDCHANGEACTIVE   0x8995   /* update to a new active slave */
 			
+
+/* Ben's little hack land */
+#define SIOCSACCEPTLOCALADDRS  0x89a0   /*  Allow interfaces to accept pkts from
+                                         * local interfaces...use with SO_BINDTODEVICE
+                                         */
+#define SIOCGACCEPTLOCALADDRS  0x89a1   /*  Allow interfaces to accept pkts from
+                                         * local interfaces...use with SO_BINDTODEVICE
+                                         */
+
+
 /* Device private ioctl calls */
 
 /*
--- linux-2.4.19/net/Config.in	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19.dev/net/Config.in	Sun Sep 15 21:27:08 2002
@@ -97,6 +97,7 @@
 mainmenu_option next_comment
 comment 'Network testing'
 tristate 'Packet Generator (USE WITH CAUTION)' CONFIG_NET_PKTGEN
+bool 'Send-to-Self' CONFIG_NET_SENDTOSELF
 endmenu
 
 endmenu
--- linux-2.4.19/include/net/tcp.h	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19.dev/include/net/tcp.h	Sun Sep 15 21:57:07 2002
@@ -27,6 +27,7 @@
 #include <linux/config.h>
 #include <linux/tcp.h>
 #include <linux/slab.h>
+#include <linux/cache.h>
 #include <net/checksum.h>
 #include <net/sock.h>
 
@@ -117,8 +118,7 @@
 	 * Now align to a new cache line as all the following members
 	 * are often dirty.
 	 */
-	rwlock_t __tcp_lhash_lock
-		__attribute__((__aligned__(SMP_CACHE_BYTES)));
+	rwlock_t __tcp_lhash_lock ____cacheline_aligned;
 	atomic_t __tcp_lhash_users;
 	wait_queue_head_t __tcp_lhash_wait;
 	spinlock_t __tcp_portalloc_lock;
@@ -447,7 +447,6 @@
 extern int sysctl_tcp_retrans_collapse;
 extern int sysctl_tcp_stdurg;
 extern int sysctl_tcp_rfc1337;
-extern int sysctl_tcp_tw_recycle;
 extern int sysctl_tcp_abort_on_overflow;
 extern int sysctl_tcp_max_orphans;
 extern int sysctl_tcp_max_tw_buckets;
@@ -520,6 +519,14 @@
 		struct tcp_v6_open_req v6_req;
 #endif
 	} af;
+#ifdef CONFIG_NET_SENDTOSELF
+        int bound_dev_if; /* This is so we can connect to ourselves and not collide
+                           * in the open-request hash (the addresses and ports are the
+                           * same, but we need two ends, so use the interface to determine
+                           * one from the other.  Active when SO_BINDTODEVICE is used.
+                           * --Ben
+                           */
+#endif
 };
 
 /* SLAB cache for open requests. */
--- linux-2.4.19/net/ipv4/arp.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19.dev/net/ipv4/arp.c	Sun Sep 15 21:14:43 2002
@@ -1,4 +1,4 @@
-/* linux/net/inet/arp.c
+/* linux/net/inet/arp.c  -*-linux-c-*-
  *
  * Version:	$Id: sts_2.4.19.patch,v 1.3 2002/09/17 07:01:55 greear Exp $
  *
@@ -351,12 +351,26 @@
 	int flag = 0; 
 	/*unsigned long now; */
 
-	if (ip_route_output(&rt, sip, tip, 0, 0) < 0) 
+	if (ip_route_output(&rt, sip, tip, 0, 0) < 0)
 		return 1;
-	if (rt->u.dst.dev != dev) { 
-		NET_INC_STATS_BH(ArpFilter);
-		flag = 1;
-	} 
+        
+	if (rt->u.dst.dev != dev) {
+#ifdef CONFIG_NET_SENDTOSELF
+                if ((dev->priv_flags & IFF_ACCEPT_LOCAL_ADDRS) &&
+                    (rt->u.dst.dev == &loopback_dev))  {
+                        /* OK, we'll let this special case slide, so that we can arp from one
+                         * local interface to another.  This seems to work, but could use some
+                         * review. --Ben
+                         */
+                }
+                else {
+#endif
+                        NET_INC_STATS_BH(ArpFilter);
+                        flag = 1;
+#ifdef CONFIG_NET_SENDTOSELF
+                }
+#endif
+        }
 	ip_rt_put(rt); 
 	return flag; 
 } 
--- linux-2.4.19/net/ipv4/fib_frontend.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19.dev/net/ipv4/fib_frontend.c	Sun Sep 15 21:16:44 2002
@@ -233,8 +233,19 @@
 
 	if (fib_lookup(&key, &res))
 		goto last_resort;
-	if (res.type != RTN_UNICAST)
-		goto e_inval_res;
+        
+	if (res.type != RTN_UNICAST) {
+#ifdef CONFIG_NET_SENDTOSELF
+           if ((res.type == RTN_LOCAL) &&
+                    (dev->priv_flags & IFF_ACCEPT_LOCAL_ADDRS)) {
+                     /* All is OK */
+           }
+           else
+#endif
+              goto e_inval_res;
+                
+        }
+        
 	*spec_dst = FIB_RES_PREFSRC(res);
 	fib_combine_itag(itag, &res);
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
--- linux-2.4.19/net/ipv4/ip_output.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19.dev/net/ipv4/ip_output.c	Sun Sep 15 21:19:45 2002
@@ -520,8 +520,18 @@
 		/*
 		 *	Get the memory we require with some space left for alignment.
 		 */
-
-		skb = sock_alloc_send_skb(sk, fraglen+hh_len+15, flags&MSG_DONTWAIT, &err);
+		if (!(flags & MSG_DONTWAIT) || nfrags == 0) {
+			skb = sock_alloc_send_skb(sk, fraglen + hh_len + 15,
+						  (flags & MSG_DONTWAIT), &err);
+		} else {
+			/* On a non-blocking write, we check for send buffer
+			 * usage on the first fragment only.
+			 */
+			skb = sock_wmalloc(sk, fraglen + hh_len + 15, 1,
+					   sk->allocation);
+			if (!skb)
+				err = -ENOBUFS;
+		}
 		if (skb == NULL)
 			goto error;
 
@@ -965,7 +975,11 @@
 			daddr = replyopts.opt.faddr;
 	}
 
+#ifdef CONFIG_NET_SENDTOSELF
+	if (ip_route_output(&rt, daddr, rt->rt_spec_dst, RT_TOS(skb->nh.iph->tos), sk->bound_dev_if))
+#else
 	if (ip_route_output(&rt, daddr, rt->rt_spec_dst, RT_TOS(skb->nh.iph->tos), 0))
+#endif
 		return;
 
 	/* And let IP do all the hard work.
--- linux-2.4.19/net/ipv4/tcp_ipv4.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19.dev/net/ipv4/tcp_ipv4.c	Sun Sep 15 21:25:42 2002
@@ -865,21 +865,36 @@
 	return h&(TCP_SYNQ_HSIZE-1);
 }
 
+/** Netdevice ID can be wild-carded by making it zero.
+ */
 static struct open_request *tcp_v4_search_req(struct tcp_opt *tp, 
 					      struct open_request ***prevp,
 					      __u16 rport,
-					      __u32 raddr, __u32 laddr)
+					      __u32 raddr, __u32 laddr,
+                                              int netdevice_id)
 {
 	struct tcp_listen_opt *lopt = tp->listen_opt;
 	struct open_request *req, **prev;  
 
+        /* Will only take netdevice_id into the equation if neither are
+         * 0.  This should be backwards compatible with older code, and also
+         * let us connect to ourselves over external ports.  Otherwise, we
+         * get confused about which connection is the originator v/s the
+         * receiver of the open request. --Ben
+         */
 	for (prev = &lopt->syn_table[tcp_v4_synq_hash(raddr, rport)];
 	     (req = *prev) != NULL;
 	     prev = &req->dl_next) {
 		if (req->rmt_port == rport &&
 		    req->af.v4_req.rmt_addr == raddr &&
 		    req->af.v4_req.loc_addr == laddr &&
-		    TCP_INET_FAMILY(req->class->family)) {
+		    TCP_INET_FAMILY(req->class->family)
+#ifdef CONFIG_NET_SENDTOSELF
+                    && ((!netdevice_id) || (!req->bound_dev_if) ||
+                     (req->bound_dev_if == netdevice_id))) {
+#else
+                   ) {
+#endif
 			BUG_TRAP(req->sk == NULL);
 			*prevp = prev;
 			return req; 
@@ -899,7 +914,10 @@
 	req->retrans = 0;
 	req->sk = NULL;
 	req->dl_next = lopt->syn_table[h];
-
+#ifdef CONFIG_NET_SENDTOSELF
+        req->bound_dev_if = sk->bound_dev_if;
+#endif
+        
 	write_lock(&tp->syn_wait_lock);
 	lopt->syn_table[h] = req;
 	write_unlock(&tp->syn_wait_lock);
@@ -979,7 +997,8 @@
 	struct sock *sk;
 	__u32 seq;
 	int err;
-
+        int netdevice_id = 0;
+        
 	if (skb->len < (iph->ihl << 2) + 8) {
 		ICMP_INC_STATS_BH(IcmpInErrors); 
 		return;
@@ -1048,9 +1067,13 @@
 		if (sk->lock.users != 0)
 			goto out;
 
+                if (skb->dev) {
+                        netdevice_id = skb->dev->ifindex;
+                }
+                
 		req = tcp_v4_search_req(tp, &prev,
 					th->dest,
-					iph->daddr, iph->saddr); 
+					iph->daddr, iph->saddr, netdevice_id);
 		if (!req)
 			goto out;
 
@@ -1394,7 +1417,7 @@
 #define want_cookie 0 /* Argh, why doesn't gcc optimize this :( */
 #endif
 
-	/* Never answer to SYNs send to broadcast or multicast */
+	/* Never answer to SYNs sent to broadcast or multicast */
 	if (((struct rtable *)skb->dst)->rt_flags & 
 	    (RTCF_BROADCAST|RTCF_MULTICAST))
 		goto drop; 
@@ -1452,6 +1475,10 @@
 	req->af.v4_req.rmt_addr = saddr;
 	req->af.v4_req.opt = tcp_v4_save_options(sk, skb);
 	req->class = &or_ipv4;
+#ifdef CONFIG_NET_SENDTOSELF
+        req->bound_dev_if = sk->bound_dev_if;
+#endif
+        
 	if (!want_cookie)
 		TCP_ECN_create_request(req, skb->h.th);
 
@@ -1587,11 +1614,12 @@
 	struct iphdr *iph = skb->nh.iph;
 	struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
 	struct sock *nsk;
-
+        int device_id = tcp_v4_iif(skb);
+        
 	/* Find possible connection requests. */
 	req = tcp_v4_search_req(tp, &prev,
 				th->source,
-				iph->saddr, iph->daddr);
+				iph->saddr, iph->daddr, device_id);
 	if (req)
 		return tcp_check_req(sk, skb, req, prev);
 
@@ -1599,7 +1627,7 @@
 					  th->source,
 					  skb->nh.iph->daddr,
 					  ntohs(th->dest),
-					  tcp_v4_iif(skb));
+					  device_id);
 
 	if (nsk) {
 		if (nsk->state != TCP_TIME_WAIT) {

--------------010703030901020509080500--

