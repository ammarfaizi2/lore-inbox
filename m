Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281562AbRLAL32>; Sat, 1 Dec 2001 06:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284071AbRLAL3L>; Sat, 1 Dec 2001 06:29:11 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:43919 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S281562AbRLAL2r>; Sat, 1 Dec 2001 06:28:47 -0500
Date: Sat, 1 Dec 2001 13:33:36 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] if (foo) kfree(foo) /net cleanup
Message-ID: <Pine.LNX.4.33.0112011332290.11026-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch to remove extraneous if (foo) check.

Zwane Mwaikambo

diffed against 2.5.1-pre4

diff -urN linux-2.5.1-pre4.orig/net/802/p8023.c linux-2.5.1-pre4.kfree/net/802/p8023.c
--- linux-2.5.1-pre4.orig/net/802/p8023.c	Wed Jul 19 01:09:27 2000
+++ linux-2.5.1-pre4.kfree/net/802/p8023.c	Sat Dec  1 00:26:52 2001
@@ -56,7 +56,6 @@

 void destroy_8023_client(struct datalink_proto *dl)
 {
-	if (dl)
-		kfree(dl);
+	kfree(dl);
 }

diff -urN linux-2.5.1-pre4.orig/net/ax25/af_ax25.c linux-2.5.1-pre4.kfree/net/ax25/af_ax25.c
--- linux-2.5.1-pre4.orig/net/ax25/af_ax25.c	Fri Sep 14 02:16:23 2001
+++ linux-2.5.1-pre4.kfree/net/ax25/af_ax25.c	Sat Dec  1 00:30:58 2001
@@ -149,11 +149,8 @@
  */
 void ax25_free_cb(ax25_cb *ax25)
 {
-	if (ax25->digipeat != NULL) {
-		kfree(ax25->digipeat);
-		ax25->digipeat = NULL;
-	}
-
+	kfree(ax25->digipeat);
+	ax25->digipeat = NULL;
 	kfree(ax25);

 	MOD_DEC_USE_COUNT;
@@ -1157,11 +1154,9 @@
 	if (fsa->fsa_ax25.sax25_family != AF_AX25)
 		return -EINVAL;

-	if (sk->protinfo.ax25->digipeat != NULL) {
-		kfree(sk->protinfo.ax25->digipeat);
-		sk->protinfo.ax25->digipeat = NULL;
-	}
-
+	kfree(sk->protinfo.ax25->digipeat);
+	sk->protinfo.ax25->digipeat = NULL;
+
 	/*
 	 *	Handle digi-peaters to be used.
 	 */
@@ -1207,7 +1202,7 @@
 	}

 	if (sk->type == SOCK_SEQPACKET && ax25_find_cb(&sk->protinfo.ax25->source_addr, &fsa->fsa_ax25.sax25_call, digi, sk->protinfo.ax25->ax25_dev->dev) != NULL) {
-		if (digi != NULL) kfree(digi);
+		kfree(digi);
 		return -EADDRINUSE;			/* Already such a connection */
 	}

