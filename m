Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbULDRe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbULDRe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 12:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbULDRe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 12:34:27 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:31712 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262560AbULDReU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 12:34:20 -0500
Date: Sat, 4 Dec 2004 18:33:27 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Nicholas Papadakos <panic@quake.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtek r8169 + kernel 2.4.24 (openmosix)
Message-ID: <20041204173327.GA4026@electric-eye.fr.zoreil.com>
References: <20041204002657.GA26399@electric-eye.fr.zoreil.com> <200412041642.iB4Ggxio006440@aiolos.otenet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412041642.iB4Ggxio006440@aiolos.otenet.gr>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Papadakos <panic@quake.gr> :
[...]
> I copied the latest r8169.c file from kernel 2.4.28 but it didn't compile at
> all giving an error message:
> 
> r8169.c: In function `rtl8169_init_board':
> r8169.c:683: warning: implicit declaration of function `SET_NETDEV_DEV'

Don't bother: comment out this line.

> r8169.c:683: error: structure has no member named `dev'
> r8169.c: In function `rtl8169_make_unusable_by_asic':
> r8169.c:1164: warning: integer constant is too large for "long" type
> make[2]: *** [r8169.o] Error 1

Please apply:

--- drivers/net/r8169.c	2004-12-04 18:22:18.000000000 +0100
+++ drivers/net/r8169.c	2004-12-04 18:22:37.000000000 +0100
@@ -1161,7 +1161,7 @@ rtl8169_hw_start(struct net_device *dev)
 
 static inline void rtl8169_make_unusable_by_asic(struct RxDesc *desc)
 {
-	desc->addr = 0x0badbadbadbadbad;
+	desc->addr = 0x0badbadbadbadbadull;
 	desc->status &= ~cpu_to_le32(OWNbit | RsvdMask);
 }
 
[...]
> The patch I previously applied was a patch made by you in personal and it
> was posted in this mailing list.
> The patch name was : r8169-debug.patch and it contained the following.
> 
> --- r8169.c-realtek	2004-01-17 14:14:50.000000000 +0100
> +++ r8169.c-debug	2004-01-17 14:17:25.000000000 +0100
> @@ -1290,6 +1290,11 @@ static void rtl8169_tx_interrupt (struct
>  	dirty_tx = priv->dirty_tx;
>  	tx_left = priv->cur_tx - dirty_tx;
>  
> +	if (entry + tx_left > NUM_TX_DESC) {
> +		printk(KERN_ERR, "r8169 bug. Please mail
> netdev@oss.sgi.com\n");
> +		return;
> +	}
> +
>  	while (tx_left > 0) {
>  		if( (priv->TxDescArray[entry].status & OWNbit) == 0 ){
>  			dev_kfree_skb_irq( priv->Tx_skbuff[dirty_tx %
> NUM_TX_DESC] );

It was just a debug patch, not a fix.

[info removed]

Thanks.

Would your application benefit from larger (> 1500 bytes) frames ?

(no need to include a complete copy of the original message)

--
Ueimor
