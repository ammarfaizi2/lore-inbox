Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbVCXQ56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbVCXQ56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVCXQ56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:57:58 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:18148 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262867AbVCXQ5l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:57:41 -0500
From: David Brownell <david-b@pacbell.net>
To: Jakemuksen spammiosote <jhroska@byterapers.com>
Subject: Re: [PATCH] usbnet.c, buf.overrun crash-bugfix, Kernel 2.6.12-rc1
Date: Thu, 24 Mar 2005 08:57:28 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503241722160.30661@byterapers.com>
In-Reply-To: <Pine.LNX.4.61.0503241722160.30661@byterapers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240857.28594.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 March 2005 8:05 am, Jakemuksen spammiosote wrote:
> Atleast versions 2.6.5 - 2.6.12-rc1 crash if an USB device using usbnet 
> sends oversized packet. Such packets occur most likely with broken
> device. 

Care to mention what device(s) you saw this with?   And what HCD?


> -       skb_put (skb, urb->actual_length);
> -       entry->state = rx_done;
> -       entry->urb = NULL;
> +       if (unlikely((skb->tail + urb->actual_length) > skb->end)) {

This logic looks wrong.  If that ever happens, surely the problem is
that the rx_submit() code submitted an urb with transfer_size that
mismatched the SKB.  The host controller isn't allowed to overrun the
end of the buffer it's passed.  And if it's tempted to do so, it's
supposed to fill up to the end (skb->end in this case...) and then
report urb->status of -EOVERFLOW.

If you insist on changing this bit of logic, then the best way to
ignore the packet is just to force urb->status to -EOVERFLOW


> +               entry->state = rx_cleanup;
> +               dev->stats.rx_errors++;
> +               dev->stats.rx_length_errors++;
> +               entry->urb = NULL;
> +               printk(KERN_ERR
> +                      "USB RX packet too long, discarded. "
> +                      "Your slave device most likely is broken\n");
> +               /* lets hope upper level protocols will recover */
> +       } else {
> +               skb_put(skb, urb->actual_length);
> +               entry->state = rx_done;
> +               entry->urb = NULL;
> +       }
> 
>          switch (urb_status) {
>              // success
> 
> 
