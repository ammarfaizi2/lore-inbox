Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276247AbRJCN3s>; Wed, 3 Oct 2001 09:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRJCN3k>; Wed, 3 Oct 2001 09:29:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29992 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276247AbRJCN3d>; Wed, 3 Oct 2001 09:29:33 -0400
To: Pierre PEIFFER <pierre.peiffer@sxb.bsf.alcatel.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e2compress in kernel 2.4
In-Reply-To: <3BBACF29.7BB980C4@sxb.bsf.alcatel.fr>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Oct 2001 07:20:26 -0600
In-Reply-To: <3BBACF29.7BB980C4@sxb.bsf.alcatel.fr>
Message-ID: <m1ofno3lnp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre PEIFFER <pierre.peiffer@sxb.bsf.alcatel.fr> writes:

> Hi !
> 
>     We are willing to port e2compress from 2.2 kernel series to 2.4 and
> we are looking for the right way for porting the compression on the
> write part.
> 
>     For the read operation, we can adapt the original design: the 2.2
> part of e2compress can be easily integrated in the 2.4 version; for the
> write, it is a little bit more complicated...

I'm not certain you even want to reuse the read path, as is from 2.2

> 
>     So, here, we are a little bit confused because we don't know where
> to introduce the compression, if we keep the same idea of the 2.2
> design... In fact, on one hand, once the buffers will be compressed, the
> pages will also become compressed, but on the other hand, we don't want
> the pages to be compressed, because, the pages, once registered and
> linked to the inode are supposed to be uncompressed...
> 
>     So our idea was to introduce the notion of "cluster of pages", as
> the notion of cluster of blocks, i.e. performs the write on several
> pages at a time, then compress the buffers corresponding to these pages,
> but here the data of the buffers should be splitted up from the data of
> the pages and that's our problem... We don't know how to do this. Is
> there a way to do this ?
> 

You can't reuse the page cache buffers, so some amount of double buffering
is needed.  The "cluster of pages" idea is already in the e2compr on-disk
format so it is natural.  Doing the compression only at close (as is
done in the 2.0 version ) may also be appropriate.  In either case
what you need is an extra address_space per inode.  In the extra
address space you can keep your compressed data.  

The index on the compressed data should be something like
(compressed_block * compressed_block_size) +
index_into_compressed_block.  

The problems you face are similiar to those faced by journaling and
more so by delayed disk block allocation.  If you can get delayed
allocation going then there is a good chance you can reduce
fragmentation by only writing the data compressed, and reading
and uncompressing the data on the fly.  

Note: delayed allocation is a much easier problem than journalling
as writes may be flushed anytime memory is low.  Though when you
throw compression into the mix you might have another set of problems.

2.4 should be able to handle logical disk blocks > PAGE_SIZE just
fine if your write routine can handle gathering up a couple of them.

>     And, from a more general point of view, do you think our approach
> has a chance to succeed ?

I think you want to step back and understand the page cache in 2.4.
It should be much easier to work with then going through the buffer
cache was in 2.2 and earlier but it is going to require some
noticeable algorithm changes, on how reads and writes are handled.

Also please keep me in the loop.  I can't commit to anything but I'm
just about interested enough to implement some of the needed changes.

Eric