diff -urN linux-2.5.1-pre4.orig/net/ax25/ax25_in.c linux-2.5.1-pre4.kfree/net/ax25/ax25_in.c
--- linux-2.5.1-pre4.orig/net/ax25/ax25_in.c	Sun Sep  9 19:52:35 2001
+++ linux-2.5.1-pre4.kfree/net/ax25/ax25_in.c	Sat Dec  1 00:28:39 2001
@@ -425,10 +425,8 @@
 	}

 	if (dp.ndigi == 0) {
-		if (ax25->digipeat != NULL) {
-			kfree(ax25->digipeat);
-			ax25->digipeat = NULL;
-		}
+		kfree(ax25->digipeat);
+		ax25->digipeat = NULL;
 	} else {
 		/* Reverse the source SABM's path */
 		memcpy(ax25->digipeat, &reverse_dp, sizeof(ax25_digi));
diff -urN linux-2.5.1-pre4.orig/net/ax25/ax25_route.c linux-2.5.1-pre4.kfree/net/ax25/ax25_route.c
--- linux-2.5.1-pre4.orig/net/ax25/ax25_route.c	Sat Dec 30 00:35:47 2000
+++ linux-2.5.1-pre4.kfree/net/ax25/ax25_route.c	Sat Dec  1 00:34:21 2001
@@ -95,15 +95,15 @@
 		if (s->dev == dev) {
 			if (ax25_route_list == s) {
 				ax25_route_list = s->next;
-				if (s->digipeat != NULL)
-					kfree(s->digipeat);
+
+				kfree(s->digipeat);
 				kfree(s);
 			} else {
 				for (t = ax25_route_list; t != NULL; t = t->next) {
 					if (t->next == s) {
 						t->next = s->next;
-						if (s->digipeat != NULL)
-							kfree(s->digipeat);
+
+						kfree(s->digipeat);
 						kfree(s);
 						break;
 					}
@@ -132,10 +132,9 @@
 				return -EINVAL;
 			for (ax25_rt = ax25_route_list; ax25_rt != NULL; ax25_rt = ax25_rt->next) {
 				if (ax25cmp(&ax25_rt->callsign, &route.dest_addr) == 0 && ax25_rt->dev == ax25_dev->dev) {
-					if (ax25_rt->digipeat != NULL) {
-						kfree(ax25_rt->digipeat);
-						ax25_rt->digipeat = NULL;
-					}
+					kfree(ax25_rt->digipeat);
+					ax25_rt->digipeat = NULL;
+
 					if (route.digi_count != 0) {
 						if ((ax25_rt->digipeat = kmalloc(sizeof(ax25_digi), GFP_ATOMIC)) == NULL)
 							return -ENOMEM;
@@ -185,15 +184,14 @@
 				if (s->dev == ax25_dev->dev && ax25cmp(&route.dest_addr, &s->callsign) == 0) {
 					if (ax25_route_list == s) {
 						ax25_route_list = s->next;
-						if (s->digipeat != NULL)
-							kfree(s->digipeat);
+						kfree(s->digipeat);
 						kfree(s);
 					} else {
 						for (t = ax25_route_list; t != NULL; t = t->next) {
 							if (t->next == s) {
 								t->next = s->next;
-								if (s->digipeat != NULL)
-									kfree(s->digipeat);
+
+								kfree(s->digipeat);
 								kfree(s);
 								break;
 							}
@@ -444,9 +442,7 @@
 		s       = ax25_rt;
 		ax25_rt = ax25_rt->next;

-		if (s->digipeat != NULL)
-			kfree(s->digipeat);
-
+		kfree(s->digipeat);
 		kfree(s);
 	}
 }
diff -urN linux-2.5.1-pre4.orig/net/core/dev_mcast.c linux-2.5.1-pre4.kfree/net/core/dev_mcast.c
--- linux-2.5.1-pre4.orig/net/core/dev_mcast.c	Mon Oct 16 21:43:50 2000
+++ linux-2.5.1-pre4.kfree/net/core/dev_mcast.c	Sat Dec  1 00:38:37 2001
@@ -192,8 +192,7 @@

 done:
 	spin_unlock_bh(&dev->xmit_lock);
-	if (dmi1)
-		kfree(dmi1);
+	kfree(dmi1);
 	return err;
 }

diff -urN linux-2.5.1-pre4.orig/net/core/sock.c linux-2.5.1-pre4.kfree/net/core/sock.c
--- linux-2.5.1-pre4.orig/net/core/sock.c	Sat Jul 28 21:12:38 2001
+++ linux-2.5.1-pre4.kfree/net/core/sock.c	Sat Dec  1 00:38:06 2001
@@ -1144,8 +1144,7 @@

 void sock_def_destruct(struct sock *sk)
 {
-	if (sk->protinfo.destruct_hook)
-		kfree(sk->protinfo.destruct_hook);
+	kfree(sk->protinfo.destruct_hook);
 }

 void sock_init_data(struct socket *sock, struct sock *sk)
diff -urN linux-2.5.1-pre4.orig/net/decnet/dn_table.c linux-2.5.1-pre4.kfree/net/decnet/dn_table.c
--- linux-2.5.1-pre4.orig/net/decnet/dn_table.c	Mon Jan 22 23:32:10 2001
+++ linux-2.5.1-pre4.kfree/net/decnet/dn_table.c	Sat Dec  1 01:00:37 2001
@@ -877,9 +877,7 @@
         dn_fib_tables[n] = NULL;
         write_unlock(&dn_fib_tables_lock);

-        if (t) {
-                kfree(t);
-        }
+	kfree(t);
 }

 struct dn_fib_table *dn_fib_empty_table(void)
diff -urN linux-2.5.1-pre4.orig/net/ethernet/pe2.c linux-2.5.1-pre4.kfree/net/ethernet/pe2.c
--- linux-2.5.1-pre4.orig/net/ethernet/pe2.c	Wed Jul 19 01:09:27 2000
+++ linux-2.5.1-pre4.kfree/net/ethernet/pe2.c	Sat Dec  1 00:59:33 2001
@@ -33,6 +33,5 @@

 void destroy_EII_client(struct datalink_proto *dl)
 {
-	if (dl)
-		kfree(dl);
+	kfree(dl);
 }
diff -urN linux-2.5.1-pre4.orig/net/ipv4/af_inet.c linux-2.5.1-pre4.kfree/net/ipv4/af_inet.c
--- linux-2.5.1-pre4.orig/net/ipv4/af_inet.c	Mon Nov  5 19:46:12 2001
+++ linux-2.5.1-pre4.kfree/net/ipv4/af_inet.c	Sat Dec  1 00:45:56 2001
@@ -175,8 +175,7 @@
 	BUG_TRAP(sk->wmem_queued == 0);
 	BUG_TRAP(sk->forward_alloc == 0);

-	if (sk->protinfo.af_inet.opt)
-		kfree(sk->protinfo.af_inet.opt);
+	kfree(sk->protinfo.af_inet.opt);
 	dst_release(sk->dst_cache);
 #ifdef INET_REFCNT_DEBUG
 	atomic_dec(&inet_sock_nr);
diff -urN linux-2.5.1-pre4.orig/net/ipv4/fib_frontend.c linux-2.5.1-pre4.kfree/net/ipv4/fib_frontend.c
--- linux-2.5.1-pre4.orig/net/ipv4/fib_frontend.c	Tue Jun 12 04:15:27 2001
+++ linux-2.5.1-pre4.kfree/net/ipv4/fib_frontend.c	Sat Dec  1 00:46:33 2001
@@ -314,8 +314,7 @@
 				if (tb)
 					err = tb->tb_insert(tb, &req.rtm, &rta, &req.nlh, NULL);
 			}
-			if (rta.rta_mx)
-				kfree(rta.rta_mx);
+			kfree(rta.rta_mx);
 		}
 		rtnl_unlock();
 		return err;
diff -urN linux-2.5.1-pre4.orig/net/ipv4/ip_sockglue.c linux-2.5.1-pre4.kfree/net/ipv4/ip_sockglue.c
--- linux-2.5.1-pre4.orig/net/ipv4/ip_sockglue.c	Wed Oct 31 01:08:12 2001
+++ linux-2.5.1-pre4.kfree/net/ipv4/ip_sockglue.c	Sat Dec  1 00:41:19 2001
@@ -202,8 +202,7 @@
 		if (ra->sk == sk) {
 			if (on) {
 				write_unlock_bh(&ip_ra_lock);
-				if (new_ra)
-					kfree(new_ra);
+				kfree(new_ra);
 				return -EADDRINUSE;
 			}
 			*rap = ra->next;
@@ -439,8 +438,7 @@
 #endif
 			}
 			opt = xchg(&sk->protinfo.af_inet.opt, opt);
-			if (opt)
-				kfree(opt);
+			kfree(opt);
 			break;
 		}
 		case IP_PKTINFO:
diff -urN linux-2.5.1-pre4.orig/net/ipv4/netfilter/ip_nat_snmp_basic.c linux-2.5.1-pre4.kfree/net/ipv4/netfilter/ip_nat_snmp_basic.c
--- linux-2.5.1-pre4.orig/net/ipv4/netfilter/ip_nat_snmp_basic.c	Wed Oct 31 01:08:12 2001
+++ linux-2.5.1-pre4.kfree/net/ipv4/netfilter/ip_nat_snmp_basic.c	Sat Dec  1 00:44:24 2001
@@ -1158,11 +1158,8 @@
 		unsigned int i;

 		if (!snmp_object_decode(&ctx, obj)) {
-			if (*obj) {
-				if ((*obj)->id)
-					kfree((*obj)->id);
-				kfree(*obj);
-			}
+			kfree((*obj)->id);
+			kfree(*obj);
 			kfree(obj);
 			return 0;
 		}
diff -urN linux-2.5.1-pre4.orig/net/ipv4/tcp_ipv4.c linux-2.5.1-pre4.kfree/net/ipv4/tcp_ipv4.c
--- linux-2.5.1-pre4.orig/net/ipv4/tcp_ipv4.c	Mon Nov  5 19:46:12 2001
+++ linux-2.5.1-pre4.kfree/net/ipv4/tcp_ipv4.c	Sat Dec  1 00:39:54 2001
@@ -1207,8 +1207,7 @@
  */
 static void tcp_v4_or_free(struct open_request *req)
 {
-	if (req->af.v4_req.opt)
-		kfree(req->af.v4_req.opt);
+	kfree(req->af.v4_req.opt);
 }

 static inline void syn_flood_warning(struct sk_buff *skb)
diff -urN linux-2.5.1-pre4.orig/net/ipv6/ip6_flowlabel.c linux-2.5.1-pre4.kfree/net/ipv6/ip6_flowlabel.c
--- linux-2.5.1-pre4.orig/net/ipv6/ip6_flowlabel.c	Mon Aug  7 07:20:09 2000
+++ linux-2.5.1-pre4.kfree/net/ipv6/ip6_flowlabel.c	Sat Dec  1 00:49:20 2001
@@ -85,8 +85,7 @@

 static void fl_free(struct ip6_flowlabel *fl)
 {
-	if (fl->opt)
-		kfree(fl->opt);
+	kfree(fl->opt);
 	kfree(fl);
 }

@@ -346,8 +345,7 @@
 	return fl;

 done:
-	if (fl)
-		fl_free(fl);
+	fl_free(fl);
 	*err_p = err;
 	return NULL;
 }
@@ -544,10 +542,8 @@
 	}

 done:
-	if (fl)
-		fl_free(fl);
-	if (sfl1)
-		kfree(sfl1);
+	fl_free(fl);
+	kfree(sfl1);
 	return err;
 }

