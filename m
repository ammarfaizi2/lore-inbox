Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSFJSK0>; Mon, 10 Jun 2002 14:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSFJSKZ>; Mon, 10 Jun 2002 14:10:25 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:32652 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S315627AbSFJSKY>;
	Mon, 10 Jun 2002 14:10:24 -0400
Date: Mon, 10 Jun 2002 11:07:40 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: paulus@samba.org, roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020610110740.B30336@ayrnetworks.com>
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <20020608.222903.122223122.davem@redhat.com> <15619.9534.521209.93822@nanango.paulus.ozlabs.org> <20020609.212705.00004924.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 09:27:05PM -0700, David S. Miller wrote:
>    From: Paul Mackerras <paulus@samba.org>
>    Date: Sun, 9 Jun 2002 19:51:58 +1000 (EST)
> 
>    This is the problem scenario.  Suppose we are doing DMA to a buffer B
>    and also independently accessing a variable X which is not part of B.
>    Suppose that X and the beginning of B are both in cache line C.
>    
> I see what the problem is.  Hmmm...
> 
> I'm trying to specify this such that knowledge of cachelines and
> whatnot don't escape the arch specific code, ho hum...  Looks like
> that isn't possible.

Perhaps provide macros in asm/pci.h that will:

- Take a buffer size and add an appropriate amount (one cache line for
  alignment and the remainder to fill out the last cache line) to be
  used for kmalloc(), etc, eg:

#define DMA_SIZE_ROUNDUP(size) \
   ((size + 2*SMP_CACHE_BYTES - 1) & ~(SMP_CACHE_BYTES - 1))

- Take a buffer address (as returned from kmalloc() with the modified
  size from above) and round it up to a cacheline boundary, eg:

#define DMA_BUFFER_ALIGN(ptr) \
   (((unsigned long)ptr + SMP_CACHE_BYTES - 1) & ~(SMP_CACHE_BYTES - 1))

These two, in conjunction, would provide a buffer that's aligned on a
cacheline boundary and ends on a cacheline boundary. Kind of ugly, but
would be sufficient and would hide the cacheline size specifics.
Cache-coherent platforms would just returned the original argument.

Thanks,
Will
