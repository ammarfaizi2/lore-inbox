Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbREOEbW>; Tue, 15 May 2001 00:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbREOEbL>; Tue, 15 May 2001 00:31:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18961 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262620AbREOEbB>; Tue, 15 May 2001 00:31:01 -0400
Date: Mon, 14 May 2001 21:30:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alexander Viro <viro@math.psu.edu>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: Getting out of hand?
In-Reply-To: <Pine.LNX.4.21.0105150011480.23642-100000@scotch.homeip.net>
Message-ID: <Pine.LNX.4.21.0105142114310.23663-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 May 2001, Alan Cox wrote:
> 
> Except that Linus wont hand out major numbers, which means I can't even boot
> simply off such a device. I bet the vendors in question dont think the sun
> shines out of linus backside any more.

Actually, it does. It's just that some people have gotten so blinded by my
a** that they can no longer see it any more ;)

The problem I have is that there are lots of _good_ solutions, but they
all imply a bit more work than the bad ones. 

What does that result in? Everybody continues to use the simple old setup,
which required no thought at all, but that is a pain to maintain.

For example, the only thing you need in order to boot is to have a nice
clean "disk" major number. That's it. Nothing fancy, nothing more. 

Look at what we have now:

 - ramdisk: major 1. Fair enough - ramdisk is special, in that it doesn't
   have any "real hardware". No problem.
 - SCSI disks:
	major 8, 65-71,
 - Compaq smart2:
	major 72-79
 - Compaq CISS:
	major 104-111
 - DASD;
	major 94
 - IDE:
	major 3, 22, 33-34, 56-57, 88-91

and then the small random ones.

NONE of these major numbers have _any_ redeeming qualities except for the
ramdisk. They should all be _one_ major number, namely "disk". There are
absolutely NO advantages to having separate devices for soem strange
compaq controllers and IDE disks. There is _no_ point in having some SCSI
disks show up at major 8, while others (who just happen to be attached to
a scsi bus that is not driven by the generic SCSI layer) show up at major
104 or whatever.

And it will never ever get fixed, unless somebody says "No more!". Which
I'm trying my best to say, except some people are so comfortable rolling
around in the shit that they have re-defined shit to be the new standard.

When Microsoft defines darkness to be standard, we laugh at them. When we
do it, Alan Cox stands up for it and claims that it's the best thing since
sliced bread. Double standards, anybody?

What I'm saying is: "No more SHIT!". I'm more than happy to give out a new
standard number for _disks_. I'm NOT AT ALL willing to say "Ok, Peter, go
ahead and give the next braindamaged Compaq/RedHat/Xxxx engineer another
random number so that we can dig ourselves deeper and deeper into this
shithole that Alan and others like so much".

How hard is it to generate a new "disk driver framework", and let people
register themselves, kind of like the "misc" drivers do. Except we'd only
allow DISKS. You could add something like

	register_disk_driver("compaq-ciss", nr_disks, &my_queue);

and then the disk driver framework will select a range of minor numbers
for the disks, and forward all requests that come to those minor numbers
to "my_queue". No major numbers. No fixed minors. And the user sees _one_
disk major, and doesn't care _what_ the hell is behind it.

But no. When I tell people "enough is enough", people want to continue
with the unbearably stupid and ugly thing we've always had, without
realizing that the _real_ problem is not that we have too few major
numbers, but the real problem is that people have mis-used the ones we
_do_ have, and the fact that we have too few _minor_ numbers (which is
easily fixable, and where 20 bits is plenty).

		Linus