diff -urN linux-2.5.1-pre4.orig/net/ipv6/ipv6_sockglue.c linux-2.5.1-pre4.kfree/net/ipv6/ipv6_sockglue.c
--- linux-2.5.1-pre4.orig/net/ipv6/ipv6_sockglue.c	Thu Sep 20 23:12:56 2001
+++ linux-2.5.1-pre4.kfree/net/ipv6/ipv6_sockglue.c	Sat Dec  1 00:47:10 2001
@@ -89,8 +89,7 @@
 		if (ra->sk == sk) {
 			if (sel>=0) {
 				write_unlock_bh(&ip6_ra_lock);
-				if (new_ra)
-					kfree(new_ra);
+				kfree(new_ra);
 				return -EADDRINUSE;
 			}

diff -urN linux-2.5.1-pre4.orig/net/irda/irias_object.c linux-2.5.1-pre4.kfree/net/irda/irias_object.c
--- linux-2.5.1-pre4.orig/net/irda/irias_object.c	Fri Oct  5 03:41:09 2001
+++ linux-2.5.1-pre4.kfree/net/irda/irias_object.c	Sat Dec  1 00:51:39 2001
@@ -110,8 +110,7 @@
 	ASSERT(attrib != NULL, return;);
 	ASSERT(attrib->magic == IAS_ATTRIB_MAGIC, return;);

-	if (attrib->name)
-		kfree(attrib->name);
+	kfree(attrib->name);

 	irias_delete_value(attrib->value);
 	attrib->magic = ~IAS_ATTRIB_MAGIC;
@@ -124,8 +123,7 @@
 	ASSERT(obj != NULL, return;);
 	ASSERT(obj->magic == IAS_OBJECT_MAGIC, return;);

-	if (obj->name)
-		kfree(obj->name);
+	kfree(obj->name);

 	hashbin_delete(obj->attribs, (FREE_FUNC) __irias_delete_attrib);

@@ -522,13 +520,11 @@
 		break;
 	case IAS_STRING:
 		/* If string, deallocate string */
-		if (value->t.string != NULL)
-			kfree(value->t.string);
+		kfree(value->t.string);
 		break;
 	case IAS_OCT_SEQ:
 		/* If byte stream, deallocate byte stream */
-		 if (value->t.oct_seq != NULL)
-			 kfree(value->t.oct_seq);
+		  kfree(value->t.oct_seq);
 		 break;
 	default:
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown value type!\n");
diff -urN linux-2.5.1-pre4.orig/net/irda/irlmp.c linux-2.5.1-pre4.kfree/net/irda/irlmp.c
--- linux-2.5.1-pre4.orig/net/irda/irlmp.c	Sat Nov 10 00:22:17 2001
+++ linux-2.5.1-pre4.kfree/net/irda/irlmp.c	Sat Dec  1 00:52:46 2001
@@ -1385,8 +1385,7 @@
 	}

 	service = hashbin_remove(irlmp->services, handle, NULL);
