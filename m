Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbVKIAbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbVKIAbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbVKIAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:31:06 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42370 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030469AbVKIAbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:31:04 -0500
Date: Tue, 8 Nov 2005 18:30:48 -0600
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
Message-ID: <20051109003048.GK19593@austin.ibm.com>
References: <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com> <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B68D1F72-F433-4E94-B755-98808482809D@mac.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 06:57:11PM -0500, Kyle Moffett was heard to remark:
> On Nov 8, 2005, at 18:23:27, linas wrote:
> >Off-topic: There's actually a neat little trick in C++ that can  
> >help avoid accidentally passing null pointers.  One can declare  
> >function declarations as:
> >
> >  int func (sturct blah &v) {
> >    v.a ++;
> >    return v.b;
> >  }
> >
> >The ampersand says "pass argument by reference (so as to get arg  
> >passing efficiency) but force coder to write code as if they were  
> >passing by value" As a result, it gets difficult to pass null  
> >pointers (for reasons similar to the difficulty of passing null  
> >pointers in Java (and yes, I loathe Java, sorry to subject you to  
> >that))  Anyway, that's a C++ trick  only; I wish it was in C so I  
> >could experiment more and find out if I like it or hate it.
> 
> That technique tends to cause more problems than it solves.  If I  
> write the following code:
> 
> struct foo the_leftmost_foo = get_leftmost_foo();
> do_some_stuff(the_leftmost_foo);
> 
> How do I know what it is going to do?  

It depends on how do_some_stuff() was declared. If its declared as

   do_some_stuff (struct foo &x)

then it will be a pass by reference.

> A much better solution is this:
> 
> void do_some_stuff(struct foo *the_foo) __attribute__((__nonnull__(1)));

Think of it as "syntactic sugar": the compiler "does the right thing"
without all the grungy extra markup such as __atribute. 

(Remember that at the dawn of time, C++ was just a bunch of pre-processor
markup that did nothing but hide grunge like __attribute__((whatever))
from the programmer. Only later did it become a language. Doing markup
like what you're suggesting is only a tiny step away from inventing a new
language, esp if you come up with some clever, unobtrusive markup for
it.)

> That ensures that the first argument cannot be explicitly passed as  
> null, 

Well, this misses the point. No one intentionally passes null pointers.
Its just that "shit happens". Pass-by-reference changes your coding
style. You tend to alloc on stack instead of malloc.  And then, since
its on stack, you know it would be very wrong to keep a pointer to it, 
and so you don't, you design code differently.  Usually, you discover 
you never really needed to hold a pointer to it anyway; you just did so
out of some ingrained habit.

And since its on stack, you can't leak memory, you don't need to 
reference count it. Much fewer mallocs & frees, so less likely to have
errors there. Better performance, and less memory fragmentation, for
what that's worth.

I dunno, I did this once on a larger, year-long project, and rather
liked it (I otherwise don't much like C++, since people tend to use
it in bad, horrible ways). I won't say this is the greatest 
coding style in the world, but it does change the way you think about 
designing code, mostly for the better.

--linas

