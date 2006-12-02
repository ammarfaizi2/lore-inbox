Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759385AbWLBG3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759385AbWLBG3e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 01:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759397AbWLBG3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 01:29:34 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:39903 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1759385AbWLBG3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 01:29:33 -0500
Message-ID: <4aca3dc20612012229l18a3c5ebsdc5ee63ef7cf9240@mail.gmail.com>
Date: Sat, 2 Dec 2006 01:29:32 -0500
From: "Daniel Berlin" <dberlin@dberlin.org>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [RFC] timers, pointers to functions and type safety
Cc: "Linus Torvalds" <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
In-Reply-To: <20061201172149.GC3078@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061201172149.GC3078@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Al Viro <viro@ftp.linux.org.uk> wrote:
>         There's a bunch of related issues, some kernel, some gcc,
> thus the Cc from hell on that one.
>
> First of all, in theory the timers in kernel are done that way:
>         * they have callback of type void (*)(unsigned long)
>         * they have data to be passed to it - of type unsigned long
>         * callback is called by the code that even in theory has no
> chance whatsoever of inlining the call.
>         * one of the constraints on the targets we can port the kernel
> on is that unsigned long must be uintptr_t.
>
> The last one means that we can pass any pointers to these suckers; just
> cast to unsigned long and cast back in the callback.
>
> While that is safe (modulo the portability constraint that affects much
> more code than just timers), it ends up very inconvenient and leads to
> lousy type safety.

Understandable.  I assume you are trying to get more  type safety more
for error checking than optimization, being that the kernel still
defaults to -fno-strict-aliasing.
>
> The thing is, absolute majority of callbacks really want a pointer to
> some object.  There is a handful of cases where we really want a genuine
> number - not a pointer cast to unsigned long, not an index in array, etc.
> They certainly can be dealt with.  Nearly a thousand of other instances
> definitely want pointers.
>
> Another observation is that quite a few places are playing fast and
> loose with function pointers.  Some are just too lazy and cast
> void (*)(void) to void (*)(unsigned long).

> These, IMO, should stop
> wanking and grow an unused argument.  Not worth the ugliness...
> However, there are other cases, including very interesting
>         timer->function = (void (*)(unsigned long))func;
>         timer->data = (unsigned long)p;
> with func actually being void (void *) and p being void *.
>
> Now, _that_ is definitely not a valid C.  Worse, it doesn't take much
> to come up with realistic architecture that would have different calling
> conventions for those.  Just assume that
>         * there are two groups of registers (A and D)
>         * base address for memory access must be in some A register
>         * both A and D registers can be used for arithmetics
>         * ABI is such that functions with few arguments have them passed
> via A and D registers, with pointers going via A and numbers via D.
> Realistic enough?  I wouldn't be surprised if such beasts actually existed -
> embedded processors influenced by m68k are not particulary rare and picking
> such ABI would make sense for them.
>
> Note that this kind of casts is not just in some obscure code; e.g.
> rpc_init_task() does just that.
>
>
> And that's where it gets interesting.  It would be very nice to get to
> the following situation:
>         * callbacks are void (*)(void *)
>         * data is void *
>         * instances can take void * or pointer to object type
>         * a macro SETUP_TIMER(timer, func, data) sets callback and data
> and checks if func(data) would be valid.
>
> It would be remove a lot of cruft and definitely improve the type safety
> of the entire thing.  It's not hard to do; all it takes [warning: non
> portable C ahead] is
>         typeof(*data) *p = data;
>         timer->function = (void (*)(void *))func;
>         timer->data = (void *)p;
>         (void)(0 && (func(p),0));
>
> Again, that's not a portable C, even leaving aside the use of typeof.
> Casts between the incompatible function types are undefined behaviour;
> rationale is that we might have different calling conventions for those.
> However, here we are at much safer ground; calling conventions are not
> likely to change if you replace a pointer to object with void *.

Is this true of the ports you guys support  even if the object is a
function pointer or a function?
(Though the first case may be insane.  I can't think of a *good*
reason you'd pass a pointer to a function pointer to a timer
callback,).

>  It's
> still possible in theory, but let's face it, we would have far worse
> problems if it ever came to porting to such targets.
>
> Note that here we have absolutely no possibility of eventual call
> ever being inlined, no matter what kind of analysis compiler might
> be doing.

Ah, well, here is where you are kinda wrong, but not for the reason
you are probably thinking of.
> Call happens when kernel/timer.c gets to structure while
> trawling the lists and it simply has no way to tell which callback
> might be there (as the matter of fact, callback can and often does
> come from a module).

Right, it doesn't know what it will *always* be, but it may add if's
and inline *possible* target sites based on profile results.

Particularly since the profile will tell us which are *actually* called.
This shouldn't matter however, we still shouldn't ICE if we inline it :)
>
> IOW, "gcc would ICE if it ever inlined it" kind of arguments (i.e. what
> had triggered gcc refusing to do direct call via such cast) doesn't apply
> here.  Question to gcc folks: can we expect no problems with the approach
> above, provided that calling conventions are the same for passing void *
> and pointers to objects?  No versions (including current 4.3 snapshots)
> create any problems here...

Personally, as someone who works on the pointer and alias analysis,
I'm much more worried about your casting of void (*)(void) to void
(*)(unsigned long) breaking in the future than I am about the above.

I can't really see the above code breaking any more than what you have
now, and it should in fact, break a lot less.  However, the removal of
the argument cast (IE void (*) (void) to void (*) unsigned long) maybe
 break eventually.  As we get into intermodule analysis and figure out
the conservative set of called functions for a random function
pointer,  the typical thing to do is to type filter the set so only
those address taken functions with "compatible"  signatures (for some
very loose definition of compatible) are said to be callable by a
given function pointer.  I can't imagine the definition of compatible
would include address taken functions with less arguments than the
function pointer you are calling through.  In this specific case, as
you point out, it's pretty unlikely we'll ever be able to come up with
a set without something telling us.  But I figured i'd mention it in
case this type of casting is prevalent elsewhere.

IOW, unless someone else can see a good reason, I see no reason for
you guys not to switch.

--Dan
