Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbUJYFvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUJYFvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 01:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUJYFvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 01:51:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64130 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261437AbUJYFuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 01:50:54 -0400
Message-ID: <417C9431.6030505@pobox.com>
Date: Mon, 25 Oct 2004 01:50:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [NET]: TSO requires SG, enforce this at device registry.
References: <200410221715.i9MHFlIu021927@hera.kernel.org>
In-Reply-To: <200410221715.i9MHFlIu021927@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff -Nru a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c	2004-10-22 10:15:57 -07:00
> +++ b/net/core/dev.c	2004-10-22 10:15:57 -07:00
> @@ -2871,6 +2871,14 @@
>  		dev->features &= ~NETIF_F_SG;
>  	}
>  
> +	/* TSO requires that SG is present as well. */
> +	if ((dev->features & NETIF_F_TSO) &&
> +	    !(dev->features & NETIF_F_SG)) {
> +		printk("%s: Dropping NETIF_F_TSO since no SG feature.\n",
> +		       dev->name);
> +		dev->features &= ~NETIF_F_TSO;
> +	}


Although this patch is correct, I am pondering whether this fully covers 
the problems in the field.

There are currently two classes of problems I am seeing, that generate 
real-life bug reports:

1) Given current driver implementations of ethtool ioctls, sysadmin is 
free to create a combination of bits that are IMHO a bug.  One can argue 
that this is an extension of "root can shoot himself in the foot", so 
who knows.

2) Programmers writing drivers do not appear to be clear that SG is 
required to tx-csum/tso, and also, should not be present without one or 
both of those bits set.

	Jeff

