Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317564AbSFIGQn>; Sun, 9 Jun 2002 02:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317565AbSFIGQm>; Sun, 9 Jun 2002 02:16:42 -0400
Received: from [209.237.59.50] ([209.237.59.50]:51908 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317564AbSFIGQm>; Sun, 9 Jun 2002 02:16:42 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52lm9p9tdz.fsf@topspin.com>
	<20020608.175325.63815788.davem@redhat.com>
	<52d6v19r9n.fsf@topspin.com>
	<20020608.222903.122223122.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 08 Jun 2002 23:16:38 -0700
Message-ID: <528z5p9dtl.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    Roland> Just to make sure I'm reading this correctly, you're
    Roland> saying that as long as a buffer is OK for DMA, it should
    Roland> be OK to use a sub-cache-line chunk as a DMA buffer via
    Roland> pci_map_single(), and accessing the rest of the cache line
    Roland> should be OK at any time before, during and after the DMA.
   
    David> Yes.
   
    Roland> What alternate implementation are you proposing?

    David> For non-cacheline aligned chunks in the range "start" to
    David> "end" you must perform a cache writeback and invalidate. To
    David> preserve the data outside of the DMA range.

Doesn't this still have a problem if you touch data in the same cache
line as the DMA buffer after the pci_map but before the DMA takes
place?  The CPU will pull the cache line back in and it might not see
the data the DMA brought in.

It seems to me that to be totally safe, pci_unmap would have to save
the non-aligned part outside the buffer to temporary storage, do an
invalidate, and then copy back the non-aligned part.

In any case if this is what pci_map is supposed to do then we have to
fix up several architectures at least...

Thanks,
  Roland
