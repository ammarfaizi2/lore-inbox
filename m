Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUJZDoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUJZDoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUJZBqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:46:32 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8918 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262024AbUJZBVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:21:25 -0400
Date: Mon, 25 Oct 2004 16:11:24 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [NET]: TSO requires SG, enforce this at device registry.
Message-Id: <20041025161124.52a04212.davem@davemloft.net>
In-Reply-To: <417C9D08.6030903@pobox.com>
References: <200410221715.i9MHFlIu021927@hera.kernel.org>
	<417C9431.6030505@pobox.com>
	<20041024225700.4a22a968.davem@davemloft.net>
	<417C9D08.6030903@pobox.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004 02:28:24 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> David S. Miller wrote:
> > I made a followon posting proposing ethtool changes which
> > would enforce the rules there too, did you see it?
> 
> 
> Sorry, I didn't see it.  URL or grep string?

It was to linux-net, here is a replay.

Date: Wed, 20 Oct 2004 16:35:10 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: thomas.spatzier@de.ibm.com, linux-net@vger.kernel.org
Subject: Re: [PATCH] select appropriate skb size in tcp_sendmsg when TSO is
 used
Message-Id: <20041020163510.6d13e9c7.davem@davemloft.net>
In-Reply-To: <E1CKE5P-0005SP-00@gondolin.me.apana.org.au>
References: <OF96546AB5.ACE12043-ONC1256F33.0027BC6B-C1256F33.002D4A6E@de.ibm.com>
	<E1CKE5P-0005SP-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Oct 2004 20:52:55 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> This is bogus.  The subsequent if clause is what allows the size to
> exceed mss_cache_std.
> 
> TSO without NETIF_F_SG is not worth it.

Indeed.  I'm going to enforce this at device registration time
as in the patch at the end of this email.

BTW, we allow mucking of all of these SG, TSO, CSUM settings
via ethtool yet the "X needs Y" rules are not enforced.  I
can't think of an easy way to do this without touching a lot
of drivers.  Perhaps something like:

int ethtool_feature_change(struct net_device *dev, u32 flag_bit, int on_off);

So drivers/net/tg3.c:tg3_set_tx() might then look like this:

static int tg3_set_tx_csum(struct net_device *dev, u32 data)
{
	struct tg3 *tp = netdev_priv(dev);
	int err;

	if (tp->tg3_flags & TG3_FLAG_BROKEN_CHECKSUMS) {
		if (data != 0)
			return -EINVAL;
		return 0;
	}

	else
		dev->features &= ~NETIF_F_IP_CSUM;

	return ethtool_feature_change(dev, NETIF_F_IP_CSUM, data);
}

And ethtool_feature_change() might be implemented like so:

int ethtool_feature_change(struct net_device *dev, u32 flag_bit, int on_off)
{
	/* If checksumming is being disabled, both SG and
	 * TSO must be disabled as well.
	 */
	if (!on_off &&
	    (flag_bit & (NETIF_F_IP_CSUM |
			 NETIF_F_HW_CSUM |
			 NETIF_F_NO_CSUM))) {
		dev->features &= ~(NETIF_F_SG | NETIF_F_TSO);
	}

	/* If SG is being disabled, TSO must be disabled
	 * as well.
	 */
	if (!on_off && (flag_bit & NETIF_F_SG))
		dev->features &= ~NETIF_F_TSO;

	/* TSO requires SG */
	if (on_off &&
	    (flag_bit & NETIF_F_TSO) &&
	    !(dev->features & NETIF_F_SG))
		return -EINVAL;

	/* SG requires CSUM */
	if (on_off &&
	    (flag_bit & NETIF_F_SG) &&
	    !(dev->features & (NETIF_F_IP_CSUM |
			       NETIF_F_HW_CSUM |
			       NETIF_F_NO_CSUM)))
		return -EINVAL;

	if (on_off)
		dev->features |= flag_bit;
	else
		dev->features &= ~flag_bit;

	return 0;
}

And then we add usage of this thing to the various drivers
and the generic implementation of the appropriate ethtool
ops in net/core/ethtool.c

It just occured to me that instead of manually clearing
dev->feature bits we should invoke the appropriate ethtool
op to accomplish that just in case the device needs to do
something implementation specific when disabling said features.
This implies that ethtool_feature_change() should be invoked
without any device locks set to prevent deadlocks.

Comments?

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/20 16:16:33-07:00 davem@nuts.davemloft.net 
#   [NET]: TSO requires SG, enforce this at device registry.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/core/dev.c
#   2004/10/20 16:16:03-07:00 davem@nuts.davemloft.net +8 -0
#   [NET]: TSO requires SG, enforce this at device registry.
# 
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	2004-10-20 16:16:47 -07:00
+++ b/net/core/dev.c	2004-10-20 16:16:47 -07:00
@@ -2871,6 +2871,14 @@
 		dev->features &= ~NETIF_F_SG;
 	}
 
+	/* TSO requires that SG is present as well. */
+	if ((dev->features & NETIF_F_TSO) &&
+	    !(dev->features & NETIF_F_SG)) {
+		printk("%s: Dropping NETIF_F_TSO since no SG feature.\n",
+		       dev->name);
+		dev->features &= ~NETIF_F_TSO;
+	}
+
 	/*
 	 *	nil rebuild_header routine,
 	 *	that should be never called and used as just bug trap.
