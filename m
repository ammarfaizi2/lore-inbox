Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVADWN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVADWN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVADWNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:13:22 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:22409 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262399AbVADWMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:12:42 -0500
Date: Tue, 4 Jan 2005 23:09:35 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jon Mason <jdmason@gmail.com>
Cc: Richard Ems <richard.ems@mtg-marinetechnik.de>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer full?"
Message-ID: <20050104220935.GA21719@electric-eye.fr.zoreil.com>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	Jon Mason <jdmason@gmail.com>,
	Richard Ems <richard.ems@mtg-marinetechnik.de>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <41C6E2E1.8030801@mtg-marinetechnik.de> <8924577504122009126c40c1fe@mail.gmail.com> <41C713EF.8050003@mtg-marinetechnik.de> <892457750412201231461415a1@mail.gmail.com> <41C7F204.3030503@mtg-marinetechnik.de> <89245775041221080238187402@mail.gmail.com> <41C93E93.5070704@mtg-marinetechnik.de> <892457750412220654918c785@mail.gmail.com> <41D2EF1F.2020400@mtg-marinetechnik.de> <89245775050104133235a22b8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89245775050104133235a22b8b@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Mason <jdmason@gmail.com> :
[...]
> @@ -1005,10 +1018,36 @@ rio_error (struct net_device *dev, int i
>         /* PCI Error, a catastronphic error related to the bus interface
>            occurs, set GlobalReset and HostReset to reset. */
>         if (int_status & HostError) {
> -               printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
> -                       dev->name, int_status);
> +               printk (KERN_ERR "%s: HostError! IntStatus %4.4x. %d
> %d %x %x\n",
> +                       dev->name, int_status, np->cur_tx, np->cur_rx,
> +                       readl (ioaddr + MACCtrl), readw(ioaddr + IntEnable));
>                 writew (GlobalReset | HostReset, ioaddr + ASICCtrl + 2);
> +
> +               /* Free all the skbuffs in the queue. */
> +               for (i = 0; i < RX_RING_SIZE; i++) {
> +                       np->rx_ring[i].status = 0;
> +                       np->rx_ring[i].fraginfo = 0;
> +                       skb = np->rx_skbuff[i];
> +                       if (skb) {
> +                               pci_unmap_single (np->pdev, np->rx_ring[i].fraginfo,
> +                                                 skb->len, PCI_DMA_FROMDEVICE);
> +                               dev_kfree_skb (skb);

It is probably a minor issue right now but skb->len seems inaccurate
(there is no guaranty that skb_put() was issued).

--
Ueimor
