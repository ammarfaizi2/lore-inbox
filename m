Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSFLWu5>; Wed, 12 Jun 2002 18:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317353AbSFLWu4>; Wed, 12 Jun 2002 18:50:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54485 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317352AbSFLWuz>;
	Wed, 12 Jun 2002 18:50:55 -0400
Date: Wed, 12 Jun 2002 15:46:28 -0700 (PDT)
Message-Id: <20020612.154628.65960832.davem@redhat.com>
To: david-b@pacbell.net
Cc: roland@topspin.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D079D44.4000701@pacbell.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Brownell <david-b@pacbell.net>
   Date: Wed, 12 Jun 2002 12:13:08 -0700

   > The current USB driver design seems pretty reasonable: only the HCD
   > drivers need to know about DMA mappings, and other USB drivers just
   > pass buffer addresses.  I don't think you would get much support for
   > forcing every driver to handle its own DMA mapping.
   
   Me either.  But I suspect that it'd be good to have that as an option;
   maybe just add a transfer_dma field to the URB, and have the HCD use
   that, instead of creating a mapping, when transfer_buffer is null.
   That'd certainly be a better approach for supporting sglist in the
   usb-storage code than the alternatives I've heard so far.

Another solution for the "small chunks" issue is to in fact keep all
of the real DMA buffers in the host controller driver.  Ie. a pool
of tiny consitent DMA memory bounce buffers.  That is an idea for 
discussion, I have no particular preference.

This could actually improve performance for things like the input
layer USB drivers.  On several systems multiple cache lines are
fetched when a keyboard key is typed, and this is because we use
streaming buffers instead of consistent ones for these transfers.

We have two problems we want to solve, the DMA alignment stuff and
using consistent memory for these small buffers.  Therefore moving to
consistent memory (by whatever mechanism the USB desires to implement
this) is the way to go.
