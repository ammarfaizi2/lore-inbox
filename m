Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbREOTRp>; Tue, 15 May 2001 15:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261279AbREOTRf>; Tue, 15 May 2001 15:17:35 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13829 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261274AbREOTRU>; Tue, 15 May 2001 15:17:20 -0400
Date: Tue, 15 May 2001 12:17:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
cc: James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010515145830.Y5599@sventech.com>
Message-ID: <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Johannes Erdfelt wrote:
> 
> Even bulk has issues because USB pipe's aren't necessarily streams, they
> can packetized in the psuedo weird way that USB does things.

This is ok. "pipe" does not mean that the write data doesn't have
boundaries.

Think about UDP. It's done with file desriptors, yet it is very much
packetized. 

Even a regular "pipe" actually has packet behaviour: a single write of <
PIPEBUF is guaranteed by UNIX to complete atomically, which is exactly so
that people can use pipes in a "packet" environment.

A file descriptor does NOT imply that the data you read or write must be
one mushy stream of bytes. It's ok to honour write() packet boundaries
etc.

You should absolutely NOT think that "we cannot send a packet down the
control pipe because multiple writers might confuse each other". You can
still require that separate packets be cleanly delimeted.

It's a huge mistake to think that you _have_ to use ioctl's to get
"packet" behaviour, or to get structured reads/writes. 

The advantage of read/write is that it doesn't _force_ a packet on you,
but the kernel really doesn't care if you have some structure to your read
and write requests.

> > or possibly you take a more socket-like approach and do
> > 
> > 	fd = socket(part-of-the-structure);
> > 	bind(fd, more-of-the-structure)
> > 	connect(fd, last-part-of-the-structure);
> 
> I don't like socket's since we do have a well bound set of endpoints. We
> don't have 4 billion IP's with 64k ports to choose from. We have x
> endpoints that the device tells us about ahead of time.

Note that "sockets" != "IPv4". Sockets just have names, they can be IPv4
(4+2 byte things), they can be pathnames (UNIX domain) and they can be
large IPv6 (16+2 or whatever). Or they could be small USB names. There's
nothing fundamentally wrong with "binding" a one-byte address and a
one-byte "interface" name. You'd just create a AF_USB layer ;)

But no, I don't actually like sockets all that much myself. They are hard
to use from scripts, and many more people are familiar with open/close and
read/write.

		Linus

