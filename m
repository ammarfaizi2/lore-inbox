Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTJRRYc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTJRRYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:24:32 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:43411 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261740AbTJRRYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:24:22 -0400
Date: Sat, 18 Oct 2003 19:23:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Finding memory leak
Message-ID: <20031018172353.GA12461@wohnheim.fh-wedel.de>
References: <20031015032539.4cfe71c7.akpm@osdl.org> <Pine.LNX.4.44.0310171235150.23079-100000@praktifix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0310171235150.23079-100000@praktifix.dwd.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 October 2003 13:26:44 +0000, Holger Kiehl wrote:
> On Wed, 15 Oct 2003, Andrew Morton wrote:
> > Holger Kiehl <Holger.Kiehl@dwd.de> wrote:
> > >
> > >    - Is it correct to assume that an application cannot be the cause
> > >       of the leak, ie. it can only be in kernel or a driver?
> > 
> > Yes.
> > 
> > >     - How can I really prove that its the driver leaking the memory?
> > 
> > Look for instances of kmalloc(n, ...) for n in the range 1025 to 2048 which
> > do not have a matching kfree.
> > 
> Could only find two instances one allocating 14 bytes and the other 4096.
> Looking further I found several calls of dev_alloc_skb(). But I assume
> these calls are also not the cause, because I put in some printk and
> the size-2048 values do not go up when this is called.
> 
> Since the only thing running at that time is some application that receives
> a multicast stream from the DVB card and writes the data to the disk, I put
> in printk's at every kmalloc() or allocation functions in net/core and
> net/ipv4. After many trials I could narrow this down to every time the
> function igmpv3_newpack() in net/ipv4/igmp.c is called. This is always
> called twice very quickly (there where never any other printk's between
> these two calls). The size allocated by alloc_skb() in igmpv3_newpack()
> when size-2048 in slabinfo goes up is 1529 bytes (in skbuff.c this allocates
> 1596 bytes).
> 
> The kernel network code is way beyond my knowledge and I cannot determine
> how it frees up the memory again. Also, it is very very likely that the leak
> is at some completely different place and igmpv3_newpack() is just called
> shortly before or afterwards.
> 
> So the questions I have are:
> 
>   - Could someone please check igmpv3_newpack() and assure me that there
>     is no leak.

There was a leak, found by the stanford checker team.  I've provided a
broken fix, DaveM wanted to write a decent one.  Not sure if it has
already found it's way into the official kernel.

Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown
