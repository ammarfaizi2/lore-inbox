Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTJRRBz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTJRRBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:01:54 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:65380 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S261743AbTJRRBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:01:53 -0400
Date: Fri, 17 Oct 2003 13:26:44 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding memory leak
In-Reply-To: <20031015032539.4cfe71c7.akpm@osdl.org>
Message-Id: <Pine.LNX.4.44.0310171235150.23079-100000@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Andrew Morton wrote:

> Holger Kiehl <Holger.Kiehl@dwd.de> wrote:
> >
> >    - Is it correct to assume that an application cannot be the cause
> >       of the leak, ie. it can only be in kernel or a driver?
> 
> Yes.
> 
> >     - How can I really prove that its the driver leaking the memory?
> 
> Look for instances of kmalloc(n, ...) for n in the range 1025 to 2048 which
> do not have a matching kfree.
> 
Could only find two instances one allocating 14 bytes and the other 4096.
Looking further I found several calls of dev_alloc_skb(). But I assume
these calls are also not the cause, because I put in some printk and
the size-2048 values do not go up when this is called.

Since the only thing running at that time is some application that receives
a multicast stream from the DVB card and writes the data to the disk, I put
in printk's at every kmalloc() or allocation functions in net/core and
net/ipv4. After many trials I could narrow this down to every time the
function igmpv3_newpack() in net/ipv4/igmp.c is called. This is always
called twice very quickly (there where never any other printk's between
these two calls). The size allocated by alloc_skb() in igmpv3_newpack()
when size-2048 in slabinfo goes up is 1529 bytes (in skbuff.c this allocates
1596 bytes).

The kernel network code is way beyond my knowledge and I cannot determine
how it frees up the memory again. Also, it is very very likely that the leak
is at some completely different place and igmpv3_newpack() is just called
shortly before or afterwards.

So the questions I have are:

  - Could someone please check igmpv3_newpack() and assure me that there
    is no leak.

  - Are there any tools or kernel switches that I can use that allow me
    to capture the leak faster? Currently I am using 2.4.22.

  - Which system call might cause a igmpv3_newpack().

Thanks,
Holger