-	if (service)
-		kfree(service);
+	kfree(service);

 	/* Remove old hint bits */
 	irlmp->hints.word = 0;
@@ -1496,8 +1495,7 @@

 	IRDA_DEBUG( 4, __FUNCTION__ "(), removing client!\n");
 	client = hashbin_remove( irlmp->clients, handle, NULL);
-	if (client)
-		kfree(client);
+	kfree(client);

 	return 0;
 }
diff -urN linux-2.5.1-pre4.orig/net/netrom/nr_route.c linux-2.5.1-pre4.kfree/net/netrom/nr_route.c
--- linux-2.5.1-pre4.orig/net/netrom/nr_route.c	Sat Dec 30 00:44:46 2000
+++ linux-2.5.1-pre4.kfree/net/netrom/nr_route.c	Sat Dec  1 01:08:47 2001
@@ -294,8 +294,7 @@
 	if ((s = nr_neigh_list) == nr_neigh) {
 		nr_neigh_list = nr_neigh->next;
 		restore_flags(flags);
-		if (nr_neigh->digipeat != NULL)
-			kfree(nr_neigh->digipeat);
+		kfree(nr_neigh->digipeat);
 		kfree(nr_neigh);
 		return;
 	}
@@ -304,8 +303,7 @@
 		if (s->next == nr_neigh) {
 			s->next = nr_neigh->next;
 			restore_flags(flags);
-			if (nr_neigh->digipeat != NULL)
-				kfree(nr_neigh->digipeat);
+			kfree(nr_neigh->digipeat);
 			kfree(nr_neigh);
 			return;
 		}
