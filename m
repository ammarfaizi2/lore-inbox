Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVJZUoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVJZUoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVJZUoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:44:37 -0400
Received: from hera.kernel.org ([140.211.167.34]:11167 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964913AbVJZUoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:44:37 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: "Badness in local_bh_enable" - a reasonable fix?
Date: Wed, 26 Oct 2005 13:44:30 -0700
Organization: OSDL
Message-ID: <20051026134430.69ded664@dxpl.pdx.osdl.net>
References: <200510261534.38291.R00020C@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1130359471 4428 10.8.0.74 (26 Oct 2005 20:44:31 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 26 Oct 2005 20:44:31 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005 15:34:38 -0400
Steve Snyder <R00020C@freescale.com> wrote:

> [ I observed the following on a Fedora Core 3 system, running kernel 
> 2.6.12-1.1380_FC3.  I am posting this here because a quick Googling 
> indicates that the problem is not specific to this environment.  ] 
> 
> Today I found my system log filled with the error shown below.  
> Reading a 366MB file across a NFS mount results in over 6300 
> occurrences of the error being written to the system log of the NFS 
> server.  
> 
> I have 2 network interfaces in the NFS server machine, a standard 
> kernel Ethernet device driver and my own Ultra-Wide Band (UWB) device 
> driver.  (In the error shown below the references to "fsuwbpci" are my 
> driver.) This problem is not seen when using the Ethernet interface, 
> but is perfectly consistent when reading a NFS-mounted file across the 
> UWB interface.  Therefore there is a problem with my code.  
> 
> I quickly established that the error came from within this routine:
> 
>   void netdev_tx_ack(struct net_device *dev, struct sk_buff *skb)
>   {
>      struct  netdev_priv *priv = (struct netdev_priv *) dev->priv;
>   
>      priv->stats.tx_packets++;
>      priv->stats.tx_bytes += skb->len;
>   
>      netdev_resume(dev);
>      dev_kfree_skb(skb);
>   }

Your driver is calling dev_kfree_skb with interrupts disabled.
Call dev_kfree_skb_any instead.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
