Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135695AbRAJOsg>; Wed, 10 Jan 2001 09:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135696AbRAJOsZ>; Wed, 10 Jan 2001 09:48:25 -0500
Received: from smtp4.libero.it ([193.70.192.54]:47276 "EHLO smtp4.libero.it")
	by vger.kernel.org with ESMTP id <S135695AbRAJOsN>;
	Wed, 10 Jan 2001 09:48:13 -0500
Date: Wed, 10 Jan 2001 17:48:59 +0100
From: antirez <antirez@invece.org>
To: linux-kernel@vger.kernel.org
Subject: * 4 converted to << 2 for networking code
Message-ID: <20010110174859.R7498@prosa.it>
Reply-To: antirez@invece.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The attached patch converts many occurences of '* 4' in the networking code
(often used to convert in bytes the TCP data offset and the IP header len)
to the faster '<< 2'. Since this was a quite repetitive work it's better
if someone double-check it before to apply the patch.
The patch is for linux-2.4.

Please, CC: me for replies since I'm not subscribed to the list.

regards,
antirez

-- 
Salvatore Sanfilippo              |                      <antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger antirez@tella.alicom.com

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="shift.diff"

diff -ru linux-2.4-orig/net/ipv4/ip_fragment.c linux-2.4/net/ipv4/ip_fragment.c
--- linux-2.4-orig/net/ipv4/ip_fragment.c	Fri Dec 29 23:07:24 2000
+++ linux-2.4/net/ipv4/ip_fragment.c	Wed Jan 10 16:50:05 2001
@@ -383,7 +383,7 @@
 	flags = offset & ~IP_OFFSET;
 	offset &= IP_OFFSET;
 	offset <<= 3;		/* offset is in 8-byte chunks */
-	ihl = iph->ihl * 4;
+	ihl = iph->ihl << 2;
 
 	/* Determine the position of this fragment. */
 	end = offset + (ntohs(iph->tot_len) - ihl);
@@ -521,7 +521,7 @@
 	BUG_TRAP(FRAG_CB(head)->offset == 0);
 
 	/* Allocate a new buffer for the datagram. */
-	ihlen = head->nh.iph->ihl*4;
+	ihlen = head->nh.iph->ihl << 2;
 	len = ihlen + qp->len;
 
 	if(len > 65535)
diff -ru linux-2.4-orig/net/ipv4/ip_input.c linux-2.4/net/ipv4/ip_input.c
--- linux-2.4-orig/net/ipv4/ip_input.c	Mon Dec 11 21:37:04 2000
+++ linux-2.4/net/ipv4/ip_input.c	Wed Jan 10 16:50:31 2001
@@ -208,7 +208,7 @@
 			if(skb2 != NULL) {
 				ret = 1;
 				ipprot->handler(skb2,
-						ntohs(iph->tot_len) - (iph->ihl * 4));
+						ntohs(iph->tot_len) - (iph->ihl << 2));
 			}
 		}
 		ipprot = (struct inet_protocol *) ipprot->next;
@@ -226,7 +226,7 @@
 #endif /*CONFIG_NETFILTER_DEBUG*/
 
         /* Point into the IP datagram, just past the header. */
-        skb->h.raw = skb->nh.raw + iph->ihl*4;
+        skb->h.raw = skb->nh.raw + (iph->ihl << 2);
 
 	{
 		/* Note: See raw.c and net/raw.h, RAWV4_HTABLE_SIZE==MAX_INET_PROTOS */
@@ -251,7 +251,7 @@
 				
 				/* Fast path... */
 				ret = ipprot->handler(skb, (ntohs(iph->tot_len) -
-							    (iph->ihl * 4)));
+							    (iph->ihl << 2)));
 
 				return ret;
 			} else {
diff -ru linux-2.4-orig/net/ipv4/ip_options.c linux-2.4/net/ipv4/ip_options.c
--- linux-2.4-orig/net/ipv4/ip_options.c	Wed Aug  9 22:51:09 2000
+++ linux-2.4/net/ipv4/ip_options.c	Wed Jan 10 16:41:12 2001
@@ -255,7 +255,7 @@
 		opt = &(IPCB(skb)->opt);
 		memset(opt, 0, sizeof(struct ip_options));
 		iph = skb->nh.raw;
-		opt->optlen = ((struct iphdr *)iph)->ihl*4 - sizeof(struct iphdr);
+		opt->optlen = (((struct iphdr *)iph)->ihl << 2) - sizeof(struct iphdr);
 		optptr = iph + sizeof(struct iphdr);
 		opt->is_data = 0;
 	} else {
diff -ru linux-2.4-orig/net/ipv4/ip_output.c linux-2.4/net/ipv4/ip_output.c
--- linux-2.4-orig/net/ipv4/ip_output.c	Fri Oct 27 20:03:14 2000
+++ linux-2.4/net/ipv4/ip_output.c	Wed Jan 10 16:51:18 2001
@@ -537,7 +537,7 @@
 						 ipc->addr, rt, offset);
 			}
 			iph->tos = sk->protinfo.af_inet.tos;
