Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbQLNRyR>; Thu, 14 Dec 2000 12:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbQLNRyI>; Thu, 14 Dec 2000 12:54:08 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:62214 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S130993AbQLNRyD>;
	Thu, 14 Dec 2000 12:54:03 -0500
Date: Thu, 14 Dec 2000 11:24:12 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: David_Feuer@brown.edu
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <Pine.LNX.4.21.0012141121360.26708-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >that is not transparently hidden to the user.  Why can't I just open
> >/dev/net0 and get the first network device?  Because we have so many
> >inconsistent, poorly design, inextensible interfaces laying around, thats
> >why.

> This is a bad example, but a (perhaps?) good point.  It seems it should be 
> possible to implement an unlimited number of TCP/IP devices, each 

Part of my argument is that although every kernel interface boils down to
something as simple as ioctl (where you have lots of api's multiplexed
onto one data sink, int 0x80 is another example, kORBit is another), some
ways of doing this multiplexing are better than others.  I look at it as a
hierarchy:

1. CORBA/kORBit
2. int 80/lcall
3. ioctl

Each level is more structured than those below it.  Each interface is also
"cleaner" than those below it.  I don't think that anyone would argue that
we should replace int 80 and friends with an interface in the spirit of
ioctl (even though it would be functionally identical).

> representing a connection, and each connected, disconnected, etc. by 
> ioctls...  Of course, I could be way wrong about this....

ioctl's... they come up again.  Everytime that I look at the beautiful,
clean, abstract interface that Unix exposes... it makes me happy.  But
unfortunately, if you look closer, you realize that the Unix API isn't
really clean or nice at all... there is this dumping ground for odds and
ends that don't fit into the standard model.  So when you show someone the
standard model, it looks clean and pretty... but someone always forgets to
mention ioctl.

I would claim that ioctl is one of the biggest reasons that kORBit needs
to exist.  See below.

> >I can't do ls /dev/*net* and get all the network
> >devices either.  Actually, one of the very cool things about CORBA is that

> Different network devices are _very_ different...  You can't broadcast on a 
> modem, for instance, nor can you use promiscuous mode on a modem... You 
> also can't do byte-by-byte raw mode on an ethernet...

Precisely.  But they do all have very common interfaces.  For example, the
standard network interface would probably have "transmit/receive
block" and "getstatus" commands.  This does not mean that they cannot
implement other interfaces, however.

Imagine this situation for writing your packet sniffer:

1. You open up /dev/net0 and get the Network interface
2. You query the network interface to see if it has an implementation
   of the promiscuous interface.
3. If not, you bail, because it doesn't support it.
4. If, you go ahead and use it.

Contrast that to:

1. Survey all the different interfaces that are known (at development time
   of course) to have promiscuous interfaces.
2. Find out which ones are active.
3. Depending on what kind of interface it is, load a library that can
   understand the byte format comming off the device.
4. Use that library.

The problems with the second (currently used) approach is that the
APPLICATION writer has to keep up with new hardware developments and new
interfaces.  They have to understand and code parsers for the bytestreams
coming from each device, which (as you mentioned) are all different,
because they all support different (although overlapping) extensions.

All of these calls that currently get dumped into ioctl (because they are
not important enough to warrant an API function at the top level) suddenly
become well structure and well designed interfaces.  For example, if your
device doesn't support the terminal handling ioctls the system has to
basically figure that out and report errors on it.  With CORBA/kORBit, you
would just not implement that interface... so if someone asked for it,
they would get a null pointer to the interface, which they check for and
realize that it's impossible to do terminal stuff on.

isatty (an example of an IOCTL wrapper) suddenly becomes implicit and the
API is cleaner...

I have no problem with the "unix way", but I do think that it can be
augmented in some ways...

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/










-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
