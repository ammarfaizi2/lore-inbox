Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSEBXGk>; Thu, 2 May 2002 19:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315473AbSEBXGj>; Thu, 2 May 2002 19:06:39 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:13731 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315472AbSEBXGi>;
	Thu, 2 May 2002 19:06:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Fri, 3 May 2002 01:05:45 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173Pe0-0002Bw-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 02:20, Anton Blanchard wrote:
> > so ia64 is one of those archs with a ram layout with huge holes in the
> > middle of the ram of the nodes? I'd be curious to know what's the
> > hardware advantage of designing the ram layout in such a way, compared
> > to all other numa archs that I deal with. Also if you know other archs
> > with huge holes in the middle of the ram of the nodes I'd be curious to
> > know about them too. thanks for the interesting info!
> 
> From arch/ppc64/kernel/iSeries_setup.c:
> 
>  * The iSeries may have very large memories ( > 128 GB ) and a partition
>  * may get memory in "chunks" that may be anywhere in the 2**52 real
>  * address space.  The chunks are 256K in size.
> 
> Also check out CONFIG_MSCHUNKS code and see why I'd love to see a generic
> solution to this problem.

Hmm, I just re-read your numbers above.  Supposing you have 256 GB of
'installed' memory, divided into 256K chunks at random places in the 52
bit address space, a hash table with 1M entries could map all that
physical memory.  You'd need 16 bytes or so per hash table entry, making
the table 16MB in size.  This would be about .0006% of memory.

More-or-less equivalently, a tree could be used, with the tradeoff being
a little better locality of reference vs more search steps.  The hash
structure can also be tweaked to improve locality by making each hash
entry map several adjacent memory chunks, and hoping that the chunks tend
to occur in groups, which they most probably do.

I'm offering the hash table, combined with config_nonlinear as a generic
solution.

-- 
Daniel
