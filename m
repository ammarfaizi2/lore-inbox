Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135824AbRDTIYN>; Fri, 20 Apr 2001 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135826AbRDTIYB>; Fri, 20 Apr 2001 04:24:01 -0400
Received: from t2.redhat.com ([199.183.24.243]:5364 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S135824AbRDTIXs>; Fri, 20 Apr 2001 04:23:48 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dhowells@redhat.com, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [andrea@suse.de: Re: generic rwsem [Re: Alpha "process table hang"]] 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Thu, 19 Apr 2001 23:23:15 PDT." <Pine.LNX.4.31.0104192315480.4357-100000@penguin.transmeta.com> 
Date: Fri, 20 Apr 2001 09:23:47 +0100
Message-ID: <24526.987755027@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
> I think Andrea is right. Although this file seems to be entirely
> old-fashioned and should never be used, right?

I presume you're talking about "include/asm-i386/rwsem-spin.h"... If so,
Andrea is right, there is a bug in it (repeated a number of times), though why
the tests succeeded, I'm not sure.

The file should only be used for the 80386 and maybe early 80486's where
CMPXCHG doesn't work properly, everything above that can use the XADD
implementation.

> Also, I _really_ don't see why the code is inlined at all (in the real
> <linux/rwsem-spinlock.h>. It shouldn't be. It should be a real function
> call, and all be done inside lib/rwsem.c inside a
> 
> 	#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
> 
> or whatever.

Andrea seems to have changed his mind on the non-inlining in the generic case.

But if you want it totally non-inline, then that can be done. However, whilst
developing it, I did notice that that slowed things down, hence why I wanted
it kept in line.

I have some ideas on how to improve efficiency in that one anyway, based on
some a comment from Alan Cox.

> Please either set me straight, or send me a patch to remove
> asm-i386/rwsem-spin.h and fix up linux/rwsem-spinlock.h. Ok?

I think there are two seperate issues here:

  (1) asm-i386/rwsem-spin.h is wrong, and can probably be replaced with the
      generic spinlock implementation without inconveniencing people much.
      (though someone has commented that they'd want this to be inline as
       cycles are precious on the slow 80386).

  (2) "fix up linux/rwsem-spinlock.h": do you want the whole generic spinlock
      implementation made non-inline then?

David
