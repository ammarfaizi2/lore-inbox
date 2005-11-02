Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbVKBOW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbVKBOW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVKBOWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:22:25 -0500
Received: from send.forptr.21cn.com ([202.105.45.47]:56982 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S932715AbVKBOWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:22:24 -0500
Message-ID: <4368CBE6.9040702@21cn.com>
Date: Wed, 02 Nov 2005 22:23:34 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATCH][MCAST]Two fix for implementation of MLDv2 .
References: <436878E7.3030303@21cn.com> <7e77d27c0511020538o4b1f3244l@mail.gmail.com>
In-Reply-To: <7e77d27c0511020538o4b1f3244l@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------060801000904070801040105"
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: 7jF7T7OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060801000904070801040105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Here is my another patch. It makes a node send state change report properly when a multicast address's soure filter mode change is cause by forwarding state change and etc.

Regards.

Signed-off-by: Yan Zheng <yanzheng@21cn.com>

Index:net/ipv6/mcast.c
===========================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-10-30 23:09:33.000000000 +0800
+++ /tmp/ipv6/mcast.c	2005-11-02 22:04:32.000000000 +0800
@@ -128,7 +128,8 @@ static DEFINE_RWLOCK(ipv6_sk_mc_lock);
 
 static struct socket *igmp6_socket;
 
-int __ipv6_dev_mc_dec(struct inet6_dev *idev, struct in6_addr *addr);
+static int ipv6_dev_mc_dec_intern(struct inet6_dev *idev, 
+			struct in6_addr *addr, int delta);
 
 static void igmp6_join_group(struct ifmcaddr6 *ma);
 static void igmp6_leave_group(struct ifmcaddr6 *ma);
@@ -270,7 +271,7 @@ int ipv6_sock_mc_drop(struct sock *sk, i
 
 				if (idev) {
 					(void) ip6_mc_leave_src(sk,mc_lst,idev);
-					__ipv6_dev_mc_dec(idev, &mc_lst->addr);
+					ipv6_dev_mc_dec_intern(idev,&mc_lst->addr,1);
 					in6_dev_put(idev);
 				}
 				dev_put(dev);
@@ -336,7 +337,7 @@ void ipv6_sock_mc_close(struct sock *sk)
 
 			if (idev) {
 				(void) ip6_mc_leave_src(sk, mc_lst, idev);
-				__ipv6_dev_mc_dec(idev, &mc_lst->addr);
+				ipv6_dev_mc_dec_intern(idev, &mc_lst->addr, 1);
 				in6_dev_put(idev);
 			}
 			dev_put(dev);
@@ -907,10 +908,9 @@ int ipv6_dev_mc_inc(struct net_device *d
 	return 0;
 }
 
-/*
- *	device multicast group del
- */
-int __ipv6_dev_mc_dec(struct inet6_dev *idev, struct in6_addr *addr)
+
+static int ipv6_dev_mc_dec_intern(struct inet6_dev *idev, 
+			struct in6_addr *addr, int delta)
 {
 	struct ifmcaddr6 *ma, **map;
 
@@ -920,20 +920,27 @@ int __ipv6_dev_mc_dec(struct inet6_dev *
 			if (--ma->mca_users == 0) {
 				*map = ma->next;
 				write_unlock_bh(&idev->lock);
-
 				igmp6_group_dropped(ma);
-
 				ma_put(ma);
 				return 0;
 			}
 			write_unlock_bh(&idev->lock);
+			if (!delta && ip6_mc_del_src(idev, addr, 
+					MCAST_EXCLUDE, 0, NULL, 0))
+				return -EINVAL; // bug 	
 			return 0;
 		}
 	}
 	write_unlock_bh(&idev->lock);
-
 	return -ENOENT;
 }
