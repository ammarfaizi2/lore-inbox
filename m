Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVEJLNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVEJLNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVEJLNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:13:55 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:10460 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261610AbVEJLNn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 07:13:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jtg9EJ0VpbG7if3B5YWvnQ/rjv3ipukzFZ8Cy24HVlnokAFE9zGMWwNyFjZ/8f0W+WpGfAyN2Hr3UcyM7OiwPXFGfnRAgcltNvivmtToB0Ilg8rSpGC2g4grEHvw/QwiIPwVvEQYtIzzFFeHz9SLJg79XihSrLJCrYsqkHABxGw=
Message-ID: <9cde8bff0505100413422104a6@mail.gmail.com>
Date: Tue, 10 May 2005 20:13:43 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: johnpol@2ka.mipt.ru
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
Cc: Andrew Morton <akpm@osdl.org>, guillaume.thouvenin@bull.net,
       alexn@dsv.su.se, linux-kernel@vger.kernel.org, jlan@engr.sgi.com,
       elsa-devel@lists.sourceforge.net
In-Reply-To: <20050510014359.074109d8@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
	 <1115631107.936.25.camel@localhost.localdomain>
	 <1115638724.8540.59.camel@frecb000711.frec.bull.fr>
	 <20050509154809.19076fe0@zanzibar.2ka.mipt.ru>
	 <20050509140836.066008e0.akpm@osdl.org>
	 <20050510014359.074109d8@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Mon, 9 May 2005 14:08:36 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > >
> > > > In the previous connector, cn_netlink_send(struct cn_msg *msg, u32
> > > > __groups) called alloc_skb(size, GFP_ATOMIC). Now a third parameter is
> > > > used with cn_netlink_send() in order to call alloc_skb(size, gfp_mask)
> > > > with a specific gfp_mask. So, I'm using GFP_ATOMIC as the third argument
> > > > to keep the same behavior.
> > >
> > > It was atomic there to allow non process context usage.
> > > Since do_fork() is executed in process context you can use GFP_KERNEL with
> > > __GFP_NOFAIL  - it will guarantee memory allocation.
> >
> > Please avoid using __GFP_NOFAIL.
> >
> > __GFP_NOFAIL was introduced because we had lots of places in the kernel
> > which were doing:
> >
> > try_again:
> >       p = allocate_something();
> >       if (!p) {
> >               /* A am too lame to handle this */
> >               delay_in_some_manner();
> >               goto try_again;
> >       }
> >
> > __GFP_NOFAIL simply takes the above bad code and centralises it so it's
> > always done in the same way and so that it's easily greppable for.  But
> > it's still bad (ie: deadlocky) code.
> >
> > Well-behaved code should notice the allocation failure and should back out
> > gracefully.
> 
> If system under so bad conditions that even process context allocation
> fails, then connector may drop message and will return error,
> probably in such conditions one may not even trust accounting data,
> so, Guillaume, feel free to drop it and just do not send data -
> it's only a matter of information importance.
> 

what i find most troublesome of this solution is that information
collected by ELSA is not reliable. The reason is that it uses netlink,
which is connectionless. So under heavy pressure, we can lose some
critical accounting data.

At least it would be nice if we can know when and why there are
problems of losing data with netlink. Any solution?

thank you,
aq
