Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbTI2PWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263559AbTI2PWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:22:42 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:54144 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263555AbTI2PWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:22:17 -0400
Date: Mon, 29 Sep 2003 16:22:20 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309291522.h8TFMKn0001184@81-2-122-30.bradfords.org.uk>
To: Rob Landley <rob@landley.net>, Larry McVoy <lm@bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309290730.52631.rob@landley.net>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
 <200309290356.27600.rob@landley.net>
 <200309291124.h8TBOlam000872@81-2-122-30.bradfords.org.uk>
 <200309290730.52631.rob@landley.net>
Subject: Re: log-buf-len dynamic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > BK is really just a merging tool that fixes rejects
> > > automatically, everything else is details...
> >
> > IFF that is true, then taking this to it's logical extreme, what is
> > the point in having an SCM system for kernel development at all?
> >
> > It could be argued that what we really need is enhanced versions of
> > diff and patch that actually understand C constructs and are able to
> > make intellegent decisions about merging two pieces of code, even
> > without knowledge of other merges.
> 
> But you can't always make intelligent merging decisions without knowledge 
> about other merges.
> 
> Suppose that tree 1 has a line "x=function(3*yy)+2", and tree 2 has the 
> corresponding line "x=fred+1".  Your only merge choice is to pick one or the 
> other.  You as a fully intelligent human being have no other choice unless 
> you're writing fresh code.

Of course not, if you have absolutely no context whatsoever.  I'm
certainly not going to argue against that.

> Now let's look at the patch history back to where the two trees diverged from:
> 
> Patch series:
> 
> original line:
> 	x=yy+1;
> 
> Patch 1:
> -	x=yy+1;
> +	x=function(3*yy)+2;
> 
> Patch 2:
> -	x=yy+1;
> +	x=fred+1;
> 
> Looking at this, you can see that the result you probably want is 
> "x=function(3*fred)+2;", but you couldn't figure that out until you'd see the 
> original line they both diverged from.

Again, I'm not arguing against that - of course you need some context,
but you don't need a complete revision history.  See [1] below.

Obviously in your example, the complete revision history and the
context of the patch are the same thing, as there is only one
generation of revision in each case.  So, you're saying that you need
the patch history, well yes, you do, one generation of it.  That's
obvious.  What I am saying is that when there are 2 or more
generations of revision history, if an improvement happens between any
two, you should only need those two, and no others, to apply that
particular improvement another tree.  See [2] below.

>  One tree probably had s/yy/fred/ 
> applied to it, and the other tweaked the algorithm, thus the merges conflict 
> going either way.
> 
> But if the original line had instead been "x=fred+2;", the logical merge would 
> instead be "x=function(3*yy)+1;". 
> 
> Original line:
> 	x=fred+2;
> 
> Patch 1:
> -	x=fred+2;
> +	x=function(3*yy)+2;
> 
> Patch 2:
> -	x=fred+2;
> +	x=fred+1;
> 
> Logical merge: "x=function(3*yy)+1;"

That's not logical at all.  Without any context, I don't think that
you can draw a meaningful conclusion at all.

> You CANNOT KNOW THIS until you see the common ancestor they diverged from.  
> There just isn't enough information to work it out, unless you do so from 
> first principles by actually comprehending the algorithm being implemented 
> and what the changes are trying to accomplish.
> 
> That's why bitkeeper has to remember all the past changes to do its job of 
> merging new ones.

Maybe I don't really understand how Bit Keeper works.

Imagine that somebody had a tree with the following revisions:

A1-A2-A3-A4-A5-A6

and somebody creates a patch against A1:

A1-A2-A3-A4-A5-A6
|
|
B1

then the owner of the A tree merges in B1 with A6:

A1-A2-A3-A4-A5-A6
|              |
|              V
|              A7
|              ^
|              |
B1-------------/

[1]

Does Bit Keeper need to refer to A1, A2, A3, A4, A5, and A6 to do this
merge?

[2] It's relatively easy to create A7 by looking at A1->B1, and then
looking at A1->A2->A3->A4->A5->A6.

[3] It's an order of magnitude more difficult to create A7 by looking
at the patch of B1 against A1, and then applying the fundamental
changes that that patch introduced in to A6.

Can Bit Keeper do this?

Now, for this simple example, it's easy to say, "Ah, but a certain
amount of guesswork is involved when doing [3], but with [2], the
changes are much more likely to be correct, because they've been
followed through all of the revisions".  For simple examples, maybe
that would be correct.  When there are hundreds of people merging in
to one tree, I don't see how you can follow each change through,
unless you do have a complete revision history.  I am suggesting that
that is inefficient, and not scalable.

> > 'Enhanced' is, of course, a complete understatement.  What I am
> > suggesting is basicaly adding A.I. functionality to diff and patch, to
> > the point where they can merge three pieces of C code as efficiently
> > as a good developer can.
> 
> If you've gotten AI working, why not just have it write the code and save us 
> the trouble?

Nice idea.  Shame I haven't got the AI working, eh?

> > This would probably involve analysing code and identifying discrete
> > sections, (analogous to the way a human developer would draw a flow
> > chart), within which the purpose of algorithms and variable names
> > could be deduced.
> 
> You're suggesting making a computer figure out the purpose of something.  
> Uh-huh.  Has this ever happened, even once, in the entire history of 
> computing?

I'm not sure what point you're trying to make.  Analysing the high
level algorithms implemented by functions written in C is certainly
possible.

> > This knowledge could then be used to adapt code
> > that was submitted as a diff against a compltely different piece of
> > code.
> 
> Written in a diferent language, performing a completely different task even...

Again, I'm not sure what point you're trying to make.  High level
algorithms are comparable whatever language they are coded in.

> > Ultimately, it should be possible for two people to independently
> > write code to do a certain task, for one of them to add an extra
> > facility to their codebase, and for the enhanced diff and patch tools
> > to then add this facilty to the other, completely separate,
> > implementation.
> 
> It'd be nice, sure.  I do not know how to implement that.  I don't know 
> anybody who does.  If you do, by all means code it up.  (My guess is you 
> don't understand the scope of the problem, but I could always be wrong....)

If it was a 5 minute job, or even a three month job, I'd work on it.
I'm not interested in spending years working on this project, which is
what I thihnk it would take to develop it.

A possible place to start would be analysing one piece of code for
something simple such as bounds checks, then looking back over the
code to see where the values being checked came from.  Similar checks
could then be added to other code automatically.

John.
