Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131604AbRAUJxR>; Sun, 21 Jan 2001 04:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132249AbRAUJxI>; Sun, 21 Jan 2001 04:53:08 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:62892 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131604AbRAUJwt>; Sun, 21 Jan 2001 04:52:49 -0500
Date: Sun, 21 Jan 2001 09:52:36 +0000 (GMT)
From: James Sutherland <mandrake@cam.ac.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Roman Zippel <zippel@fh-brandenburg.de>,
        Kai Henningsen <kaih@khms.westfalen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101201629110.10849-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101210945220.8238-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, Linus Torvalds wrote:

>
>
> On Sat, 20 Jan 2001, Roman Zippel wrote:
> >
> > On Sat, 20 Jan 2001, Linus Torvalds wrote:
> >
> > > But point-to-point also means that you don't get any real advantage from
> > > doing things like device-to-device DMA. Because the links are
> > > asynchronous, you need buffers in between them anyway, and there is no
> > > bandwidth advantage of not going through the hub if the topology is a
> > > pretty normal "star" kind of thing. And you _do_ want the star topology,
> > > because in the end most of the bandwidth you want concentrated at the
> > > point that uses it.
> >
> > I agree, but who says, that the buffer always has to be the main memory?
>
> It doesn't _have_ to be.
>
> But think like a good hardware designer.
>
> In 99% of all cases, where do you want the results of a read to end up?
> Where do you want the contents of a write to come from?
>
> Right. Memory.

For many applications, yes - but think about a file server for a moment.
99% of the data read from the RAID (or whatever) is really aimed at the
appropriate NIC - going via main memory would just slow things down.

Take a heavily laden webserver. With a nice intelligent NIC and RAID
controller, you might have the httpd write the header to this NIC, then
have the NIC and RAID controller handle the sendfile operation themselves
- without ever touching the OS with this data.

> Now, optimize for the common case. Make the common case go as fast as
> you can, with as little latency and as high bandwidth as you can.
>
> What kind of hardware would _you_ design for the point-to-point link?
>
> I'm claiming that you'd do a nice DMA engine for each link point. There
> wouldn't be any reason to have any other buffers (except, of course,
> minimal buffers inside the IO chip itself - not for the whole packet, but
> for just being able to handle cases where you don't have 100% access to
> the memory bus all the time - and for doing things like burst reads and
> writes to memory etc).
>
> I'm _not_ seeing the point for a high-performance link to have a generic
> packet buffer.

I'd agree with that, but I would want peripherals to be able to send data
to each other without touching the host memory - think about playing video
files with an accelerator (just pipe the files from disk to the
accelerator), music with an "intelligent" sound card (just pipe the music
to the card), video capture, file servers, CD burning...

Having an Ethernet-style point-to-point "network" (everything connected as
a star, with something intelligent in the middle to direct the data where
it needs to go) makes sense, but don't assume everything is heading for
the host's memory. DMA straight to/from a "switch" would be a nice
solution, though...


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
