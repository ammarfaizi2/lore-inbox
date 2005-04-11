Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVDKKph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVDKKph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVDKKph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:45:37 -0400
Received: from postel.suug.ch ([195.134.158.23]:48058 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S261768AbVDKKp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:45:29 -0400
Date: Mon, 11 Apr 2005 12:45:50 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: jamal <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, jmorris@redhat.com,
       ijc@hellion.org.uk, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       netdev <netdev@oss.sgi.com>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050411104550.GK26731@postel.suug.ch>
References: <1112942924.28858.234.camel@uganda> <E1DKZ7e-00070D-00@gondolin.me.apana.org.au> <20050410143205.18bff80d@zanzibar.2ka.mipt.ru> <1113131325.6994.66.camel@localhost.localdomain> <20050410153757.104fe611@zanzibar.2ka.mipt.ru> <20050410121005.GF26731@postel.suug.ch> <20050410161549.3abe4778@zanzibar.2ka.mipt.ru> <1113143959.1089.316.camel@jzny.localdomain> <20050410192727.GI26731@postel.suug.ch> <20050411092228.A32699@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411092228.A32699@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Evgeniy Polyakov <20050411092228.A32699@2ka.mipt.ru> 2005-04-11 09:22
> On Sun, Apr 10, 2005 at 09:27:27PM +0200, Thomas Graf (tgraf@suug.ch) wrote:
> > +       size = NLMSG_SPACE(sizeof(*msg) + msg->len);
> > +
> > +       skb = alloc_skb(size, GFP_ATOMIC);
> > +       if (!skb) {
> > +               printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
> > +               return;
> > +       }
> > +
> > +       nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh));
> > 
> > This is not correct, what happens is:
> > size = NLMSG_SPACE(sizeof(*msg) + msg->len);
> >  --> align(hdr)+align(data)
> > size - sizeof(*nlh)
> >  --> (align(hdr)-hdr)+align(data)
> > NLMSG_PUT pads again to get to the end of the data block (NLMSG_LENGTH)
> >  --> align(hdr)+(align(hdr)-hdr)+align(data)
> > 
> > At the moment align(hdr) == hdr since nlmsghdr is already aligned
> > but this might change and your code will break.
> 
> As far as I remember, header is always supposed to be aligned properly
> "by design", so it even could be nonaligned here.

No, have a look at the macros:

#define NLMSG_LENGTH(len) ((len)+NLMSG_ALIGN(sizeof(struct nlmsghdr)))
#define NLMSG_SPACE(len) NLMSG_ALIGN(NLMSG_LENGTH(len))

NLMSG_LENGTH points to the end of the payload in the message, NLMSG_SPACE
represents the total size aligned properly for a possible next multipart
message.

It is unlikely that nlmsghdr will ever be unaligned but there can be no
reason to introduce code that can break with perfectly legal changes just
because of that.
