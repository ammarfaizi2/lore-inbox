Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSFLDaM>; Tue, 11 Jun 2002 23:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSFLDaL>; Tue, 11 Jun 2002 23:30:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44492 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317331AbSFLDaH>;
	Tue, 11 Jun 2002 23:30:07 -0400
Date: Tue, 11 Jun 2002 20:25:53 -0700 (PDT)
Message-Id: <20020611.202553.28822742.davem@redhat.com>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D061363.70500@pacbell.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Brownell <david-b@pacbell.net>
   Date: Tue, 11 Jun 2002 08:12:35 -0700
   
   Should the dma mapping APIs try to detect the "DMA buffer starts in
   middle of non-coherent cacheline" case, and fail?  That might be
   worth checking, catching some of these errors, even if it ignores
   the corresponding "ends in middle of non-coherent cacheline" case.
   And it'd handle that "it's a runtime issue on some HW" concern.
   
This brings back another issue, returning failure from pci_map_*()
and friends which currently cannot happen.

   Or then there's David Woodhouse's option (disable caching on those
   pages while the DMA mapping is active) which seems good, except for
   the fact that this issue is most common for buffers that are a lot
   smaller than one page ... so lots of otherwise cacheable data would
   suddenly get very slow. :)
   
Remember please that specifically the DMA mapping APIs encourage use
of consistent memory for small data objects.  It is specifically
because non-consistent DMA accesses to small bits are going to be very
slow (ie. the PCI controller is going to prefetch further cache lines
for no reason, for example).  The non-consistent end of the APIs is
meant for long contiguous buffers, not small chunks.

This is one of the reasons I want to fix this by making people use
either consistent memory or PCI pools (which is consistent memory
too).
