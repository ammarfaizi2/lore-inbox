Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQJaMAm>; Tue, 31 Oct 2000 07:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129522AbQJaMAc>; Tue, 31 Oct 2000 07:00:32 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:18442 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129436AbQJaMAX>; Tue, 31 Oct 2000 07:00:23 -0500
Date: Tue, 31 Oct 2000 05:59:59 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Keith Owens <kaos@ocs.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
Message-ID: <20001031055959.A1041@wire.cadcamlab.org>
In-Reply-To: <11462.972947019@ocs3.ocs-net> <Pine.LNX.4.10.10010301508360.1085-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10010301508360.1085-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 30, 2000 at 03:15:57PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Linus]
> In short, we should _remove_ all traces of stuff like
> 
> 	O_OBJS = $(filter-out $(export-objs), $(obj-y))
> 
> It's wrong.
> 
> We should just have
> 
> 	O_OBJS = $(obj-y)
> 
> which is always right.

This part I agree with..

> And it should make all this FIRST/LAST object file mockery a total
> non-issue, because the whole concept turns out to be completely
> unnecessary.
> 
> Is there anything that makes this more complex than what I've
> outlined above?

One thing.  The main benefit of $(sort), which I haven't heard you
address yet, is to remove duplicate files.  Think about 8390.o, and how
many net drivers require it.  There are two ways to handle this:

  obj-$(CONFIG_WD80x3) += wd.o 8390.o
  obj-$(CONFIG_EL2) += 3c503.o 8390.o
  obj-$(CONFIG_NE2000) += ne.o 8390.o
  obj-$(CONFIG_NE2_MCA) += ne2.o 8390.o
  obj-$(CONFIG_HPLAN) += hp.o 8390.o

and then remove duplicates from $(obj-y) using $(sort)...

...Or do horrible games with 'if' statements and temporary variables
with names like $(NEED_8390) to ensure that it gets included once if
needed and not if not -- thereby pretty much defeating the readability
of the new-style makefiles.

Oh.  There's a third way: ignore the issue and hope users don't feel
the need for both ne.o and wd.o linked into the same kernel.  I do hope
you aren't advocating *that* solution, which unfortunately appears to
be the status quo in drivers/net/Makefile.  I guess solution #2 was
seen as too much trouble there.

The horrible games with 'if' statements have been played in any number
of kernel makefiles and I'd really like to see them go away.

That is the real reason I like LINK_FIRST.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
