Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317493AbSFIB0R>; Sat, 8 Jun 2002 21:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317495AbSFIB0Q>; Sat, 8 Jun 2002 21:26:16 -0400
Received: from [209.237.59.50] ([209.237.59.50]:184 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317493AbSFIB0P>; Sat, 8 Jun 2002 21:26:15 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52vg8ta4ki.fsf@topspin.com>
	<20020608.160300.37239939.davem@redhat.com>
	<52lm9p9tdz.fsf@topspin.com>
	<20020608.175325.63815788.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 08 Jun 2002 18:26:12 -0700
Message-ID: <52d6v19r9n.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    Roland> Or should we leave that usage unless it is observed
    Roland> causing problems (since we almost always get lucky and
    Roland> don't touch the rest of the cache line near the DMA)?
   
    David> I think passing in a 4 byte chunk and assuming the rest of
    David> the cacheline is unmodified is a valid expectation the more
    David> I think about it.

Just to make sure I'm reading this correctly, you're saying that as
long as a buffer is OK for DMA, it should be OK to use a
sub-cache-line chunk as a DMA buffer via pci_map_single(), and
accessing the rest of the cache line should be OK at any time before,
during and after the DMA.

    David> This means what MIPS is doing is wrong.  For partial
    David> cacheline bits it can't do the invalidate thing.

If I understand you, this means non-cache-coherent PPC is wrong as
well -- pci_map_single() goes through consistent_sync() and turns
into:

	case PCI_DMA_FROMDEVICE:	/* invalidate only */
		invalidate_dcache_range(start, end);
		break;

What alternate implementation are you proposing?

Thanks,
  Roland
