Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSFJQD1>; Mon, 10 Jun 2002 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSFJQD0>; Mon, 10 Jun 2002 12:03:26 -0400
Received: from [209.237.59.50] ([209.237.59.50]:43550 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S315480AbSFJQD0>; Mon, 10 Jun 2002 12:03:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52lm9p9tdz.fsf@topspin.com>
	<20020608.175325.63815788.davem@redhat.com>
	<52d6v19r9n.fsf@topspin.com>
	<20020608.222903.122223122.davem@redhat.com>
	<528z5p9dtl.fsf@topspin.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Jun 2002 09:03:22 -0700
Message-ID: <52y9dn86k5.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Roland" == Roland Dreier <roland@topspin.com> writes:

    David> For non-cacheline aligned chunks in the range "start" to
    David> "end" you must perform a cache writeback and invalidate. To
    David> preserve the data outside of the DMA range.

    Roland> Doesn't this still have a problem if you touch data in the
    Roland> same cache line as the DMA buffer after the pci_map but
    Roland> before the DMA takes place?  The CPU will pull the cache
    Roland> line back in and it might not see the data the DMA brought
    Roland> in.

    Roland> It seems to me that to be totally safe, pci_unmap would
    Roland> have to save the non-aligned part outside the buffer to
    Roland> temporary storage, do an invalidate, and then copy back
    Roland> the non-aligned part.

Replying to myself....  Anyway, I realized that even my idea above is
wrong.  I don't see _any_ safe way to share a cache line between a DMA
buffer and other data.  Access to the cache line might pull the cache
line back in and write it back at any time, which could corrupt the
DMA'ed data.  I don't see a way to hide the existence of cache lines
etc. from the driver.

Best,
  Roland
