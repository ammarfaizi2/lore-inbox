Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289371AbSAOC7K>; Mon, 14 Jan 2002 21:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289370AbSAOC7A>; Mon, 14 Jan 2002 21:59:00 -0500
Received: from science.horizon.com ([192.35.100.1]:49974 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S289376AbSAOC6p>; Mon, 14 Jan 2002 21:58:45 -0500
Date: 15 Jan 2002 02:58:40 -0000
Message-ID: <20020115025840.11509.qmail@science.horizon.com>
From: peter@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't mind how people do it, but there are currently two significant
penalties associated with modules on x86.  I think other architectures
have analogues.

1) The main kernel is contiguous in physical memory and is mapped with
   large (4 MB) pages.  This reduces pressure on the TLB.  Modules are
   loaded in vmalloc memory, which uses small pages, and therefore
   competes for TLB space.  This is a performance penalty, especially
   as most current machines have undersized TLBs already.  (A 64-entry
   TLB with 4K pages maps 256K at a time.  On-chip L2 caches are this
   large or larger.  Thus, as a crude approximation, every L2 miss also
   causes a TLB miss.)

   Also, vmalloc space is limited, and contributes to the "why isn't
   the kernel seeing all of my 1 GB?" question.

2) Space for module code is allocated in page units.  Thus, each module
   wastes an average of 2K.  If I'm going to have dozens of modules
   loaded, small machines are going to notice.


On a related subject, I'd like a kernel image to consist of a series
of concatenated "chunks".  The first one is the kernel proper, and then
come various modules and initrd image(s).  (There may be an "EOF" chunk,
or just the absence of a magic number.)

All the boot loader has to do is copy the image into contiguous memory
and jump to it.  The start of the image (ideally, it'd be PIC) then
relocates itself to wherever it wants and starts assembling the pieces.

Whether this is done by a sort of linker before the kernel boots, or
if the chunks are all ramdisk components and form a userland that the
kernel boots to which assemble the rest of the kernel is not particularly
important.  I just want the unnecessary bits to get thrown away once
we've booted.  (Kernel bloat should NOT be designed in.)

That would make assembling a custom boot image simple enough for a fancy
boot loader (or fancy tftp server) to do.
