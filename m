Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbTALWk0>; Sun, 12 Jan 2003 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267599AbTALWk0>; Sun, 12 Jan 2003 17:40:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:18693 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S267588AbTALWkN>;
	Sun, 12 Jan 2003 17:40:13 -0500
Date: Sun, 12 Jan 2003 23:48:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Rob Wilkens <robw@optonline.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*? -> goto example
Message-ID: <20030112224829.GA29534@alpha.home.local>
References: <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com> <1042404503.1208.95.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042404503.1208.95.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Sun, Jan 12, 2003 at 03:48:24PM -0500, Rob Wilkens wrote:
[...] 
> > For example, it is quite common to have conditionals THAT DO NOT NEST.
> 
> Could someone (Linus, I know your busy, so I won't ask you -- in fact,
> I'm amazed you'd bother to write to _me_ at all) please point me to
> sample code that illustrates this.  I'm trying to envision "conditionals
> that do not nest that need goto".  As near as I can tell, there must be
> some condition that the goto nests all the conditions in otherwise the
> goto wouldn't be needed.  In some cases, Maybe what's between the goto
> and whats gone to should be broken up into a new function (modularized)
> and called independently of function that the goto was in.

Look at any tree walking function or macro. Try to write an efficient one
yourself, with lots of time the same tests and code to walk left, right, up or
down. Always the same thing : just move pointers around and go on to the loop.
Of course you can write it in your "clear structured" code, but I bet many
people won't understand it because of the multiple nested tests. But a simple
goto in each if statement to go to a common place is far cleaner. It's about
the same as the final instruction in the for loop.
 
> As someone else pointed out, it's provable that goto isn't needed, and
> given that C is a minimalist language, I'm not sure why it was included.

Of course it's provable. Anyway, any algorithm can also be written with a
very complex S-K program ! But if you'd know how a processor works, you'd
understand the evidence : about 1/5 of instructions is a branch (goto). The
basics of computing are test, set and branch. Your while, for, if ... all
do a mix of these. Why do you want to put the branch as a special case ? it's
as much needed as others. And the only instruction which does only branch
without test nor set is goto.

What you do with your methods, is replacing a branch with a set, test then
branch. More efficient ? I don't think so ! More readable ? I don't think so.
Linus is right, you've been brainwashed :-)

In fact, at school, thet tell you not to use goto to force you to learn how to
use useful things such as the while loop. If you had used BASIC in the past,
you'd remember how awful these programs were, not because of all the gotos, but
because since we were never told the beauty of other methods, we simply used
crappy gotos everywhere within left-justified code.
 
> > The Pascal language is a prime example of the latter problem. Because it 
> > doesn't have a "break" statement, loops in (traditional) Pascal end up 
> > often looking like total shit, because you have to add totally arbitrary 
> > logic to say "I'm done now".
> 
> But at least the code is "readable" when you do that.  Sure it's a
> little more work on the part of the programmer.

and the CPU ! Fortunately, Borland added the break and continue statements so
that their compiler could be used to produce good programs.

> But anyone reading the
> code can say "oh, so the loop exits when condition x is met", rather
> than digging through the code looking for any place their might be a
> goto.

I prefer a "goto end_of_loop" than a "end_of_loop=1" followed by nested
"if (!end_of_loop)" for each following blocks ! This way, you focus on
what the code really does and not how the programmer could trick the
compiler to tell the CPU what he wanted to really do.

> -Rob

Now, you asked for an example. Here is one. Please recode it without the
gotos, try to keep it at least as readable, and then bench it !
I'll send you public apologies if you can make it either faster and as
much readable, or as fast and much more readable. (yes, all the code
sits within a for condition, just to allow 'break' within the loop !).
As you see, I don't really mind writing awful primitives if they help
upper levels being much cleaner and efficient.

Cheers,
Willy

#define tree_foreach_destructive(__type, __root, __data, __stack, __slen)               \
    for (__slen = 0, __stack[0] = __root, __data = NULL; ({             \
        __label__ __left, __right, __again, __end;                      \
        typeof(__root) __ptr = __stack[__slen];                         \
__again:                                                                \
        __data = __ptr->data;                                           \
        if (__data != NULL) {                                           \
            __ptr->data = NULL;                                         \
            goto __end;                                                 \
        }                                                               \
        else if (__ptr->left != NULL) {                                 \
            __stack[++__slen] = __ptr = __ptr->left;                    \
            goto __again;                                               \
        }                                                               \
        else                                                            \
__left:                                                                 \
        if (__ptr->right != NULL) {                                     \
            __stack[++__slen] = __ptr = __ptr->right;                   \
            goto __again;                                               \
        }                                                               \
        else                                                            \
__right:                                                                \
        if (!__slen--)                                                  \
            goto __end; /* nothing left, don't delete the root node */  \
        else {                                                          \
            typeof (__root) __old;                                      \
            pool_free(__type, __ptr);                                   \
            __old = __ptr;                                              \
            __ptr = __stack[__slen];                                    \
            if (__ptr->left == __old) {                                 \
                /* unlink this node from its parent */                  \
                __ptr->left = NULL;                                     \
                goto __left;                                            \
            }                                                           \
            else {                                                      \
                /* no need to unlink, the parent will also die */       \
                goto __right;                                           \
            }                                                           \
        }                                                               \
__end:                                                                  \
        (__slen >= 0); /* nothing after loop */}); )


