Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSIOGj0>; Sun, 15 Sep 2002 02:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSIOGj0>; Sun, 15 Sep 2002 02:39:26 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:1740 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317865AbSIOGjV>;
	Sun, 15 Sep 2002 02:39:21 -0400
Message-ID: <3D842C3C.6000205@candelatech.com>
Date: Sat, 14 Sep 2002 23:44:12 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Enable sending network traffic to local machine over external
 interfaces.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should allow one to connect over external interface (ie eth1, eth2)
and actually have traffic pass externally to the box, not routed internally
as now.  This is of primary interest to folks wanting to make traffic generators
and the like, but it should also be useful for certain HA applications where
testing path continuity is desired....

This patch also fixes what I believe is a bug in the SO_BINDTODEVICE
implementation (the first syn-ack was not being routed based on the
bound-device of the listening socket, but was being routed as if it
came from loopback_dev)

I have tested ARP, UDP, and TCP/IP traffic, but please consider this
beta quality at best.  Comments and suggestions are welcome! :)

To use this feature, code like this must be written in user space:

// Enable an interface to receive packets who's source was our
// local machine.  By default, we will not do this.
                // query to see if we are set up for send-to-self
                strcpy(ifr.ifr_name, dev_name);
                ifr.ifr_addr.sa_family = AF_INET;
                if (ioctl(fd, 0x89a1, &ifr) < 0) {
                   VLOG_ERR(VLOG << "ERROR: ioctl(0x89a1): " << strerror(errno)
                            << " ifr.ifr_name -:" << ifr.ifr_name << ":-" << endl);
                }
                //result is stored in ifr.ifr_flags, 0 or 1

                // Try to make send_to_self true
                memset(&ifr, 0, sizeof(struct ifreq));
                strcpy(ifr.ifr_name, dev_name);
                ifr.ifr_addr.sa_family = AF_INET;
                ifr.ifr_flags = 1;
                if (ioctl(fd, 0x89a0, &ifr) < 0) {
                   VLOG_ERR(VLOG << "ERROR: ioctl(0x89a0): " << strerror(errno)
                            << " ifr.ifr_name -:" << ifr.ifr_name << ":-" << endl);
                }

When using sockets, be sure to use the SO_BINDTODEVICE option before
opening or using a socket.

       // Bind to specific device.
       if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE,
                      dev_to_bind_to, DEV_NAME_LEN + 1)) {
          VLOG_ERR(VLOG << "ERROR:  tcp-connect, setsockopt (BINDTODEVICE):  "
                   << strerror(errno) << "  Not fatal in most cases..continuing...\n");
       }


Here is the patch, pasted from a larger patch.  Hopefully it will apply
without problem to 2.4.20-pre7.  I have a full patch with pktgen updates
in it as well if anyone wants the full thing as an attachment...


diff -u -r -N -X /home/greear/exclude.list linux-2.4.19/include/linux/if.h linux-2.4.19.dev/include/linux/if.h
--- linux-2.4.19/include/linux/if.h	Thu Nov 22 12:47:07 2001
+++ linux-2.4.19.dev/include/linux/if.h	Sat Sep 14 22:04:50 2002
@@ -47,6 +47,12 @@

  /* Private (from user) interface flags (netdevice->priv_flags). */
  #define IFF_802_1Q_VLAN 0x1             /* 802.1Q VLAN device.          */
+#define IFF_PKTGEN_RCV  0x2             /* Registered to receive & consume  Pktgen skbs */
+#define IFF_ACCEPT_LOCAL_ADDRS 0x4      /**  Accept pkts even if they come from a local
+                                         * address.  This lets use send pkts to ourselves
+                                         * over external interfaces (when used in conjunction
+                                         * with SO_BINDTODEVICE
+                                         */

  /*
   *	Device mapping structure. I'd just gone off and designed a
diff -u -r -N -X /home/greear/exclude.list linux-2.4.19/include/linux/netdevice.h linux-2.4.19.dev/include/linux/netdevice.h
--- linux-2.4.19/include/linux/netdevice.h	Sat Sep 14 22:13:44 2002
+++ linux-2.4.19.dev/include/linux/netdevice.h	Sat Sep 14 22:04:51 2002
@@ -296,7 +296,9 @@

  	unsigned short		flags;	/* interface flags (a la BSD)	*/
  	unsigned short		gflags;
-        unsigned short          priv_flags; /* Like 'flags' but invisible to userspace. */
+        unsigned short          priv_flags; /* Like 'flags' but invisible to userspace,
+                                             * see: if.h for flag definitions.
+                                             */
          unsigned short          unused_alignment_fixer; /* Because we need priv_flags,
                                                           * and we want to be 32-bit aligned.
                                                           */
@@ -438,6 +440,7 @@
  	/* this will get initialized at each interface type init routine */
  	struct divert_blk	*divert;
  #endif /* CONFIG_NET_DIVERT */
+
  };


