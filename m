Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUGaVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUGaVOq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUGaVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:14:46 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55047 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264261AbUGaVOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:14:25 -0400
Date: Sat, 31 Jul 2004 23:06:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, greearb@candelatech.com,
       akpm@osdl.org, alan@redhat.com, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org
Subject: PATCH-2.4: MTU fix for tulip driver
Message-ID: <20040731210621.GB28074@alpha.home.local>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <410BC32F.7050107@pobox.com> <20040731161234.GA27388@alpha.home.local> <410BC81D.3010105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410BC81D.3010105@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 12:26:05PM -0400, Jeff Garzik wrote:
 
> Using MODULE_PARM to select max MTU limit was always the wrong thing to 
> do.  The user generally has no idea of the hardware limits involve.

That's right but sometimes useful, especially when there's no other choice :-)
I've used with it a lot when playing with jumbo frames on dl2k.

> Patches to remove these incorrect module parameters are welcome.

OK, here are two patches :
  - the first one, against 2.4.27-rc4, removes the unused static mtu
  - the second one, which has to be applied on top of the previous one,
    implements the change_mtu() function.

I've tried it, and indeed my firewall currently runs on it.

For the higher bound, I looked at Donald Becker's driver, and noticed that
he considers 18 bytes between dev->mtu and PKT_BUF_SZ. So I set the limit
to (PKT_BUF_SZ - 18). BTW, at first, I used netif_running() to prevent
MTU changes when the device was up, but since the code never uses it
anywhere, I simply removed this annoying constraint.

Now I could successfully change the MTU on my firewall up to 1518 and SEND
frames normally (1532 bytes frames).

The problem is with incoming frames larger than 1514 bytes. They get
accounted as errors. Matti talked about a 'TL' bit which should be ignored,
but I couldn't find anything related to it. Even the way the rx_missed_errors
are increased is magics to me.

That's exactly the part I didn't want to get into, since I don't know
how the driver nor the hardware works.

I past the 2 trivial patches here anyway, hoping that someone else knows
how to unlock the receive limit.

Regards,
Willy

#### patch 1 : remove the unused mtu[] array

--- ./drivers/net/tulip/tulip_core.c~	Sat Jul 31 18:45:59 2004
+++ ./drivers/net/tulip/tulip_core.c	Sat Jul 31 18:47:50 2004
@@ -48,7 +48,6 @@
 /* Used to pass the full-duplex flag, etc. */
 static int full_duplex[MAX_UNITS];
 static int options[MAX_UNITS];
-static int mtu[MAX_UNITS];			/* Jumbo MTU for interfaces. */
 
 /*  The possible media types that can be set in options[] are: */
 const char * const medianame[32] = {
@@ -1671,8 +1670,6 @@
 			tp->default_port = options[board_idx] & MEDIA_MASK;
 		if ((options[board_idx] & FullDuplex) || full_duplex[board_idx] > 0)
 			tp->full_duplex = 1;
-		if (mtu[board_idx] > 0)
-			dev->mtu = mtu[board_idx];
 	}
 	if (dev->mem_start & MEDIA_MASK)
 		tp->default_port = dev->mem_start & MEDIA_MASK;


#### patch 2 : implement change_mtu()

--- linux-2.4.27-rc4-tulip-no-mtu/drivers/net/tulip/tulip.h	Mon May 10 01:11:16 2004
+++ linux-2.4.27-rc4-tulip-mtu/drivers/net/tulip/tulip.h	Sat Jul 31 18:56:21 2004
@@ -267,6 +267,8 @@
 #define MEDIA_MASK     31
 
 #define PKT_BUF_SZ		1536	/* Size of each temporary Rx buffer. */
+#define TULIP_MTU_MIN		68
+#define TULIP_MTU_MAX		(PKT_BUF_SZ - 18) /* from D.Becker's tulip.c */
 
 #define TULIP_MIN_CACHE_LINE	8	/* in units of 32-bit words */
 
diff -urN linux-2.4.27-rc4-tulip-no-mtu/drivers/net/tulip/tulip_core.c linux-2.4.27-rc4-tulip-mtu/drivers/net/tulip/tulip_core.c
--- linux-2.4.27-rc4-tulip-no-mtu/drivers/net/tulip/tulip_core.c	Sat Jul 31 18:58:54 2004
+++ linux-2.4.27-rc4-tulip-mtu/drivers/net/tulip/tulip_core.c	Sat Jul 31 18:56:31 2004
@@ -266,8 +266,16 @@
 static struct net_device_stats *tulip_get_stats(struct net_device *dev);
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void set_rx_mode(struct net_device *dev);
+static int change_mtu(struct net_device *dev, int new_mtu);
 
 
+static int change_mtu(struct net_device *dev, int new_mtu)
+{
+	if ((new_mtu < TULIP_MTU_MIN) || (new_mtu > TULIP_MTU_MAX))
+		return -EINVAL;
+	dev->mtu = new_mtu;
+	return 0;
+}
 
 static void tulip_set_power_state (struct tulip_private *tp,
 				   int sleep, int snooze)
@@ -1726,6 +1734,7 @@
 	dev->get_stats = tulip_get_stats;
 	dev->do_ioctl = private_ioctl;
 	dev->set_multicast_list = set_rx_mode;
+	dev->change_mtu = &change_mtu;
 
 	if (register_netdev(dev))
 		goto err_out_free_ring;


