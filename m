Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSE3LqS>; Thu, 30 May 2002 07:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSE3LqR>; Thu, 30 May 2002 07:46:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52151 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316595AbSE3LqQ>;
	Thu, 30 May 2002 07:46:16 -0400
Date: Thu, 30 May 2002 04:30:49 -0700 (PDT)
Message-Id: <20020530.043049.63270720.davem@redhat.com>
To: adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does pci_alloc_consisent really need to zero memory?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200205301141.EAA15864@baldur.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Thu, 30 May 2002 04:41:06 -0700

   	In my efforts to port almost all of the scsi drivers to your
   DMA-mapping interface, I have converted some kmalloc's that
   are frequently called with pci_alloc_consistent (I have not
   submitted these changes, because I think there is an unrelated
   bug in my changes).  Come to think of it, you advised me to go
   that route, as opposed to using pci_map_single(), when I asked about
   it with respect to advansys.c.  I'd like to have as little
   performance penalty for this as possible.  That also makes it
   marginally easier to encourge movement to your DMA-mapping interface.
   
The only advansys.c should be using consistent memory for are
it's command descriptor blocks that it sends to/from the card.
It should allocate these at device probe time, not while SCSI
commands are being issued.

Maybe for rare things like scsi status blocks, but not for normal scsi
command blocks.  Therein lies your problem, nothing to do with
pci_alloc_consistent zero'ing out memory or not.

   	While it is normally good programming practice for
   routines to always return deterministic results (same initial
   values in memory), I think that in a performance-oriented
   software component like the kernel, it's better programming practice
   to have primitives that do no more than they need to, that run as
   fast as possible, and behave consistently (no other remaining memory
   allocators in linux-2.5 do this, right?).
   
pci_alloc_consistent is not defined to go fast, period.  This allows
considerable flexibility in implementation.  On several systems,
setting up consistent mappings are expensive.  There is simply no way
around it.  But that's ok if the drivers aren't using it in hot paths,
which as I describe above they should not.

So trying to "speed up" pci_alloc_consistent is a misguided adventure.

Franks a lot,
David S. Miller
davem@redhat.com
