Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTEHHuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbTEHHuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:50:05 -0400
Received: from holomorphy.com ([66.224.33.161]:6806 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261159AbTEHHtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:49:09 -0400
Date: Thu, 8 May 2003 01:01:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030508080135.GK8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@digeo.com
References: <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com> <20030508065440.GA1890@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508065440.GA1890@hh.idb.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 06:38:54PM -0700, William Lee Irwin III wrote:
>> Can you try one kernel with the netfilter cset backed out, and another
>> with the re-slabification patch backed out? (But not with both backed
>> out simultaneously).

On Thu, May 08, 2003 at 08:54:40AM +0200, Helge Hafting wrote:
> I'm compiling without reslabify now.
> I got 
> patching file arch/i386/mm/pageattr.c
> Hunk #1 succeeded at 67 (offset 9 lines).
> when backing it out - is this the effect of
> some other patch touching the same file or could
> my source be wrong somehow?
> Which patch is the netfilter cset?  None of
> the patches in mm2 looked obvious to me.  Or
> is it part of the linus patch? Note that mm1
> works for me, so anything found there too
> isn't as likely to be the problem.

The fuzz/offset is safe. The netfilter patch to back out follows
(there's actually a fix for it now but ignore that -- we just want
to isolate the problem):

Thanks.

-- wli

-- wli

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1072  -> 1.1073 
#	include/linux/netfilter_ipv4/ip_nat_core.h	1.1     -> 1.2    
#	net/ipv4/netfilter/ip_nat_proto_tcp.c	1.3     -> 1.4    
#	net/ipv4/netfilter/ip_nat_core.c	1.22    -> 1.23   
#	net/ipv4/netfilter/ip_nat_helper.c	1.12    -> 1.13   
#	net/ipv4/netfilter/ip_nat_proto_udp.c	1.1     -> 1.2    
#	include/linux/netfilter_ipv4/ip_nat_helper.h	1.4     -> 1.5    
#	net/ipv4/netfilter/ip_nat_tftp.c	1.2     -> 1.3    
#	net/ipv4/netfilter/ip_nat_proto_icmp.c	1.1     -> 1.2    
#	net/ipv4/netfilter/ip_nat_proto_unknown.c	1.2     -> 1.3    
#	include/linux/netfilter_ipv4/ip_nat_protocol.h	1.1     -> 1.2    
#	net/ipv4/netfilter/ip_nat_standalone.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/06	rusty@rustcorp.com.au	1.1073
# [NETFILTER]: Make NAT code handle non-linear skbs.
# Makes the NAT code and all NAT helpers handle non-linear skbs.
# Main trick is to introduce skb_ip_make_writable which handles all
# the decloning, linearizing, etc.
# --------------------------------------------
#
diff -Nru a/include/linux/netfilter_ipv4/ip_nat_core.h b/include/linux/netfilter_ipv4/ip_nat_core.h
--- a/include/linux/netfilter_ipv4/ip_nat_core.h	Tue May  6 09:30:02 2003
+++ b/include/linux/netfilter_ipv4/ip_nat_core.h	Tue May  6 09:30:02 2003
@@ -16,10 +16,10 @@
 
 extern struct list_head protos;
 
-extern unsigned int icmp_reply_translation(struct sk_buff *skb,
-					   struct ip_conntrack *conntrack,
-					   unsigned int hooknum,
-					   int dir);
+extern int icmp_reply_translation(struct sk_buff **pskb,
+				  struct ip_conntrack *conntrack,
+				  unsigned int hooknum,
+				  int dir);
 
 extern void replace_in_hashes(struct ip_conntrack *conntrack,
 			      struct ip_nat_info *info);
@@ -30,4 +30,10 @@
 extern struct ip_nat_protocol ip_nat_protocol_tcp;
 extern struct ip_nat_protocol ip_nat_protocol_udp;
 extern struct ip_nat_protocol ip_nat_protocol_icmp;
+
+/* Call this before modifying an existing IP packet: ensures it is
+   modifiable and linear to the point you care about (writable_len).
+   Returns true or false. */
+extern int skb_ip_make_writable(struct sk_buff **pskb,
+				unsigned int writable_len);
 #endif /* _IP_NAT_CORE_H */
diff -Nru a/include/linux/netfilter_ipv4/ip_nat_helper.h b/include/linux/netfilter_ipv4/ip_nat_helper.h
--- a/include/linux/netfilter_ipv4/ip_nat_helper.h	Tue May  6 09:30:02 2003
+++ b/include/linux/netfilter_ipv4/ip_nat_helper.h	Tue May  6 09:30:02 2003
@@ -43,22 +43,23 @@
 
 extern int ip_nat_helper_register(struct ip_nat_helper *me);
 extern void ip_nat_helper_unregister(struct ip_nat_helper *me);
+
+/* These return true or false. */
 extern int ip_nat_mangle_tcp_packet(struct sk_buff **skb,
 				struct ip_conntrack *ct,
 				enum ip_conntrack_info ctinfo,
 				unsigned int match_offset,
 				unsigned int match_len,
-				char *rep_buffer,
+				const char *rep_buffer,
 				unsigned int rep_len);
 extern int ip_nat_mangle_udp_packet(struct sk_buff **skb,
 				struct ip_conntrack *ct,
 				enum ip_conntrack_info ctinfo,
 				unsigned int match_offset,
 				unsigned int match_len,
-				char *rep_buffer,
+				const char *rep_buffer,
 				unsigned int rep_len);
-extern int ip_nat_seq_adjust(struct sk_buff *skb,
-				struct ip_conntrack *ct,
-				enum ip_conntrack_info ctinfo);
-extern void ip_nat_delete_sack(struct sk_buff *skb);
+extern int ip_nat_seq_adjust(struct sk_buff **pskb, 
+			     struct ip_conntrack *ct, 
+			     enum ip_conntrack_info ctinfo);
 #endif
diff -Nru a/include/linux/netfilter_ipv4/ip_nat_protocol.h b/include/linux/netfilter_ipv4/ip_nat_protocol.h
--- a/include/linux/netfilter_ipv4/ip_nat_protocol.h	Tue May  6 09:30:02 2003
+++ b/include/linux/netfilter_ipv4/ip_nat_protocol.h	Tue May  6 09:30:02 2003
@@ -18,10 +18,11 @@
 	unsigned int protonum;
 
 	/* Do a packet translation according to the ip_nat_proto_manip
-	 * and manip type. */
-	void (*manip_pkt)(struct iphdr *iph, size_t len,
-			  const struct ip_conntrack_manip *manip,
-			  enum ip_nat_manip_type maniptype);
+	 * and manip type.  Return true if succeeded. */
+	int (*manip_pkt)(struct sk_buff **pskb,
+			 unsigned int hdroff,
+			 const struct ip_conntrack_manip *manip,
+			 enum ip_nat_manip_type maniptype);
 
 	/* Is the manipable part of the tuple between min and max incl? */
 	int (*in_range)(const struct ip_conntrack_tuple *tuple,
diff -Nru a/net/ipv4/netfilter/ip_nat_core.c b/net/ipv4/netfilter/ip_nat_core.c
--- a/net/ipv4/netfilter/ip_nat_core.c	Tue May  6 09:30:02 2003
+++ b/net/ipv4/netfilter/ip_nat_core.c	Tue May  6 09:30:02 2003
@@ -13,6 +13,8 @@
 #include <net/icmp.h>
 #include <net/ip.h>
 #include <net/tcp.h>  /* For tcp_prot in getorigdst */
+#include <linux/icmp.h>
+#include <linux/udp.h>
 
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_nat_lock)
 #define ASSERT_WRITE_LOCK(x) MUST_BE_WRITE_LOCKED(&ip_nat_lock)
@@ -698,14 +700,26 @@
 	list_prepend(&byipsproto[ipsprotohash], &info->byipsproto);
 }
 
