Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTIABOi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTIABOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:14:36 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:65413 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262567AbTIABNf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:13:35 -0400
Date: Sun, 31 Aug 2003 18:13:34 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0308311742420.2043@twinlark.arctic.org>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003, Jamie Lokier wrote:

> I already got a surprise (to me): my Athlon MP is much slower
> accessing multiple mappings which are within 32k of each other, than
> mappings which are further apart, although it is coherent.  The L1
> data cache is 64k.  (The explanation is easy: virtually indexed,
> physically tagged cache moves data among cache lines, possibly via L2).

opteron has 64KiB / 2-way L1 which means 15-bits of indexing... which
totally predicts the 32KiB spacing i saw someone else post about.

tm8000 also has some virtual aliasing and your test detects it properly...
but i'm probably not supposed to say anything about that :)

there's a real oddity i found on p4 just yesterday.  i was doing some
pointer-chasing experiments, and i set up two 8192B shared mappings to the
same file, for example:

0x50000000 => /var/tmp/foo offset 0
0x50002000 => /var/tmp/foo offset 0

then i set up a 4 element cycle:

0x50000000 => 0x50001004 => 0x50002008 => 0x5000300c => 0x50000000

when i do this it seems to trip up a p4 badly ... i'm seeing 3000 cycles
per load on a 2.4GHz p4, and 300 cycles per load on a 2.4GHz xeon.  the
crazy thing is that small variations in the experiment (such as longer
cycles) make the oddity go away!

i've placed my hack here <http://arctic.org/~dean/noah/chase.c>.


> This suggests scope for improving x86 kernel performance in the areas
> of kmap() and shared library / executable mappings, by good choice of
> _virtual_ addresses.  This doesn't require a cache colouring
> page allocator, so maybe it's a new avenue?

i was trying to use wli's pgcl patch to test out larger clustering, but it
still has some perf problems which i never got enough time to dig into
further :)  this approach might be better than just colouring.

here's what i've found tripping up virtual aliasing on processors which
have this "feature":

- shared use empty_zero_page trips up virtual aliasing for things like BSS
  -- especially if the program for some reason doesn't typically have to
  write before reading.  this is pretty easy to fix (there's even an
  example fix in the mips architecture, i believe R4000 or something)

- kernel and user mappings differ in the virtual index bits.  this means
  CoW will trip up virtual aliases amongst other things.  i imagine it
  means network checksum calculation on write(2) data will trip up virtual
  aliases.  this is more of a pain to fix in a way which is nice on SMP.

- physical pages change their virtual index bits each alloc/free.

mind you overall i'm not sure that i'm seeing any perf loss due to this
sort of thing...

-dean
