Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132534AbQLNFa6>; Thu, 14 Dec 2000 00:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132051AbQLNFas>; Thu, 14 Dec 2000 00:30:48 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:33798 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S131555AbQLNFa2>;
	Thu, 14 Dec 2000 00:30:28 -0500
Date: Wed, 13 Dec 2000 23:00:34 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012132334050.6300-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012132250030.25033-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, now I'm completely confused. 
> 	* which complex data structures do you want to export from the kernel
> in non-opaque way? 
> 	* which of those structures are guaranteed to remain unchanged?
> 	* if you have userland-to-userland RPC in mind - why put anything
> marshalling-related into the kernel?

Okay, I think I did my best to completely confuse you.  :)  #1: CORBA
objects _are_ opaque.  #2 is irrelevant due to #1.   #3: userland->userland 
is not the interesting part.  We want kernel->userland or user->kernel, as
the common (ie fast) case, but we also want to do client->client or
kernel->kernel without anything breaking.

> > /dev/mouse for example.  Combine that with the problem that /dev/mouse
> > might change format in the future (okay stupid example, but you get the
> > idea) to use floating point coordinates, and things certainly get hairy.

> HUH? OK, suppose it had happened. Do you really expect that you will not
> need to change your applications? I mean, if you expected a bunch of

YES.  You should not have to change your apps at all.

> ints and received a bunch of doubles... You either need to decide on
> rounding (and it's a non-obvious question) or you need to change quite a
> bit of code in your program. It goes way past the demarshalling, no
> matter whether you use CORBA, 9P or printf/scanf.

NO.  You want leagacy program to "just get" rounded ints, and new programs
to get the "full precision" of the floating point #'s.

> OK, suppose you have a CORBA-based system and mouse drivers' API had been
> changed - they really want to return floating point coordinates. How will
> CORBA help you? Aside of making your programs scream aloud, that is.

Okay, maybe this isn't a terrible example afterall.  :)  Consider this
theoretical API for a mouse, that I'm certainly not saying is wonderful or
perfect, just consider it to be an example (on the fly), and no it
doesn't let you poll for mouse activity, this is just off the cuff:

Original interface for the mouse:

interface mouse {
 void getPosition(out long X, out long Y);
};

So if you get the mouse interface in CORBA (which is an opaque object),
you get back something that you can make requests to, and, for example,
get the coordinate the mouse is currently at.  Okay, that's fine, 15 years
later and after much legacy software has been developed, company X
develops a new high precions floating point mouse.  Well crap, don't want
to change the interface.  Now instead of getting that, you get the
"mouse2" or "floaty mouse" interface (for sake of argument suppose that
we actually did want to use FP arithmetic in the kernel, that's an
artifact of a bad example, not a bad point :):

interface floatymouse : extends mouse {
  void getFloatyPosition(out float X, out float Y);
}

Now people that get the "/dev/mouse" interface get a floatymouse.  Does
this break all that leagacy mouse wielding code?  No, because we used
inheritance, the floatymouse is a superset of the mouse, and the original
interface still works.  The server/kernel side of the floaty mouse just
chops off the decimal places when you use the getPosition method.  

This is the kind of stuff that I'm talking about.  The concept that a
mouse is more than a byte stream... that there is actual structure that
must be understood before a datastream can be used.

Yes, I am very aware that there are other ways of doing this, but CORBA is
a very general & powerful system that is also quite mature (unlike
kORBit.  ;)

I hope this helps clarify what the heck I'm talking about.  :)

-Chris

btw, just imagine how much cleaner the mount interface could be... ;)

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
