Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSFHUi7>; Sat, 8 Jun 2002 16:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSFHUi6>; Sat, 8 Jun 2002 16:38:58 -0400
Received: from [209.237.59.50] ([209.237.59.50]:57517 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317446AbSFHUi5>; Sat, 8 Jun 2002 16:38:57 -0400
To: linux-kernel@vger.kernel.org
Subject: PCI DMA to small buffers on cache-incoherent arch
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 08 Jun 2002 13:38:53 -0700
Message-ID: <52vg8ta4ki.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently fixed some problems in the 2.4 USB stack that caused
crashes on the PowerPC 440GP (and probably other cache-incoherent
architectures).  However, some parts of my fix have raised some
questions on the linux-usb-devel and linuxppc-embedded mailing lists
and I would like to raise these issues here so that we can get a
definitive answer.  I would especially appreciate comments from David
Miller and other PCI DMA experts.

The problem that caused crashes on cache-incoherent architectures (my
specific system uses a PPC 440GP but this should apply in general) was
the following.  The USB stack was doing PCI DMA into buffers that were
allocated on the stack, which causes stack corruption: on the PPC
440GP, pci_map_single() with PCI_DMA_FROMDEVICE just invalidates the
cache for the region being mapped.  However, if a buffer is smaller
than a cache line, then two bad things can happen.

First, there may be valid data outside the buffer but in the same
cache line that has not been flushed to main memory yet.  In that case
when the cache is invalidated the new data is lost and any access to
that memory will get the old data from main memory.  Second, access to
the cache line after the cache has been invalidated but before the DMA
has completed will pull the cache line back into processor cache and
the DMA buffer will have invalid data.

The solution to this was simply to use kmalloc() to allocate buffers
instead of using automatic variables.  On the PPC 440GP this is
definitely safe because the 440GP's has 32 byte cache lines and
kmalloc() will never return a buffer that is smaller than 32 bytes or
not 32-byte aligned.  However, this leads to my first question: is
this safe on all architectures?  Could there be a cache-incoherent
architecture where kmalloc() returned a buffer smaller than a cache
line?

The second question is related to this.  There are other parts of the
USB stack where structures are defined:

	struct something {
	        /* ... some members ... */
	        char buffer[SMALLER_THAN_L1_CACHE_LINE_SIZE];
	        /* ... some more members ... */
	};

Then a struct something is kmalloc()'ed and buffer is used to DMA
into.  However, even though the overall structure is aligned on a
cache line boundary, buffer is not aligned.  It seems to me that this
is not safe because access to members near buffer during a DMA could
cause corruption (as detailed above).  In my patch I changed code like
this to look like

	struct something {
	        /* ... some members ... */
	        char *buffer;
	        /* ... some more members ... */
	};

and then kmalloc()'ed buffer separately when kmalloc()'ing a struct
something.

However, there is some question about whether changing these buffers
is really necessary.  Code like the above doesn't cause immediately
obvious crashes the way buffers on the stack do (since we usually get
lucky and don't touch the members near buffer around the DMA access).
I felt that relying on this coincidence is not safe and should be
fixed at the same time.

DMA-mapping.txt says kmalloc()'ed memory is OK for DMAs and does not
mention cache alignment.  So the question is: did I misunderstand the
cache coherency issues or is my patch correct?  At a higher level: how
is this supposed to work?  Should code doing DMA into a smallish
buffer do

        buffer = kmalloc(max(BUFFER_SIZE, L1_CACHE_BYTES), GFP_XXX);

or is a kmalloc()'ed buffer always safe?  Does the code doing DMA need
to worry about the cache alignment of its buffer?

In any case this probably needs to be documented better.  Once I
understand the answer I'll write up a patch to DMA-mapping.txt so no
one has to rediscover all this.

Thanks,
  Roland
