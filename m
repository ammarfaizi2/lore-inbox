Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273448AbRIWNEv>; Sun, 23 Sep 2001 09:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273476AbRIWNEm>; Sun, 23 Sep 2001 09:04:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29026 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273448AbRIWNEc>; Sun, 23 Sep 2001 09:04:32 -0400
To: James McKenzie <kernel@ostrich.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alpha 4K mmap offsets and em86
In-Reply-To: <20010923123042.B32649@hecate.esc.cam.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Sep 2001 06:55:51 -0600
In-Reply-To: <20010923123042.B32649@hecate.esc.cam.ac.uk>
Message-ID: <m1adzm83s8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James McKenzie <kernel@ostrich.dhs.org> writes:

> Hi,
> 
> very sorry if this has been discussed before I couldn't
> find any references in the archive. There is a program
> on the alpha architecture which can (with a little help
> from the kernel) execute ia32 linux binaries it's useful
> if you need to run badly written 32 bit code.
> 
> The emulator needs to mmap elf binaries in, and 
> offsets in ia32 elf files are 4k aligned for a 4k
> pagesize. On 2.2 on an alpha you could do
> mmap(NULL,3176, ... , fd, 0x1000);
> but now in 2.4 but in 2.4 it returns EINVAL.
> 
> The code in mm/mmap.c and vm_area_struct seem to
> now count the offset in pages rather than bytes, 
> which would make fixing this ugly [maybe an element
> in the structure to store 'slop' ?]

Nope.  This change was rather important to simplifying
the page cache, so having slop is not really what we want.  Having
slop is actually a coherency nightmare.

You can do:  mmap(/dev/zero, size) read(binary) if you
really nead that functionality.  Unless you are running
many instances of a program it really shouldn't matter.

Also you can't emulate full x86 semantics whatever you do because you 
don't have 4K granularity.

There are actually processors where it is worse, and you need
something like 64K alignment despite the fact they have 4K pages.
That is needed to avoid conflicts in virtually indexed L1 caches.

Eric
