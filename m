Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVBJKeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVBJKeC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 05:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVBJKeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 05:34:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:34227 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262055AbVBJKd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 05:33:58 -0500
Date: Thu, 10 Feb 2005 02:33:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, michal@logix.cz,
       davem@davemloft.net, adam@yggdrasil.com
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050210023344.390fb358.akpm@osdl.org>
In-Reply-To: <1108028923.14335.44.camel@ghanima>
References: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com>
	<1107997358.7645.24.camel@ghanima>
	<20050209171943.05e9816e.akpm@osdl.org>
	<1108028923.14335.44.camel@ghanima>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens@endorphin.org> wrote:
>
> On Wed, 2005-02-09 at 17:19 -0800, Andrew Morton wrote:
> > Fruhwirth Clemens <clemens@endorphin.org> wrote:
> > >
> > > It must be
> > >  possible to process more than 2 mappings in softirq context.
> > 
> > Adding a few more fixmap slots wouldn't hurt anyone.  But if you want an
> > arbitrarily large number of them then no, we cannot do that.
> 
> What magnitude is "few more"? 2, 10, 100?

Not 100.  10 would seem excessive.

> > Taking more than one sleeping kmap at a time within the same process is
> > deadlocky, btw.  You can end up with N such tasks all holding one kmap and
> > waiting for someone else to release one.
> > 
> > Possibly one could arrange for the pages to not be in highmem at all.
> 
> Is there an easy way to bring pages to lowmem? The cryptoapi is called
> from the backlog of the networking stack, which is assigned in irq
> context first and processed softirq context.

Are networking frames ever allocated from highmem?  Don't think so.

> There is little opportunity
> to bringt stuff to low mem. And we can't bringt stuff to lowmem on our
> own as well, because (as I guess) this involves a page allocation, which
> would have to be GFP_ATOMIC, which can fail. So we would need fallback
> for the fallback mechanism, and that's still the tiny set of scratch
> buffers.. hairy business..

yup.

> Ok, what about the following plan:
> 
> If context == softirq, use kmap_atomic until they all used, fall-back to
> scratch buffers, and printk in some DEBUG mode:"Warning slow, redesign
> your client or raise the number of fixmaps".

Sounds painful.

> If context == user, use kmap_atomic until they all used, and fall-back
> to kmap.

Taking multiple kmaps can deadlock due to kmap exhaustion though.