+/*
+ *	device multicast group del
+ */
+int __ipv6_dev_mc_dec(struct inet6_dev *idev, struct in6_addr *addr)
+{
+	return ipv6_dev_mc_dec_intern(idev, addr, 0);
+}
 
 int ipv6_dev_mc_dec(struct net_device *dev, struct in6_addr *addr)
 {

--------------060801000904070801040105
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- linux-2.6.14/net/ipv6/mcast.c	2005-10-30 23:09:33.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-11-02 21:25:27.000000000 +0800
@@ -128,7 +128,8 @@ static DEFINE_RWLOCK(ipv6_sk_mc_lock);
 
 static struct socket *igmp6_socket;
 
-int __ipv6_dev_mc_dec(struct inet6_dev *idev, struct in6_addr *addr);
+static int ipv6_dev_mc_dec_intern(struct inet6_dev *idev, 
+			struct in6_addr *addr, int delta);
 
 static void igmp6_join_group(struct ifmcaddr6 *ma);
 static void igmp6_leave_group(struct ifmcaddr6 *ma);
@@ -164,7 +165,7 @@ static int ip6_mc_leave_src(struct sock 
 #define MLDV2_MASK(value, nb) ((nb)>=32 ? (value) : ((1<<(nb))-1) & (value))
 #define MLDV2_EXP(thresh, nbmant, nbexp, value) \
 	((value) < (thresh) ? (value) : \
-	((MLDV2_MASK(value, nbmant) | (1<<(nbmant+nbexp))) << \
+	((MLDV2_MASK(value, nbmant) | (1<<(nbmant))) << \
 	(MLDV2_MASK((value) >> (nbmant), nbexp) + (nbexp))))
 
 #define MLDV2_QQIC(value) MLDV2_EXP(0x80, 4, 3, value)
@@ -270,7 +271,7 @@ int ipv6_sock_mc_drop(struct sock *sk, i
 
 				if (idev) {
 					(void) ip6_mc_leave_src(sk,mc_lst,idev);
-					__ipv6_dev_mc_dec(idev, &mc_lst->addr);
+					ipv6_dev_mc_dec_intern(idev,&mc_lst->addr,1);
 					in6_dev_put(idev);
 				}
 				dev_put(dev);
@@ -336,7 +337,7 @@ void ipv6_sock_mc_close(struct sock *sk)
 
 			if (idev) {
 				(void) ip6_mc_leave_src(sk, mc_lst, idev);
-				__ipv6_dev_mc_dec(idev, &mc_lst->addr);
+				ipv6_dev_mc_dec_intern(idev, &mc_lst->addr, 1);
 				in6_dev_put(idev);
 			}
 			dev_put(dev);
@@ -545,8 +546,10 @@ int ip6_mc_msfilter(struct sock *sk, str
 			sock_kfree_s(sk, newpsl, IP6_SFLSIZE(newpsl->sl_max));
 			goto done;
 		}
-	} else
+	} else {
 		newpsl = NULL;
+		(void) ip6_mc_add_src(idev, group, gsf->gf_fmode, 0, NULL, 0);
+	}
 	psl = pmc->sflist;
 	if (psl) {
 		(void) ip6_mc_del_src(idev, group, pmc->sfmode,
@@ -907,10 +910,8 @@ int ipv6_dev_mc_inc(struct net_device *d
 	return 0;
 }
 
-/*
- *	device multicast group del
- */
-int __ipv6_dev_mc_dec(struct inet6_dev *idev, struct in6_addr *addr)
+static int ipv6_dev_mc_dec_intern(struct inet6_dev *idev, 
+			struct in6_addr *addr, int delta)
 {
 	struct ifmcaddr6 *ma, **map;
 
@@ -920,20 +921,27 @@ int __ipv6_dev_mc_dec(struct inet6_dev *
 			if (--ma->mca_users == 0) {
 				*map = ma->next;
 				write_unlock_bh(&idev->lock);
-
 				igmp6_group_dropped(ma);
-
 				ma_put(ma);
 				return 0;
 			}
 			write_unlock_bh(&idev->lock);
+			if (!delta && ip6_mc_del_src(idev, addr, 
+					MCAST_EXCLUDE, 0, NULL, 0))
+			       return -EINVAL; // bug 	
 			return 0;
 		}
 	}
 	write_unlock_bh(&idev->lock);
-
 	return -ENOENT;
 }
+/*
+ *	device multicast group del
+ */
+int __ipv6_dev_mc_dec(struct inet6_dev *idev, struct in6_addr *addr)
+{
+	return ipv6_dev_mc_dec_intern(idev, addr, 0);
+}
 
 int ipv6_dev_mc_dec(struct net_device *dev, struct in6_addr *addr)
 {
@@ -1087,7 +1095,7 @@ static void mld_marksources(struct ifmca
 
 int igmp6_event_query(struct sk_buff *skb)
 {
-	struct mld2_query *mlh2 = (struct mld2_query *) skb->h.raw;
+	struct mld2_query *mlh2 = NULL;
 	struct ifmcaddr6 *ma;
 	struct in6_addr *group;
 	unsigned long max_delay;
@@ -1140,6 +1148,21 @@ int igmp6_event_query(struct sk_buff *sk
 		/* clear deleted report items */
 		mld_clear_delrec(idev);
 	} else if (len >= 28) {
+		int srcs_offset = sizeof(struct mld2_query) -
+			sizeof(struct icmp6hdr);
+		if (!pskb_may_pull(skb, srcs_offset)) {
+			in6_dev_put(idev);
+			return -EINVAL;
+		}
+		mlh2 = (struct mld2_query *) skb->h.raw;
+		if (mlh2->nsrcs != 0) {
+			if (!pskb_may_pull(skb, srcs_offset +
+				mlh2->nsrcs * sizeof(struct in6_addr))) {
+				in6_dev_put(idev);
+				return -EINVAL;
+			}
+			mlh2 = (struct mld2_query *) skb->h.raw;
+		}
 		max_delay = (MLDV2_MRC(ntohs(mlh2->mrc))*HZ)/1000;
 		if (!max_delay)
 			max_delay = 1;
@@ -1256,10 +1279,13 @@ static int is_in(struct ifmcaddr6 *pmc, 
 {
 	switch (type) {
 	case MLD2_MODE_IS_INCLUDE:
-	case MLD2_MODE_IS_EXCLUDE:
 		if (gdeleted || sdeleted)
 			return 0;
 		return !((pmc->mca_flags & MAF_GSQUERY) && !psf->sf_gsresp);
+	case MLD2_MODE_IS_EXCLUDE:
+		if (gdeleted || sdeleted)
+			return 0;
+		return 1;
 	case MLD2_CHANGE_TO_INCLUDE:
 		if (gdeleted || sdeleted)
 			return 0;
@@ -1428,13 +1454,15 @@ static struct sk_buff *add_grec(struct s
 	struct mld2_report *pmr;
 	struct mld2_grec *pgr = NULL;
 	struct ip6_sf_list *psf, *psf_next, *psf_prev, **psf_list;
-	int scount, first, isquery, truncate;
+	int scount, first, isquery, ischange, truncate;
 
 	if (pmc->mca_flags & MAF_NOREPORT)
 		return skb;
 
 	isquery = type == MLD2_MODE_IS_INCLUDE ||
 		  type == MLD2_MODE_IS_EXCLUDE;
+	ischange = type == MLD2_CHANGE_TO_INCLUDE ||
+		   type == MLD2_CHANGE_TO_EXCLUDE; 
 	truncate = type == MLD2_MODE_IS_EXCLUDE ||
 		    type == MLD2_CHANGE_TO_EXCLUDE;
 
@@ -1444,7 +1472,7 @@ static struct sk_buff *add_grec(struct s
 		if (type == MLD2_ALLOW_NEW_SOURCES ||
 		    type == MLD2_BLOCK_OLD_SOURCES)
 			return skb;
-		if (pmc->mca_crcount || isquery) {
+		if (ischange || isquery) {
 			/* make sure we have room for group header and at
 			 * least one source.
 			 */
@@ -1460,9 +1488,12 @@ static struct sk_buff *add_grec(struct s
 	pmr = skb ? (struct mld2_report *)skb->h.raw : NULL;
 
 	/* EX and TO_EX get a fresh packet, if needed */
-	if (truncate) {
-		if (pmr && pmr->ngrec &&
-		    AVAILABLE(skb) < grec_size(pmc, type, gdeleted, sdeleted)) {
+	if (truncate || ischange) {
+		int min_len;
+		min_len	= truncate ? grec_size(pmc, type, gdeleted, sdeleted) : 
+			  (sizeof(struct mld2_grec) + sizeof(struct in6_addr));
+		if (((pmr && pmr->ngrec) || ischange) &&
+		    AVAILABLE(skb) < min_len) {
 			if (skb)
 				mld_sendpack(skb);
 			skb = mld_newpack(dev, dev->mtu);
@@ -1471,6 +1502,10 @@ static struct sk_buff *add_grec(struct s
 	first = 1;
 	scount = 0;
 	psf_prev = NULL;
+	if (ischange) {
+		skb = add_grhead(skb, pmc, type, &pgr);
+		first = 0;
+	}
 	for (psf=*psf_list; psf; psf=psf_next) {
 		struct in6_addr *psrc;
 

--------------060801000904070801040105--
