Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWGSPbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWGSPbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWGSPbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:31:14 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:26635 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030182AbWGSPbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:31:13 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net, ruben@puettmann.net (Ruben Puettmann)
Subject: Re: 2.6.18-rc2 tg3  Dead loop on netdevice eth0 fix it urgently!
Cc: sergio@sergiomb.no-ip.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Organization: Core
In-Reply-To: <20060719110439.GJ23431@puettmann.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G3E0V-0006e2-00@gondolin.me.apana.org.au>
Date: Thu, 20 Jul 2006 01:30:39 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Puettmann <ruben@puettmann.net> wrote:
>
> Yes But in the moment I thing  I have not enough informations.

Oops, it was a thinko on my part.

[NET]: Fix reversed error test in netif_tx_trylock

A non-zero return value indicates success from spin_trylock,
not error.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 76cc099..75f02d8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -924,10 +924,10 @@ static inline void netif_tx_lock_bh(stru
 
 static inline int netif_tx_trylock(struct net_device *dev)
 {
-	int err = spin_trylock(&dev->_xmit_lock);
-	if (!err)
+	int ok = spin_trylock(&dev->_xmit_lock);
+	if (likely(ok))
 		dev->xmit_lock_owner = smp_processor_id();
-	return err;
+	return ok;
 }
 
 static inline void netif_tx_unlock(struct net_device *dev)
