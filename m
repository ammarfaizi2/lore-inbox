Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130267AbQLaRwT>; Sun, 31 Dec 2000 12:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130355AbQLaRwK>; Sun, 31 Dec 2000 12:52:10 -0500
Received: from Cantor.suse.de ([194.112.123.193]:23556 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130267AbQLaRv4>;
	Sun, 31 Dec 2000 12:51:56 -0500
Date: Sun, 31 Dec 2000 18:21:27 +0100
From: Andi Kleen <ak@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001231182127.A24348@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.10.10012281459150.995-100000@penguin.transmeta.com> <Pine.LNX.4.10.10012301422310.581-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012301422310.581-100000@cassiopeia.home>; from geert@linux-m68k.org on Sat, Dec 30, 2000 at 02:24:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2000 at 02:24:06PM +0100, Geert Uytterhoeven wrote:
> On Thu, 28 Dec 2000, Linus Torvalds wrote:
> > On Thu, 28 Dec 2000, Andi Kleen wrote:
> > > - Instead of having a zone pointer mask use a 8 or 16 byte index into a 
> > > zone table. On a modern CPU it is much cheaper to do the and/shifts than
> > > to do even a single cache miss during page aging. On a lot of systems 
> > > that zone index could be hardcoded to 0 anyways, giving better code.
> > > - Instead of using 4/8 bytes for the age use only 16bit (FreeBSD which
> > > has the same swapping algorithm even only uses 8bit) 
> > 
> > This would be good, but can be hard.
> > 
> > FreeBSD doesn't try to be portable any more, but Linux does, and there are
> > architectures where 8- and 16-bit accesses aren't atomic but have to be
> > done with read-modify-write cycles.
> > 
> > And even for fields like "age", where we don't care whether the age itself
> > is 100% accurate, we _do_ care that the fields close-by don't get strange
> > effects from updating "age". We used to have exactly this problem on alpha
> > back in the 2.1.x timeframe.
> > 
> > This is why a lot of fields are 32-bit, even though we wouldn't need more
> > than 8 or 16 bits of them.
> 
> What about defining new types for this? Like e.g. `x8', being `u8' on platforms
> were that's OK, and `u32' on platforms where that's more efficient?

Sounds good. It could also be controlled by a CONFIG_SPACE_EFFICIENT for
embedded systems, where you could trade a bit of CPU for less memory overhead 
even on systems where u8 is slow and atomicity doesn't come into play
because it's UP anyways. 

Only problem I see is that when the programmer was wrong about the possible
range (which sometimes happens) then it could mysteriously work on some
machines and fail on others. This is already the case e.g. with atomic_t,
which is shorter than 32bit e.g. on sparc32, so it is probably not a too
big problem. 


-Andi

/* asm/types.h for a random 32bit machine with no byte access */ 
#if defined(CONFIG_SPACE_EFFICIENT) && !defined(CONFIG_SMP)
typedef __u8 x8; 
typedef __u16 x16; 
typedef __u32 x32; 
#else
typedef __u32 x8; 
typedef __u32 x16; 
typedef __u32 x32; 
#endif

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