diff -urN linux-2.5.1-pre4.orig/net/packet/af_packet.c linux-2.5.1-pre4.kfree/net/packet/af_packet.c
--- linux-2.5.1-pre4.orig/net/packet/af_packet.c	Wed Oct 31 01:08:12 2001
+++ linux-2.5.1-pre4.kfree/net/packet/af_packet.c	Sat Dec  1 01:11:49 2001
@@ -209,8 +209,7 @@
 		return;
 	}

-	if (sk->protinfo.destruct_hook)
-		kfree(sk->protinfo.destruct_hook);
+	kfree(sk->protinfo.destruct_hook);
 	atomic_dec(&packet_socks_nr);
 #ifdef PACKET_REFCNT_DEBUG
 	printk(KERN_DEBUG "PACKET socket %p is free, %d are alive\n", sk, atomic_read(&packet_socks_nr));
@@ -1729,8 +1728,7 @@

 	release_sock(sk);

-	if (io_vec)
-		kfree(io_vec);
+	kfree(io_vec);

 out_free_pgvec:
 	if (pg_vec)
diff -urN linux-2.5.1-pre4.orig/net/rose/rose_route.c linux-2.5.1-pre4.kfree/net/rose/rose_route.c
--- linux-2.5.1-pre4.orig/net/rose/rose_route.c	Sat Jun 30 04:38:26 2001
+++ linux-2.5.1-pre4.kfree/net/rose/rose_route.c	Sat Dec  1 00:53:48 2001
@@ -232,8 +232,7 @@
 	if ((s = rose_neigh_list) == rose_neigh) {
 		rose_neigh_list = rose_neigh->next;
 		restore_flags(flags);
-		if (rose_neigh->digipeat != NULL)
-			kfree(rose_neigh->digipeat);
+		kfree(rose_neigh->digipeat);
 		kfree(rose_neigh);
 		return;
 	}
