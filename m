Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290802AbSARUXH>; Fri, 18 Jan 2002 15:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290803AbSARUW5>; Fri, 18 Jan 2002 15:22:57 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:31010 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290802AbSARUWs> convert rfc822-to-8bit; Fri, 18 Jan 2002 15:22:48 -0500
Date: Fri, 18 Jan 2002 21:21:35 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Troy Benjegerdes <hozer@drgw.net>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, Dan Malek <dan@embeddededge.com>,
        <mattl@mvista.com>
Subject: Re: pci_alloc_consistent from interrupt == BAD
In-Reply-To: <20020118130209.J14725@altus.drgw.net>
Message-ID: <20020118210150.Q1937-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Jan 2002, Troy Benjegerdes wrote:

> Somehow the docs in DMA-mappings.txt say pci_alloc_consistent is allowed from
> interrupt, but this is a "bad thing" on at least arm and PPC non-cache
> coherent cpus.

Everything gets bad when it doesn't work for you. :-)

> On these cpus we have to allocate page tables for consistent_alloc.. I really
> dont' think we want to be doing this during interrupt context.
>
> This also causes the sym53c8xx_2 driver to not work on some embedded ppc 4xx
> boards, and in general, seems to be a 'bad thing' to allow.

I have noted that some ports may [ever] require pci_alloc_consistent not
to be called from interrupt context. Just I will look into this when time
will allow.

Btw, I thought long ago about using a thread in the driver to deal with
completions and some other events on which the driver may want to allocate
memory. But this would have added useless latency. Instead I preferred to
be careful about the driver to be as fast as possible when completing an
IO under interrupt.

Btw-bis, FreeBSD-5 wants to thread everything (as most of you know). We
will see the result... No need to say that I posted my disagreement when
this project started. As FreeBSD-5 should be ready when Linux-2.6 will be,
we will be able to compare interrupt threading cost against simple fast
interrupt on typical hardware (99% are UP in my guessing).

> For example, in the arch/arm/consistent.c:
>
> /*
>  * This allocates one page of cache-coherent memory space and returns
>  * both the virtual and a "dma" address to that space.  It is not clear
>  * whether this could be called from an interrupt context or not.  For
>  * now, we expressly forbid it, especially as some of the stuff we do
>  * here is not interrupt context safe.
>  *
>  * Note that this does *not* zero the allocated area!
>  */
> void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)
>
> (arm's pci_alloc_consistent always calls consistent_alloc).

ARM arch is simplistic. Wanting to run modern O/Ses on this crap looks
utter stupidity to me. I don't care about ARM at all.

> The PPC version calls a similiar function when CONFIG_NOT_COHERENT_CACHE is
> defined. On 'regular' ppc machines, it's just a __get_free_pages, which is
> why no one from the pmac crowd has screamed.

I am not going to ever use not cache coherent hardware, even if I am ready
to make the sym driver work reliably on such brain-dead things. Just it is
not high priority stuff for now.

  Gérard.

