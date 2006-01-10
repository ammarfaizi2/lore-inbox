Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWAJWWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWAJWWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWAJWWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:22:11 -0500
Received: from DSL022.labridge.com ([206.117.136.22]:25874 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S932569AbWAJWWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:22:09 -0500
Subject: [RFC][PATCH] - NIP6_FMT in kernel.h? NIPQUAD_FMT too? [NH]IPQUAD
	to [NH]IP4?
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 10 Jan 2006 14:21:51 -0800
Message-Id: <1136931711.15615.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3.1.102mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about introducing a #define NIP6_FMT "%04x:..." to kernel.h?

This RFC patch:

	adds NIP6_FMT to kernel.h
	changes all code to use NIP6_FMT
	fixes net/ipv6/ip6_flowlabel.c
	adds NIPQUAD_FMT to kernel.h
	fixes net/netfilter/nf_conntrack_ftp.c
	changes a few uses of "%u.%u.%u.%u" to NIPQUAD_FMT for symmetry to NIP6_FMT

There are errors and inconsistency in the display of NIP6 strings.

	ie: net/ipv6/ip6_flowlabel.c

There are errors and inconsistency in the display of NIPQUAD strings too.

	ie: net/netfilter/nf_conntrack_ftp.c

Maybe kernel.h could use an NIPQUAD_FMT or NIP4_FMT too?

Also, could NIPQUAD be changed to NIP4?

There are currently 98 files with 323 uses of [NH]IPQUAD,
not too many to change I think, but is a far more intrusive change.

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index b1e407a..c7b4e7c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -212,6 +212,7 @@ extern void dump_stack(void);
 	((unsigned char *)&addr)[1], \
 	((unsigned char *)&addr)[2], \
 	((unsigned char *)&addr)[3]
+#define NIPQUAD_FMT "%u.%u.%u.%u"
 
 #define NIP6(addr) \
 	ntohs((addr).s6_addr16[0]), \
@@ -222,6 +223,7 @@ extern void dump_stack(void);
 	ntohs((addr).s6_addr16[5]), \
 	ntohs((addr).s6_addr16[6]), \
 	ntohs((addr).s6_addr16[7])
+#define NIP6_FMT "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x"
 
 #if defined(__LITTLE_ENDIAN)
 #define HIPQUAD(addr) \
diff --git a/include/net/netfilter/nf_conntrack_tuple.h b/include/net/netfilter/nf_conntrack_tuple.h
index 14ce790..530ef1f 100644
--- a/include/net/netfilter/nf_conntrack_tuple.h
+++ b/include/net/netfilter/nf_conntrack_tuple.h
@@ -111,7 +111,7 @@ struct nf_conntrack_tuple
 #ifdef __KERNEL__
 
 #define NF_CT_DUMP_TUPLE(tp)						    \
-DEBUGP("tuple %p: %u %u %04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x %hu -> %04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x %hu\n",					    \
+DEBUGP("tuple %p: %u %u " NIP6_FMT " %hu -> " NIP6_FMT " %hu\n",	    \
 	(tp), (tp)->src.l3num, (tp)->dst.protonum,			    \
 	NIP6(*(struct in6_addr *)(tp)->src.u3.all), ntohs((tp)->src.u.all), \
 	NIP6(*(struct in6_addr *)(tp)->dst.u3.all), ntohs((tp)->dst.u.all))
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 8f24121..a553f39 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -225,13 +225,13 @@ extern int sctp_debug_flag;
 	if (sctp_debug_flag) { \
 		if (saddr->sa.sa_family == AF_INET6) { \
 			printk(KERN_DEBUG \
-			       lead "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x" trail, \
+			       lead NIP6_FMT trail, \
 			       leadparm, \
 			       NIP6(saddr->v6.sin6_addr), \
 			       otherparms); \
 		} else { \
 			printk(KERN_DEBUG \
-			       lead "%u.%u.%u.%u" trail, \
+			       lead NIPQUAD_FMT trail, \
 			       leadparm, \
 			       NIPQUAD(saddr->v4.sin_addr.s_addr), \
 			       otherparms); \
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 704fb73..13a9edc 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2643,7 +2643,7 @@ static int if6_seq_show(struct seq_file 
 {
 	struct inet6_ifaddr *ifp = (struct inet6_ifaddr *)v;
 	seq_printf(seq,
-		   "%04x%04x%04x%04x%04x%04x%04x%04x %02x %02x %02x %02x %8s\n",
+		   NIP6_FMT " %02x %02x %02x %02x %8s\n",
 		   NIP6(ifp->addr),
 		   ifp->idev->dev->ifindex,
 		   ifp->prefix_len,
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 13cc7f8..c7932cb 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -332,8 +332,7 @@ static void ah6_err(struct sk_buff *skb,
 	if (!x)
 		return;
 
-	NETDEBUG(KERN_DEBUG "pmtu discovery on SA AH/%08x/"
-		 "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+	NETDEBUG(KERN_DEBUG "pmtu discovery on SA AH/%08x/" NIP6_FMT "\n",
 		 ntohl(ah->spi), NIP6(iph->daddr));
 
 	xfrm_state_put(x);
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 6b72940..c1cdd73 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -531,9 +531,7 @@ static int ac6_seq_show(struct seq_file 
 	struct ac6_iter_state *state = ac6_seq_private(seq);
 
 	seq_printf(seq,
-		   "%-4d %-15s "
-		   "%04x%04x%04x%04x%04x%04x%04x%04x "
-		   "%5d\n",
+		   "%-4d %-15s " NIP6_FMT " %5d\n",
 		   state->dev->ifindex, state->dev->name,
 		   NIP6(im->aca_addr),
 		   im->aca_users);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 6de8ee1..7b5b94f 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -266,8 +266,7 @@ static void esp6_err(struct sk_buff *skb
 	x = xfrm_state_lookup((xfrm_address_t *)&iph->daddr, esph->spi, IPPROTO_ESP, AF_INET6);
 	if (!x)
 		return;
-	printk(KERN_DEBUG "pmtu discovery on SA ESP/%08x/"
-			"%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n", 
+	printk(KERN_DEBUG "pmtu discovery on SA ESP/%08x/" NIP6_FMT "\n", 
 			ntohl(esph->spi), NIP6(iph->daddr));
 	xfrm_state_put(x);
 }
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 6ec6a2b..6e58a9f 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -607,7 +607,7 @@ static int icmpv6_rcv(struct sk_buff **p
 		skb->csum = ~csum_ipv6_magic(saddr, daddr, skb->len,
 					     IPPROTO_ICMPV6, 0);
 		if (__skb_checksum_complete(skb)) {
-			LIMIT_NETDEBUG(KERN_DEBUG "ICMPv6 checksum failed [%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x > %04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x]\n",
+			LIMIT_NETDEBUG(KERN_DEBUG "ICMPv6 checksum failed [" NIP6_FMT " > " NIP6_FMT "]\n",
 				       NIP6(*saddr), NIP6(*daddr));
 			goto discard_it;
 		}
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 89d12b4..dea867b 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -628,9 +628,7 @@ static void ip6fl_fl_seq_show(struct seq
 {
 	while(fl) {
 		seq_printf(seq,
-			   "%05X %-1d %-6d %-6d %-6ld %-8ld "
-			   "%02x%02x%02x%02x%02x%02x%02x%02x "
-			   "%-4d\n",
+			   "%05X %-1d %-6d %-6d %-6ld %-8ld " NIP6_FMT " %-4d\n",
 			   (unsigned)ntohl(fl->label),
 			   fl->share,
 			   (unsigned)fl->owner,
@@ -646,8 +644,8 @@ static void ip6fl_fl_seq_show(struct seq
 static int ip6fl_seq_show(struct seq_file *seq, void *v)
 {
 	if (v == SEQ_START_TOKEN)
-		seq_puts(seq, "Label S Owner  Users  Linger Expires  "
-			      "Dst                              Opt\n");
+		seq_printf(seq, "%5s %1s %6s %6s %6s %8s %39s %s\n",
+			   "Label", "S", "Owner", "Users", "Linger", "Expires", "Dst", "Opt");
 	else
 		ip6fl_fl_seq_show(seq, v);
 	return 0;
diff --git a/net/ipv6/ipcomp6.c b/net/ipv6/ipcomp6.c
index 626dd39..d511a88 100644
--- a/net/ipv6/ipcomp6.c
+++ b/net/ipv6/ipcomp6.c
@@ -212,8 +212,7 @@ static void ipcomp6_err(struct sk_buff *
 	if (!x)
 		return;
 
-	printk(KERN_DEBUG "pmtu discovery on SA IPCOMP/%08x/"
-			"%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+	printk(KERN_DEBUG "pmtu discovery on SA IPCOMP/%08x/" NIP6_FMT "\n",
 			spi, NIP6(iph->daddr));
 	xfrm_state_put(x);
 }
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 1cf305a..c01f440 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2374,7 +2374,7 @@ static int igmp6_mc_seq_show(struct seq_
 	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
 
 	seq_printf(seq,
-		   "%-4d %-15s %04x%04x%04x%04x%04x%04x%04x%04x %5d %08X %ld\n", 
+		   "%-4d %-15s " NIP6_FMT " %5d %08X %ld\n", 
 		   state->dev->ifindex, state->dev->name,
 		   NIP6(im->mca_addr),
 		   im->mca_users, im->mca_flags,
@@ -2543,15 +2543,12 @@ static int igmp6_mcf_seq_show(struct seq
 	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq, 
 			   "%3s %6s "
-			   "%32s %32s %6s %6s\n", "Idx",
+			   "%39s %39s %6s %6s\n", "Idx",
 			   "Device", "Multicast Address",
 			   "Source Address", "INC", "EXC");
 	} else {
 		seq_printf(seq,
-			   "%3d %6.6s "
-			   "%04x%04x%04x%04x%04x%04x%04x%04x "
-			   "%04x%04x%04x%04x%04x%04x%04x%04x "
-			   "%6lu %6lu\n",
+			   "%3d %6.6s " NIP6_FMT " " NIP6_FMT " %6lu %6lu\n",
 			   state->dev->ifindex, state->dev->name,
 			   NIP6(state->im->mca_addr),
 			   NIP6(psf->sf_addr),
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 305d9ee..cb8856b 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -692,7 +692,7 @@ static void ndisc_solicit(struct neighbo
 		if (!(neigh->nud_state & NUD_VALID)) {
 			ND_PRINTK1(KERN_DEBUG
 				   "%s(): trying to ucast probe in NUD_INVALID: "
-				   "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+				   NIP6_FMT "\n",
 				   __FUNCTION__,
 				   NIP6(*target));
 		}
diff --git a/net/ipv6/netfilter/ip6t_LOG.c b/net/ipv6/netfilter/ip6t_LOG.c
index ae4653b..2660aef 100644
--- a/net/ipv6/netfilter/ip6t_LOG.c
+++ b/net/ipv6/netfilter/ip6t_LOG.c
@@ -63,9 +63,8 @@ static void dump_packet(const struct nf_
 		return;
 	}
 
-	/* Max length: 88 "SRC=0000.0000.0000.0000.0000.0000.0000.0000 DST=0000.0000.0000.0000.0000.0000.0000.0000" */
-	printk("SRC=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x ", NIP6(ih->saddr));
-	printk("DST=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x ", NIP6(ih->daddr));
+	/* Max length: 88 "SRC=0000.0000.0000.0000.0000.0000.0000.0000 DST=0000.0000.0000.0000.0000.0000.0000.0000 " */
+	printk("SRC=" NIP6_FMT " DST=" NIP6_FMT " ", NIP6(ih->saddr), NIP6(ih->daddr));
 
 	/* Max length: 44 "LEN=65535 TC=255 HOPLIMIT=255 FLOWLBL=FFFFF " */
 	printk("LEN=%Zu TC=%u HOPLIMIT=%u FLOWLBL=%u ",
diff --git a/net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c b/net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c
index 704fbbe..121d080 100644
--- a/net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c
+++ b/net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c
@@ -74,7 +74,7 @@ static int ipv6_invert_tuple(struct nf_c
 static int ipv6_print_tuple(struct seq_file *s,
 			    const struct nf_conntrack_tuple *tuple)
 {
-	return seq_printf(s, "src=%x:%x:%x:%x:%x:%x:%x:%x dst=%x:%x:%x:%x:%x:%x:%x:%x ",
+	return seq_printf(s, "src=" NIP6_FMT " dst=" NIP6_FMT " ",
 			  NIP6(*((struct in6_addr *)tuple->src.u3.ip6)),
 			  NIP6(*((struct in6_addr *)tuple->dst.u3.ip6)));
 }
diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index fbef782..2b93165 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -259,8 +259,7 @@ try_next_2:;
 	spi = 0;
 	goto out;
 alloc_spi:
-	X6TPRINTK3(KERN_DEBUG "%s(): allocate new spi for "
-			      "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n", 
+	X6TPRINTK3(KERN_DEBUG "%s(): allocate new spi for " NIP6_FMT "\n",
 			      __FUNCTION__, 
 			      NIP6(*(struct in6_addr *)saddr));
 	x6spi = kmem_cache_alloc(xfrm6_tunnel_spi_kmem, SLAB_ATOMIC);
@@ -323,9 +322,8 @@ void xfrm6_tunnel_free_spi(xfrm_address_
 				  list_byaddr)
 	{
 		if (memcmp(&x6spi->addr, saddr, sizeof(x6spi->addr)) == 0) {
-			X6TPRINTK3(KERN_DEBUG "%s(): x6spi object "
-					      "for %04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x "
-					      "found at %p\n",
+			X6TPRINTK3(KERN_DEBUG "%s(): x6spi object for " NIP6_FMT 
+					      " found at %p\n",
 				   __FUNCTION__, 
 				   NIP6(*(struct in6_addr *)saddr),
 				   x6spi);
diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index d5a6eaf..ab0c920 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -545,11 +545,11 @@ static int help(struct sk_buff **pskb,
                    different IP address.  Simply don't record it for
                    NAT. */
 		if (cmd.l3num == PF_INET) {
-                	DEBUGP("conntrack_ftp: NOT RECORDING: %u,%u,%u,%u != %u.%u.%u.%u\n",
+                	DEBUGP("conntrack_ftp: NOT RECORDING: " NIPQUAD_FMT " != " NIPQUAD_FMT "\n",
 			       NIPQUAD(cmd.u3.ip),
 			       NIPQUAD(ct->tuplehash[dir].tuple.src.u3.ip));
 		} else {
-			DEBUGP("conntrack_ftp: NOT RECORDING: %x:%x:%x:%x:%x:%x:%x:%x != %x:%x:%x:%x:%x:%x:%x:%x\n",
+			DEBUGP("conntrack_ftp: NOT RECORDING: " NIP6_FMT " != " NIP6_FMT "\n",
 			       NIP6(*((struct in6_addr *)cmd.u3.ip6)),
 			       NIP6(*((struct in6_addr *)ct->tuplehash[dir]
 							.tuple.src.u3.ip6)));
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 15c0516..f18d3bd 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -180,8 +180,7 @@ static int sctp_v6_xmit(struct sk_buff *
 	}
 
 	SCTP_DEBUG_PRINTK("%s: skb:%p, len:%d, "
-			  "src:%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x "
-			  "dst:%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+			  "src:" NIP6_FMT " dst:" NIP6_FMT "\n",
 			  __FUNCTION__, skb, skb->len,
 			  NIP6(fl.fl6_src), NIP6(fl.fl6_dst));
 
@@ -206,13 +205,13 @@ static struct dst_entry *sctp_v6_get_dst
 		fl.oif = daddr->v6.sin6_scope_id;
 	
 
-	SCTP_DEBUG_PRINTK("%s: DST=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x ",
+	SCTP_DEBUG_PRINTK("%s: DST=" NIP6_FMT " ",
 			  __FUNCTION__, NIP6(fl.fl6_dst));
 
 	if (saddr) {
 		ipv6_addr_copy(&fl.fl6_src, &saddr->v6.sin6_addr);
 		SCTP_DEBUG_PRINTK(
-			"SRC=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x - ",
+			"SRC=" NIP6_FMT " - ",
 			NIP6(fl.fl6_src));
 	}
 
@@ -221,8 +220,7 @@ static struct dst_entry *sctp_v6_get_dst
 		struct rt6_info *rt;
 		rt = (struct rt6_info *)dst;
 		SCTP_DEBUG_PRINTK(
-			"rt6_dst:%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x "
-			"rt6_src:%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+			"rt6_dst:" NIP6_FMT " rt6_src:" NIP6_FMT "\n",
 			NIP6(rt->rt6i_dst.addr), NIP6(rt->rt6i_src.addr));
 	} else {
 		SCTP_DEBUG_PRINTK("NO ROUTE\n");
@@ -271,13 +269,12 @@ static void sctp_v6_get_saddr(struct sct
 	__u8 bmatchlen;
 
 	SCTP_DEBUG_PRINTK("%s: asoc:%p dst:%p "
-			  "daddr:%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x ",
+			  "daddr:" NIP6_FMT " ",
 			  __FUNCTION__, asoc, dst, NIP6(daddr->v6.sin6_addr));
 
 	if (!asoc) {
 		ipv6_get_saddr(dst, &daddr->v6.sin6_addr,&saddr->v6.sin6_addr);
-		SCTP_DEBUG_PRINTK("saddr from ipv6_get_saddr: "
-				  "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+		SCTP_DEBUG_PRINTK("saddr from ipv6_get_saddr: " NIP6_FMT "\n",
 				  NIP6(saddr->v6.sin6_addr));
 		return;
 	}
@@ -305,13 +302,11 @@ static void sctp_v6_get_saddr(struct sct
 
 	if (baddr) {
 		memcpy(saddr, baddr, sizeof(union sctp_addr));
-		SCTP_DEBUG_PRINTK("saddr: "
-				  "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+		SCTP_DEBUG_PRINTK("saddr: " NIP6_FMT "\n",
 				  NIP6(saddr->v6.sin6_addr));
 	} else {
 		printk(KERN_ERR "%s: asoc:%p Could not find a valid source "
-		       "address for the "
-		       "dest:%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+		       "address for the dest:" NIP6_FMT "\n",
 		       __FUNCTION__, asoc, NIP6(daddr->v6.sin6_addr));
 	}
 
@@ -675,8 +670,7 @@ static int sctp_v6_is_ce(const struct sk
 /* Dump the v6 addr to the seq file. */
 static void sctp_v6_seq_dump_addr(struct seq_file *seq, union sctp_addr *addr)
 {
-	seq_printf(seq, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x ",
-		   NIP6(addr->v6.sin6_addr));
+	seq_printf(seq, NIP6_FMT " ", NIP6(addr->v6.sin6_addr));
 }
 
 /* Initialize a PF_INET6 socket msg_name. */
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 557a7d9..477d7f8 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1036,14 +1036,14 @@ sctp_disposition_t sctp_sf_backbeat_8_3(
 		if (from_addr.sa.sa_family == AF_INET6) {
 			printk(KERN_WARNING
 			       "%s association %p could not find address "
-			       "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+			       NIP6_FMT "\n",
 			       __FUNCTION__,
 			       asoc,
 			       NIP6(from_addr.v6.sin6_addr));
 		} else {
 			printk(KERN_WARNING
 			       "%s association %p could not find address "
-			       "%u.%u.%u.%u\n",
+			       NIPQUAD_FMT "\n",
 			       __FUNCTION__,
 			       asoc,
 			       NIPQUAD(from_addr.v4.sin_addr.s_addr));
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 12e4fb7..53d6c7b 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -494,8 +494,7 @@ static inline void avc_print_ipv6_addr(s
 				       char *name1, char *name2)
 {
 	if (!ipv6_addr_any(addr))
-		audit_log_format(ab, " %s=%04x:%04x:%04x:%04x:%04x:"
-				 "%04x:%04x:%04x", name1, NIP6(*addr));
+		audit_log_format(ab, " %s=" NIP6_FMT, name1, NIP6(*addr));
 	if (port)
 		audit_log_format(ab, " %s=%d", name2, ntohs(port));
 }
@@ -504,7 +503,7 @@ static inline void avc_print_ipv4_addr(s
 				       __be16 port, char *name1, char *name2)
 {
 	if (addr)
-		audit_log_format(ab, " %s=%d.%d.%d.%d", name1, NIPQUAD(addr));
+		audit_log_format(ab, " %s=" NIPQUAD_FMT, name1, NIPQUAD(addr));
 	if (port)
 		audit_log_format(ab, " %s=%d", name2, ntohs(port));
 }