@@ -242,8 +241,7 @@
 		if (s->next == rose_neigh) {
 			s->next = rose_neigh->next;
 			restore_flags(flags);
-			if (rose_neigh->digipeat != NULL)
-				kfree(rose_neigh->digipeat);
+			kfree(rose_neigh->digipeat);
 			kfree(rose_neigh);
 			return;
 		}
diff -urN linux-2.5.1-pre4.orig/net/sched/cls_fw.c linux-2.5.1-pre4.kfree/net/sched/cls_fw.c
--- linux-2.5.1-pre4.orig/net/sched/cls_fw.c	Sun Sep 30 21:26:09 2001
+++ linux-2.5.1-pre4.kfree/net/sched/cls_fw.c	Sat Dec  1 09:01:01 2001
@@ -266,8 +266,7 @@
 	return 0;

 errout:
-	if (f)
-		kfree(f);
+	kfree(f);
 	return err;
 }

diff -urN linux-2.5.1-pre4.orig/net/sched/cls_route.c linux-2.5.1-pre4.kfree/net/sched/cls_route.c
--- linux-2.5.1-pre4.orig/net/sched/cls_route.c	Sun Sep 30 21:26:09 2001
+++ linux-2.5.1-pre4.kfree/net/sched/cls_route.c	Sat Dec  1 00:58:27 2001
@@ -511,8 +511,7 @@
 	return 0;

 errout:
-	if (f)
-		kfree(f);
+	kfree(f);
 	return err;
 }

diff -urN linux-2.5.1-pre4.orig/net/sched/cls_tcindex.c linux-2.5.1-pre4.kfree/net/sched/cls_tcindex.c
--- linux-2.5.1-pre4.orig/net/sched/cls_tcindex.c	Sun Sep 30 21:26:09 2001
+++ linux-2.5.1-pre4.kfree/net/sched/cls_tcindex.c	Sat Dec  1 00:57:08 2001
@@ -194,8 +194,7 @@
 #ifdef CONFIG_NET_CLS_POLICE
 	tcf_police_release(r->police);
 #endif
-	if (f)
-		kfree(f);
+	kfree(f);
 	return 0;
 }

@@ -411,10 +410,8 @@
 	walker.skip = 0;
 	walker.fn = &tcindex_destroy_element;
 	tcindex_walk(tp,&walker);
-	if (p->perfect)
-		kfree(p->perfect);
-	if (p->h)
-		kfree(p->h);
+	kfree(p->perfect);
+	kfree(p->h);
 	kfree(p);
 	tp->root = NULL;
 	MOD_DEC_USE_COUNT;
diff -urN linux-2.5.1-pre4.orig/net/sched/sch_api.c linux-2.5.1-pre4.kfree/net/sched/sch_api.c
--- linux-2.5.1-pre4.orig/net/sched/sch_api.c	Sat Nov 10 00:12:54 2001
+++ linux-2.5.1-pre4.kfree/net/sched/sch_api.c	Sat Dec  1 00:57:48 2001
@@ -465,8 +465,7 @@

 err_out:
 	*errp = err;
-	if (sch)
-		kfree(sch);
+	kfree(sch);
 	return NULL;
 }

diff -urN linux-2.5.1-pre4.orig/net/sunrpc/svc.c linux-2.5.1-pre4.kfree/net/sunrpc/svc.c
--- linux-2.5.1-pre4.orig/net/sunrpc/svc.c	Fri Sep  7 19:48:39 2001
+++ linux-2.5.1-pre4.kfree/net/sunrpc/svc.c	Sat Dec  1 01:13:51 2001
@@ -156,10 +156,8 @@
 	struct svc_serv	*serv = rqstp->rq_server;

 	svc_release_buffer(&rqstp->rq_defbuf);
-	if (rqstp->rq_resp)
-		kfree(rqstp->rq_resp);
-	if (rqstp->rq_argp)
-		kfree(rqstp->rq_argp);
+	kfree(rqstp->rq_resp);
+	kfree(rqstp->rq_argp);
 	kfree(rqstp);

 	/* Release the server */
