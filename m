Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752018AbWCKHpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWCKHpc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 02:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWCKHpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 02:45:32 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:46597 "EHLO
	smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP
	id S1752018AbWCKHpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 02:45:31 -0500
Date: Sat, 11 Mar 2006 08:45:07 +0100
From: thunder7@xs4all.nl
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: skge/sk98lin slowdown with 4 Gb memory compared to 2 Gb memory
Message-ID: <20060311074507.GA6469@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20060310202929.GA7308@amd64.of.nowhere> <20060310132838.7cd176f4@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310132838.7cd176f4@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, Mar 10, 2006 at 01:28:38PM -0800
> I suspect the optimization (in other drivers as well) that doesn't set 64 bit mask
> unless dma addresses are 64 bit. The problem would go away if you config for 64G of
> memory.
> 
> This unconditionally sets 64 bit mask, does it change the situation?
> 
> --- linux-2.6.orig/drivers/net/skge.c	2006-03-10 13:26:29.000000000 -0800
> +++ linux-2.6/drivers/net/skge.c	2006-03-10 13:12:38.000000000 -0800
> @@ -3265,16 +3265,10 @@
>  
>  	pci_set_master(pdev);
>  
> -	if (sizeof(dma_addr_t) > sizeof(u32) &&
> -	    !(err = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
> +	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK) &&
> +	    !pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK))
>  		using_dac = 1;
> -		err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
> -		if (err < 0) {
> -			printk(KERN_ERR PFX "%s unable to obtain 64 bit DMA "
> -			       "for consistent allocations\n", pci_name(pdev));
> -			goto err_out_free_regions;
> -		}
> -	} else {
> +	else {
>  		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
>  		if (err) {
>  			printk(KERN_ERR PFX "%s no usable DMA configuration\n",
> 
It makes a difference, with this patch:

INTEL :free
             total       used       free     shared    buffers     cached
Mem:       4043388     263432    3779956          0      23340      50576
-/+ buffers/cache:     189516    3853872
Swap:      4200888          0    4200888
INTEL :ping rusalka
PING rusalka.of.nowhere (192.168.0.3) 56(84) bytes of data.
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=2 ttl=128 time=4012 ms
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available

--- rusalka.of.nowhere ping statistics ---
29 packets transmitted, 1 received, 96% packet loss, time 47037ms
rtt min/avg/max/mdev = 4012.565/4012.565/4012.565/0.000 ms, pipe 5
INTEL :

and with this patch, booting with mem=3G:

INTEL :ping rusalka
PING rusalka.of.nowhere (192.168.0.3) 56(84) bytes of data.
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=1 ttl=128 time=0.253 ms
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=2 ttl=128 time=0.233 ms
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=3 ttl=128 time=0.246 ms
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=4 ttl=128 time=0.262 ms
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=5 ttl=128 time=0.261 ms
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=6 ttl=128 time=0.262 ms
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=7 ttl=128 time=0.269 ms
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=8 ttl=128 time=0.260 ms
64 bytes from rusalka.of.nowhere (192.168.0.3): icmp_seq=9 ttl=128 time=0.269 ms

--- rusalka.of.nowhere ping statistics ---
9 packets transmitted, 9 received, 0% packet loss, time 8000ms
rtt min/avg/max/mdev = 0.233/0.257/0.269/0.015 ms
INTEL :

So I don't think this patch is the solution you and I hoped for.

Sorry,
Jurriaan
-- 
We the unwilling, led by the unknowing have been doing the difficult
with little for so long that we are now ready to tackle the
impossible with nothing.
	Fire Communications Reserve Volunteer Motto
Debian (Unstable) GNU/Linux 2.6.16-rc5-mm2 5503 bogomips load 0.29
