Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316593AbSE3LlQ>; Thu, 30 May 2002 07:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSE3LlP>; Thu, 30 May 2002 07:41:15 -0400
Received: from h-64-105-136-78.SNVACAID.covad.net ([64.105.136.78]:56284 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316593AbSE3LlP>; Thu, 30 May 2002 07:41:15 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 30 May 2002 04:41:06 -0700
Message-Id: <200205301141.EAA15864@baldur.yggdrasil.com>
To: davem@redhat.com
Subject: Re: Does pci_alloc_consisent really need to zero memory?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave S. Miller writes:
>pci_alloc_consistent is so rare, I doubt it [clearing the memory it
>returns] matters performance wise.

	In my efforts to port almost all of the scsi drivers to your
DMA-mapping interface, I have converted some kmalloc's that
are frequently called with pci_alloc_consistent (I have not
submitted these changes, because I think there is an unrelated
bug in my changes).  Come to think of it, you advised me to go
that route, as opposed to using pci_map_single(), when I asked about
it with respect to advansys.c.  I'd like to have as little
performance penalty for this as possible.  That also makes it
marginally easier to encourge movement to your DMA-mapping interface.

	While it is normally good programming practice for
routines to always return deterministic results (same initial
values in memory), I think that in a performance-oriented
software component like the kernel, it's better programming practice
to have primitives that do no more than they need to, that run as
fast as possible, and behave consistently (no other remaining memory
allocators in linux-2.5 do this, right?).

	Also as a general practice, I especially would like to
be paranoid about unnecessary memory copying or filling.  I like
to grep for memcpy's and memset's and ask "is this call really
necessary?" Core CPU speed improvements have out pace memory bus
improvements.  Today, a 2GHz CPU and with a 2GB/sec memory channel
(typical new computer) can only sustain clearing 1 byte per CPU
cycle (although much of that can accumulate in a write-behind
cache, but then you've just flushed a lot of your cache
unnecessarily, and that generates some memory traffic, etc.).
Plus, CPU's often execute more than one instruction per cycle,
so each byte might burn the time in which 1.4 instructions
could be executed, and other devices may want that memory
bandwidth too (I/O devices, another CPU, built-in video).

	Maybe if you could point out an example of some
code that actually depends on pci_alloc_consistent return
zeroes, I be able to see what I missed and be able to
track down similar cases.  There are plenty of drivers
that do pci_alloc_consistent and then memset.  So, whichever
way the semantics of pci_alloc_consistent are defined, some
drivers ought to be modified.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
