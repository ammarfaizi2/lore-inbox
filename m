Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUHALRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUHALRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUHALRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:17:02 -0400
Received: from mail.dif.dk ([193.138.115.101]:24505 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265800AbUHALQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:16:50 -0400
Date: Sun, 1 Aug 2004 13:21:22 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: jgarzik@pobox.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.6 patch] net/hamachi.c: remove bogus inline at function
 prototype (fwd)
In-Reply-To: <20040729140535.GU2349@fs.tum.de>
Message-ID: <Pine.LNX.4.60.0408011314480.2535@dragon.hygekrogen.localhost>
References: <20040729140535.GU2349@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Adrian Bunk wrote:

> 
> FYI:
> The patch forwarded below is still required in 2.6.8-rc2-mm1.
> 
> 
> ----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----
> 
> Date:	Wed, 14 Jul 2004 23:52:56 +0200
> From: Adrian Bunk <bunk@fs.tum.de>
> To: jgarzik@pobox.com
> Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
> Subject: [2.6 patch] net/hamachi.c: remove bogus inline at function prototype
> 
> Trying to compile drivers/net/hamachi.c in 2.6.8-rc1-mm1 using gcc 3.4 
> results in the folloeing compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/net/hamachi.o
> drivers/net/hamachi.c: In function `hamachi_interrupt':
> drivers/net/hamachi.c:562: sorry, unimplemented: inlining failed in call 
> to 'hamachi_rx': function body not available
> drivers/net/hamachi.c:1402: sorry, unimplemented: called from here
> make[2]: *** [drivers/net/hamachi.o] Error 1
> 
> <--  snip  -->
> 
> 
> The inline at the prototype is bogus since the function itself is not 
> marked as inline.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> 
> --- linux-2.6.7-mm6-full-gcc3.4/drivers/net/hamachi.c.old	2004-07-09 00:28:31.000000000 +0200
> +++ linux-2.6.7-mm6-full-gcc3.4/drivers/net/hamachi.c	2004-07-09 00:30:18.000000000 +0200
> @@ -559,7 +559,7 @@
>  static void hamachi_init_ring(struct net_device *dev);
>  static int hamachi_start_xmit(struct sk_buff *skb, struct net_device *dev);
>  static irqreturn_t hamachi_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
> -static inline int hamachi_rx(struct net_device *dev);
> +static int hamachi_rx(struct net_device *dev);
>  static inline int hamachi_tx(struct net_device *dev);
>  static void hamachi_error(struct net_device *dev, int intr_status);
>  static int hamachi_close(struct net_device *dev);
> 

Wouldn't it make sense to also un-inline hamachi_tx? both the _rx and _tx 
functions are quite big - are they really suitable to be inlined?

Here's a proposed patch against 2.6.8-rc2-mm1

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.8-rc2-mm1-orig/drivers/net/hamachi.c linux-2.6.8-rc2-mm1/drivers/net/hamachi.c
--- linux-2.6.8-rc2-mm1-orig/drivers/net/hamachi.c	2004-07-31 13:12:52.000000000 +0200
+++ linux-2.6.8-rc2-mm1/drivers/net/hamachi.c	2004-08-01 13:18:43.000000000 +0200
@@ -559,8 +559,8 @@ static void hamachi_tx_timeout(struct ne
 static void hamachi_init_ring(struct net_device *dev);
 static int hamachi_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t hamachi_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
-static inline int hamachi_rx(struct net_device *dev);
-static inline int hamachi_tx(struct net_device *dev);
+static int hamachi_rx(struct net_device *dev);
+static int hamachi_tx(struct net_device *dev);
 static void hamachi_error(struct net_device *dev, int intr_status);
 static int hamachi_close(struct net_device *dev);
 static struct net_device_stats *hamachi_get_stats(struct net_device *dev);
@@ -998,7 +998,7 @@ static int hamachi_open(struct net_devic
 	return 0;
 }
 
-static inline int hamachi_tx(struct net_device *dev)
+static int hamachi_tx(struct net_device *dev)
 {
 	struct hamachi_private *hmp = dev->priv;
 


/Jesper Juhl

