Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWGAOGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWGAOGX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWGAOGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:06:23 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:9421 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751146AbWGAOGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:06:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lurCT12471Va7XBZ+C6rUi75Cgo+zJJF8ij5QA9R/dQt8RrMXzkPwUd2ZeShmGbEo+dmXqPL2niHZ2poThmWu3sUpwJtWqLfyfCWMSuDVqcxzHgpO+YkvNwlveUsZjtWYOYXbxHi2YDJjS2NHELxCu52AQ1eUPGnHFdcyzKL6CM=
Message-ID: <a44ae5cd0607010706k74c30a9ey6b7eac49d11e7827@mail.gmail.com>
Date: Sat, 1 Jul 2006 07:06:22 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Cc: "Ingo Molnar" <mingo@elte.hu>, "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1151746867.3195.19.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com>
	 <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu>
	 <20060630091850.GA10713@elte.hu>
	 <20060630111734.GA22202@gondor.apana.org.au>
	 <20060630113758.GA18504@elte.hu>
	 <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com>
	 <20060630203804.GA1950@elte.hu>
	 <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
	 <1151746867.3195.19.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Fri, 2006-06-30 at 15:45 -0700, Miles Lane wrote:
> > Okay, I rebuilt my kernel with your combo patch applied.
> > Then, I inserted my US Robotics USR2210 PCMCIA wifi card,
> > ran "pccardutil eject", popped out the card and then inserted
> > a Compaq iPaq wifi card.  This triggered the following.
> >
> > [ INFO: possible circular locking dependency detected ]
> > -------------------------------------------------------
> > syslogd/1886 is trying to acquire lock:
> >  (&dev->queue_lock){-+..}, at: [<c11a50b5>] dev_queue_xmit+0x120/0x24b
> >
> > but task is already holding lock:
> >  (&dev->_xmit_lock){-+..}, at: [<c11a5118>] dev_queue_xmit+0x183/0x24b
> >
> > which lock already depends on the new lock.
>
>
> ok this appears to be hostap playing games... it has 2 network devices
> for one piece of hardware and one calls the other via the networking
> layer; there is thankfully a natural ordering between the two, so just
> making the slave one a separate type ought to make this work.
>
> Can you test the patch below?
>
> ---
>  drivers/net/wireless/hostap/hostap_hw.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> Index: linux-2.6.17-mm4/drivers/net/wireless/hostap/hostap_hw.c
> ===================================================================
> --- linux-2.6.17-mm4.orig/drivers/net/wireless/hostap/hostap_hw.c
> +++ linux-2.6.17-mm4/drivers/net/wireless/hostap/hostap_hw.c
> @@ -3096,6 +3096,14 @@ static void prism2_clear_set_tim_queue(l
>  }
>
>
> +/*
> + * HostAP uses two layers of net devices, where the inner
> + * layer gets called all the time from the outer layer.
> + * This is a natural nesting, which needs a split lock type.
> + */
> +static struct lock_class_key hostap_netdev_xmit_lock_key;
> +
> +
>  static struct net_device *
>  prism2_init_local_data(struct prism2_helper_functions *funcs, int card_idx,
>                        struct device *sdev)
> @@ -3260,6 +3268,8 @@ while (0)
>         SET_NETDEV_DEV(dev, sdev);
>         if (ret >= 0)
>                 ret = register_netdevice(dev);
> +
> +       lockdep_set_class(&dev->_xmit_lock, &hostap_netdev_xmit_lock_key);
>         rtnl_unlock();
>         if (ret < 0) {
>                 printk(KERN_WARNING "%s: register netdevice failed!\n",

(Sorry for the duplicate message Arjan, I forgot to Reply All the first time.)

After rebuilding with this patch, I still get the lockdep message.
Everything is the same except now the "other info" section reads:

other info that might help us debug this:

1 lock held by swapper/0:
 #0:  (&dev->_xmit_lock){-+..}, at: [<c11a5118>] dev_queue_xmit+0x183/0x24b
