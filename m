Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317562AbSFIFcv>; Sun, 9 Jun 2002 01:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317563AbSFIFcu>; Sun, 9 Jun 2002 01:32:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38316 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317562AbSFIFcu>;
	Sun, 9 Jun 2002 01:32:50 -0400
Date: Sat, 08 Jun 2002 22:29:03 -0700 (PDT)
Message-Id: <20020608.222903.122223122.davem@redhat.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52d6v19r9n.fsf@topspin.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 08 Jun 2002 18:26:12 -0700

   Just to make sure I'm reading this correctly, you're saying that as
   long as a buffer is OK for DMA, it should be OK to use a
   sub-cache-line chunk as a DMA buffer via pci_map_single(), and
   accessing the rest of the cache line should be OK at any time before,
   during and after the DMA.
   
Yes.

       David> This means what MIPS is doing is wrong.  For partial
       David> cacheline bits it can't do the invalidate thing.
   
   If I understand you, this means non-cache-coherent PPC is wrong as
   well -- pci_map_single() goes through consistent_sync() and turns
   into:
   
   	case PCI_DMA_FROMDEVICE:	/* invalidate only */
   		invalidate_dcache_range(start, end);
   		break;
   
   What alternate implementation are you proposing?

For non-cacheline aligned chunks in the range "start" to "end" you
must perform a cache writeback and invalidate. To preserve the data
outside of the DMA range.