diff -urN linux-2.5.1-pre4.orig/net/wanrouter/af_wanpipe.c linux-2.5.1-pre4.kfree/net/wanrouter/af_wanpipe.c
--- linux-2.5.1-pre4.orig/net/wanrouter/af_wanpipe.c	Sun Sep 30 21:26:42 2001
+++ linux-2.5.1-pre4.kfree/net/wanrouter/af_wanpipe.c	Sat Dec  1 01:06:57 2001
@@ -852,11 +852,9 @@
 		if (atomic_read(&sk->wmem_alloc) || atomic_read(&sk->rmem_alloc))
 			printk(KERN_INFO "wansock: Warning, Packet Discarded due to sock shutdown!\n");

-		if (sk->protinfo.af_wanpipe){
-			kfree(sk->protinfo.af_wanpipe);
-			sk->protinfo.af_wanpipe=NULL;
-		}
-
+		kfree(sk->protinfo.af_wanpipe);
+		sk->protinfo.af_wanpipe=NULL;
+
               #ifdef LINUX_2_4
 		if (atomic_read(&sk->refcnt) != 1){
 			atomic_set(&sk->refcnt,1);
@@ -1136,10 +1134,8 @@
 	sk->zapped=0;

 	if (sk->protinfo.af_wanpipe){
-		if (sk->protinfo.af_wanpipe->mbox){
-			kfree(sk->protinfo.af_wanpipe->mbox);
-			sk->protinfo.af_wanpipe->mbox=NULL;
-		}
+		kfree(sk->protinfo.af_wanpipe->mbox);
+		sk->protinfo.af_wanpipe->mbox=NULL;
 	}
 }

@@ -1244,11 +1240,9 @@
 		return;
 	}

-	if (sk->protinfo.af_wanpipe){
-		kfree(sk->protinfo.af_wanpipe);
-		sk->protinfo.af_wanpipe=NULL;
-	}
-
+	kfree(sk->protinfo.af_wanpipe);
+	sk->protinfo.af_wanpipe=NULL;
+
       #ifdef LINUX_2_4
 	if (atomic_read(&sk->refcnt) != 1){
 		atomic_set(&sk->refcnt,1);
@@ -1317,11 +1311,9 @@

 	sk->socket = NULL;

-	if (sk->protinfo.af_wanpipe){
-		kfree(sk->protinfo.af_wanpipe);
-		sk->protinfo.af_wanpipe=NULL;
-	}
-
+	kfree(sk->protinfo.af_wanpipe);
+	sk->protinfo.af_wanpipe=NULL;
+
       #ifdef LINUX_2_4
 	if (atomic_read(&sk->refcnt) != 1){
 		atomic_set(&sk->refcnt,1);
diff -urN linux-2.5.1-pre4.orig/net/wanrouter/wanmain.c linux-2.5.1-pre4.kfree/net/wanrouter/wanmain.c
--- linux-2.5.1-pre4.orig/net/wanrouter/wanmain.c	Wed Aug 15 10:22:18 2001
+++ linux-2.5.1-pre4.kfree/net/wanrouter/wanmain.c	Sat Dec  1 01:04:08 2001
@@ -651,9 +651,7 @@
 			err = wandev->setup(wandev, conf);
 		}

-        	if (data){
-			kfree(data);
-		}
+        	kfree(data);
 #endif
 	}else{
 		printk(KERN_INFO
@@ -874,11 +872,8 @@
 	}

 	/* This code has moved from del_if() function */
-	if (dev->priv){
-		kfree(dev->priv);
-		dev->priv=NULL;
-	}
-
+	kfree(dev->priv);
+	dev->priv=NULL;

       #ifdef CONFIG_WANPIPE_MULTPPP
 	if (conf.config_id == WANCONFIG_MPPP){
@@ -1028,19 +1023,16 @@

 	/* Due to new interface linking method using dev->priv,
 	 * this code has moved from del_if() function.*/
-	if (dev->priv){
-		kfree(dev->priv);
-		dev->priv=NULL;
-	}
+	kfree(dev->priv);
+	dev->priv=NULL;

 	unregister_netdev(dev);

       #ifdef LINUX_2_4
 	kfree(dev);
       #else
-	if (dev->name){
-		kfree(dev->name);
-	}
+
+	kfree(dev->name);
 	kfree(dev);
       #endif


