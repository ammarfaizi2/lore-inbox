Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131740AbQKYUuN>; Sat, 25 Nov 2000 15:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131738AbQKYUuE>; Sat, 25 Nov 2000 15:50:04 -0500
Received: from hera.cwi.nl ([192.16.191.1]:52209 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129387AbQKYUtu>;
        Sat, 25 Nov 2000 15:49:50 -0500
Date: Sat, 25 Nov 2000 21:19:39 +0100
From: Andries Brouwer <aeb@veritas.com>
To: rmk@arm.linux.org.uk, rusty@linuxcare.com.au
Cc: tigran@veritas.com, linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001125211939.A6883@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 11:50:20AM +0000, Russell King wrote:
> Rusty Russell writes:
> > What irritates about these monkey-see-monkey-do patches is that if I
> > initialize a variable to NULL, it's because my code actually relies on
> > it; I don't want that information eliminated.
> 
> What information is lost?  Unless you're working on a really strange
> machine which does not zero bss, the following means the same from the
> codes point of view:
> 
> static int foo = 0;
> static int foo;
> 
> Both are initialised to zero by the time the code sees them for the
> first time.  Therefore there is no difference to the code in its reliance
> on whether foo is zero.  foo will be zero in both cases.
> 
> Also, any good programmer worth their skin should know this, and should
> realise it.  Therefore, there is no information loss

What a strange reaction. If I write

 static int foo;

this means that foo is a variable, local to the present compilation unit,
whose initial value is irrelevant because it will be assigned to before use.
If I write

 static int foo = 0;

this means that the code depends on the initialization.
Indeed, it is customary to write

 int foo = 0;  /* just for gcc */

when the initialization in fact is not necessary.


It is a bad programming habit to depend on this zero initialization.
Indeed, very often, when you have a program that does something
you need to change it so that it does that thing a number of times.
Well, put a for- or while-loop around it. But wait! The second time
through the loop certain variables need to be reinitialized. Which ones?
The ones that were initialized explicitly in your first program.
Make the program into a function in a larger one. Same story.


Saving a byte in the binary image is not very interesting.
Preserving information about the program is important.

I see that this message is cc'ed to Tigran, so let me address him as well.
Tigran, you like to destabilize Linux. I like to stabilize Linux.

If it is your intention to destabilize then you need not read the following.
But let us assume that you try to make a perfect system.

There is the issue of local and global correctness.
A piece of code is locally correct when its correctness can be seen
by just looking at those lines, or that function, or that source file.
A piece of code is globally correct when you need to read the entire kernel
source to convince yourself that all is well.

Often local correctness is obtained by local tests. After reading the entire
kernel source you conclude that these tests are superfluous because they
are satisfied in all cases. And you think it is an improvement to remove
the test. It almost never is. On a fast path, where every cycle counts, yes.
But it is not a good idea to sacrifice local correctness and save five
kernel image bytes, or speed up the mount system call by 0.001%.
Why not? Because you read the entire kernel source of today.
But not that of next week. Somewhere someone changes some code.
The test is gone and the kernel crashes instead of returning an error.

You even like to destabilize when there is no gain in size or speed at all.
It is bad coding practice to use casts. They tell the compiler not to check.
With functions returning (void *) the opposite is true. The compiler cannot
check now, but given a cast, it can. Thus, I wrote a few months ago

> If one just writes
>       foo = kmalloc(n * sizeof(some_type), GFP_x);
> then neither the compiler nor the human eye can check
> easily that things are right, i.e. that foo really is
> a (some_type *). Therefore it is better to write
>       foo = (some_type *) kmalloc(n * sizeof(some_type), GFP_x);

To my surprise you answered

: It is a small thing, Andries, but I still think otherwise than you.
: It is better for code to be smaller than to be slightly more fool-proof.

Please change your mind.

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