diff -u -r -N -X /home/greear/exclude.list linux-2.4.19/include/linux/sockios.h linux-2.4.19.dev/include/linux/sockios.h
--- linux-2.4.19/include/linux/sockios.h	Wed Nov  7 15:39:36 2001
+++ linux-2.4.19.dev/include/linux/sockios.h	Sat Sep 14 21:42:29 2002
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
diff -u -r -N -X /home/greear/exclude.list linux-2.4.19/include/net/tcp.h linux-2.4.19.dev/include/net/tcp.h
--- linux-2.4.19/include/net/tcp.h	Sat Sep 14 22:13:45 2002
+++ linux-2.4.19.dev/include/net/tcp.h	Sat Sep 14 22:26:37 2002
@@ -519,6 +519,12 @@
  		struct tcp_v6_open_req v6_req;
  #endif
  	} af;
+        int bound_dev_if; /* This is so we can connect to ourselves and not collide
+                           * in the open-request hash (the addresses and ports are the
+                           * same, but we need two ends, so use the interface to determine
+                           * one from the other.  Active when SO_BINDTODEVICE is used.
+                           * --Ben
+                           */
  };

  /* SLAB cache for open requests. */
diff -u -r -N -X /home/greear/exclude.list linux-2.4.19/net/core/dev.c linux-2.4.19.dev/net/core/dev.c
--- linux-2.4.19/net/core/dev.c	Sat Sep 14 22:13:45 2002
+++ linux-2.4.19.dev/net/core/dev.c	Sat Sep 14 21:42:29 2002
@@ -2151,6 +2181,24 @@
  			notifier_call_chain(&netdev_chain, NETDEV_CHANGENAME, dev);
  			return 0;

+                case SIOCSACCEPTLOCALADDRS:
+                        if (ifr->ifr_flags) {
+                                dev->priv_flags |= IFF_ACCEPT_LOCAL_ADDRS;
+                        }
+                        else {
+                                dev->priv_flags &= ~IFF_ACCEPT_LOCAL_ADDRS;
+                        }
+                        return 0;
+
+                case SIOCGACCEPTLOCALADDRS:
+                        if (dev->priv_flags & IFF_ACCEPT_LOCAL_ADDRS) {
+                                ifr->ifr_flags = 1;
+                        }
+                        else {
+                                ifr->ifr_flags = 0;
+                        }
+                        return 0;
+
  		/*
  		 *	Unknown or private ioctl
  		 */
@@ -2247,6 +2295,7 @@
  		case SIOCGIFMAP:
  		case SIOCGIFINDEX:
  		case SIOCGIFTXQLEN:
+                case SIOCGACCEPTLOCALADDRS:
  			dev_load(ifr.ifr_name);
  			read_lock(&dev_base_lock);
  			ret = dev_ifsioc(&ifr, cmd);
@@ -2310,6 +2359,7 @@
  		case SIOCBONDSLAVEINFOQUERY:
  		case SIOCBONDINFOQUERY:
  		case SIOCBONDCHANGEACTIVE:
+                case SIOCSACCEPTLOCALADDRS:
  			if (!capable(CAP_NET_ADMIN))
  				return -EPERM;
  			dev_load(ifr.ifr_name);
diff -u -r -N -X /home/greear/exclude.list linux-2.4.19/net/ipv4/arp.c linux-2.4.19.dev/net/ipv4/arp.c
--- linux-2.4.19/net/ipv4/arp.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19.dev/net/ipv4/arp.c	Sat Sep 14 21:58:57 2002
@@ -1,4 +1,4 @@
-/* linux/net/inet/arp.c
+/* linux/net/inet/arp.c  -*-linux-c-*-
   *
   * Version:	$Id: arp.c,v 1.99 2001/08/30 22:55:42 davem Exp $
   *
@@ -351,12 +351,22 @@
  	int flag = 0;
  	/*unsigned long now; */

-	if (ip_route_output(&rt, sip, tip, 0, 0) < 0)
+	if (ip_route_output(&rt, sip, tip, 0, 0) < 0) {
  		return 1;
-	if (rt->u.dst.dev != dev) {
-		NET_INC_STATS_BH(ArpFilter);
-		flag = 1;
-	}
+        }
+	if (rt->u.dst.dev != dev) {
+                if ((dev->priv_flags & IFF_ACCEPT_LOCAL_ADDRS) &&
+                    (rt->u.dst.dev == &loopback_dev))  {
+                        /* OK, we'll let this special case slide, so that we can arp from one
+                         * local interface to another.  This seems to work, but could use some
+                         * review. --Ben
+                         */
+                }
+                else {
+                        NET_INC_STATS_BH(ArpFilter);
+                        flag = 1;
+                }
+        }
  	ip_rt_put(rt);
  	return flag;
  }