-			iph->tot_len = htons(fraglen - fragheaderlen + iph->ihl*4);
+			iph->tot_len = htons(fraglen - fragheaderlen + (iph->ihl << 2));
 			iph->frag_off = htons(offset>>3)|mf|df;
 			iph->id = id;
 			if (!mf) {
@@ -564,7 +564,7 @@
 			iph->saddr = rt->rt_src;
 			iph->daddr = rt->rt_dst;
 			iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
-			data += iph->ihl*4;
+			data += iph->ihl << 2;
 		}
 
 		/*
@@ -685,7 +685,7 @@
 		iph->daddr=rt->rt_dst;
 		iph->check=0;
 		iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
-		err = getfrag(frag, ((char *)iph)+iph->ihl*4,0, length-iph->ihl*4);
+		err = getfrag(frag, ((char *)iph)+(iph->ihl << 2),0, length-(iph->ihl << 2));
 	}
 	else
 		err = getfrag(frag, (void *)iph, 0, length);
@@ -745,7 +745,7 @@
 	 *	Setup starting values.
 	 */
 
-	hlen = iph->ihl * 4;
+	hlen = iph->ihl << 2;
 	left = ntohs(iph->tot_len) - hlen;	/* Space per frame */
 	mtu = rt->u.dst.pmtu - hlen;	/* Size of data space */
 	ptr = raw + hlen;			/* Where to start from */
diff -ru linux-2.4-orig/net/ipv4/netfilter/ip_conntrack_core.c linux-2.4/net/ipv4/netfilter/ip_conntrack_core.c
--- linux-2.4-orig/net/ipv4/netfilter/ip_conntrack_core.c	Thu Aug 10 21:35:15 2000
+++ linux-2.4/net/ipv4/netfilter/ip_conntrack_core.c	Wed Jan 10 16:46:23 2001
@@ -123,7 +123,7 @@
 		return 0;
 	}
 	/* Guarantee 8 protocol bytes: if more wanted, use len param */
-	else if (iph->ihl * 4 + 8 > len)
+	else if ((iph->ihl << 2) + 8 > len)
 		return 0;
 
 	tuple->src.ip = iph->saddr;
@@ -308,9 +308,9 @@
 	iph = skb->nh.iph;
 	hdr = (struct icmphdr *)((u_int32_t *)iph + iph->ihl);
 	inner = (struct iphdr *)(hdr + 1);
-	datalen = skb->len - iph->ihl*4 - sizeof(*hdr);
+	datalen = skb->len - (iph->ihl << 2) - sizeof(*hdr);
 
