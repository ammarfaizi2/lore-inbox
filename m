Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUFVQ6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUFVQ6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUFVQ4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 12:56:02 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:58055 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265033AbUFVQQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:16:42 -0400
Date: Tue, 22 Jun 2004 09:11:04 -0700
From: Arthur Kepner <akepner@sgi.com>
X-X-Sender: akepner@neteng.engr.sgi.com
To: Chris Wright <chrisw@osdl.org>
cc: Bob Gill <gillb4@telusplanet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.7-bk] NFS-related kernel panic
In-Reply-To: <20040621203520.H22989@build.pdx.osdl.net>
Message-ID: <Pine.SGI.4.56.0406220906190.1334066@neteng.engr.sgi.com>
References: <1087872607.4066.13.camel@localhost.localdomain>
 <20040621203520.H22989@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Jun 2004, Chris Wright wrote:

>
> The lockless loopback transmission patch mucks up the preempt count.
> Can you give this patch a try?
>
> thanks,
> -chris
> --
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
>

Yes, there's a problem with preempt count. And this patch is
the minimal fix for it.

However, Andrew Morton noted this problem already and posted
a patch to be tested yesterday. I'd like to suggest that we go
with his patch (very slightly modified) which I'll post in a few
minutes to netdev. (I will cc Chris and Bob on this too.)

--

Arthur


> ===== loopback.c 1.15 vs edited =====
> --- 1.15/drivers/net/loopback.c	2004-06-20 17:35:52 -07:00
> +++ edited/loopback.c	2004-06-21 20:23:06 -07:00
> @@ -143,10 +143,11 @@
>
>  	dev->last_rx = jiffies;
>  	if (likely(loopback_stats)) {
> -		get_cpu_ptr(loopback_stats)->rx_bytes += skb->len;
> -		get_cpu_ptr(loopback_stats)->tx_bytes += skb->len;
> -		get_cpu_ptr(loopback_stats)->rx_packets++;
> -		get_cpu_ptr(loopback_stats)->tx_packets++;
> +		struct net_device_stats *stats = get_cpu_ptr(loopback_stats);
> +		stats->rx_bytes += skb->len;
> +		stats->tx_bytes += skb->len;
> +		stats->rx_packets++;
> +		stats->tx_packets++;
>  		put_cpu_ptr(loopback_stats);
>  	}
>
>
