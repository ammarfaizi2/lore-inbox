Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136098AbRASAkB>; Thu, 18 Jan 2001 19:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136438AbRASAjv>; Thu, 18 Jan 2001 19:39:51 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:38135 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S136098AbRASAjp>; Thu, 18 Jan 2001 19:39:45 -0500
Date: Fri, 19 Jan 2001 01:18:01 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andreas Dilger <adilger@turbolinux.com>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101181120070.18387-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10101182335320.3304-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 Jan 2001, Linus Torvalds wrote:

> It's too damn device-dependent, and it's not worth it. There's no way to
> make it general with any current hardware, and there probably isn't going
> to be for at least another decade or so. And because it's expensive and
> slow to do even on a hardware level, it probably won't be done even then.
> 
> [...]
> 
> An important point in interface design is to know when you don't know
> enough. We do not have the internal interfaces for doing anything like
> this, and I seriously doubt they'll be around soon.

I agree, it's device dependent, but such hardware exists. It needs of
course its own memory, but then you can see it as a NUMA architecture and
we already have the support for this. Create a new memory zone for the
device memory and keep the pages reserved. Now you can use it almost like
other memory, e.g. reading from/writing to it using address_space_ops.

An application, where I'd like to use it, is audio recording/playback
(24bit, 96kHz on 144 channels). Although it's possible to copy that amount
of data around, but then you can't do much beside this. All the data is
most of the time only needed on the soundcard, so why should I copy it
first to the main memory?

Right now I'm stuck to accessing a scsi device directly, but I would love
to use the generic file/address_space interface for that, so you can
directly stream to/from any filesystem. The only problem is that the fs
interface is still to slow.

That's btw the reason I suggested to split the get_block function. If you
record into a file, you first just want to allocate any block from the fs
for that file. A bit later when you start the write, you need a real
block. And again a bit later you can still update the inode. These three
stages have completely different locking requirements (except the page
lock) and you can use the same mechanism for delayed writes.

Anyway, now with the zerocopy network patches, there are basically already
all the needed interfaces and you don't have to wait for 10 years, so I
think you need to polish your crystal ball. :-)

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
