Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWILHJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWILHJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWILHJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:09:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:56922 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751387AbWILHJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:09:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L9XlIv+6+0uqKTA63gnvYdDJOA4QFYmrYaISu193AmJeSimydTg8oCTW9Fk0QHmI1peVnTB99o3HlLmzUqLKWLBZFu8olE+o3ODlgMUL3Y3B9sGaDgdynil2boGhDoL2NqI7KOUCFKygZwAWkD9dYn+0/tj657zdX7qGRpmstKQ=
Message-ID: <787b0d920609120009q7b7bf47dw9d320e838cf191a@mail.gmail.com>
Date: Tue, 12 Sep 2006 03:09:46 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Cc: jbarnes@virtuousgeek.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
In-Reply-To: <1158041558.15465.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920609112130v2d855023ief2457942736ccfd@mail.gmail.com>
	 <1158039004.15465.62.camel@localhost.localdomain>
	 <787b0d920609112304x3342e3bek88a8e12da62adac4@mail.gmail.com>
	 <1158041558.15465.77.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > Oops, I forgot about store-store ordering being automatic.
> > Pretend I had some loads in my example.
>
> Well, in 99% of the cases, you want MMIO loads to be orderd vs. MMIO
> stores and thus you can use __writel and __readl (which will only do an
> eieio in __readl). If you are really that picky, then, of course you can
> go use the __raw_* versions.

If I could get the __raw_* versions for every arch, and there
wouldn't be any endianness troubles, it'd do.

I think a single or double "_" is enough warning to enable
full foot-shooting ability though.

> > A proper interface would be more explicit about what the
> > fence does, so that driver authors shouldn't need to know
> > this detail.
>
> What detail ? Isn't my document explicit enough ? If not, please let me
> know what is not clear in the definition of the 4 ordering rules and the
> matching fences.

The driver code is not very self-documenting this way.

If I see an io_to_io_barrier(), how am I to tell if it is
read to read, write to write, read to write, write to read,
read/write to read, read/write to write, read to read/write,
write to read/write, or read/write to read/write?

Considering just reads and writes to MMIO, there are
9 possible types of fence. SPARC seems to cover a
decent number of these distinctly; the instruction takes
an immediate value as flags.

> > So you say: never mix strict mappings with loose operations,
> > and never mix loose mappings with strict operations.
>
> I don't want the concept of "lose mappings" in the generic driver
> interface for now anyway :)
>
> It's too implementation specific and I want to know that a given access
> is strictly ordered or relaxed just by looking at the accessor used, not
> having to go look for where the driver did the ioremap. We can still
> provide arch specific things where we feel it's useful but let's move
> one step at a time with the generic accessors.

I suppose the "sparse" tool could match up mapping type
with accessor type. That'd let you rely on the accessor to
be doing what you expect when you read the code.

Loose mappings are only arch-specific in implementation.
Generic non-arch driver code ought to be able to take
advantage of the performance benefits of loose mappings.
(that is: full any-any reordering)
