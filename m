Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVDKFXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVDKFXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 01:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVDKFXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 01:23:36 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:31457 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261275AbVDKFXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 01:23:30 -0400
Date: Mon, 11 Apr 2005 09:22:28 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Thomas Graf <tgraf@suug.ch>
Cc: jamal <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, jmorris@redhat.com,
       ijc@hellion.org.uk, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       netdev <netdev@oss.sgi.com>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050411092228.A32699@2ka.mipt.ru>
References: <1112942924.28858.234.camel@uganda> <E1DKZ7e-00070D-00@gondolin.me.apana.org.au> <20050410143205.18bff80d@zanzibar.2ka.mipt.ru> <1113131325.6994.66.camel@localhost.localdomain> <20050410153757.104fe611@zanzibar.2ka.mipt.ru> <20050410121005.GF26731@postel.suug.ch> <20050410161549.3abe4778@zanzibar.2ka.mipt.ru> <1113143959.1089.316.camel@jzny.localdomain> <20050410192727.GI26731@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050410192727.GI26731@postel.suug.ch>; from tgraf@suug.ch on Sun, Apr 10, 2005 at 09:27:27PM +0200
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 11 Apr 2005 09:22:31 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 09:27:27PM +0200, Thomas Graf (tgraf@suug.ch) wrote:
> * jamal <1113143959.1089.316.camel@jzny.localdomain> 2005-04-10 10:39
> > Please crosspost on netdev - you should know that by now;->
> > 
> > I actually disagreee with Herbert on this. Theres definetely good
> > need to have a more usable messaging system that rides on top of
> > netlink. It is not that netlink cant be extended (I actually think thats
> > a separate topic)
> 
> I find it quite easy already but I guess a few macros would improve
> it even more. The routing attribute macros could be made generic to
> so can benefit from the advanages of TLVs.
> 
> Evgeniy, Sorry for not having time earlier to give your patch a
> review. I'm not yet through completely and won't comment on the
> overall architecture until I have understood it all.
> 
> diff -Nru /tmp/empty/cn_queue.c linux-2.6/drivers/connector/cn_queue.c
> --- /tmp/empty/cn_queue.c       1970-01-01 03:00:00.000000000 +0300
> +++ linux-2.6/drivers/connector/cn_queue.c      2004-09-24 00:01:00.000000000 
> +int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb)
> +{
> +       struct cn_callback_entry *cbq, *n, *__cbq;
> +       int found = 0;
> +
> +       cbq = cn_queue_alloc_callback_entry(cb);
> +       if (!cbq)
> +               return -ENOMEM;
> +
> +       atomic_inc(&dev->refcnt);
> +       cbq->pdev = dev;
> +
> +       spin_lock(&dev->queue_lock);
> +       list_for_each_entry_safe(__cbq, n, &dev->queue_list, callback_entry) {
> 
> Why _safe? There is no way a entry can be removed here.

No particular reason - it easier to copy-paste it from other line :)

> +               if (cn_cb_equal(&__cbq->cb->id, &cb->id)) {
> +                       found = 1;
> +                       break;
> +               }
> +       }
> diff -Nru /tmp/empty/connector.c linux-2.6/drivers/connector/connector.c
> --- /tmp/empty/connector.c      1970-01-01 03:00:00.000000000 +0300
> +++ linux-2.6/drivers/connector/connector.c     2004-09-24 00:01:00.000000000 
> +void cn_netlink_send(struct cn_msg *msg, u32 __groups)
> +{
> +       struct cn_callback_entry *n, *__cbq;
> +       unsigned int size;
> +       struct sk_buff *skb;
> +       struct nlmsghdr *nlh;
> +       struct cn_msg *data;
> +       struct cn_dev *dev = &cdev;
> +       u32 groups = 0;
> +       int found = 0;
> +
> +       if (!__groups)
> +       {
> +               spin_lock(&dev->cbdev->queue_lock);
> +               list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
> 
> Same here
> 
> +                       if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
> +                               found = 1;
> +                               groups = __cbq->group;
> +                       }
> +               }
> +               spin_unlock(&dev->cbdev->queue_lock);
> +
> +               if (!found) {
> +                       printk(KERN_ERR "Failed to find multicast netlink group for callback[0x%x.0x%x]. seq=%u\n",
> +                              msg->id.idx, msg->id.val, msg->seq);
> +                       return;
> +               }
> +       }
> +       else
> +               groups = __groups;
> +
> +       size = NLMSG_SPACE(sizeof(*msg) + msg->len);
> +
> +       skb = alloc_skb(size, GFP_ATOMIC);
> +       if (!skb) {
> +               printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
> +               return;
> +       }
> +
> +       nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh));
> 
> This is not correct, what happens is:
> size = NLMSG_SPACE(sizeof(*msg) + msg->len);
>  --> align(hdr)+align(data)
> size - sizeof(*nlh)
>  --> (align(hdr)-hdr)+align(data)
> NLMSG_PUT pads again to get to the end of the data block (NLMSG_LENGTH)
>  --> align(hdr)+(align(hdr)-hdr)+align(data)
> 
> At the moment align(hdr) == hdr since nlmsghdr is already aligned
> but this might change and your code will break.

As far as I remember, header is always supposed to be aligned properly
"by design", so it even could be nonaligned here.

-- 
	Evgeniy Polyakov ( s0mbre )
