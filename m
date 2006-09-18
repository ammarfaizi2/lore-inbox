Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWIRW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWIRW4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWIRW4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:56:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:33980 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030249AbWIRW4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:56:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ruH5rlp8pI6SaM3MK/dOTbEo9UeDhoOebgmH2nCXmwBgiF1yIKy/ShKynU69m/lmBc0sLiskCvgYjDClEuDuyiMHKznAD5km37cQd8eOAuQoKDrpiDnMv5XMuhFJ0ookLTOXE+MhHUQHfarM1EpxKOjy//1w5OtFDXaGGyQ93Qk=
Message-ID: <e9c3a7c20609181556n235d650eg16e5296f192bd2d5@mail.gmail.com>
Date: Mon, 18 Sep 2006 15:56:37 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH] dmaengine: clean up and abstract function types (was Re: [PATCH 08/19] dmaengine: enable multiple clients and operations)
Cc: christopher.leech@intel.com, "Jeff Garzik" <jeff@garzik.org>,
       neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060915144423.500b529d@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	 <20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>
	 <4505F4D0.7010901@garzik.org>
	 <20060915113817.6154aa67@localhost.localdomain>
	 <20060915144423.500b529d@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/06, Olof Johansson <olof@lixom.net> wrote:
> On Fri, 15 Sep 2006 11:38:17 -0500 Olof Johansson <olof@lixom.net> wrote:
>
> > On Mon, 11 Sep 2006 19:44:16 -0400 Jeff Garzik <jeff@garzik.org> wrote:
>
> > > Are we really going to add a set of hooks for each DMA engine whizbang
> > > feature?
> > >
> > > That will get ugly when DMA engines support memcpy, xor, crc32, sha1,
> > > aes, and a dozen other transforms.
> >
> >
> > Yes, it will be unmaintainable. We need some sort of multiplexing with
> > per-function registrations.
> >
> > Here's a first cut at it, just very quick. It could be improved further
> > but it shows that we could exorcise most of the hardcoded things pretty
> > easily.
>
> Ok, that was obviously a naive and not so nice first attempt, but I
> figured it was worth it to show how it can be done.
>
> This is a little more proper: Specify at client registration time what
> the function the client will use is, and make the channel use it. This
> way most of the error checking per call can be removed too.
>
> Chris/Dan: Please consider picking this up as a base for the added
> functionality and cleanups.
>
Thanks for this Olof it has sparked some ideas about how to redo
support for multiple operations.

>
>
>
>
> Clean up dmaengine a bit. Make the client registration specify which
> channel functions ("type") the client will use. Also, make devices
> register which functions they will provide.
>
> Also exorcise most of the memcpy-specific references from the generic
> dma engine code. There's still some left in the iov stuff.
I think we should keep the operation type in the function name but
drop all the [buf|pg|dma]_to_[buf|pg|dma] permutations.  The buffer
type can be handled generically across all operation types.  Something
like the following for a pg_to_buf memcpy.

struct dma_async_op_memcpy *op;
struct page *pg;
void *buf;
size_t len;

dma_async_op_init_src_pg(op, pg);
dma_async_op_init_dest_buf(op, buf);
dma_async_memcpy(chan, op, len);

-Dan
