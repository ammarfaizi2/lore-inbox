Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261213AbREOSM1>; Tue, 15 May 2001 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261237AbREOSMR>; Tue, 15 May 2001 14:12:17 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13841 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261239AbREOSEj>; Tue, 15 May 2001 14:04:39 -0400
Date: Tue, 15 May 2001 11:04:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Simmons <jsimmons@transvirtual.com>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151028380.22038-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.21.0105151043360.2112-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, James Simmons wrote:
> > 
> > And if write() has too much overhead - we'd better fix _that_, because
> > it's much more likely hotspot than ioctl ever will be.
> 
> I would use write except we use write to draw into the framebuffer. If I
> write to the framebuffer with that data the only thing that will happen is
> I will get pretty colors on my screen. 

Note that this was the same argument that the USB people had, and it was
wrong then. It's wrong now.

The USB people decided on using ioctl's, because the way USB works you
send a packet down a "USB pipe", which is identified by the direction, the
device number and the type (and other details). So what the USB system
does to expose this to user land is very similar to what you propose for
ioctl's: a structured ioctl that has a "data" field.

What Al is saying, and what makes perfect sense is that you generate a
separate fd for each "pipe". It's even more obvious in the case of USB,
because, by golly, the things are actually _called_ "pipes" in the USB
documentation, which should have made people make the immediate
association. Instead of doing

	fd = open("unstructured-name" ...);
	ioctl(fd, MAGICIOCTL, { structured data });

you do

	fd = open("/structured/name", ...);
	write(fd, data, size);

or possibly you take a more socket-like approach and do

	fd = socket(part-of-the-structure);
	bind(fd, more-of-the-structure)
	connect(fd, last-part-of-the-structure);

and use write() there (or use "sendto()" etc which allow more dynamic
structure constructs - you don't have to statically bind the fd early at
bind/connect time.

See? 

Don't get boxed in by thinking that you only have one fd. Even if you have
only one _device_node_, you can have multiple fd's. In fact, you can, with
the Linux VFS layer, fairly easily do things like

	mknod /dev/fd0 c X Y

and then use

	fd = open("/dev/fd0/colourspace", O_RDWR);

and your device just implements some trivial "lookup()" functions (you
don't _have_ to be a directory to allow name lookups - although right now
I suspect that you can confuse the VFS layer if you aren't. That's a VFS
layer deficiency, if so. Nobody has tested it, but it should be really
easy to fix if somebody is really interested).

Note that with these kinds of things, you don't need ugly ioctl's. The
code, I bet, would be a LOT more readable. There's nothing fundamentally
impossible with having

	> /dev/fd0/eject

cause an eject event on /dev/fd0. It would be fairly easy, I bet, to
expand the current "struct file_operations def_blk_fops" to also include
_dentry_ operations, and then all of this could be done by fs/block_dev.c,
with the actual device drivers not having to know about it.

Same thing with character devices. We should be fairly easily able to make
something like

	fd = open("/dev/fd0/colourspace=1", ...)

be fully parsed by the fs/block_dev.c layer: we could add a nice string to
"bd_op->open()", to be passed in to the device driver to do with as it
wishes. That would require _no_ changes from device driver writers except
the addition of a new argument ("const char * arg") and the choice to
possibly using that argument for extra structure..

This, btw, is Al Viro's wet dream. But I have to agree: using name spaces
etc is MUCH preferable to ioctl's, makes code more readable and logical,
and often makes it possible to do things you couldn't sanely do before
(control these things from scripts etc).

And using ASCII names ("eject") instead of numbers (see the "FDEJECT" and
"CDROMEJECT" etc #defines) sure as hell makes for easier maintenance and
avoids the whole issue of maintaining static numbers (all the same things
that make me hate device number maintenance makes me also hate the fact
that we need to maintain this list of ioctl numbers etc). By using
descriptive names, the "maintenance" simple does not exist.

		Linus

