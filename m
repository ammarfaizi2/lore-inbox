Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317645AbSFLG2r>; Wed, 12 Jun 2002 02:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317646AbSFLG2q>; Wed, 12 Jun 2002 02:28:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4302 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317644AbSFLG2o>;
	Wed, 12 Jun 2002 02:28:44 -0400
Date: Tue, 11 Jun 2002 23:24:30 -0700 (PDT)
Message-Id: <20020611.232430.05228219.davem@redhat.com>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D06E945.7070301@pacbell.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Brownell <david-b@pacbell.net>
   Date: Tue, 11 Jun 2002 23:25:09 -0700

   I'd suspect ((dma_addr_t)0) would be a reasonable error return.
   At least some hardware treats such values like software would
   treat null pointers.  No call syntax change necessary, which
   might be good or bad depending on how you feel tomorrow.
   
0 is a valid PCI dma address on many platforms.  This is part
of the problem.

   > Remember please that specifically the DMA mapping APIs encourage use
   > of consistent memory for small data objects.  ...
   > ...  The non-consistent end of the APIs is
   > meant for long contiguous buffers, not small chunks.
   
   And in between, a nice huge grey area to play with and argue about!
   
Not gray area, fully intentional!  From the beginning that was meant
to be one of the distinctions between consistent and streaming DMA
memory.

   For that model, I would prefer tools more like a kmalloc than the
   pci_pool, which is most like a kmem_cache_t.  The particular objects
   in question are a bit small to use page-or-bigger allocators, too.
   
Huh?  The whole idea is that it is memory for PCI dma, it has to be
PCI in nature.  If you want a kmalloc'ish thing, simple use
pci_alloc_consistent and carve up the pages you get internally.

   The problem for APIs like USB is that they haven't yet exposed DMA
   addresses.  Doing that, giving folk a choice from the "non-consistent
   end of the APIs", would be a big change.
   
But that is the direction I'd like things to go in.  A lot of problems
have arisen because the USB layer likes to internally let drivers do
DMA on any gob of memory whatsoever.  That has to stop, it really does.
   
   Oh no -- I just had an evil thought.  Now that we have the device model
   code partially in place, shouldn't we have DMA memory calls talk in
   terms of "struct device" not "struct pci_device"?  That'd be the way
   to have _one_ API for dma mapping (and consistent memory allocation),
   working for PCI, USB, and any other bus framework that comes along.
   
Sure, that's the idea.  Just change pci_alloc_consistent to
dev_alloc_consistent whatever.  It's all still the same problem
though.  The USB drivers have to stop DMA'ing to arbitrary little gobs
of memory.

   
