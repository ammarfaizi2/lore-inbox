Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129905AbQKLDTN>; Sat, 11 Nov 2000 22:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129930AbQKLDTE>; Sat, 11 Nov 2000 22:19:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40693 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129905AbQKLDSs>;
	Sat, 11 Nov 2000 22:18:48 -0500
Date: Sat, 11 Nov 2000 22:18:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_task() and thread_saved_pc() fix for x86
In-Reply-To: <Pine.LNX.4.10.10011111844080.3611-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0011112207230.24250-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Nov 2000, Linus Torvalds wrote:

> On Fri, 10 Nov 2000, Alexander Viro wrote:
> > diff -urN rc11-2/include/asm-i386/processor.h rc11-2-show_task/include/asm-i386/processor.h
> > --- rc11-2/include/asm-i386/processor.h	Fri Nov 10 09:14:04 2000
> > +++ rc11-2-show_task/include/asm-i386/processor.h	Fri Nov 10 16:08:15 2000
> > @@ -412,7 +412,7 @@
> >   */
> >  extern inline unsigned long thread_saved_pc(struct thread_struct *t)
> >  {
> > -	return ((unsigned long *)t->esp)[3];
> > +	return ((unsigned long **)t->esp)[0][1];
> >  }
> 
> The above needs to get verified: it should be something like
> 
> 	unsigned long *ebp = *((unsigned long **)t->esp);
> 
> 	if ((void *) ebp < (void *) t)
> 		return 0;
> 	if ((void *) ebp >= (void *) t + 2*PAGE_SIZE)
> 		return 0;
> 	if (3 & (unsigned long)ebp)
> 		return 0;
> 	return *ebp;
> 
> because otherwise I guarantee that we'll eventually have a bug with a
> invalid pointer reference in the debugging code and that would be bad.

I would probably turn it into
	unsigned long *ebp = *((unsigned long **)t->esp);

	/* Bits 0,1 and 13..31 must be shared with the stack base */
	if (((unsigned long)ebp ^ (unsigned long)t) & ~(2*PAGE_SIZE-4))
		return 0;

	return *ebp;

Comments? Alternative variant: just let schedule() store its return address
in the task_struct. Yeah, it's couple of tacts per schedule(). And much saner
code, without second-guessing the compiler. OTOH, the value is used only
by Alt-SysRq-T, so... Hell knows.
								Cheers,
									Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