-	if (skb->len < iph->ihl * 4 + sizeof(struct icmphdr)) {
+	if (skb->len < (iph->ihl << 2) + sizeof(struct icmphdr)) {
 		DEBUGP("icmp_error_track: too short\n");
 		return NULL;
 	}
@@ -337,7 +337,7 @@
 
 	innerproto = find_proto(inner->protocol);
 	/* Are they talking about one of our connections? */
-	if (inner->ihl * 4 + 8 > datalen
+	if ((inner->ihl << 2) + 8 > datalen
 	    || !get_tuple(inner, datalen, &origtuple, innerproto)) {
 		DEBUGP("icmp_error: ! get_tuple p=%u (%u*4+%u dlen=%u)\n",
 		       inner->protocol, inner->ihl, 8,
diff -ru linux-2.4-orig/net/ipv4/netfilter/ip_conntrack_ftp.c linux-2.4/net/ipv4/netfilter/ip_conntrack_ftp.c
--- linux-2.4-orig/net/ipv4/netfilter/ip_conntrack_ftp.c	Thu Aug 10 21:35:15 2000
+++ linux-2.4/net/ipv4/netfilter/ip_conntrack_ftp.c	Wed Jan 10 16:47:37 2001
@@ -104,10 +104,10 @@
 		enum ip_conntrack_info ctinfo)
 {
 	/* tcplen not negative guaranteed by ip_conntrack_tcp.c */
-	struct tcphdr *tcph = (void *)iph + iph->ihl * 4;
-	const char *data = (const char *)tcph + tcph->doff * 4;
-	unsigned int tcplen = len - iph->ihl * 4;
-	unsigned int datalen = tcplen - tcph->doff * 4;
+	struct tcphdr *tcph = (void *)iph + (iph->ihl << 2);
+	const char *data = (const char *)tcph + (tcph->doff << 2);
+	unsigned int tcplen = len - (iph->ihl << 2);
+	unsigned int datalen = tcplen - (tcph->doff << 2);
 	u_int32_t old_seq_aft_nl;
 	int old_seq_aft_nl_set;
 	u_int32_t array[6] = { 0 };
@@ -124,7 +124,7 @@
 	}
 
 	/* Not whole TCP header? */
-	if (tcplen < sizeof(struct tcphdr) || tcplen < tcph->doff*4) {
+	if (tcplen < sizeof(struct tcphdr) || tcplen < (tcph->doff << 2)) {
 		DEBUGP("ftp: tcplen = %u\n", (unsigned)tcplen);
 		return NF_ACCEPT;
 	}
diff -ru linux-2.4-orig/net/ipv4/netfilter/ip_conntrack_proto_tcp.c linux-2.4/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
--- linux-2.4-orig/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Fri Aug  4 22:07:24 2000
+++ linux-2.4/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Wed Jan 10 16:49:20 2001
@@ -153,7 +153,7 @@
 
 	/* We're guaranteed to have the base header, but maybe not the
            options. */
-	if (len < (iph->ihl + tcph->doff) * 4) {
+	if (len < ((iph->ihl + tcph->doff) << 2)) {
 		DEBUGP("ip_conntrack_tcp: Truncated packet.\n");
 		return -1;
 	}
diff -ru linux-2.4-orig/net/ipv4/netfilter/ip_conntrack_standalone.c linux-2.4/net/ipv4/netfilter/ip_conntrack_standalone.c
--- linux-2.4-orig/net/ipv4/netfilter/ip_conntrack_standalone.c	Thu Aug 10 21:35:15 2000
+++ linux-2.4/net/ipv4/netfilter/ip_conntrack_standalone.c	Wed Jan 10 16:51:59 2001
@@ -217,7 +217,7 @@
 {
 	/* root is playing with raw sockets. */
 	if ((*pskb)->len < sizeof(struct iphdr)
-	    || (*pskb)->nh.iph->ihl * 4 < sizeof(struct iphdr)) {
+	    || ((*pskb)->nh.iph->ihl << 2) < sizeof(struct iphdr)) {
 		if (net_ratelimit())
 			printk("ipt_hook: happy cracking.\n");
 		return NF_ACCEPT;
diff -ru linux-2.4-orig/net/ipv4/netfilter/ip_nat_core.c linux-2.4/net/ipv4/netfilter/ip_nat_core.c
--- linux-2.4-orig/net/ipv4/netfilter/ip_nat_core.c	Thu Aug 10 21:35:15 2000
+++ linux-2.4/net/ipv4/netfilter/ip_nat_core.c	Wed Jan 10 16:52:27 2001
@@ -749,7 +749,7 @@
 	unsigned int i;
 	struct ip_nat_info *info = &conntrack->nat.info;
 
-	IP_NF_ASSERT(skb->len >= iph->ihl*4 + sizeof(struct icmphdr));
+	IP_NF_ASSERT(skb->len >= (iph->ihl << 2) + sizeof(struct icmphdr));
 	/* Must be RELATED */
 	IP_NF_ASSERT(skb->nfct - (struct ip_conntrack *)skb->nfct->master
 		     == IP_CT_RELATED
diff -ru linux-2.4-orig/net/ipv4/netfilter/ip_nat_ftp.c linux-2.4/net/ipv4/netfilter/ip_nat_ftp.c
--- linux-2.4-orig/net/ipv4/netfilter/ip_nat_ftp.c	Sun Sep 17 19:15:00 2000
+++ linux-2.4/net/ipv4/netfilter/ip_nat_ftp.c	Wed Jan 10 16:55:21 2001
@@ -112,9 +112,9 @@
 	sprintf(buffer, "%u,%u,%u,%u,%u,%u",
 		NIPQUAD(newip), port>>8, port&0xFF);
 
-	tcplen = (*pskb)->len - iph->ihl * 4;
+	tcplen = (*pskb)->len - (iph->ihl << 2);
 	newtcplen = tcplen - matchlen + strlen(buffer);
-	newlen = iph->ihl*4 + newtcplen;
+	newlen = (iph->ihl << 2) + newtcplen;
 
 	/* So there I am, in the middle of my `netfilter-is-wonderful'
 	   talk in Sydney, and someone asks `What happens if you try
@@ -144,8 +144,8 @@
 		}
 	}
 
-	tcph = (void *)iph + iph->ihl*4;
-	data = (void *)tcph + tcph->doff*4;
+	tcph = (void *)iph + (iph->ihl << 2);
+	data = (void *)tcph + (tcph->doff << 2);
 
 	DEBUGP("Mapping `%.*s' [%u %u %u] to new `%s' [%u]\n",
 		 (int)matchlen, data+matchoff,
@@ -183,11 +183,11 @@
 
 	/* Fix checksums */
 	iph->tot_len = htons(newlen);
-	(*pskb)->csum = csum_partial((char *)tcph + tcph->doff*4,
-				     newtcplen - tcph->doff*4, 0);
+	(*pskb)->csum = csum_partial((char *)tcph + (tcph->doff << 2),
+				     newtcplen - (tcph->doff << 2), 0);
 	tcph->check = 0;
 	tcph->check = tcp_v4_check(tcph, newtcplen, iph->saddr, iph->daddr,
-				   csum_partial((char *)tcph, tcph->doff*4,
+				   csum_partial((char *)tcph, tcph->doff << 2,
 						(*pskb)->csum));
 	ip_send_check(iph);
 	return 1;
@@ -202,8 +202,8 @@
 	u_int8_t *opt = (u_int8_t *)tcph;
 
 	DEBUGP("Seeking SACKPERM in SYN packet (doff = %u).\n",
-	       tcph->doff * 4);
-	for (i = sizeof(struct tcphdr); i < tcph->doff * 4;) {
+	       tcph->doff << 2);
+	for (i = sizeof(struct tcphdr); i < (tcph->doff << 2);) {
 		DEBUGP("%u ", opt[i]);
 		switch (opt[i]) {
 		case TCPOPT_NOP:
@@ -227,7 +227,7 @@
 	DEBUGP("Found SACKPERM at offset %u.\n", i);
 
 	/* Must be within TCP header, and valid SACK perm. */
-	if (i + opt[i+1] <= tcph->doff*4 && opt[i+1] == 2) {
+	if (i + opt[i+1] <= (tcph->doff << 2) && opt[i+1] == 2) {
 		/* Replace with NOPs. */
 		tcph->check
 			= ip_nat_cheat_check(*((u_int16_t *)(opt + i))^0xFFFF,
@@ -245,7 +245,7 @@
 {
 	u_int32_t newip;
 	struct iphdr *iph = (*pskb)->nh.iph;
-	struct tcphdr *tcph = (void *)iph + iph->ihl*4;
+	struct tcphdr *tcph = (void *)iph + (iph->ihl << 2);
 	u_int16_t port;
 	struct ip_conntrack_tuple tuple;
 	/* Don't care about source port */
@@ -304,7 +304,7 @@
 			 struct sk_buff **pskb)
 {
 	struct iphdr *iph = (*pskb)->nh.iph;
-	struct tcphdr *tcph = (void *)iph + iph->ihl*4;
+	struct tcphdr *tcph = (void *)iph + (iph->ihl << 2);
 	u_int32_t newseq, newack;
 	unsigned int datalen;
 	int dir;
@@ -331,7 +331,7 @@
 		return NF_ACCEPT;
 	}
 
-	datalen = (*pskb)->len - iph->ihl * 4 - tcph->doff * 4;
+	datalen = (*pskb)->len - (iph->ihl << 2) - (tcph->doff << 2);
 	score = 0;
 	LOCK_BH(&ip_ftp_lock);
 	if (ct_ftp_info->len) {
@@ -361,7 +361,7 @@
 
 			/* skb may have been reallocated */
 			iph = (*pskb)->nh.iph;
-			tcph = (void *)iph + iph->ihl*4;
+			tcph = (void *)iph + (iph->ihl << 2);
 		}
 	}
 
diff -ru linux-2.4-orig/net/ipv4/netfilter/ip_nat_standalone.c linux-2.4/net/ipv4/netfilter/ip_nat_standalone.c
--- linux-2.4-orig/net/ipv4/netfilter/ip_nat_standalone.c	Mon Oct 30 23:27:49 2000
+++ linux-2.4/net/ipv4/netfilter/ip_nat_standalone.c	Wed Jan 10 16:55:51 2001
@@ -139,7 +139,7 @@
 {
 	/* root is playing with raw sockets. */
 	if ((*pskb)->len < sizeof(struct iphdr)
-	    || (*pskb)->nh.iph->ihl * 4 < sizeof(struct iphdr))
+	    || ((*pskb)->nh.iph->ihl << 2) < sizeof(struct iphdr))
 		return NF_ACCEPT;
 
 	/* We can hit fragment here; forwarded packets get
@@ -202,7 +202,7 @@
 
 	/* root is playing with raw sockets. */
 	if ((*pskb)->len < sizeof(struct iphdr)
-	    || (*pskb)->nh.iph->ihl * 4 < sizeof(struct iphdr))
+	    || ((*pskb)->nh.iph->ihl << 2) < sizeof(struct iphdr))
 		return NF_ACCEPT;
 
 	saddr = (*pskb)->nh.iph->saddr;
diff -ru linux-2.4-orig/net/ipv4/netfilter/ip_tables.c linux-2.4/net/ipv4/netfilter/ip_tables.c
--- linux-2.4-orig/net/ipv4/netfilter/ip_tables.c	Tue Dec  5 03:43:02 2000
+++ linux-2.4/net/ipv4/netfilter/ip_tables.c	Wed Jan 10 16:56:27 2001
@@ -267,7 +267,7 @@
 	/* Initialization */
 	ip = (*pskb)->nh.iph;
 	protohdr = (u_int32_t *)ip + ip->ihl;
-	datalen = (*pskb)->len - ip->ihl * 4;
+	datalen = (*pskb)->len - (ip->ihl << 2);
 	indev = in ? in->name : nulldevname;
 	outdev = out ? out->name : nulldevname;
 	/* We handle fragments by dealing with the first fragment as
@@ -373,7 +373,7 @@
 				/* Target might have changed stuff. */
 				ip = (*pskb)->nh.iph;
 				protohdr = (u_int32_t *)ip + ip->ihl;
-				datalen = (*pskb)->len - ip->ihl * 4;
+				datalen = (*pskb)->len - (ip->ihl << 2);
 
 				if (verdict == IPT_CONTINUE)
 					e = (void *)e + e->next_offset;
@@ -1450,12 +1450,12 @@
 
 	duprintf("tcp_match: finding option\n");
 	/* If we don't have the whole header, drop packet. */
-	if (tcp->doff * 4 > datalen) {
+	if ((tcp->doff << 2) > datalen) {
 		*hotdrop = 1;
 		return 0;
 	}
 
-	while (i < tcp->doff * 4) {
+	while (i < (tcp->doff << 2)) {
 		if (opt[i] == option) return !invert;
 		if (opt[i] < 2) i++;
 		else i += opt[i+1]?:1;
diff -ru linux-2.4-orig/net/ipv4/netfilter/ipchains_core.c linux-2.4/net/ipv4/netfilter/ipchains_core.c
--- linux-2.4-orig/net/ipv4/netfilter/ipchains_core.c	Fri Apr 14 02:19:57 2000
+++ linux-2.4/net/ipv4/netfilter/ipchains_core.c	Wed Jan 10 16:56:50 2001
@@ -1679,7 +1679,7 @@
 		      struct sk_buff **pskb)
 {
 	/* Locally generated bogus packets by root. <SIGH>. */
-	if (((struct iphdr *)phdr)->ihl * 4 < sizeof(struct iphdr)
+	if ((((struct iphdr *)phdr)->ihl << 2) < sizeof(struct iphdr)
 	    || (*pskb)->len < sizeof(struct iphdr))
 		return FW_ACCEPT;
 	return ip_fw_check(phdr, dev->name,
diff -ru linux-2.4-orig/net/ipv4/netfilter/ipt_LOG.c linux-2.4/net/ipv4/netfilter/ipt_LOG.c
--- linux-2.4-orig/net/ipv4/netfilter/ipt_LOG.c	Mon Jan  1 18:54:07 2001
+++ linux-2.4/net/ipv4/netfilter/ipt_LOG.c	Wed Jan 10 16:57:48 2001
@@ -32,7 +32,7 @@
 			struct iphdr *iph, unsigned int len, int recurse)
 {
 	void *protoh = (u_int32_t *)iph + iph->ihl;
-	unsigned int datalen = len - iph->ihl * 4;
+	unsigned int datalen = len - (iph->ihl << 2);
 
 	/* Important fields:
 	 * TOS, len, DF/MF, fragment offset, TTL, src, dst, options. */
@@ -58,12 +58,12 @@
 		printk("FRAG:%u ", ntohs(iph->frag_off) & IP_OFFSET);
 
 	if ((info->logflags & IPT_LOG_IPOPT)
-	    && iph->ihl * 4 != sizeof(struct iphdr)) {
+	    && (iph->ihl << 2) != sizeof(struct iphdr)) {
 		unsigned int i;
 
 		/* Max length: 127 "OPT (" 15*4*2chars ") " */
 		printk("OPT (");
-		for (i = sizeof(struct iphdr); i < iph->ihl * 4; i++)
+		for (i = sizeof(struct iphdr); i < (iph->ihl << 2); i++)
 			printk("%02X", ((u_int8_t *)iph)[i]);
 		printk(") ");
 	}
@@ -112,12 +112,12 @@
 		printk("URGP=%u ", ntohs(tcph->urg_ptr));
 
 		if ((info->logflags & IPT_LOG_TCPOPT)
-		    && tcph->doff * 4 != sizeof(struct tcphdr)) {
+		    && (tcph->doff << 2) != sizeof(struct tcphdr)) {
 			unsigned int i;
 
 			/* Max length: 127 "OPT (" 15*4*2chars ") " */
 			printk("OPT (");
-			for (i =sizeof(struct tcphdr); i < tcph->doff * 4; i++)
+			for (i =sizeof(struct tcphdr); i < (tcph->doff << 2); i++)
 				printk("%02X", ((u_int8_t *)tcph)[i]);
 			printk(") ");
 		}
diff -ru linux-2.4-orig/net/ipv4/netfilter/ipt_REJECT.c linux-2.4/net/ipv4/netfilter/ipt_REJECT.c
--- linux-2.4-orig/net/ipv4/netfilter/ipt_REJECT.c	Tue Sep 19 17:31:53 2000
+++ linux-2.4/net/ipv4/netfilter/ipt_REJECT.c	Wed Jan 10 16:58:37 2001
@@ -36,7 +36,7 @@
 		return;
 
 	otcph = (struct tcphdr *)((u_int32_t*)oldskb->nh.iph + oldskb->nh.iph->ihl);
-	otcplen = oldskb->len - oldskb->nh.iph->ihl*4;
+	otcplen = oldskb->len - (oldskb->nh.iph->ihl << 2);
 
 	/* No RST for RST. */
 	if (otcph->rst)
@@ -73,7 +73,7 @@
 
 	/* Truncate to length (no data) */
 	tcph->doff = sizeof(struct tcphdr)/4;
-	skb_trim(nskb, nskb->nh.iph->ihl*4 + sizeof(struct tcphdr));
+	skb_trim(nskb, (nskb->nh.iph->ihl << 2) + sizeof(struct tcphdr));
 	nskb->nh.iph->tot_len = htons(nskb->len);
 
 	if (tcph->ack) {
@@ -170,7 +170,7 @@
     	case IPT_ICMP_ECHOREPLY: {
 		struct icmphdr *icmph  = (struct icmphdr *)
 			((u_int32_t *)(*pskb)->nh.iph + (*pskb)->nh.iph->ihl);
-		unsigned int datalen = (*pskb)->len - (*pskb)->nh.iph->ihl * 4;
+		unsigned int datalen = (*pskb)->len - ((*pskb)->nh.iph->ihl << 2);
 
 		/* Not non-head frags, or truncated */
 		if (((ntohs((*pskb)->nh.iph->frag_off) & IP_OFFSET) == 0)
diff -ru linux-2.4-orig/net/ipv4/netfilter/ipt_unclean.c linux-2.4/net/ipv4/netfilter/ipt_unclean.c
--- linux-2.4-orig/net/ipv4/netfilter/ipt_unclean.c	Fri Apr 28 00:43:15 2000
+++ linux-2.4/net/ipv4/netfilter/ipt_unclean.c	Wed Jan 10 17:00:51 2001
@@ -112,7 +112,7 @@
 				limpk("ICMP error internal way too short\n");
 				return 0;
 			}
-			if (datalen - 8 < inner->ihl*4 + 8) {
+			if (datalen - 8 < (inner->ihl << 2) + 8) {
 				limpk("ICMP error internal too short\n");
 				return 0;
 			}
@@ -155,7 +155,7 @@
 		u_int32_t arg = ntohl(icmph->un.gateway);
 
 		if (icmph->code == 0) {
-			if ((arg >> 24) >= iph->ihl*4) {
+			if ((arg >> 24) >= (iph->ihl << 2)) {
 				limpk("ICMP PARAMETERPROB ptr = %u\n",
 				      ntohl(icmph->un.gateway) >> 24);
 				return 0;
@@ -292,7 +292,7 @@
 	}
 
 	/* CHECK: Smaller than actual TCP hdr. */
-	if (datalen < tcph->doff * 4) {
+	if (datalen < (tcph->doff << 2)) {
 		if (!embedded) {
 			limpk("Packet length %u < actual TCP header.\n",
 			      datalen);
@@ -339,7 +339,7 @@
 		return 0;
 	}
 
-	for (i = sizeof(struct tcphdr); i < tcph->doff * 4; ) {
+	for (i = sizeof(struct tcphdr); i < (tcph->doff << 2); ) {
 		switch (opt[i]) {
 		case 0:
 			end_of_options = 1;
@@ -356,7 +356,7 @@
 				return 0;
 			}
 			/* CHECK: options at tail. */
-			else if (i+1 >= tcph->doff * 4) {
+			else if (i+1 >= (tcph->doff << 2)) {
 				limpk("TCP option %u at tail\n",
 				      opt[i]);
 				return 0;
@@ -368,7 +368,7 @@
 				return 0;
 			}
 			/* CHECK: oversize options. */
-			else if (opt[i+1] + i >= tcph->doff * 4) {
+			else if (opt[i+1] + i >= (tcph->doff << 2)) {
 				limpk("TCP option %u at %Zu too long\n",
 				      (unsigned int) opt[i], i);
 				return 0;
@@ -393,14 +393,14 @@
 
 	/* Should only happen for local outgoing raw-socket packets. */
 	/* CHECK: length >= ip header. */
-	if (length < sizeof(struct iphdr) || length < iph->ihl * 4) {
+	if (length < sizeof(struct iphdr) || length < (iph->ihl << 2)) {
 		limpk("Packet length %Zu < IP header.\n", length);
 		return 0;
 	}
 
 	offset = ntohs(iph->frag_off) & IP_OFFSET;
-	protoh = (void *)iph + iph->ihl * 4;
-	datalen = length - iph->ihl * 4;
+	protoh = (void *)iph + (iph->ihl << 2);
+	datalen = length - (iph->ihl << 2);
 
 	/* CHECK: Embedded fragment. */
 	if (embedded && offset) {
@@ -408,7 +408,7 @@
 		return 0;
 	}
 
-	for (i = sizeof(struct iphdr); i < iph->ihl * 4; ) {
+	for (i = sizeof(struct iphdr); i < (iph->ihl << 2); ) {
 		switch (opt[i]) {
 		case 0:
 			end_of_options = 1;
@@ -425,7 +425,7 @@
 				return 0;
 			}
 			/* CHECK: options at tail. */
-			else if (i+1 >= iph->ihl * 4) {
+			else if (i+1 >= (iph->ihl << 2)) {
 				limpk("IP option %u at tail\n",
 				      opt[i]);
 				return 0;
@@ -437,7 +437,7 @@
 				return 0;
 			}
 			/* CHECK: oversize options. */
-			else if (opt[i+1] + i >= iph->ihl * 4) {
+			else if (opt[i+1] + i >= (iph->ihl << 2)) {
 				limpk("IP option %u at %u too long\n",
 				      opt[i], i);
 				return 0;
diff -ru linux-2.4-orig/net/ipv4/netfilter/iptable_filter.c linux-2.4/net/ipv4/netfilter/iptable_filter.c
--- linux-2.4-orig/net/ipv4/netfilter/iptable_filter.c	Fri May 12 20:45:26 2000
+++ linux-2.4/net/ipv4/netfilter/iptable_filter.c	Wed Jan 10 17:01:15 2001
@@ -105,7 +105,7 @@
 {
 	/* root is playing with raw sockets. */
 	if ((*pskb)->len < sizeof(struct iphdr)
-	    || (*pskb)->nh.iph->ihl * 4 < sizeof(struct iphdr)) {
+	    || ((*pskb)->nh.iph->ihl << 2) < sizeof(struct iphdr)) {
 		if (net_ratelimit())
 			printk("ipt_hook: happy cracking.\n");
 		return NF_ACCEPT;
diff -ru linux-2.4-orig/net/ipv4/netfilter/iptable_mangle.c linux-2.4/net/ipv4/netfilter/iptable_mangle.c
--- linux-2.4-orig/net/ipv4/netfilter/iptable_mangle.c	Sat Sep 16 06:37:23 2000
+++ linux-2.4/net/ipv4/netfilter/iptable_mangle.c	Wed Jan 10 17:02:25 2001
@@ -134,7 +134,7 @@
 
 	/* root is playing with raw sockets. */
 	if ((*pskb)->len < sizeof(struct iphdr)
-	    || (*pskb)->nh.iph->ihl * 4 < sizeof(struct iphdr)) {
+	    || ((*pskb)->nh.iph->ihl << 2) < sizeof(struct iphdr)) {
 		if (net_ratelimit())
 			printk("ipt_hook: happy cracking.\n");
 		return NF_ACCEPT;
diff -ru linux-2.4-orig/net/ipv4/route.c linux-2.4/net/ipv4/route.c
--- linux-2.4-orig/net/ipv4/route.c	Tue Oct 10 19:33:52 2000
+++ linux-2.4/net/ipv4/route.c	Wed Jan 10 17:19:36 2001
@@ -2247,7 +2247,7 @@
 #ifdef CONFIG_SMP
 		if (smp_num_cpus > 1 || cpu_logical_map(0) != 0) {
 			int i;
-			int cnt = length/4;
+			int cnt = length >> 2;
 
 			for (i=0; i<smp_num_cpus; i++) {
 				int cpu = cpu_logical_map(i);
diff -ru linux-2.4-orig/net/ipv4/tcp.c linux-2.4/net/ipv4/tcp.c
--- linux-2.4-orig/net/ipv4/tcp.c	Wed Nov 29 06:53:45 2000
+++ linux-2.4/net/ipv4/tcp.c	Wed Jan 10 16:43:30 2001
@@ -1534,7 +1534,7 @@
 
 		err = 0;
 		if (!(flags&MSG_TRUNC)) {
-			err = memcpy_toiovec(msg->msg_iov, ((unsigned char *)skb->h.th) + skb->h.th->doff*4 + offset, used);
+			err = memcpy_toiovec(msg->msg_iov, ((unsigned char *)skb->h.th) + (skb->h.th->doff << 2) + offset, used);
 			if (err) {
 				/* Exception. Bailout! */
 				if (!copied)
diff -ru linux-2.4-orig/net/ipv4/tcp_input.c linux-2.4/net/ipv4/tcp_input.c
--- linux-2.4-orig/net/ipv4/tcp_input.c	Fri Dec 29 23:07:24 2000
+++ linux-2.4/net/ipv4/tcp_input.c	Wed Jan 10 16:44:40 2001
@@ -1988,7 +1988,7 @@
 {
 	unsigned char *ptr;
 	struct tcphdr *th = skb->h.th;
-	int length=(th->doff*4)-sizeof(struct tcphdr);
+	int length=(th->doff << 2)-sizeof(struct tcphdr);
 
 	ptr = (unsigned char *)(th + 1);
 	tp->saw_tstamp = 0;
@@ -2829,8 +2829,8 @@
 	struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
 
 	th = skb->h.th;
-	skb_pull(skb, th->doff*4);
-	skb_trim(skb, len - (th->doff*4));
+	skb_pull(skb, th->doff << 2);
+	skb_trim(skb, len - (th->doff << 2));
 
         if (skb->len == 0 && !th->fin)
 		goto drop;
@@ -3052,7 +3052,7 @@
 
 	/* Do we wait for any urgent data? - normally not... */
 	if (tp->urg_data == TCP_URG_NOTYET) {
-		u32 ptr = tp->urg_seq - ntohl(th->seq) + (th->doff*4);
+		u32 ptr = tp->urg_seq - ntohl(th->seq) + (th->doff << 2);
 
 		/* Is the urgent pointer pointing into this packet? */	 
 		if (ptr < len) {
diff -ru linux-2.4-orig/net/ipv4/tcp_ipv4.c linux-2.4/net/ipv4/tcp_ipv4.c
--- linux-2.4-orig/net/ipv4/tcp_ipv4.c	Mon Jan  1 20:01:58 2001
+++ linux-2.4/net/ipv4/tcp_ipv4.c	Wed Jan 10 17:20:09 2001
@@ -1117,7 +1117,7 @@
 	/* Swap the send and the receive. */
 	rep.th.dest = th->source;
 	rep.th.source = th->dest; 
-	rep.th.doff = arg.iov[0].iov_len/4;
+	rep.th.doff = arg.iov[0].iov_len >> 2;
 	rep.th.seq = htonl(seq);
 	rep.th.ack_seq = htonl(ack);
 	rep.th.ack = 1;
@@ -1629,7 +1629,7 @@
 
 	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
-				    len - th->doff*4);
+				    len - (th->doff << 2));
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
 	TCP_SKB_CB(skb)->when = 0;
 	TCP_SKB_CB(skb)->flags = skb->nh.iph->tos;
diff -ru linux-2.4-orig/net/ipv6/tcp_ipv6.c linux-2.4/net/ipv6/tcp_ipv6.c
--- linux-2.4-orig/net/ipv6/tcp_ipv6.c	Mon Jan  1 20:01:58 2001
+++ linux-2.4/net/ipv6/tcp_ipv6.c	Wed Jan 10 17:35:19 2001
@@ -1558,7 +1558,7 @@
 
 	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
-				    len - th->doff*4);
+				    len - (th->doff << 2));
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
 	TCP_SKB_CB(skb)->when = 0;
 	TCP_SKB_CB(skb)->flags = ip6_get_dsfield(skb->nh.ipv6h);

--HcAYCG3uE/tztfnV--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
