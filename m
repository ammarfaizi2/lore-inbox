Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUBJNHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 08:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUBJNHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 08:07:34 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62987 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265871AbUBJNHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 08:07:31 -0500
Message-ID: <4028DA93.9060107@aitel.hist.no>
Date: Tue, 10 Feb 2004 14:20:19 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mike Bell <kernel@mikebell.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
References: <20040210113417.GD4421@tinyvaio.nome.ca>
In-Reply-To: <20040210113417.GD4421@tinyvaio.nome.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Bell wrote:
> I've been reading a lot lately about udev and how it's both very
> different to and much better than devfs, and with _most_ of the reasons
> given, I can't see how either is the case. I'd like to lay out why I
> think that is.
> 
> I keep hearing about how udev has no naming policy in the kenel, while
> devfs has a fixed one and if you don't like it tough. 

One of the weakest arguments - who really cares if the kernel sets some
device names?  Makedev users rarely change those names either, although
they can.  Those rare cases where you need to rename a device so some
stupid binary-only thing can find it is solvable by symlinks.

Devfs is dying because nobody bothers fixing it (and it is believed
to be a big job).  Those who can seems to like udev.  No matter what
virtues devfs may have - arguments are useless unless someone volunteers
to maintain it.  I don't think it will disappear if someone does that and
does it well, but I am sure it _will_ go if nobody does.
A nice concept not yet implemented properly doesn't cut it.

> But udev relies on
> sysfs, which IS naming policy in the kernel. And devfs has devfsd, which
> is a userspace daemon that listens to a kernel-exported filesystem (just
> like udev) and can create whatever /dev layout you want from that, in
> userspace (just like udev). Basically, udev relies on sysfs exporting
> device numbers. Well, imagine for a moment sysfs exported actual device
> files instead of just the numbers you'd need to make a device file (a
> pretty minor change, though not one I'm advocating). What you've got
> there is basically devfs and devfsd, right? Not the same

Interesting idea.

> implementation-wise, obviously, but essentially IDENTICAL concepts.
> Kernel exports device files to a kernel-generated filesystem, user-space
> daemon creates /dev from those with a layout according to your liking.
> 
> Meanwhile, devfs (or a devfs-like solution) offer several things which
> udev just can't. Having a special kernel-exported filesystem just for
> /dev means your user-space daemon can see when a program is trying to
> access a device file that doesn't exist yet, 

Devfs can do this, but it is not necessarily a good thing.
I tried it - and it only works if someone tries to look up
a particluar name, such as /dev/dsp.  It doesn't work when someone
does a "ls /dev" to see what devices is there.
A "ls /dev/dsp*" didn't find the multiple soundcards for which
modules weren't yet loaded.

So you can list and see nothing, and still have stuff magically
appear _if_ you know what the name ought to be.  A hairy concept.
Do you know the device name for the second sound device?

The point of this is module users - they can delay module loading
till the module is needed.  Supporting opening of "nonexisting" devices
required a trigger mechanism though - devfsd had to know what module
to load at lookup time.

Non-devfs setups (with or without udev) support a similiar trigger
mechanism for module loading, that is simpler to set up and understand.
And that is a persistend device node.  Plain, simple, and ls sees it too.
Open it and the device is loaded as needed.  And at open time, not
at lookup time.  Load at lookup time might not be necessary, after all.

devfs gave us a /dev uncluttered by nonexisting hardware - now
udev can do that part and some persistent nodes can do the module 
loading part. 

> you can't do that with
> udev and tmpfs. Moreover, it means you've got a functional /dev that
> accurately represents the system regardless of whether the user-space
> daemon is running yet. With udev, you're stuck with a static /dev unless
> udev is running. 

I worried about this too, but notice which way the kernel is going.
"Essential" stuff like parsing the disk partition tables (or getting
a nfs root via dhcp) is being moved out of the kernel and into a
early userspace in initramfs.  Such a thing _must not_ break, so it
is the perfect place to put udev too.  It won't break from mere
misconfiguration because the initramfs isn't on disk but stuffed into
the kernel image where it is safe.  Someone who actually disrupts the kernel
loose anyway.

> This can happen when broken system or doing a fresh
> installation, or if you accidentally break your udev binary. 

Not if it resides in early userspace.  Then you need to break
the kernel image.

> And heavens
> help you if linux ever moves to dynamic device files, that would make a
> static /dev completely unusable. Which would in turn mean that your
> system is unusable unless udev is running. It's not a big problem, but
> myself I find myself using devfs without devfsd for those two reasons
> every once in a while, and in those instances devfs is really nice.
> 
If devfsd ran out of early userspace then you'd never be without that either.

> So the question is, is a devfs-like implementation really unfixable? And
It is fixable, but nobody wants to do it.  They have another solution 
they like better.  Feel free to fix devfs though, then we'll get
choice . . .

Helge Hafting

