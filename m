Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLNTm3>; Thu, 14 Dec 2000 14:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129260AbQLNTmS>; Thu, 14 Dec 2000 14:42:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39128 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129345AbQLNTmP>;
	Thu, 14 Dec 2000 14:42:15 -0500
Date: Thu, 14 Dec 2000 14:11:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Lattner <sabre@nondot.org>
cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012141141010.26883-100000@www.nondot.org>
Message-ID: <Pine.GSO.4.21.0012141331460.8287-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Chris Lattner wrote:

> > Yes, I did. What I don't understand is how kernel mechanism for marshalling
> > would make your life easier wrt changes.
> 
> I gave a very simple example of how an interface could be designed and
> then later extended without breaking any user space programs.  Please
> reread the example and tell me precisely what doesn't make sense, and I
> would be glad to explain it better.

What does it win compared to adding new file and allowing new programs use
it while the old ones keep using the old one? That's precisely the same
situation, isn't it?
 
> > So what's to stop you from letting readdir() do the work? WTF do we need
> > one more API for returning the list of objects?
> 
> Urm.. that was the point.  You don't add a new API (it's built into corba,
> along with introspection).  Also, like I JUST MENTIONED, readdir will have
> no way of knowing what is a network device in the quagmire of stuff
> floating around in /dev.  (ls *net* does actually call readdir ya
> know.  Perhaps you should read up more on unix... [sorry couldn't help
> it. ;])

Cool. We don't have network devices represented as fs. We could have,
but nobody had really cared. Guess what, I know that. It's _not_ a good
thing. What you propose is expanding the area of brokenness.

> structure of.  Imaging this.  You have a bytestream flowing out of some
> pipe/device/socket/file/whatever and you pipe it to a
> "Decode" program.  The decode program spits this out:

Is it separated on per-object streams?
 
> Heh... I'm not trying to replace od or cat or tee or pipes.  What I'm
> trying to do is give you a larger toolkit that gives you MORE
> power.  Imagine you want to get the first float value (of each struct) of
> the above stream.  Imagine a functional scripting language where you could
> do this (haskell syntax stolen gratitously):
> 
> cat /dev/floatymouse | funcwith 'map fst'

No problems with that. But notice that you did introduce a new device here.

> > No, it isn't. The difference being: letting driver to define a filesystem
> > and mounting/exporting it/whatever means that you get to use _all_ _normal_
> > _data-agnostic_ _tools_. And believe me, it matters. If you don't understand
> > that - no offense, but you don't understand UNIX.
> 
> Ouch.
> 
> /me digs around and puts on thick skin
> 
> Okay, fine.  You want to talk unix.  You proclaim that this beautiful
> infalliable API is simple open/close/read/write calls on stanardized
> devices, right?  What about ioctl?  What about the HUGE class of crap that

ioctl() is avoidable. Proof: Plan 9. They don't _have_ that system call.
It doesn't mean that we should (or could) remove it. It _does_ mean that
new APIs do not need it.
 
And I'm quite serious. ioctl() is used in too many programs to kill it
off (compatibility reasons). No arguments here. However, looking back
at these cases... All of them could be done without ioctl(). Moreover,
it had been done. Says something about the need of adding new ioctls,
doesn't it?

Instead of having a metric buttload of device nodes in /dev you have
drivers export filesystems. You can mount them anywhere you want.
These filesystems can contain both devices and control files. Writing
commands to control file gives you a replacement of ioctl(). It
actually works quite nicely.

As long as you separate the data streams for different objects and
give them some names, so they can be intercepted, etc. - fine with
me. There's nothing wrong with having a library for marshalling.
There's nothing wrong with having it in the kernel too, BTW.
However, _that_ is completely independent from any form of transport.
All you need is "export a piece of namespace to another box".

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
