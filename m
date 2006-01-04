Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbWADCXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWADCXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 21:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWADCXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 21:23:47 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:43787 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S965168AbWADCXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 21:23:46 -0500
Date: Tue, 03 Jan 2006 20:24:22 -0600 (CST)
Message-Id: <20060103.202422.50699198.yoshfuji@linux-ipv6.org>
To: dmlb2000@gmail.com, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: 2.6.15-rt1
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <9c21eeae0601031512m44c4a269ua2214528eaf90914@mail.gmail.com>
References: <20060103094720.GA16497@elte.hu>
	<9c21eeae0601031512m44c4a269ua2214528eaf90914@mail.gmail.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <9c21eeae0601031512m44c4a269ua2214528eaf90914@mail.gmail.com> (at Tue, 3 Jan 2006 15:12:50 -0800), David Brown <dmlb2000@gmail.com> says:

>   CC [M]  net/ipv6/icmp.o
>   CC [M]  net/ipv6/mcast.o
> net/ipv6/mcast.c: In function `ipv6_sock_mc_join':
> net/ipv6/mcast.c:227: error: `RW_LOCK_UNLOCKED' undeclared (first use
> in this function)
> net/ipv6/mcast.c:227: error: (Each undeclared identifier is reported only once
> net/ipv6/mcast.c:227: error: for each function it appears in.)
> make[2]: *** [net/ipv6/mcast.o] Error 1
> make[1]: *** [net/ipv6] Error 2
> make: *** [net] Error 2

This patch should fix compilation issues in net/ipv6 subsystem
w/ rt patch.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index f829a4a..15264f4 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -224,7 +224,7 @@ int ipv6_sock_mc_join(struct sock *sk, i
 
 	mc_lst->ifindex = dev->ifindex;
 	mc_lst->sfmode = MCAST_EXCLUDE;
-	mc_lst->sflock = RW_LOCK_UNLOCKED;
+	mc_lst->sflock = RW_LOCK_UNLOCKED(mc_lst->sflock);
 	mc_lst->sflist = NULL;
 
 	/*
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index c2c52af..bfd7a2b 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -98,7 +98,7 @@ struct nf_ct_frag6_queue
 #define FRAG6Q_HASHSZ	64
 
 static struct nf_ct_frag6_queue *nf_ct_frag6_hash[FRAG6Q_HASHSZ];
-static rwlock_t nf_ct_frag6_lock = RW_LOCK_UNLOCKED;
+static rwlock_t nf_ct_frag6_lock = RW_LOCK_UNLOCKED(nf_ct_frag6_lock);
 static u32 nf_ct_frag6_hash_rnd;
 static LIST_HEAD(nf_ct_frag6_lru_list);
 int nf_ct_frag6_nqueues = 0;
@@ -371,7 +371,7 @@ nf_ct_frag6_create(unsigned int hash, u3
 	init_timer(&fq->timer);
 	fq->timer.function = nf_ct_frag6_expire;
 	fq->timer.data = (long) fq;
-	fq->lock = SPIN_LOCK_UNLOCKED;
+	fq->lock = SPIN_LOCK_UNLOCKED(fq->lock);
 	atomic_set(&fq->refcnt, 1);
 
 	return nf_ct_frag6_intern(hash, fq);

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
