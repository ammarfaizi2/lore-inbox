Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132132AbQLNG2t>; Thu, 14 Dec 2000 01:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132193AbQLNG2j>; Thu, 14 Dec 2000 01:28:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16859 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132132AbQLNG2b>;
	Thu, 14 Dec 2000 01:28:31 -0500
Date: Thu, 14 Dec 2000 00:56:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Lattner <sabre@nondot.org>
cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012132250030.25033-100000@www.nondot.org>
Message-ID: <Pine.GSO.4.21.0012140018120.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chris Lattner wrote:

> > OK, now I'm completely confused. 
> > 	* which complex data structures do you want to export from the kernel
> > in non-opaque way? 
> > 	* which of those structures are guaranteed to remain unchanged?
> > 	* if you have userland-to-userland RPC in mind - why put anything
> > marshalling-related into the kernel?
> 
> Okay, I think I did my best to completely confuse you.  :)  #1: CORBA
> objects _are_ opaque.  #2 is irrelevant due to #1.   #3: userland->userland 
> is not the interesting part.  We want kernel->userland or user->kernel, as
> the common (ie fast) case, but we also want to do client->client or
> kernel->kernel without anything breaking.
 
> > ints and received a bunch of doubles... You either need to decide on
> > rounding (and it's a non-obvious question) or you need to change quite a
> > bit of code in your program. It goes way past the demarshalling, no
> > matter whether you use CORBA, 9P or printf/scanf.
> 
> NO.  You want leagacy program to "just get" rounded ints, and new programs
> to get the "full precision" of the floating point #'s.

What rounded ints? Rounded to zero? To nearest integer? To plus or minus
infinity? Does program have something to say here?

> Original interface for the mouse:
> 
> interface mouse {
>  void getPosition(out long X, out long Y);
> };
> 
> So if you get the mouse interface in CORBA (which is an opaque object),
> you get back something that you can make requests to, and, for example,
> get the coordinate the mouse is currently at.  Okay, that's fine, 15 years
> later and after much legacy software has been developed, company X
> develops a new high precions floating point mouse.  Well crap, don't want
> to change the interface.  Now instead of getting that, you get the
> "mouse2" or "floaty mouse" interface (for sake of argument suppose that
> we actually did want to use FP arithmetic in the kernel, that's an
> artifact of a bad example, not a bad point :):
>
> interface floatymouse : extends mouse {
>   void getFloatyPosition(out float X, out float Y);
> }
> 
> Now people that get the "/dev/mouse" interface get a floatymouse.  Does
> this break all that leagacy mouse wielding code?  No, because we used
> inheritance, the floatymouse is a superset of the mouse, and the original
> interface still works.  The server/kernel side of the floaty mouse just
> chops off the decimal places when you use the getPosition method.  

Oh, great. So we don't have to care about formatting changes. We just
have to care about the data changes. IOW, we are shielded from the
results of changes that should never happen in the first place. And the
benefit being...?

Notice that we could equally well add /dev/floatymouse and everything that
worked with old API would keep working. The only programs that would need
to know about floats would be ones that would... need to know about floats
since they want to work with them.

Notice also that I can say ls /dev/*mouse* and get some idea of the files
there. I can't do that for your interfaces.

The point being: if your program spends efforts on marshalling it would
better _do_ something with the obtained data. And then we are back to
the square 1.

Returning to your example, I could not tee(1) the stream into file for
later analysis. Not unless I write a special-case program for intercepting
that stuff. I don't see why it is a good thing.

I also don't see where the need in new system calls (or ioctls, same shit)
comes from. Notice that your way is much closer to new system call than
read()/write() of the right stuff.

As for the proc/meminfo... What would you do to a userland programmer who
had defined a structure like that? Let's see: way too large, ugly as hell,
many fields are almost guaranteed to become meaningless at later point...
It was not designed, it got accreted. And that's very mild description -
judging by results it might as well be s/ac/ex/.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
