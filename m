Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314413AbSEIWXT>; Thu, 9 May 2002 18:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314420AbSEIWXS>; Thu, 9 May 2002 18:23:18 -0400
Received: from dsl-213-023-040-085.arcor-ip.net ([213.23.40.85]:47597 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314413AbSEIWXS>;
	Thu, 9 May 2002 18:23:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Fri, 10 May 2002 00:22:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205062053050.32715-100000@serv> <E175qT7-00087g-00@starship> <3CDAF2D4.C7F20249@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E175wJO-0008Lz-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 May 2002 00:06, Roman Zippel wrote:
> 1. My patch only modifies init code, I don't think it's really a problem
> if it's slightly slower.

But why be slower when we don't have to.  And why slow down *all* architectures?

> 2. Above can now be written as "page = pfn_to_page(i +
> (bdata->node_boot_start >> PAGE_SHIFT))". Nice, isn't it? :)

page++ is nicer yet.

> > > I don't need that, because I create a contiguous _virtual_ address
> > > space.
> > 
> > Again, we're arguing about what?  So do I.  The relationship between virtual
> > and logical, for me, is just logical = virtual - PAGE_OFFSET, a meme you'll
> > find in many places in the kernel source already, often obscured by the
> > impression that physical addresses are really being manipulated when in fact
> > nothing of the kind is going on - the simple truth is, the arithmetic gets
> > easier then you work zero-based instead of PAGE_OFFSET based.
> 
> Why do you want to introduce another abstraction?

The abstraction is already there.  I didn't create the logical space, I identified
it.  There are places where the code is really manipulating logical addresses, not
physical addresses, and these are not explicitly identified.  This makes the code
cleaner and easier to read.

Your question is really 'why introduce any abstraction', or maybe you're asking
'is this an abstraction worth introducing'?  Clearly it is, since it makes
bootmem run faster, with nothing but name changes.

> If the logical address
> is basically the same as the virtual address, just use the virtual
> address.

But kernel coders have already done that in lots of places.  Why?  Because it's
a pain to to arithmetic where everything is at an offset, and difficult to read.
Not to mention, bulkier.

> What difference should that offset make? Could you show me
> please one single example?

Look at drivers/char/mem.c, read_mem.  Clearly, the code is not dealing with
physical addresses.  Yet it starts off with virt_to_phys, and thereafter works
in zero-offset addresses.  Why?  Because it's clearer and more efficient to do
that.  The generic part of my nonlinear patch clarifies this usage by rewriting
it as virt_to_logical, which is really what's happening.

That's really what's happening in bootmem too.

-- 
Daniel
