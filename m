Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317586AbSFIJzy>; Sun, 9 Jun 2002 05:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317587AbSFIJzx>; Sun, 9 Jun 2002 05:55:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:54171 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317586AbSFIJzx>;
	Sun, 9 Jun 2002 05:55:53 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15619.9534.521209.93822@nanango.paulus.ozlabs.org>
Date: Sun, 9 Jun 2002 19:51:58 +1000 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <20020608.222903.122223122.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

>    From: Roland Dreier <roland@topspin.com>
>    Date: 08 Jun 2002 18:26:12 -0700
> 
>    Just to make sure I'm reading this correctly, you're saying that as
>    long as a buffer is OK for DMA, it should be OK to use a
>    sub-cache-line chunk as a DMA buffer via pci_map_single(), and
>    accessing the rest of the cache line should be OK at any time before,
>    during and after the DMA.
>    
> Yes.

No.  Not on processors where the cache doesn't snoop DMA accesses to
memory.

>    What alternate implementation are you proposing?
> 
> For non-cacheline aligned chunks in the range "start" to "end" you
> must perform a cache writeback and invalidate. To preserve the data
> outside of the DMA range.

This is the problem scenario.  Suppose we are doing DMA to a buffer B
and also independently accessing a variable X which is not part of B.
Suppose that X and the beginning of B are both in cache line C.

	CPU				I/O device

1.	write back & invalidate cache
	line(s) containing B
2.	start DMA
3.	read X: cache line C now
	present in cache
4.					DMA write to B:
					cache line C updated in memory
5.	write X: cache line C now
	dirty in cache
6.					Signal DMA completion

Now at this point the driver calls pci_unmap_single or whatever.  What
is pci_unmap_single to do?  If it does nothing, or does a writeback,
we lose the DMA data.  If it does an invalidate we lose the value
written to X.  Clearly, neither is correct.

The bottom line is that we can only have one writer to any given cache
line at a time.  If a buffer is being used for DMA from a device to
memory, the cpu MUST NOT write to any cache line that overlaps the
buffer.

Fundamentally, this is because the hardware lacks the ability to
transfer the "ownership" of the cache line between the cpu and the DMA
device on demand, and so we must manage that in software.  The only
safe way to allow the cpu to write to the cache line during a DMA
transfer is active is to pause the DMA, invalidate the cache line, do
the write, write back and invalidate the cache line, and restart the
DMA.

Paul.