-static void
-manip_pkt(u_int16_t proto, struct iphdr *iph, size_t len,
+/* Returns true if succeeded. */
+static int
+manip_pkt(u_int16_t proto,
+	  struct sk_buff **pskb,
+	  unsigned int iphdroff,
 	  const struct ip_conntrack_manip *manip,
-	  enum ip_nat_manip_type maniptype,
-	  __u32 *nfcache)
+	  enum ip_nat_manip_type maniptype)
 {
-	*nfcache |= NFC_ALTERED;
-	find_nat_proto(proto)->manip_pkt(iph, len, manip, maniptype);
+	struct iphdr *iph;
+
+	(*pskb)->nfcache |= NFC_ALTERED;
+	if (!skb_ip_make_writable(pskb, iphdroff+sizeof(iph)))
+		return 0;
+
+	iph = (void *)(*pskb)->data + iphdroff;
+
+	/* Manipulate protcol part. */
+	if (!find_nat_proto(proto)->manip_pkt(pskb, iphdroff + iph->ihl*4,
+					      manip, maniptype))
+		return 0;
 
 	if (maniptype == IP_NAT_MANIP_SRC) {
 		iph->check = ip_nat_cheat_check(~iph->saddr, manip->ip,
@@ -716,17 +730,7 @@
 						iph->check);
 		iph->daddr = manip->ip;
 	}
-#if 0
-	if (ip_fast_csum((u8 *)iph, iph->ihl) != 0)
-		DEBUGP("IP: checksum on packet bad.\n");
-
-	if (proto == IPPROTO_TCP) {
-		void *th = (u_int32_t *)iph + iph->ihl;
-		if (tcp_v4_check(th, len - 4*iph->ihl, iph->saddr, iph->daddr,
-				 csum_partial((char *)th, len-4*iph->ihl, 0)))
-			DEBUGP("TCP: checksum on packet bad\n");
-	}
-#endif
+	return 1;
 }
 
 static inline int exp_for_packet(struct ip_conntrack_expect *exp,
@@ -754,25 +758,13 @@
 	unsigned int i;
 	struct ip_nat_helper *helper;
 	enum ip_conntrack_dir dir = CTINFO2DIR(ctinfo);
-	int is_tcp = (*pskb)->nh.iph->protocol == IPPROTO_TCP;
+	int proto = (*pskb)->nh.iph->protocol;
 
 	/* Need nat lock to protect against modification, but neither
 	   conntrack (referenced) and helper (deleted with
 	   synchronize_bh()) can vanish. */
 	READ_LOCK(&ip_nat_lock);
 	for (i = 0; i < info->num_manips; i++) {
-		/* raw socket (tcpdump) may have clone of incoming
-                   skb: don't disturb it --RR */
-		if (skb_cloned(*pskb) && !(*pskb)->sk) {
-			struct sk_buff *nskb = skb_copy(*pskb, GFP_ATOMIC);
-			if (!nskb) {
-				READ_UNLOCK(&ip_nat_lock);
-				return NF_DROP;
-			}
-			kfree_skb(*pskb);
-			*pskb = nskb;
-		}
-
 		if (info->manips[i].direction == dir
 		    && info->manips[i].hooknum == hooknum) {
 			DEBUGP("Mangling %p: %s to %u.%u.%u.%u %u\n",
@@ -781,12 +773,12 @@
 			       ? "SRC" : "DST",
 			       NIPQUAD(info->manips[i].manip.ip),
 			       htons(info->manips[i].manip.u.all));
-			manip_pkt((*pskb)->nh.iph->protocol,
-				  (*pskb)->nh.iph,
-				  (*pskb)->len,
-				  &info->manips[i].manip,
-				  info->manips[i].maniptype,
-				  &(*pskb)->nfcache);
+			if (manip_pkt(proto, pskb, 0,
+				      &info->manips[i].manip,
+				      info->manips[i].maniptype) < 0) {
+				READ_UNLOCK(&ip_nat_lock);
+				return NF_DROP;
+			}
 		}
 	}
 	helper = info->helper;
@@ -839,12 +831,14 @@
 		
 		/* Adjust sequence number only once per packet 
 		 * (helper is called at all hooks) */
-		if (is_tcp && (hooknum == NF_IP_POST_ROUTING
-			       || hooknum == NF_IP_LOCAL_IN)) {
+		if (proto == IPPROTO_TCP
+		    && (hooknum == NF_IP_POST_ROUTING
+			|| hooknum == NF_IP_LOCAL_IN)) {
 			DEBUGP("ip_nat_core: adjusting sequence number\n");
 			/* future: put this in a l4-proto specific function,
 			 * and call this function here. */
-			ip_nat_seq_adjust(*pskb, ct, ctinfo);
+			if (!ip_nat_seq_adjust(pskb, ct, ctinfo))
+				ret = NF_DROP;
 		}
 
 		return ret;
@@ -855,39 +849,51 @@
 	/* not reached */
 }
 
-unsigned int
-icmp_reply_translation(struct sk_buff *skb,
+int
+icmp_reply_translation(struct sk_buff **pskb,
 		       struct ip_conntrack *conntrack,
 		       unsigned int hooknum,
 		       int dir)
 {
-	struct iphdr *iph = skb->nh.iph;
-	struct icmphdr *hdr = (struct icmphdr *)((u_int32_t *)iph + iph->ihl);
-	struct iphdr *inner = (struct iphdr *)(hdr + 1);
-	size_t datalen = skb->len - ((void *)inner - (void *)iph);
+	struct {
+		struct icmphdr icmp;
+		struct iphdr ip;
+	} *inside;
 	unsigned int i;
 	struct ip_nat_info *info = &conntrack->nat.info;
 
-	IP_NF_ASSERT(skb->len >= iph->ihl*4 + sizeof(struct icmphdr));
+	if (!skb_ip_make_writable(pskb,(*pskb)->nh.iph->ihl*4+sizeof(*inside)))
+		return 0;
+	inside = (void *)(*pskb)->data + (*pskb)->nh.iph->ihl*4;
+
+	/* We're actually going to mangle it beyond trivial checksum
+	   adjustment, so make sure the current checksum is correct. */
+	if ((*pskb)->ip_summed != CHECKSUM_UNNECESSARY
+	    && (u16)csum_fold(skb_checksum(*pskb, (*pskb)->nh.iph->ihl*4,
+					   (*pskb)->len, 0)))
+		return 0;
+
 	/* Must be RELATED */
-	IP_NF_ASSERT(skb->nfct - (struct ip_conntrack *)skb->nfct->master
+	IP_NF_ASSERT((*pskb)->nfct
+		     - (struct ip_conntrack *)(*pskb)->nfct->master
 		     == IP_CT_RELATED
-		     || skb->nfct - (struct ip_conntrack *)skb->nfct->master
+		     || (*pskb)->nfct
+		     - (struct ip_conntrack *)(*pskb)->nfct->master
 		     == IP_CT_RELATED+IP_CT_IS_REPLY);
 
 	/* Redirects on non-null nats must be dropped, else they'll
            start talking to each other without our translation, and be
            confused... --RR */
-	if (hdr->type == ICMP_REDIRECT) {
+	if (inside->icmp.type == ICMP_REDIRECT) {
 		/* Don't care about races here. */
 		if (info->initialized
 		    != ((1 << IP_NAT_MANIP_SRC) | (1 << IP_NAT_MANIP_DST))
 		    || info->num_manips != 0)
-			return NF_DROP;
+			return 0;
 	}
 
 	DEBUGP("icmp_reply_translation: translating error %p hook %u dir %s\n",
-	       skb, hooknum, dir == IP_CT_DIR_ORIGINAL ? "ORIG" : "REPLY");
+	       *pskb, hooknum, dir == IP_CT_DIR_ORIGINAL ? "ORIG" : "REPLY");
 	/* Note: May not be from a NAT'd host, but probably safest to
 	   do translation always as if it came from the host itself
 	   (even though a "host unreachable" coming from the host
@@ -918,11 +924,13 @@
 			       ? "DST" : "SRC",
 			       NIPQUAD(info->manips[i].manip.ip),
 			       ntohs(info->manips[i].manip.u.udp.port));
-			manip_pkt(inner->protocol, inner,
-				  skb->len - ((void *)inner - (void *)iph),
-				  &info->manips[i].manip,
-				  !info->manips[i].maniptype,
-				  &skb->nfcache);
+			if (manip_pkt(inside->ip.protocol, pskb,
+				      (*pskb)->nh.iph->ihl*4
+				      + sizeof(inside->icmp),
+				      &info->manips[i].manip,
+				      !info->manips[i].maniptype) < 0)
+				goto unlock_fail;
+
 			/* Outer packet needs to have IP header NATed like
 	                   it's a reply. */
 
@@ -932,22 +940,82 @@
 			       info->manips[i].maniptype == IP_NAT_MANIP_SRC
 			       ? "SRC" : "DST",
 			       NIPQUAD(info->manips[i].manip.ip));
-			manip_pkt(0, iph, skb->len,
-				  &info->manips[i].manip,
-				  info->manips[i].maniptype,
-				  &skb->nfcache);
+			if (manip_pkt(0, pskb, 0,
+				      &info->manips[i].manip,
+				      info->manips[i].maniptype) < 0)
+				goto unlock_fail;
 		}
 	}
 	READ_UNLOCK(&ip_nat_lock);
 
-	/* Since we mangled inside ICMP packet, recalculate its
-	   checksum from scratch.  (Hence the handling of incorrect
-	   checksums in conntrack, so we don't accidentally fix one.)  */
-	hdr->checksum = 0;
-	hdr->checksum = ip_compute_csum((unsigned char *)hdr,
-					sizeof(*hdr) + datalen);
+	inside->icmp.checksum = 0;
+	inside->icmp.checksum = csum_fold(skb_checksum(*pskb,
+						       (*pskb)->nh.iph->ihl*4,
+						       (*pskb)->len, 0));
+	return 1;
 
-	return NF_ACCEPT;
+ unlock_fail:
+	READ_UNLOCK(&ip_nat_lock);
+	return 0;
+}
+
+int skb_ip_make_writable(struct sk_buff **pskb, unsigned int writable_len)
+{
+	struct sk_buff *nskb;
+	unsigned int iplen;
+
+	if (writable_len > (*pskb)->len)
+		return 0;
+
+	/* Not exclusive use of packet?  Must copy. */
+	if (skb_shared(*pskb) || skb_cloned(*pskb))
+		goto copy_skb;
+
+	/* Alexey says IP hdr is always modifiable and linear, so ok. */
+	if (writable_len <= (*pskb)->nh.iph->ihl*4)
+		return 1;
+
+	iplen = writable_len - (*pskb)->nh.iph->ihl*4;
+
+	/* DaveM says protocol headers are also modifiable. */
+	switch ((*pskb)->nh.iph->protocol) {
+	case IPPROTO_TCP: {
+		struct tcphdr hdr;
+		if (skb_copy_bits(*pskb, (*pskb)->nh.iph->ihl*4,
+				  &hdr, sizeof(hdr)) != 0)
+			goto copy_skb;
+		if (writable_len <= (*pskb)->nh.iph->ihl*4 + hdr.doff*4)
+			goto pull_skb;
+		goto copy_skb;
+	}
+	case IPPROTO_UDP:
+		if (writable_len<=(*pskb)->nh.iph->ihl*4+sizeof(struct udphdr))
+			goto pull_skb;
+		goto copy_skb;
+	case IPPROTO_ICMP:
+		if (writable_len
+		    <= (*pskb)->nh.iph->ihl*4 + sizeof(struct icmphdr))
+			goto pull_skb;
+		goto copy_skb;
+	/* Insert other cases here as desired */
+	}
+
+copy_skb:
+	nskb = skb_copy(*pskb, GFP_ATOMIC);
+	if (!nskb)
+		return 0;
+	BUG_ON(skb_is_nonlinear(nskb));
+
+	/* Rest of kernel will get very unhappy if we pass it a
+	   suddenly-orphaned skbuff */
+	if ((*pskb)->sk)
+		skb_set_owner_w(nskb, (*pskb)->sk);
+	kfree_skb(*pskb);
+	*pskb = nskb;
+	return 1;
+
+pull_skb:
+	return pskb_may_pull(*pskb, writable_len);
 }
 
 int __init ip_nat_init(void)
