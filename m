Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755002AbWKLGuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbWKLGuI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 01:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbWKLGuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 01:50:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21765 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755002AbWKLGuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 01:50:06 -0500
Date: Sun, 12 Nov 2006 07:50:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] drivers/usb/gadget/ether.c: NULL dereference
Message-ID: <20061112065008.GF25057@stusta.de>
References: <20061111160643.GA8809@stusta.de> <200611112235.49931.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611112235.49931.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 10:35:48PM -0800, David Brownell wrote:
> On Saturday 11 November 2006 8:06 am, Adrian Bunk wrote:
> > The Coverity checker spotted the following NULL dereference of "skb" in 
> > drivers/usb/gadget/ether.c:
> 
> I don't see such a dereference.  As usual, free(NULL) is legit.
>...


void dev_kfree_skb_any(struct sk_buff *skb)
{
        if (in_irq() || irqs_disabled())
                dev_kfree_skb_irq(skb);
        else
                dev_kfree_skb(skb);
}


And the first thing dev_kfree_skb_irq() does is to dereference skb...


> > <--  snip  -->
> > 
> > ...
> > static int
> > rx_submit (struct eth_dev *dev, struct usb_request *req, gfp_t gfp_flags)
> > {
> >         struct sk_buff          *skb;
> >         int                     retval = -ENOMEM;
> > ...
> >         if ((skb = alloc_skb (size + NET_IP_ALIGN, gfp_flags)) == 0) {
> >                 DEBUG (dev, "no rx skb\n");
> >                 goto enomem;
> >         }
> > ...
> > enomem:
> >                 defer_kevent (dev, WORK_RX_MEMORY);
> >         if (retval) {
> >                 DEBUG (dev, "rx submit --> %d\n", retval);
> >                 dev_kfree_skb_any (skb);
> > ...
> > 
> > <--  snip  -->
> > 
> > cu
> > Adrian
> > 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

