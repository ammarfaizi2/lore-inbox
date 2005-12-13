Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVLMP5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVLMP5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVLMP5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:57:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932320AbVLMP5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:57:14 -0500
Date: Tue, 13 Dec 2005 07:45:32 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] skge: get rid of warning on race
Message-ID: <20051213074532.18ee734c@localhost.localdomain>
In-Reply-To: <20051213145054.GA24897@suse.de>
References: <200512130559.jBD5xUjf015319@hera.kernel.org>
	<20051213145054.GA24897@suse.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005 15:50:54 +0100
Olaf Hering <olh@suse.de> wrote:

>  On Mon, Dec 12, Linux Kernel Mailing List wrote:
> 
> > tree 987cfbd2134b82bea55c55fa17bd70d29df70458
> > parent 0e670506668a43e1355b8f10c33d081a676bd521
> > author Stephen Hemminger <shemminger@osdl.org> Wed, 07 Dec 2005 07:01:49 -0800
> > committer Jeff Garzik <jgarzik@pobox.com> Tue, 13 Dec 2005 09:33:03 -0500
> > 
> > [PATCH] skge: get rid of warning on race
> 
> >  drivers/net/skge.c |   10 ++++++----
> 
> > -		netif_stop_queue(dev);
> > -		spin_unlock_irqrestore(&skge->tx_lock, flags);
> > +		if (!netif_stopped(dev)) {
> > +			netif_stop_queue(dev);
> 
> Current Linus tree does not compile:
> 
> drivers/net/skge.c:2283: error: implicit declaration of function 'netif_stopped'

Should have been netif_queue_stopped..

Index: skge-2.6/drivers/net/skge.c
===================================================================
--- skge-2.6.orig/drivers/net/skge.c
+++ skge-2.6/drivers/net/skge.c
@@ -2280,7 +2280,7 @@ static int skge_xmit_frame(struct sk_buf
  	}
 
 	if (unlikely(skge->tx_avail < skb_shinfo(skb)->nr_frags +1)) {
-		if (!netif_stopped(dev)) {
+		if (!netif_queue_stopped(dev)) {
 			netif_stop_queue(dev);
 
 			printk(KERN_WARNING PFX "%s: ring full when
queue awake!\n",


