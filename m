Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbREOTnp>; Tue, 15 May 2001 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbREOTnf>; Tue, 15 May 2001 15:43:35 -0400
Received: from quattro.sventech.com ([205.252.248.110]:7955 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S261316AbREOTn1>; Tue, 15 May 2001 15:43:27 -0400
Date: Tue, 15 May 2001 15:43:26 -0400
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
Message-ID: <20010515154325.Z5599@sventech.com>
In-Reply-To: <20010515145830.Y5599@sventech.com> <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com>; from Linus Torvalds on Tue, May 15, 2001 at 12:17:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001, Linus Torvalds <torvalds@transmeta.com> wrote:
> 
> On Tue, 15 May 2001, Johannes Erdfelt wrote:
> > 
> > Even bulk has issues because USB pipe's aren't necessarily streams, they
> > can packetized in the psuedo weird way that USB does things.
> 
> This is ok. "pipe" does not mean that the write data doesn't have
> boundaries.
> 
> Think about UDP. It's done with file desriptors, yet it is very much
> packetized. 
> 
> Even a regular "pipe" actually has packet behaviour: a single write of <
> PIPEBUF is guaranteed by UNIX to complete atomically, which is exactly so
> that people can use pipes in a "packet" environment.
> 
> A file descriptor does NOT imply that the data you read or write must be
> one mushy stream of bytes. It's ok to honour write() packet boundaries
> etc.
> 
> You should absolutely NOT think that "we cannot send a packet down the
> control pipe because multiple writers might confuse each other". You can
> still require that separate packets be cleanly delimeted.
> 
> It's a huge mistake to think that you _have_ to use ioctl's to get
> "packet" behaviour, or to get structured reads/writes. 

We never made that assumption. We used ioctl's since it was the easiest
and consistent way of solving the problem at the moment. We never said
it was the pefect solution :)

> The advantage of read/write is that it doesn't _force_ a packet on you,
> but the kernel really doesn't care if you have some structure to your read
> and write requests.

No argument here. I completely agree.

The problem with the shared control pipe is not 2 writers stomping on
each other, it's permissions. You can have 2 interfaces on one device
which are completely seperate from each other and you'd like 2 seperate
users/programs to have access to each interface. Each endpoint is
guaranteed to be unique to an interface, except for the default control
pipe.

A simple solution would be to clone the default control pipe for each
interface and manage the permissions independantly.

The major problem with read/write and USB is that while it can solve the
problem for control and bulk pipes, it can't for interrupt and
isochronous pipes.

> > > or possibly you take a more socket-like approach and do
> > > 
> > > 	fd = socket(part-of-the-structure);
> > > 	bind(fd, more-of-the-structure)
> > > 	connect(fd, last-part-of-the-structure);
> > 
> > I don't like socket's since we do have a well bound set of endpoints. We
> > don't have 4 billion IP's with 64k ports to choose from. We have x
> > endpoints that the device tells us about ahead of time.
> 
> Note that "sockets" != "IPv4". Sockets just have names, they can be IPv4
> (4+2 byte things), they can be pathnames (UNIX domain) and they can be
> large IPv6 (16+2 or whatever). Or they could be small USB names. There's
> nothing fundamentally wrong with "binding" a one-byte address and a
> one-byte "interface" name. You'd just create a AF_USB layer ;)

I had always made the assumption that sockets were created because you
couldn't easily map IPv4 semantics onto filesystems. It's unreasonable
to have a file for every possible IP address/port you can communicate
with.

It's not so unreasonable with USB however since the data set (endpoints)
is significantly smaller and manageable. It can be placed in the
filesystem namespace without any problems.

That being said, we can't solve all of USB's problems that way. AF_USB
would probably solve them all however.

> But no, I don't actually like sockets all that much myself. They are hard
> to use from scripts, and many more people are familiar with open/close and
> read/write.

Agreed.

It would be nice to use open/close/read/write for control and bulk and
sockets for interrupt and isochronous.

Although I think that's just too complicated. It's probably easier to
make everything a socket and deal with it that way.

JE

