Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbUFVUuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUFVUuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUFVUtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:49:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6558 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265900AbUFVUnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:43:33 -0400
Message-ID: <40D899E6.5060409@pobox.com>
Date: Tue, 22 Jun 2004 16:43:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NET]: Fix dev_queue_xmit build with older gcc.
References: <200406221816.i5MIG9jZ024996@hera.kernel.org>
In-Reply-To: <200406221816.i5MIG9jZ024996@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1822, 2004/06/21 09:32:44-07:00, akm@osdl.org
> 
> 	[NET]: Fix dev_queue_xmit build with older gcc.
> 	
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: David S. Miller <davem@redhat.com>
> 
> 
> 
>  dev.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> 
> diff -Nru a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c	2004-06-22 11:16:18 -07:00
> +++ b/net/core/dev.c	2004-06-22 11:16:18 -07:00
> @@ -1406,13 +1406,12 @@
>  	   Either shot noqueue qdisc, it is even simpler 8)
>  	 */
>  	if (dev->flags & IFF_UP) {
> -		preempt_disable();
> -		int cpu = smp_processor_id();
> +		int cpu = get_cpu();
>  
>  		if (dev->xmit_lock_owner != cpu) {
>  
>  			HARD_TX_LOCK_BH(dev, cpu);
> -			preempt_enable();
> +			put_cpu();
>  
>  			if (!netif_queue_stopped(dev)) {
>  				if (netdev_nit)
> @@ -1430,7 +1429,7 @@
>  				       "queue packet!\n", dev->name);
>  			goto out_enetdown;
>  		} else {
> -			preempt_enable();
> +			put_cpu();


Has this been tested with preempt?

It looks right, but I'm paranoid...

	Jeff


