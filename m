Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131841AbQLNSd6>; Thu, 14 Dec 2000 13:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132284AbQLNSds>; Thu, 14 Dec 2000 13:33:48 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:1031 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S131960AbQLNSdd>;
	Thu, 14 Dec 2000 13:33:33 -0500
Date: Thu, 14 Dec 2000 12:03:42 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012140127060.6300-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012141141010.26883-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Oh, great. So we don't have to care about formatting changes. We just
> > > have to care about the data changes. IOW, we are shielded from the
> > > results of changes that should never happen in the first place. And the
> > > benefit being...?
> > 
> > What the hell are you talking about?  Did you even read my example? I was
> > giving an example of extending an API, adding new functionality to it.
> 
> Yes, I did. What I don't understand is how kernel mechanism for marshalling
> would make your life easier wrt changes.

I gave a very simple example of how an interface could be designed and
then later extended without breaking any user space programs.  Please
reread the example and tell me precisely what doesn't make sense, and I
would be glad to explain it better.

> > > Notice also that I can say ls /dev/*mouse* and get some idea of the files
> > > there. I can't do that for your interfaces.

> > And you know what?  I can't do ls /dev/*net* and get all the network
> > devices either.  Actually, one of the very cool things about CORBA is that
> > you can BROWSE/LIST/SEARCH all objects currently instantiated.  Being
> > able to browse all in kernel objects would be very cool.

> So what's to stop you from letting readdir() do the work? WTF do we need
> one more API for returning the list of objects?

Urm.. that was the point.  You don't add a new API (it's built into corba,
along with introspection).  Also, like I JUST MENTIONED, readdir will have
no way of knowing what is a network device in the quagmire of stuff
floating around in /dev.  (ls *net* does actually call readdir ya
know.  Perhaps you should read up more on unix... [sorry couldn't help
it. ;])

> > > The point being: if your program spends efforts on marshalling it would
> > > better _do_ something with the obtained data. And then we are back to
> > > the square 1.
> > Uh huh, go ahead and read the example I sent to you.
> Did that.

So they you understand that no interface was broken even though more data
is now available...

> > > Returning to your example, I could not tee(1) the stream into file for
> > > later analysis. Not unless I write a special-case program for intercepting
> > > that stuff. I don't see why it is a good thing.

> > On the contrary, it would be pretty easy to do something like that with
> > CORBA.  No you wouldn't be able to use tee, but why would you want to tee
> > a binary data file?  The only reason that tee works in this situation is

> For the same reasons why I use tar, gzip, whatever. I don't _want_ to
> invent a new utility every time when Joe Doe adds a new piece of interface.
> Data is data is data. I can uuencode it and send to somebody who would
> care to analize the bloody thing. Do you mean that I need to write a
> special tool for that? For _every_ member of every interface somebody
> decided to add? I don't think so. I really don't.

That's fine, I don't blame you.  Ya know what?  I even agree with you
(image that?  hehe :).  You seem to forget that a CORBA object is exactly
the same thing: a stream of bytes.  Actually it does better than
that.  It's a stream of bytes that you can introspect on and determine the
structure of.  Imaging this.  You have a bytestream flowing out of some
pipe/device/socket/file/whatever and you pipe it to a
"Decode" program.  The decode program spits this out:

sequence < 
   struct { 
     float
     float
   }>

This example is meant to illustrate that _in a general way_ you can decode
the structure of the bytestream.  (hence my claims about CORBA adding
structure to a standard bytestream)...  this is quite a bit more useful
than trying to figure out what 'cat' is trying to tell you about binary
data (especially if it's floating point numbers).

> > line... your analysis program would have to have special purpose code to
> > parse the file.  EVERY consumer of "mouse data" would have to parse the

> Or I would look at the size. Or I would say od and look at the result. Don't
> tell me what to do with the data, when I'll need to parse it I will. And
> if you expect me to bother with writing more stuff when generic tools would
> work fine - too bad, I've been there, done that and I'm not coming back.

Heh... I'm not trying to replace od or cat or tee or pipes.  What I'm
trying to do is give you a larger toolkit that gives you MORE
power.  Imagine you want to get the first float value (of each struct) of
the above stream.  Imagine a functional scripting language where you could
do this (haskell syntax stolen gratitously):

cat /dev/floatymouse | funcwith 'map fst'

Which you could then point to the "decode" type program mentioned above,
and you would now get:

sequence<float>

> BTW, you cared about size of /dev, didn't you? /usr/bin choke-full of tee-foo,
> tee-bar, yodda, yodda would be better?

You wouldn't have to replace the standard utilities.  Sorry to rain on
your parade.

> > file.  That seems pretty silly to me.
> Difference between good program and bad one: the former gets used in ways
> its authors never thought about...

*cough* see above.

> > > I also don't see where the need in new system calls (or ioctls, same shit)
> > > comes from. Notice that your way is much closer to new system call than
> > > read()/write() of the right stuff.
> > 
> > A new syscall was one example.  It would be very simple to implement this
> > by making _yet_another_ device node in /dev and issue reads and writes to
> > it.  That's more of a syntactic issue than a symantic one.
> 
> No, it isn't. The difference being: letting driver to define a filesystem
> and mounting/exporting it/whatever means that you get to use _all_ _normal_
> _data-agnostic_ _tools_. And believe me, it matters. If you don't understand
> that - no offense, but you don't understand UNIX.

Ouch.

/me digs around and puts on thick skin

Okay, fine.  You want to talk unix.  You proclaim that this beautiful
infalliable API is simple open/close/read/write calls on stanardized
devices, right?  What about ioctl?  What about the HUGE class of crap that
has fallen into ioctl?  You can't run a system without ioctl.  You can't
operate a terminal without ioctl.  What happened to your beautiful
pristine API?  ioctl eats it for breakfast.  What I'm offering is a way of
sorting out all that crap and standardizing it.

What I'm basically claiming here is that any API that lets you call
ioctl(TCXONC) on a socket is broken.  It just means that you have to check
for that error someplace: oh yeah, in the kernel.

> To get this stuff working without excessive PITA you'll need to teach
> userland about the new mechanism. Shells, mailers, archivers, backup, you
> name it. It might be an interesting OS, but it sure as hell wouldn't be
> UNIX and what's worse, it doesn't exist.

I'm sorry for trying to suggest that there are interesting things that you
can do in a UNIX framework, that were not invented 30 years ago.

> Mix of that CORBA_OS and UNIX would be extremely nasty. I have a serious
> suspicion that CORBA_OS in itself would be a wonderful illustration to
> "Why Pascal is Not My Favorite Programming Language", but that's
> another story (BTW, that paper may make an interesting reading - check
> http://www.lysator.liu.se/c/bwk-on-pascal.html).

Uh huh.  I fail to see what pascal has to do with this.  And yes, I read
that paper _years_ ago.

> Sigh... OK, as far as I'm concerned we are in the dead-end - data-agnostic
> tools are very useful and I don't believe that you can convince me in the
> contrary. If it leaves something to discuss - you are welcome. If it doesn't
> we probably ought to stop wasting the bandwidth and agree that we disagree.

It is entirely possible that we will never agree, but that does not
mean that this discussion is worthless.  I think it's good to get the 
ideas and the potential out in the open so that others can form their 
own opinions.  "I can only show you the door..."  :)

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
