Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWISBIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWISBIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 21:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWISBIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 21:08:45 -0400
Received: from lixom.net ([66.141.50.11]:48098 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751490AbWISBIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 21:08:44 -0400
Date: Mon, 18 Sep 2006 20:05:55 -0500
From: Olof Johansson <olof@lixom.net>
To: "Dan Williams" <dan.j.williams@gmail.com>
Cc: christopher.leech@intel.com, "Jeff Garzik" <jeff@garzik.org>,
       neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: clean up and abstract function types (was
 Re: [PATCH 08/19] dmaengine: enable multiple clients and operations)
Message-ID: <20060918200555.74aedeae@localhost.localdomain>
In-Reply-To: <e9c3a7c20609181556n235d650eg16e5296f192bd2d5@mail.gmail.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	<20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>
	<4505F4D0.7010901@garzik.org>
	<20060915113817.6154aa67@localhost.localdomain>
	<20060915144423.500b529d@localhost.localdomain>
	<e9c3a7c20609181556n235d650eg16e5296f192bd2d5@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.20; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2006 15:56:37 -0700 "Dan Williams" <dan.j.williams@gmail.com> wrote:

> On 9/15/06, Olof Johansson <olof@lixom.net> wrote:
> > On Fri, 15 Sep 2006 11:38:17 -0500 Olof Johansson <olof@lixom.net> wrote:

> > Chris/Dan: Please consider picking this up as a base for the added
> > functionality and cleanups.
> >
> Thanks for this Olof it has sparked some ideas about how to redo
> support for multiple operations.

Good. :)

> I think we should keep the operation type in the function name but
> drop all the [buf|pg|dma]_to_[buf|pg|dma] permutations.  The buffer
> type can be handled generically across all operation types.  Something
> like the following for a pg_to_buf memcpy.
> 
> struct dma_async_op_memcpy *op;
> struct page *pg;
> void *buf;
> size_t len;
> 
> dma_async_op_init_src_pg(op, pg);
> dma_async_op_init_dest_buf(op, buf);
> dma_async_memcpy(chan, op, len);

I'm generally for a more generic interface, especially in the address
permutation cases like above. However, I think it'll be a mistake to
keep the association between the API and the function names and types
so close.

What's the benefit of keeping a memcpy-specific dma_async_memcpy()
instead of a more generic dma_async_commit() (or similar)? We'll know
based on how the client/channel was allocated what kind of function is
requested, won't we?

Same goes for the dma_async_op_memcpy. Make it an union that has a type
field if you need per-operation settings. But as before, we'll know
what kind of op structure gets passed in since we'll know what kind of
operation is to be performed on it.

Finally, yet again the same goes for the op_init settings. I would even
prefer it to not be function-based, instead just direct union/struct
assignments.

struct dma_async_op op;
...

op.src_type = PG; op.src = pg;
op.dest_type = BUF; op.dest = buf;
op.len = len;
dma_async_commit(chan, op);

op might have to be dynamically allocated, since it'll outlive the
scope of this function. But the idea would be the same.


-Olof
