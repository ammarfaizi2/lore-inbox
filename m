Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272915AbTHKSVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272885AbTHKSV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:21:28 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45192 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272840AbTHKSTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:19:23 -0400
Date: Mon, 11 Aug 2003 20:11:48 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: davej@redhat.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] Missing spin_unlock_irqrestore from rrunner driver.
Message-ID: <20030811201148.A1246@electric-eye.fr.zoreil.com>
References: <E19mF4Z-0005Ep-00@tetrachloride>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E19mF4Z-0005Ep-00@tetrachloride>; from davej@redhat.com on Mon, Aug 11, 2003 at 04:59:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@redhat.com <davej@redhat.com> :
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/rrunner.c linux-2.5/drivers/net/rrunner.c
> --- bk-linus/drivers/net/rrunner.c	2003-08-04 01:00:27.000000000 +0100
> +++ linux-2.5/drivers/net/rrunner.c	2003-08-06 18:59:37.000000000 +0100
> @@ -1645,6 +1645,7 @@ static int rr_ioctl(struct net_device *d
>  			printk(KERN_ERR "%s: Error reading EEPROM\n",
>  			       dev->name);
>  			error = -EFAULT;
> +			spin_unlock_irqrestore(&rrpriv->lock, flags);
>  			goto gf_out;
>  		}
>  		spin_unlock_irqrestore(&rrpriv->lock, flags);
> -

Bloat :o)

--- linux-2.6.0-test3/drivers/net/rrunner.c	Mon Aug 11 20:03:21 2003
+++ linux-2.6.0-test3/drivers/net/rrunner.c	Mon Aug 11 20:03:38 2003
@@ -1641,13 +1641,13 @@ static int rr_ioctl(struct net_device *d
 
 		spin_lock_irqsave(&rrpriv->lock, flags);
 		i = rr_read_eeprom(rrpriv, 0, image, EEPROM_BYTES);
+		spin_unlock_irqrestore(&rrpriv->lock, flags);
 		if (i != EEPROM_BYTES){
 			printk(KERN_ERR "%s: Error reading EEPROM\n",
 			       dev->name);
 			error = -EFAULT;
 			goto gf_out;
 		}
-		spin_unlock_irqrestore(&rrpriv->lock, flags);
 		error = copy_to_user(rq->ifr_data, image, EEPROM_BYTES);
 		if (error)
 			error = -EFAULT;