diff -u -r -N -X /home/greear/exclude.list linux-2.4.19/net/ipv4/fib_frontend.c linux-2.4.19.dev/net/ipv4/fib_frontend.c
--- linux-2.4.19/net/ipv4/fib_frontend.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19.dev/net/ipv4/fib_frontend.c	Sat Sep 14 21:42:29 2002
@@ -228,13 +228,24 @@
  	}
  	read_unlock(&inetdev_lock);

-	if (in_dev == NULL)
+	if (in_dev == NULL) {
  		goto e_inval;
+        }

-	if (fib_lookup(&key, &res))
+	if (fib_lookup(&key, &res)) {
  		goto last_resort;
-	if (res.type != RTN_UNICAST)
-		goto e_inval_res;
+        }
+
+	if (res.type != RTN_UNICAST) {
+                if ((res.type == RTN_LOCAL) &&
+                    (dev->priv_flags & IFF_ACCEPT_LOCAL_ADDRS)) {
+                     /* All is OK */
+                }
+                else {
+                     goto e_inval_res;
+                }
+        }
+
  	*spec_dst = FIB_RES_PREFSRC(res);
  	fib_combine_itag(itag, &res);
  #ifdef CONFIG_IP_ROUTE_MULTIPATH
diff -u -r -N -X /home/greear/exclude.list linux-2.4.19/net/ipv4/ip_output.c linux-2.4.19.dev/net/ipv4/ip_output.c
--- linux-2.4.19/net/ipv4/ip_output.c	Sat Sep 14 22:13:47 2002
+++ linux-2.4.19.dev/net/ipv4/ip_output.c	Sat Sep 14 21:44:58 2002
@@ -975,7 +975,7 @@
  			daddr = replyopts.opt.faddr;
  	}

-	if (ip_route_output(&rt, daddr, rt->rt_spec_dst, RT_TOS(skb->nh.iph->tos), 0))
+	if (ip_route_output(&rt, daddr, rt->rt_spec_dst, RT_TOS(skb->nh.iph->tos), sk->bound_dev_if))
  		return;

  	/* And let IP do all the hard work.
diff -u -r -N -X /home/greear/exclude.list linux-2.4.19/net/ipv4/tcp_ipv4.c linux-2.4.19.dev/net/ipv4/tcp_ipv4.c
--- linux-2.4.19/net/ipv4/tcp_ipv4.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19.dev/net/ipv4/tcp_ipv4.c	Sat Sep 14 21:54:51 2002
@@ -865,21 +865,32 @@
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
+		    TCP_INET_FAMILY(req->class->family) &&
+                    ((!netdevice_id) || (!req->bound_dev_if) ||
+                     (req->bound_dev_if == netdevice_id))) {
  			BUG_TRAP(req->sk == NULL);
  			*prevp = prev;
  			return req;
@@ -899,7 +910,8 @@
  	req->retrans = 0;
  	req->sk = NULL;
  	req->dl_next = lopt->syn_table[h];
-
+        req->bound_dev_if = sk->bound_dev_if;
+
  	write_lock(&tp->syn_wait_lock);
  	lopt->syn_table[h] = req;
  	write_unlock(&tp->syn_wait_lock);
@@ -979,7 +991,8 @@
  	struct sock *sk;
  	__u32 seq;
  	int err;
-
+        int netdevice_id = 0;
+
  	if (skb->len < (iph->ihl << 2) + 8) {
  		ICMP_INC_STATS_BH(IcmpInErrors);
  		return;
@@ -1048,9 +1061,13 @@
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

@@ -1394,7 +1411,7 @@
  #define want_cookie 0 /* Argh, why doesn't gcc optimize this :( */
  #endif

-	/* Never answer to SYNs send to broadcast or multicast */
+	/* Never answer to SYNs sent to broadcast or multicast */
  	if (((struct rtable *)skb->dst)->rt_flags &
  	    (RTCF_BROADCAST|RTCF_MULTICAST))
  		goto drop;
@@ -1452,6 +1469,8 @@
  	req->af.v4_req.rmt_addr = saddr;
  	req->af.v4_req.opt = tcp_v4_save_options(sk, skb);
  	req->class = &or_ipv4;
+        req->bound_dev_if = sk->bound_dev_if;
+
  	if (!want_cookie)
  		TCP_ECN_create_request(req, skb->h.th);

@@ -1587,11 +1606,12 @@
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

@@ -1599,7 +1619,7 @@
  					  th->source,
  					  skb->nh.iph->daddr,
  					  ntohs(th->dest),
-					  tcp_v4_iif(skb));
+					  device_id);

  	if (nsk) {
  		if (nsk->state != TCP_TIME_WAIT) {





-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


