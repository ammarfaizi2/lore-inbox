Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423837AbWLBMgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423837AbWLBMgx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 07:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423819AbWLBMgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 07:36:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60370 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1423801AbWLBMgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 07:36:52 -0500
Date: Sat, 2 Dec 2006 12:36:53 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Berlin <dberlin@dberlin.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061202123653.GH3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk> <4aca3dc20612012229l18a3c5ebsdc5ee63ef7cf9240@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aca3dc20612012229l18a3c5ebsdc5ee63ef7cf9240@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 01:29:32AM -0500, Daniel Berlin wrote:
> >While that is safe (modulo the portability constraint that affects much
> >more code than just timers), it ends up very inconvenient and leads to
> >lousy type safety.
> 
> Understandable.  I assume you are trying to get more  type safety more
> for error checking than optimization, being that the kernel still
> defaults to -fno-strict-aliasing.

Indeed.

> >Again, that's not a portable C, even leaving aside the use of typeof.
> >Casts between the incompatible function types are undefined behaviour;
> >rationale is that we might have different calling conventions for those.
> >However, here we are at much safer ground; calling conventions are not
> >likely to change if you replace a pointer to object with void *.
                                                ^^^^^^
> Is this true of the ports you guys support  even if the object is a
> function pointer or a function?
> (Though the first case may be insane.  I can't think of a *good*
> reason you'd pass a pointer to a function pointer to a timer
> callback,).

Pointer to pointer to function should be OK - it's a pointer to normal
object type and I would be very surprised if it differed from void *,
modulo very creative reading of 6.3.2.3(1).  I certainly wouldn't expect
it to differ from e.g. pointer to pointer to struct, even on targets
far odder than anything we might hope to port to.

Pointer to function might be worse, but that's excluded by the above -
it's not a pointer to object type.

In any case, we don't do either anywhere and if the need ever arises
we can simply put that pointer into whatever structure our timer_list
is embedded into and pass the address of that structure (which is what
we do in a lot of cases anyway).

IOW, it's worth checking in SETUP_TIMER, but it's not going to be a
realistic PITA in any instance.

> >IOW, "gcc would ICE if it ever inlined it" kind of arguments (i.e. what
> >had triggered gcc refusing to do direct call via such cast) doesn't apply
> >here.  Question to gcc folks: can we expect no problems with the approach
> >above, provided that calling conventions are the same for passing void *
> >and pointers to objects?  No versions (including current 4.3 snapshots)
> >create any problems here...
> 
> Personally, as someone who works on the pointer and alias analysis,
> I'm much more worried about your casting of void (*)(void) to void
> (*)(unsigned long) breaking in the future than I am about the above.

That one will be gone; it's pure laziness and IMO ~10 instances mostly in
weird ancient cdrom drivers are not worth worrying about, especially since
getting rid of such crap is a matter of minutes.

> I can't really see the above code breaking any more than what you have
> now, and it should in fact, break a lot less.  However, the removal of
> the argument cast (IE void (*) (void) to void (*) unsigned long) maybe
> break eventually.  As we get into intermodule analysis and figure out
> the conservative set of called functions for a random function
> pointer,  the typical thing to do is to type filter the set so only
> those address taken functions with "compatible"  signatures (for some
> very loose definition of compatible) are said to be callable by a
> given function pointer.  I can't imagine the definition of compatible
> would include address taken functions with less arguments than the
> function pointer you are calling through.  In this specific case, as
> you point out, it's pretty unlikely we'll ever be able to come up with
> a set without something telling us.  But I figured i'd mention it in
> case this type of casting is prevalent elsewhere.

Umm...  That type of casting worries me too, and not for timer-related
reasons.  We do it a lot in one place: fs/bad_inode.c.  A bunch of methods
with different arguments,
static int return_EIO(void)
{
        return -EIO;
}
and (void *)return_EIO used to initialize them.  There's a couple of
other places where minor turds like that are done, but that one is
the most massive.  That's bloody annoying when doing any global call
graph analysis (sparse-based in my case, but I wouldn't expect gcc
folks being any happier with it)...

And no, it certainly isn't good C for many reasons (any target where
callee removes arguments from stack before returning control to caller
and that one's toast, for starters).
 
> IOW, unless someone else can see a good reason, I see no reason for
> you guys not to switch.