diff -Nru a/net/ipv4/netfilter/ip_nat_helper.c b/net/ipv4/netfilter/ip_nat_helper.c
--- a/net/ipv4/netfilter/ip_nat_helper.c	Tue May  6 09:30:02 2003
+++ b/net/ipv4/netfilter/ip_nat_helper.c	Tue May  6 09:30:02 2003
@@ -46,14 +46,14 @@
 #endif
 
 DECLARE_LOCK(ip_nat_seqofs_lock);
-			 
-static inline int 
-ip_nat_resize_packet(struct sk_buff **skb,
-		     struct ip_conntrack *ct, 
-		     enum ip_conntrack_info ctinfo,
-		     int new_size)
+
+/* Setup TCP sequence correction given this change at this sequence */
+static inline void 
+adjust_tcp_sequence(u32 seq,
+		    int sizediff,
+		    struct ip_conntrack *ct, 
+		    enum ip_conntrack_info ctinfo)
 {
-	struct iphdr *iph;
 	int dir;
 	struct ip_nat_seq *this_way, *other_way;
 
@@ -65,52 +65,89 @@
 	this_way = &ct->nat.info.seq[dir];
 	other_way = &ct->nat.info.seq[!dir];
 
-	if (new_size > (*skb)->len + skb_tailroom(*skb)) {
-		struct sk_buff *newskb;
-		newskb = skb_copy_expand(*skb, skb_headroom(*skb),
-					 new_size - (*skb)->len,
-					 GFP_ATOMIC);
-
-		if (!newskb) {
-			printk("ip_nat_resize_packet: oom\n");
-			return 0;
-		} else {
-			kfree_skb(*skb);
-			*skb = newskb;
-		}
+	DEBUGP("ip_nat_resize_packet: Seq_offset before: ");
+	DUMP_OFFSET(this_way);
+
+	LOCK_BH(&ip_nat_seqofs_lock);
+
+	/* SYN adjust. If it's uninitialized, of this is after last
+	 * correction, record it: we don't handle more than one
+	 * adjustment in the window, but do deal with common case of a
+	 * retransmit */
+	if (this_way->offset_before == this_way->offset_after
+	    || before(this_way->correction_pos, seq)) {
+		    this_way->correction_pos = seq;
+		    this_way->offset_before = this_way->offset_after;
+		    this_way->offset_after += sizediff;
 	}
+	UNLOCK_BH(&ip_nat_seqofs_lock);
 
-	iph = (*skb)->nh.iph;
-	if (iph->protocol == IPPROTO_TCP) {
-		struct tcphdr *tcph = (void *)iph + iph->ihl*4;
-
-		DEBUGP("ip_nat_resize_packet: Seq_offset before: ");
-		DUMP_OFFSET(this_way);
-
-		LOCK_BH(&ip_nat_seqofs_lock);
-
-		/* SYN adjust. If it's uninitialized, of this is after last 
-		 * correction, record it: we don't handle more than one 
-		 * adjustment in the window, but do deal with common case of a 
-		 * retransmit */
-		if (this_way->offset_before == this_way->offset_after
-		    || before(this_way->correction_pos, ntohl(tcph->seq))) {
-			this_way->correction_pos = ntohl(tcph->seq);
-			this_way->offset_before = this_way->offset_after;
-			this_way->offset_after = (int32_t)
-				this_way->offset_before + new_size -
-				(*skb)->len;
-		}
+	DEBUGP("ip_nat_resize_packet: Seq_offset after: ");
+	DUMP_OFFSET(this_way);
+}
+
+/* Frobs data inside this packet, which is linear. */
+static void mangle_contents(struct sk_buff *skb,
+			    unsigned int dataoff,
+			    unsigned int match_offset,
+			    unsigned int match_len,
+			    const char *rep_buffer,
+			    unsigned int rep_len)
+{
+	unsigned char *data;
+
+	BUG_ON(skb_is_nonlinear(skb));
+	data = (unsigned char *)skb->nh.iph + dataoff;
 
-		UNLOCK_BH(&ip_nat_seqofs_lock);
+	/* move post-replacement */
+	memmove(data + match_offset + rep_len,
+		data + match_offset + match_len,
+		skb->tail - (data + match_offset + match_len));
 
-		DEBUGP("ip_nat_resize_packet: Seq_offset after: ");
-		DUMP_OFFSET(this_way);
+	/* insert data from buffer */
+	memcpy(data + match_offset, rep_buffer, rep_len);
+
+	/* update skb info */
+	if (rep_len > match_len) {
+		DEBUGP("ip_nat_mangle_packet: Extending packet by "
+			"%u from %u bytes\n", rep_len - match_len,
+		       skb->len);
+		skb_put(skb, rep_len - match_len);
+	} else {
+		DEBUGP("ip_nat_mangle_packet: Shrinking packet from "
+			"%u from %u bytes\n", match_len - rep_len,
+		       skb->len);
+		__skb_trim(skb, skb->len + rep_len - match_len);
 	}
-	
-	return 1;
+
+	/* fix IP hdr checksum information */
+	skb->nh.iph->tot_len = htons(skb->len);
+	ip_send_check(skb->nh.iph);
+	skb->csum = csum_partial(data, skb->len - dataoff, 0);
 }
 
+/* Unusual, but possible case. */
+static int enlarge_skb(struct sk_buff **pskb, unsigned int extra)
+{
+	struct sk_buff *nskb;
+
+	if ((*pskb)->len + extra > 65535)
+		return 0;
+
+	nskb = skb_copy_expand(*pskb, skb_headroom(*pskb), extra, GFP_ATOMIC);
+	if (!nskb)
+		return 0;
+
+	/* Transfer socket to new skb. */
+	if ((*pskb)->sk)
+		skb_set_owner_w(nskb, (*pskb)->sk);
+#ifdef CONFIG_NETFILTER_DEBUG
+	nskb->nf_debug = (*pskb)->nf_debug;
+#endif
+	kfree_skb(*pskb);
+	*pskb = nskb;
+	return 1;
+}
 
 /* Generic function for mangling variable-length address changes inside
  * NATed TCP connections (like the PORT XXX,XXX,XXX,XXX,XXX,XXX
@@ -121,91 +158,41 @@
  *
  * */
 int 
-ip_nat_mangle_tcp_packet(struct sk_buff **skb,
+ip_nat_mangle_tcp_packet(struct sk_buff **pskb,
 			 struct ip_conntrack *ct,
 			 enum ip_conntrack_info ctinfo,
 			 unsigned int match_offset,
 			 unsigned int match_len,
-			 char *rep_buffer,
+			 const char *rep_buffer,
 			 unsigned int rep_len)
 {
-	struct iphdr *iph = (*skb)->nh.iph;
+	struct iphdr *iph;
 	struct tcphdr *tcph;
-	unsigned char *data;
-	u_int32_t tcplen, newlen, newtcplen;
 
-	tcplen = (*skb)->len - iph->ihl*4;
-	newtcplen = tcplen - match_len + rep_len;
-	newlen = iph->ihl*4 + newtcplen;
-
-	if (newlen > 65535) {
-		if (net_ratelimit())
-			printk("ip_nat_mangle_tcp_packet: nat'ed packet "
-				"exceeds maximum packet size\n");
+	if (!skb_ip_make_writable(pskb, (*pskb)->len))
 		return 0;
-	}
 
-	if ((*skb)->len != newlen) {
-		if (!ip_nat_resize_packet(skb, ct, ctinfo, newlen)) {
-			printk("resize_packet failed!!\n");
-			return 0;
-		}
-	}
+	if (rep_len > match_len
+	    && rep_len - match_len > skb_tailroom(*pskb)
+	    && !enlarge_skb(pskb, rep_len - match_len))
+		return 0;
 
-	/* Alexey says: if a hook changes _data_ ... it can break
-	   original packet sitting in tcp queue and this is fatal */
-	if (skb_cloned(*skb)) {
-		struct sk_buff *nskb = skb_copy(*skb, GFP_ATOMIC);
-		if (!nskb) {
-			if (net_ratelimit())
-				printk("Out of memory cloning TCP packet\n");
-			return 0;
-		}
-		/* Rest of kernel will get very unhappy if we pass it
-		   a suddenly-orphaned skbuff */
-		if ((*skb)->sk)
-			skb_set_owner_w(nskb, (*skb)->sk);
-		kfree_skb(*skb);
-		*skb = nskb;
-	}
+	SKB_LINEAR_ASSERT(*pskb);
 
-	/* skb may be copied !! */
-	iph = (*skb)->nh.iph;
+	iph = (*pskb)->nh.iph;
 	tcph = (void *)iph + iph->ihl*4;
-	data = (void *)tcph + tcph->doff*4;
-
-	if (rep_len != match_len)
-		/* move post-replacement */
-		memmove(data + match_offset + rep_len,
-			data + match_offset + match_len,
-			(*skb)->tail - (data + match_offset + match_len));
-
-	/* insert data from buffer */
-	memcpy(data + match_offset, rep_buffer, rep_len);
-
-	/* update skb info */
-	if (newlen > (*skb)->len) {
-		DEBUGP("ip_nat_mangle_tcp_packet: Extending packet by "
-			"%u to %u bytes\n", newlen - (*skb)->len, newlen);
-		skb_put(*skb, newlen - (*skb)->len);
-	} else {
-		DEBUGP("ip_nat_mangle_tcp_packet: Shrinking packet from "
-			"%u to %u bytes\n", (*skb)->len, newlen);
-		skb_trim(*skb, newlen);
-	}
-
-	/* fix checksum information */
 
-	iph->tot_len = htons(newlen);
-	(*skb)->csum = csum_partial((char *)tcph + tcph->doff*4,
-				    newtcplen - tcph->doff*4, 0);
+	mangle_contents(*pskb, iph->ihl*4 + tcph->doff*4,
+			match_offset, match_len, rep_buffer, rep_len);
 
 	tcph->check = 0;
-	tcph->check = tcp_v4_check(tcph, newtcplen, iph->saddr, iph->daddr,
+	tcph->check = tcp_v4_check(tcph, (*pskb)->len - iph->ihl*4,
+				   iph->saddr, iph->daddr,
 				   csum_partial((char *)tcph, tcph->doff*4,
-					   (*skb)->csum));
-	ip_send_check(iph);
-
+						(*pskb)->csum));
+	adjust_tcp_sequence(ntohl(tcph->seq),
+			    (int)match_len - (int)rep_len,
+			    ct, ctinfo);
 	return 1;
 }
 			
@@ -220,219 +207,164 @@
  *       should be fairly easy to do.
  */
 int 
-ip_nat_mangle_udp_packet(struct sk_buff **skb,
+ip_nat_mangle_udp_packet(struct sk_buff **pskb,
 			 struct ip_conntrack *ct,
 			 enum ip_conntrack_info ctinfo,
 			 unsigned int match_offset,
 			 unsigned int match_len,
-			 char *rep_buffer,
+			 const char *rep_buffer,
 			 unsigned int rep_len)
 {
-	struct iphdr *iph = (*skb)->nh.iph;
-	struct udphdr *udph = (void *)iph + iph->ihl * 4;
-	unsigned char *data;
-	u_int32_t udplen, newlen, newudplen;
+	struct iphdr *iph;
+	struct udphdr *udph;
+	int need_csum = ((*pskb)->csum != 0);
 
-	udplen = (*skb)->len - iph->ihl*4;
-	newudplen = udplen - match_len + rep_len;
-	newlen = iph->ihl*4 + newudplen;
-
-	if (newlen > 65535) {
-		if (net_ratelimit())
-			printk("ip_nat_mangle_udp_packet: nat'ed packet "
-				"exceeds maximum packet size\n");
+	if (!skb_ip_make_writable(pskb, (*pskb)->len))
 		return 0;
-	}
 
-	if ((*skb)->len != newlen) {
-		if (!ip_nat_resize_packet(skb, ct, ctinfo, newlen)) {
-			printk("resize_packet failed!!\n");
-			return 0;
-		}
-	}
-
-	/* Alexey says: if a hook changes _data_ ... it can break
-	   original packet sitting in tcp queue and this is fatal */
-	if (skb_cloned(*skb)) {
-		struct sk_buff *nskb = skb_copy(*skb, GFP_ATOMIC);
-		if (!nskb) {
-			if (net_ratelimit())
-				printk("Out of memory cloning TCP packet\n");
-			return 0;
-		}
-		/* Rest of kernel will get very unhappy if we pass it
-		   a suddenly-orphaned skbuff */
-		if ((*skb)->sk)
-			skb_set_owner_w(nskb, (*skb)->sk);
-		kfree_skb(*skb);
-		*skb = nskb;
-	}
+	if (rep_len > match_len
+	    && rep_len - match_len > skb_tailroom(*pskb)
+	    && !enlarge_skb(pskb, rep_len - match_len))
+		return 0;
 
-	/* skb may be copied !! */
-	iph = (*skb)->nh.iph;
+	iph = (*pskb)->nh.iph;
 	udph = (void *)iph + iph->ihl*4;
-	data = (void *)udph + sizeof(struct udphdr);
-
-	if (rep_len != match_len)
-		/* move post-replacement */
-		memmove(data + match_offset + rep_len,
-			data + match_offset + match_len,
-			(*skb)->tail - (data + match_offset + match_len));
-
-	/* insert data from buffer */
-	memcpy(data + match_offset, rep_buffer, rep_len);
+	mangle_contents(*pskb, iph->ihl*4 + sizeof(*udph),
+			match_offset, match_len, rep_buffer, rep_len);
 
-	/* update skb info */
-	if (newlen > (*skb)->len) {
-		DEBUGP("ip_nat_mangle_udp_packet: Extending packet by "
-			"%u to %u bytes\n", newlen - (*skb)->len, newlen);
-		skb_put(*skb, newlen - (*skb)->len);
-	} else {
-		DEBUGP("ip_nat_mangle_udp_packet: Shrinking packet from "
-			"%u to %u bytes\n", (*skb)->len, newlen);
-		skb_trim(*skb, newlen);
-	}
-
-	/* update the length of the UDP and IP packets to the new values*/
-	udph->len = htons((*skb)->len - iph->ihl*4);
-	iph->tot_len = htons(newlen);
+	/* update the length of the UDP packet */
+	udph->len = htons((*pskb)->len - iph->ihl*4);
 
 	/* fix udp checksum if udp checksum was previously calculated */
-	if ((*skb)->csum != 0) {
-		(*skb)->csum = csum_partial((char *)udph +
-					    sizeof(struct udphdr),
-					    newudplen - sizeof(struct udphdr),
-					    0);
-
+	if (need_csum) {
 		udph->check = 0;
-		udph->check = csum_tcpudp_magic(iph->saddr, iph->daddr,
-						newudplen, IPPROTO_UDP,
-						csum_partial((char *)udph,
+		udph->check
+			= csum_tcpudp_magic(iph->saddr, iph->daddr,
+					    (*pskb)->len - iph->ihl*4,
+					    IPPROTO_UDP,
+					    csum_partial((char *)udph,
 							 sizeof(struct udphdr),
-							(*skb)->csum));
-	}
-
-	ip_send_check(iph);
-
+							 (*pskb)->csum));
+	} else
+		(*pskb)->csum = 0;
 	return 1;
 }
 
 /* Adjust one found SACK option including checksum correction */
 static void
-sack_adjust(struct tcphdr *tcph, 
-	    unsigned char *ptr, 
+sack_adjust(struct sk_buff *skb,
+	    struct tcphdr *tcph, 
+	    unsigned int sackoff,
+	    unsigned int sackend,
 	    struct ip_nat_seq *natseq)
 {
-	struct tcp_sack_block *sp = (struct tcp_sack_block *)(ptr+2);
-	int num_sacks = (ptr[1] - TCPOLEN_SACK_BASE)>>3;
-	int i;
-
-	for (i = 0; i < num_sacks; i++, sp++) {
+	while (sackoff < sackend) {
+		struct tcp_sack_block *sack;
 		u_int32_t new_start_seq, new_end_seq;
 
-		if (after(ntohl(sp->start_seq) - natseq->offset_before,
+		sack = (void *)skb->data + sackoff;
+		if (after(ntohl(sack->start_seq) - natseq->offset_before,
 			  natseq->correction_pos))
-			new_start_seq = ntohl(sp->start_seq) 
+			new_start_seq = ntohl(sack->start_seq) 
 					- natseq->offset_after;
 		else
-			new_start_seq = ntohl(sp->start_seq) 
+			new_start_seq = ntohl(sack->start_seq) 
 					- natseq->offset_before;
 		new_start_seq = htonl(new_start_seq);
 
-		if (after(ntohl(sp->end_seq) - natseq->offset_before,
+		if (after(ntohl(sack->end_seq) - natseq->offset_before,
 			  natseq->correction_pos))
-			new_end_seq = ntohl(sp->end_seq)
+			new_end_seq = ntohl(sack->end_seq)
 				      - natseq->offset_after;
 		else
-			new_end_seq = ntohl(sp->end_seq)
+			new_end_seq = ntohl(sack->end_seq)
 				      - natseq->offset_before;
 		new_end_seq = htonl(new_end_seq);
 
 		DEBUGP("sack_adjust: start_seq: %d->%d, end_seq: %d->%d\n",
-			ntohl(sp->start_seq), new_start_seq,
-			ntohl(sp->end_seq), new_end_seq);
+			ntohl(sack->start_seq), new_start_seq,
+			ntohl(sack->end_seq), new_end_seq);
 
 		tcph->check = 
-			ip_nat_cheat_check(~sp->start_seq, new_start_seq,
-					   ip_nat_cheat_check(~sp->end_seq, 
+			ip_nat_cheat_check(~sack->start_seq, new_start_seq,
+					   ip_nat_cheat_check(~sack->end_seq, 
 						   	      new_end_seq,
 							      tcph->check));
-
-		sp->start_seq = new_start_seq;
-		sp->end_seq = new_end_seq;
+		sack->start_seq = new_start_seq;
+		sack->end_seq = new_end_seq;
+		sackoff += sizeof(*sack);
 	}
 }
-			
 
-/* TCP SACK sequence number adjustment, return 0 if sack found and adjusted */
-static inline int
-ip_nat_sack_adjust(struct sk_buff *skb,
-			struct ip_conntrack *ct,
-			enum ip_conntrack_info ctinfo)
+/* TCP SACK sequence number adjustment */
+static inline unsigned int
+ip_nat_sack_adjust(struct sk_buff **pskb,
+		   struct tcphdr *tcph,
+		   struct ip_conntrack *ct,
+		   enum ip_conntrack_info ctinfo)
 {
-	struct iphdr *iph;
-	struct tcphdr *tcph;
-	unsigned char *ptr;
-	int length, dir, sack_adjusted = 0;
+	unsigned int dir, optoff, optend;
 
-	iph = skb->nh.iph;
-	tcph = (void *)iph + iph->ihl*4;
-	length = (tcph->doff*4)-sizeof(struct tcphdr);
-	ptr = (unsigned char *)(tcph+1);
+	optoff = (*pskb)->nh.iph->ihl*4 + sizeof(struct tcphdr);
+	optend = (*pskb)->nh.iph->ihl*4 + tcph->doff*4;
+
+	if (!skb_ip_make_writable(pskb, optend))
+		return 0;
 
 	dir = CTINFO2DIR(ctinfo);
 
-	while (length > 0) {
-		int opcode = *ptr++;
-		int opsize;
+	while (optoff < optend) {
+		/* Usually: option, length. */
+		unsigned char *op = (*pskb)->data + optoff;
 
-		switch (opcode) {
+		switch (op[0]) {
 		case TCPOPT_EOL:
-			return !sack_adjusted;
+			return 1;
 		case TCPOPT_NOP:
-			length--;
+			optoff++;
 			continue;
 		default:
-			opsize = *ptr++;
-			if (opsize > length) /* no partial opts */
-				return !sack_adjusted;
-			if (opcode == TCPOPT_SACK) {
-				/* found SACK */
-				if((opsize >= (TCPOLEN_SACK_BASE
-					       +TCPOLEN_SACK_PERBLOCK)) &&
-				   !((opsize - TCPOLEN_SACK_BASE)
-				     % TCPOLEN_SACK_PERBLOCK))
-					sack_adjust(tcph, ptr-2,
-						    &ct->nat.info.seq[!dir]);
-				
-				sack_adjusted = 1;
-			}
-			ptr += opsize-2;
-			length -= opsize;
+			/* no partial options */
+			if (optoff + 1 == optend
+			    || optoff + op[1] > optend
+			    || op[1] < 2)
+				return 0;
+			if (op[0] == TCPOPT_SACK
+			    && op[1] >= 2+TCPOLEN_SACK_PERBLOCK
+			    && ((op[1] - 2) % TCPOLEN_SACK_PERBLOCK) == 0)
+				sack_adjust(*pskb, tcph, optoff+2,
+					    optoff+op[1],
+					    &ct->nat.info.seq[!dir]);
+			optoff += op[1];
 		}
 	}
-	return !sack_adjusted;
+	return 1;
 }
 
-/* TCP sequence number adjustment */
-int 
-ip_nat_seq_adjust(struct sk_buff *skb, 
+/* TCP sequence number adjustment.  Returns true or false.  */
+int
+ip_nat_seq_adjust(struct sk_buff **pskb, 
 		  struct ip_conntrack *ct, 
 		  enum ip_conntrack_info ctinfo)
 {
-	struct iphdr *iph;
 	struct tcphdr *tcph;
 	int dir, newseq, newack;
 	struct ip_nat_seq *this_way, *other_way;	
-	
-	iph = skb->nh.iph;
-	tcph = (void *)iph + iph->ihl*4;
 
 	dir = CTINFO2DIR(ctinfo);
 
 	this_way = &ct->nat.info.seq[dir];
 	other_way = &ct->nat.info.seq[!dir];
-	
+
+	/* No adjustments to make?  Very common case. */
+	if (!this_way->offset_before && !this_way->offset_after
+	    && !other_way->offset_before && !other_way->offset_after)
+		return 1;
+
+	if (!skb_ip_make_writable(pskb, (*pskb)->nh.iph->ihl*4+sizeof(*tcph)))
+		return 0;
+
+	tcph = (void *)(*pskb)->data + (*pskb)->nh.iph->ihl*4;
 	if (after(ntohl(tcph->seq), this_way->correction_pos))
 		newseq = ntohl(tcph->seq) + this_way->offset_after;
 	else
@@ -458,9 +390,7 @@
 	tcph->seq = newseq;
 	tcph->ack_seq = newack;
 
-	ip_nat_sack_adjust(skb, ct, ctinfo);
-
-	return 0;
+	return ip_nat_sack_adjust(pskb, tcph, ct, ctinfo);
 }
 
 static inline int
diff -Nru a/net/ipv4/netfilter/ip_nat_proto_icmp.c b/net/ipv4/netfilter/ip_nat_proto_icmp.c
--- a/net/ipv4/netfilter/ip_nat_proto_icmp.c	Tue May  6 09:30:02 2003
+++ b/net/ipv4/netfilter/ip_nat_proto_icmp.c	Tue May  6 09:30:02 2003
@@ -42,17 +42,24 @@
 	return 0;
 }
 
-static void
-icmp_manip_pkt(struct iphdr *iph, size_t len,
+static int
+icmp_manip_pkt(struct sk_buff **pskb,
+	       unsigned int hdroff,
 	       const struct ip_conntrack_manip *manip,
 	       enum ip_nat_manip_type maniptype)
 {
-	struct icmphdr *hdr = (struct icmphdr *)((u_int32_t *)iph + iph->ihl);
+	struct icmphdr *hdr;
+
+	if (!skb_ip_make_writable(pskb, hdroff + sizeof(*hdr)))
+		return 0;
+
+	hdr = (void *)(*pskb)->data + hdroff;
 
 	hdr->checksum = ip_nat_cheat_check(hdr->un.echo.id ^ 0xFFFF,
-					   manip->u.icmp.id,
-					   hdr->checksum);
+					    manip->u.icmp.id,
+					    hdr->checksum);
 	hdr->un.echo.id = manip->u.icmp.id;
+	return 1;
 }
 
 static unsigned int
diff -Nru a/net/ipv4/netfilter/ip_nat_proto_tcp.c b/net/ipv4/netfilter/ip_nat_proto_tcp.c
--- a/net/ipv4/netfilter/ip_nat_proto_tcp.c	Tue May  6 09:30:02 2003
+++ b/net/ipv4/netfilter/ip_nat_proto_tcp.c	Tue May  6 09:30:02 2003
@@ -7,6 +7,7 @@
 #include <linux/netfilter_ipv4/ip_nat.h>
 #include <linux/netfilter_ipv4/ip_nat_rule.h>
 #include <linux/netfilter_ipv4/ip_nat_protocol.h>
+#include <linux/netfilter_ipv4/ip_nat_core.h>
 
 static int
 tcp_in_range(const struct ip_conntrack_tuple *tuple,
@@ -73,36 +74,49 @@
 	return 0;
 }
 
-static void
-tcp_manip_pkt(struct iphdr *iph, size_t len,
+static int
+tcp_manip_pkt(struct sk_buff **pskb,
+	      unsigned int hdroff,
 	      const struct ip_conntrack_manip *manip,
 	      enum ip_nat_manip_type maniptype)
 {
-	struct tcphdr *hdr = (struct tcphdr *)((u_int32_t *)iph + iph->ihl);
+	struct tcphdr *hdr;
 	u_int32_t oldip;
-	u_int16_t *portptr;
+	u_int16_t *portptr, oldport;
+	int hdrsize = 8; /* TCP connection tracking guarantees this much */
+
+	/* this could be a inner header returned in icmp packet; in such
+	   cases we cannot update the checksum field since it is outside of
+	   the 8 bytes of transport layer headers we are guaranteed */
+	if ((*pskb)->len >= hdroff + sizeof(struct tcphdr))
+		hdrsize = sizeof(struct tcphdr);
+
+	if (!skb_ip_make_writable(pskb, hdroff + hdrsize))
+		return 0;
+
+	hdr = (void *)(*pskb)->data + hdroff;
 
 	if (maniptype == IP_NAT_MANIP_SRC) {
 		/* Get rid of src ip and src pt */
-		oldip = iph->saddr;
+		oldip = (*pskb)->nh.iph->saddr;
 		portptr = &hdr->source;
 	} else {
 		/* Get rid of dst ip and dst pt */
-		oldip = iph->daddr;
+		oldip = (*pskb)->nh.iph->daddr;
 		portptr = &hdr->dest;
 	}
 
-	/* this could be a inner header returned in icmp packet; in such
-	   cases we cannot update the checksum field since it is outside of
-	   the 8 bytes of transport layer headers we are guaranteed */
-	if(((void *)&hdr->check + sizeof(hdr->check) - (void *)iph) <= len) {
-		hdr->check = ip_nat_cheat_check(~oldip, manip->ip,
-					ip_nat_cheat_check(*portptr ^ 0xFFFF,
+	oldport = *portptr;
+	*portptr = manip->u.tcp.port;
+
+	if (hdrsize < sizeof(*hdr))
+		return 1;
+
+	hdr->check = ip_nat_cheat_check(~oldip, manip->ip,
+					ip_nat_cheat_check(oldport ^ 0xFFFF,
 							   manip->u.tcp.port,
 							   hdr->check));
-	}
-
-	*portptr = manip->u.tcp.port;
+	return 1;
 }
 
 static unsigned int
diff -Nru a/net/ipv4/netfilter/ip_nat_proto_udp.c b/net/ipv4/netfilter/ip_nat_proto_udp.c
--- a/net/ipv4/netfilter/ip_nat_proto_udp.c	Tue May  6 09:30:02 2003
+++ b/net/ipv4/netfilter/ip_nat_proto_udp.c	Tue May  6 09:30:02 2003
@@ -72,22 +72,27 @@
 	return 0;
 }
 
-static void
-udp_manip_pkt(struct iphdr *iph, size_t len,
+static int
+udp_manip_pkt(struct sk_buff **pskb,
+	      unsigned int hdroff,
 	      const struct ip_conntrack_manip *manip,
 	      enum ip_nat_manip_type maniptype)
 {
-	struct udphdr *hdr = (struct udphdr *)((u_int32_t *)iph + iph->ihl);
+	struct udphdr *hdr;
 	u_int32_t oldip;
 	u_int16_t *portptr;
 
+	if (!skb_ip_make_writable(pskb, hdroff + sizeof(hdr)))
+		return 0;
+
+	hdr = (void *)(*pskb)->data + hdroff;
 	if (maniptype == IP_NAT_MANIP_SRC) {
 		/* Get rid of src ip and src pt */
-		oldip = iph->saddr;
+		oldip = (*pskb)->nh.iph->saddr;
 		portptr = &hdr->source;
 	} else {
 		/* Get rid of dst ip and dst pt */
-		oldip = iph->daddr;
+		oldip = (*pskb)->nh.iph->daddr;
 		portptr = &hdr->dest;
 	}
 	if (hdr->check) /* 0 is a special case meaning no checksum */
@@ -96,6 +101,7 @@
 							   manip->u.udp.port,
 							   hdr->check));
 	*portptr = manip->u.udp.port;
+	return 1;
 }
 
 static unsigned int
diff -Nru a/net/ipv4/netfilter/ip_nat_proto_unknown.c b/net/ipv4/netfilter/ip_nat_proto_unknown.c
--- a/net/ipv4/netfilter/ip_nat_proto_unknown.c	Tue May  6 09:30:02 2003
+++ b/net/ipv4/netfilter/ip_nat_proto_unknown.c	Tue May  6 09:30:02 2003
@@ -29,12 +29,13 @@
 	return 0;
 }
 
-static void
-unknown_manip_pkt(struct iphdr *iph, size_t len,
+static int
+unknown_manip_pkt(struct sk_buff **pskb,
+		  unsigned int hdroff,
 		  const struct ip_conntrack_manip *manip,
 		  enum ip_nat_manip_type maniptype)
 {
-	return;
+	return 1;
 }
 
 static unsigned int
diff -Nru a/net/ipv4/netfilter/ip_nat_standalone.c b/net/ipv4/netfilter/ip_nat_standalone.c
--- a/net/ipv4/netfilter/ip_nat_standalone.c	Tue May  6 09:30:02 2003
+++ b/net/ipv4/netfilter/ip_nat_standalone.c	Tue May  6 09:30:02 2003
@@ -71,10 +71,6 @@
 	/* maniptype == SRC for postrouting. */
 	enum ip_nat_manip_type maniptype = HOOK2MANIP(hooknum);
 
-	/* FIXME: Push down to extensions --RR */
-	if (skb_is_nonlinear(*pskb) && skb_linearize(*pskb, GFP_ATOMIC) != 0)
-		return NF_DROP;
-
 	/* We never see fragments: conntrack defrags on pre-routing
 	   and local-out, and ip_nat_out protects post-routing. */
 	IP_NF_ASSERT(!((*pskb)->nh.iph->frag_off
@@ -95,12 +91,14 @@
 		/* Exception: ICMP redirect to new connection (not in
                    hash table yet).  We must not let this through, in
                    case we're doing NAT to the same network. */
-		struct iphdr *iph = (*pskb)->nh.iph;
-		struct icmphdr *hdr = (struct icmphdr *)
-			((u_int32_t *)iph + iph->ihl);
-		if (iph->protocol == IPPROTO_ICMP
-		    && hdr->type == ICMP_REDIRECT)
-			return NF_DROP;
+		if ((*pskb)->nh.iph->protocol == IPPROTO_ICMP) {
+			struct icmphdr hdr;
+
+			if (skb_copy_bits(*pskb, (*pskb)->nh.iph->ihl*4,
+					  &hdr, sizeof(hdr)) == 0
+			    && hdr.type == ICMP_REDIRECT)
+				return NF_DROP;
+		}
 		return NF_ACCEPT;
 	}
 
@@ -108,8 +106,11 @@
 	case IP_CT_RELATED:
 	case IP_CT_RELATED+IP_CT_IS_REPLY:
 		if ((*pskb)->nh.iph->protocol == IPPROTO_ICMP) {
-			return icmp_reply_translation(*pskb, ct, hooknum,
-						      CTINFO2DIR(ctinfo));
+			if (!icmp_reply_translation(pskb, ct, hooknum,
+						    CTINFO2DIR(ctinfo)))
+				return NF_DROP;
+			else
+				return NF_ACCEPT;
 		}
 		/* Fall thru... (Only ICMPs can be IP_CT_IS_REPLY) */
 	case IP_CT_NEW:
@@ -174,10 +175,6 @@
 	   const struct net_device *out,
 	   int (*okfn)(struct sk_buff *))
 {
-	/* FIXME: Push down to extensions --RR */
-	if (skb_is_nonlinear(*pskb) && skb_linearize(*pskb, GFP_ATOMIC) != 0)
-		return NF_DROP;
-
 	/* root is playing with raw sockets. */
 	if ((*pskb)->len < sizeof(struct iphdr)
 	    || (*pskb)->nh.iph->ihl * 4 < sizeof(struct iphdr))
@@ -213,10 +210,6 @@
 	u_int32_t saddr, daddr;
 	unsigned int ret;
 
-	/* FIXME: Push down to extensions --RR */
-	if (skb_is_nonlinear(*pskb) && skb_linearize(*pskb, GFP_ATOMIC) != 0)
-		return NF_DROP;
-
 	/* root is playing with raw sockets. */
 	if ((*pskb)->len < sizeof(struct iphdr)
 	    || (*pskb)->nh.iph->ihl * 4 < sizeof(struct iphdr))
@@ -387,4 +380,5 @@
 EXPORT_SYMBOL(ip_nat_mangle_tcp_packet);
 EXPORT_SYMBOL(ip_nat_mangle_udp_packet);
 EXPORT_SYMBOL(ip_nat_used_tuple);
+EXPORT_SYMBOL(skb_ip_make_writable);
 MODULE_LICENSE("GPL");
diff -Nru a/net/ipv4/netfilter/ip_nat_tftp.c b/net/ipv4/netfilter/ip_nat_tftp.c
--- a/net/ipv4/netfilter/ip_nat_tftp.c	Tue May  6 09:30:02 2003
+++ b/net/ipv4/netfilter/ip_nat_tftp.c	Tue May  6 09:30:02 2003
@@ -57,9 +57,7 @@
 	      struct sk_buff **pskb)
 {
 	int dir = CTINFO2DIR(ctinfo);
-	struct iphdr *iph = (*pskb)->nh.iph;
-	struct udphdr *udph = (void *)iph + iph->ihl * 4;
-	struct tftphdr *tftph = (void *)udph + 8;
+	struct tftphdr tftph;
 	struct ip_conntrack_tuple repl;
 
 	if (!((hooknum == NF_IP_POST_ROUTING && dir == IP_CT_DIR_ORIGINAL)
@@ -71,7 +69,11 @@
 		return NF_ACCEPT;
 	}
 
-	switch (ntohs(tftph->opcode)) {
+	if (skb_copy_bits(*pskb, (*pskb)->nh.iph->ihl*4+sizeof(struct udphdr),
+			  &tftph, sizeof(tftph)) != 0)
+		return NF_DROP;
+
+	switch (ntohs(tftph.opcode)) {
 	/* RRQ and WRQ works the same way */
 	case TFTP_OPCODE_READ:
 	case TFTP_OPCODE_WRITE:
@@ -104,8 +106,10 @@
 #if 0
 	const struct ip_conntrack_tuple *repl =
 			&master->tuplehash[IP_CT_DIR_REPLY].tuple;
-	struct iphdr *iph = (*pskb)->nh.iph;
-	struct udphdr *udph = (void *)iph + iph->ihl*4;
+	struct udphdr udph;
+
+	if (skb_copy_bits(*pskb,(*pskb)->nh.iph->ihl*4,&udph,sizeof(udph))!=0)
+		return NF_DROP;
 #endif
 
 	IP_NF_ASSERT(info);
@@ -119,8 +123,8 @@
 		mr.range[0].min_ip = mr.range[0].max_ip = orig->dst.ip; 
 		DEBUGP("orig: %u.%u.%u.%u:%u <-> %u.%u.%u.%u:%u "
 			"newsrc: %u.%u.%u.%u\n",
-                        NIPQUAD((*pskb)->nh.iph->saddr), ntohs(udph->source),
-			NIPQUAD((*pskb)->nh.iph->daddr), ntohs(udph->dest),
+                        NIPQUAD((*pskb)->nh.iph->saddr), ntohs(udph.source),
+ 			NIPQUAD((*pskb)->nh.iph->daddr), ntohs(udph.dest),
 			NIPQUAD(orig->dst.ip));
 	} else {
 		mr.range[0].min_ip = mr.range[0].max_ip = orig->src.ip;
@@ -130,8 +134,8 @@
 
 		DEBUGP("orig: %u.%u.%u.%u:%u <-> %u.%u.%u.%u:%u "
 			"newdst: %u.%u.%u.%u:%u\n",
-                        NIPQUAD((*pskb)->nh.iph->saddr), ntohs(udph->source),
-                        NIPQUAD((*pskb)->nh.iph->daddr), ntohs(udph->dest),
+                        NIPQUAD((*pskb)->nh.iph->saddr), ntohs(udph.source),
+                        NIPQUAD((*pskb)->nh.iph->daddr), ntohs(udph.dest),
                         NIPQUAD(orig->src.ip), ntohs(orig->src.u.udp.port));
 	}
 
