Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSAPSUq>; Wed, 16 Jan 2002 13:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSAPSUg>; Wed, 16 Jan 2002 13:20:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285829AbSAPSUY>; Wed, 16 Jan 2002 13:20:24 -0500
Date: Wed, 16 Jan 2002 10:19:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pte-highmem-5
In-Reply-To: <20020116185814.I22791@athlon.random>
Message-ID: <Pine.LNX.4.33.0201161008270.2112-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Btw, some suggestions:

 - why have those ugly special cases for bootup defines. kmap() is a no-op
   on 1:1 pages, so all those "arch/i386/mm/init.c" games are totally
   unnecessary if you just have the pages in low memory. That gets rid of
   much of it.

 - do the highmem pte bouncing only for CONFIG_X86_PAE: with less then 4GB
   of RAM this doesn't seem to matter all that much (rule of thumb: we
   need about 1% of memory for page tables). Again, this will simplify
   things, as it will make other architectures not have to worry about the
   change.

   (And it's really CONFIG_X86_PAE that makes page tables twice as big, so
   PAE increases the lowmem pressure for two independent reasons: twice as
   much memory in page tables _and_ larger amounts of memory to map).

 - please don't do that "pte_offset_atomic_irq()" have special support in
   the header files: it is _not_ a generic operation, and it is only used
   by the x86 page fault logic. For that reason, I would suggest moving
   all that logic out of the header files, and into i386/mm/fault.c,
   something along the lines of

	pte = pte_offset_nokmap(..)
	addr = kmap_atomic(pte, KM_VMFAULT);

   instead of having special magic logic in the header files.

Other than that it looks fairly straightforward, I think.

		Linus

