Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278099AbRJRThl>; Thu, 18 Oct 2001 15:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278100AbRJRThb>; Thu, 18 Oct 2001 15:37:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2312 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278099AbRJRThN>; Thu, 18 Oct 2001 15:37:13 -0400
Date: Thu, 18 Oct 2001 16:16:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork() failing
In-Reply-To: <20011018.122525.82054118.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0110181609360.12383-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Oct 2001, David S. Miller wrote:

>    From: Marcelo Tosatti <marcelo@conectiva.com.br>
>    Date: Thu, 18 Oct 2001 15:04:15 -0200 (BRST)
>    
>    As you know, we currently allow 1-order allocations to fail easily. 
>    
>    However, there is one special case of 1-order allocations which cannot
>    fail: fork.
>    
>    Here is the tested patch against pre4.
> 
> There are also some platforms using 1-order allocations
> for page tables as well.
> 
> But I don't know if I agree with this special casing.
> Why not just put something into the GFP flag bits
> which distinguishes between high order allocations which
> are "critical" and others which are "don't try too hard".

Look at the comment on my patch. I've suggested that :)

I've added a __GFP_FAIL flag back in 2.4-ac something days exactly for
that purpose. I've ported the same code to the XFS tree so they could try
to "lazily" allocate (big) structures to build page clusters.

However, there is one nasty problem with it: How we can define "don't try
too hard" ?

Lets say you want to use the __GFP_FAIL flag when trying to allocate data
to do more readahead. If it fails too easily, we're never going to do
enough readahead.

What I'm trying to say is that we would need levels of "don't try too
hard" to have a nice scheme, and thats not simple.

See my point? 

> BTW, such a scheme could be useful for page cache pre-fetching.

It could be used in a _LOT_ of performance critical parts of the kernel,
indeed.

> If you use a high order allocation, it is more likely that all
> of the pages in that prefetch will fit into the same kernel TLB
> mapping.  We could use a GFP_NONCRITICAL for something like this.


