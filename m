Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261261AbREOS6t>; Tue, 15 May 2001 14:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261262AbREOS6j>; Tue, 15 May 2001 14:58:39 -0400
Received: from quattro.sventech.com ([205.252.248.110]:46352 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S261261AbREOS6c>; Tue, 15 May 2001 14:58:32 -0400
Date: Tue, 15 May 2001 14:58:31 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515145830.Y5599@sventech.com>
In-Reply-To: <Pine.LNX.4.10.10105151028380.22038-100000@www.transvirtual.com> <Pine.LNX.4.21.0105151043360.2112-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <Pine.LNX.4.21.0105151043360.2112-100000@penguin.transmeta.com>; from Linus Torvalds on Tue, May 15, 2001 at 11:04:27AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001, Linus Torvalds <torvalds@transmeta.com> wrote:
> 
> On Tue, 15 May 2001, James Simmons wrote:
> > > 
> > > And if write() has too much overhead - we'd better fix _that_, because
> > > it's much more likely hotspot than ioctl ever will be.
> > 
> > I would use write except we use write to draw into the framebuffer. If I
> > write to the framebuffer with that data the only thing that will happen is
> > I will get pretty colors on my screen. 
> 
> Note that this was the same argument that the USB people had, and it was
> wrong then. It's wrong now.

Hardly pretty and definately not perfect, but that's mostly because we
haven't solved the other problems yet.

> The USB people decided on using ioctl's, because the way USB works you
> send a packet down a "USB pipe", which is identified by the direction, the
> device number and the type (and other details). So what the USB system
> does to expose this to user land is very similar to what you propose for
> ioctl's: a structured ioctl that has a "data" field.
> 
> What Al is saying, and what makes perfect sense is that you generate a
> separate fd for each "pipe". It's even more obvious in the case of USB,
> because, by golly, the things are actually _called_ "pipes" in the USB
> documentation, which should have made people make the immediate
> association. Instead of doing

That was not why we did it that way. We used ioctl's because there is no
way to apply USB semantics to file streams.

> 	fd = open("unstructured-name" ...);
> 	ioctl(fd, MAGICIOCTL, { structured data });
> 
> you do
> 
> 	fd = open("/structured/name", ...);
> 	write(fd, data, size);

That was the plan, but unfortunately USB pipes aren't what you or I
would consider a pipe normally.

Take isochronous pipe's for instance. How would we apply that to a
normal file stream? Or an interrupt pipe?

Even bulk has issues because USB pipe's aren't necessarily streams, they
can packetized in the psuedo weird way that USB does things.

I'm all for seperating out each endpoint into a seperate file in your
/structured/name way since it's necessary for multi interface devices,
but we still have problems with sharing the default control pipe for
instance.

> or possibly you take a more socket-like approach and do
> 
> 	fd = socket(part-of-the-structure);
> 	bind(fd, more-of-the-structure)
> 	connect(fd, last-part-of-the-structure);

I don't like socket's since we do have a well bound set of endpoints. We
don't have 4 billion IP's with 64k ports to choose from. We have x
endpoints that the device tells us about ahead of time.

> and use write() there (or use "sendto()" etc which allow more dynamic
> structure constructs - you don't have to statically bind the fd early at
> bind/connect time.

sendto() is the only reason I can think that socket's would be useful.
bulk pipes are more like a sequenced datagram transport than anything.

However, it still doesn't seem to apply cleanly to the other 3 types of
pipe type's.

Perhaps we can create some new families specifically for USB?

> This, btw, is Al Viro's wet dream. But I have to agree: using name spaces
> etc is MUCH preferable to ioctl's, makes code more readable and logical,
> and often makes it possible to do things you couldn't sanely do before
> (control these things from scripts etc).

I think this is an excellent idea as well. Just USB is poor example
since the real problem with USB is not the naming, it's applying USB
semantics to file streams or sockets.

JE

