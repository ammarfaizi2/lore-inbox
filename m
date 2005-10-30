Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVJ3Pmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVJ3Pmg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVJ3Pmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:42:36 -0500
Received: from send.forptr.21cn.com ([202.105.45.48]:21226 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1751012AbVJ3Pmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:42:35 -0500
Message-ID: <4364EA58.7040707@21cn.com>
Date: Sun, 30 Oct 2005 23:44:24 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][MCAST]IPv6: doubt about ipv6_sk_mc_lock usage.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: qdbWP6OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I think ipv6_sk_mc_lock should protest both ipv6_mc_list and it's sflist. because they can are used by 
inet6_mc_check(...) in softirq and be modified by ip6_mc_source(...) or ip6_mc_msfilter(...) simultaneity.
I also remove read_lock when traverse ipv6_mc_list, because it's protected by lock_sock(sk).

Regards

Signed-off-by: Yan Zheng <yanzheng@21cn.com>

Index: net/ipv6/mcast.c
====================================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-10-30 23:09:33.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-10-30 23:00:24.000000000 +0800
@@ -188,15 +188,12 @@ int ipv6_sock_mc_join(struct sock *sk, i
 	if (!ipv6_addr_is_multicast(addr))
 		return -EINVAL;
 
-	read_lock_bh(&ipv6_sk_mc_lock);
 	for (mc_lst=np->ipv6_mc_list; mc_lst; mc_lst=mc_lst->next) {
 		if ((ifindex == 0 || mc_lst->ifindex == ifindex) &&
 		    ipv6_addr_equal(&mc_lst->addr, addr)) {
-			read_unlock_bh(&ipv6_sk_mc_lock);
 			return -EADDRINUSE;
 		}
 	}
-	read_unlock_bh(&ipv6_sk_mc_lock);
 
 	mc_lst = sock_kmalloc(sk, sizeof(struct ipv6_mc_socklist), GFP_KERNEL);
 
@@ -379,7 +376,6 @@ int ip6_mc_source(int add, int omode, st
 
 	err = -EADDRNOTAVAIL;
 
-	read_lock_bh(&ipv6_sk_mc_lock);
 	for (pmc=inet6->ipv6_mc_list; pmc; pmc=pmc->next) {
 		if (pgsr->gsr_interface && pmc->ifindex != pgsr->gsr_interface)
 			continue;
@@ -400,7 +396,7 @@ int ip6_mc_source(int add, int omode, st
 		/* allow mode switches for empty-set filters */
 		ip6_mc_add_src(idev, group, omode, 0, NULL, 0);
 		ip6_mc_del_src(idev, group, pmc->sfmode, 0, NULL, 0);
-		pmc->sfmode = omode;
+		pmc->sfmode = omode; //need a write lock ?
 	}
 
 	psl = pmc->sflist;
@@ -425,10 +421,12 @@ int ip6_mc_source(int add, int omode, st
 
 		/* update the interface filter */
 		ip6_mc_del_src(idev, group, omode, 1, source, 1);
-
+		
+		write_lock_bh(&ipv6_sk_mc_lock);
 		for (j=i+1; j<psl->sl_count; j++)
 			psl->sl_addr[j-1] = psl->sl_addr[j];
 		psl->sl_count--;
+		write_unlock_bh(&ipv6_sk_mc_lock);
 		err = 0;
 		goto done;
 	}
@@ -455,9 +453,12 @@ int ip6_mc_source(int add, int omode, st
 		if (psl) {
 			for (i=0; i<psl->sl_count; i++)
 				newpsl->sl_addr[i] = psl->sl_addr[i];
-			sock_kfree_s(sk, psl, IP6_SFLSIZE(psl->sl_max));
 		}
+		write_lock_bh(&ipv6_sk_mc_lock);
+		if (psl) 
+			sock_kfree_s(sk, psl, IP6_SFLSIZE(psl->sl_max));
 		pmc->sflist = psl = newpsl;
+		write_unlock_bh(&ipv6_sk_mc_lock);
 	}
 	rv = 1;	/* > 0 for insert logic below if sl_count is 0 */
 	for (i=0; i<psl->sl_count; i++) {
@@ -467,15 +468,16 @@ int ip6_mc_source(int add, int omode, st
 	}
 	if (rv == 0)		/* address already there is an error */
 		goto done;
+	write_lock_bh(&ipv6_sk_mc_lock);
 	for (j=psl->sl_count-1; j>=i; j--)
 		psl->sl_addr[j+1] = psl->sl_addr[j];
 	psl->sl_addr[i] = *source;
 	psl->sl_count++;
+	write_unlock_bh(&ipv6_sk_mc_lock);
 	err = 0;
 	/* update the interface list */
 	ip6_mc_add_src(idev, group, omode, 1, source, 1);
 done:
-	read_unlock_bh(&ipv6_sk_mc_lock);
 	read_unlock_bh(&idev->lock);
 	in6_dev_put(idev);
 	dev_put(dev);
@@ -548,14 +550,17 @@ int ip6_mc_msfilter(struct sock *sk, str
 	} else
 		newpsl = NULL;
 	psl = pmc->sflist;
-	if (psl) {
+	if (psl) 
 		(void) ip6_mc_del_src(idev, group, pmc->sfmode,
 			psl->sl_count, psl->sl_addr, 0);
-		sock_kfree_s(sk, psl, IP6_SFLSIZE(psl->sl_max));
-	} else
+	else
 		(void) ip6_mc_del_src(idev, group, pmc->sfmode, 0, NULL, 0);
+	write_lock_bh(&ipv6_sk_mc_lock);
+	if (psl) 
+		sock_kfree_s(sk, psl, IP6_SFLSIZE(psl->sl_max));
 	pmc->sflist = newpsl;
 	pmc->sfmode = gsf->gf_fmode;
+	write_unlock_bh(&ipv6_sk_mc_lock);
 	err = 0;
 done:
 	read_unlock_bh(&idev->lock);
