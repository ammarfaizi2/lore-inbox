Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbREOUii>; Tue, 15 May 2001 16:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbREOUi2>; Tue, 15 May 2001 16:38:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33544 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261473AbREOUiX>; Tue, 15 May 2001 16:38:23 -0400
Date: Tue, 15 May 2001 13:37:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105151607100.21081-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105151328160.2470-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Alexander Viro wrote:
> 
> The thing being, why thet hell create these device/directory hybrids?

Backwards compatibility, and the ability to automatically take advantage
of existing filesystems without having any administrative worries.

No real technical reason, in other words.

But trust me: avoiding administrative worry is a _big_ plus.

And making people think of device nodes as more of a "window" into the
driver is a good thing anyway.

> Driver can export a tree and we mount it on fb0. After that you have
> the whole set - yes, /dev/fb0/colourspace, etc. - no problem. And no
> need to do mknod, BTW. Yes, we'll need to use /dev/fb0/frame for
> frame itself. BFD...

Actually, we can just continue to use "/dev/fb0", which would continue to
work the way ti has always worked.

It's a mistake to think that a directory has to be a directory. Or to
think that a device node has to be a device node. It's perfectly ok to
just think of it as namespaces. So opening /dev/fb0 continues to open the
"master fd", whatever that means (in this case, the actual frame
buffer). The namespaces _under_ /dev/fb0 would be the control channels, or
in fact _anything_ that the frame buffer driver wants to expose.

They might also be exactly the same channel, except with certain magic
bits set. The example peter gave was fine: tty devices could very usefully
be opened with something like

	fd = open("/dev/tty00/nonblock,9600,n8", O_RDWR);

where we actually open up exactly the same channel as if we opened up
/dev/cua00, we just set the speed etc at the same time. Which makes things
a hell of a lot more readable, AND they are again easily done from
scripts. The above is exactly the kind of thing that UNIX has not done
well, and some others have done better (let's face it, even _DOS_ did it
better, for chrissake! Those callout devices and those ioctl's are a pain
in the ass, for no really good reason).

Using ASCII names for these kinds of channel controls is fine.

> You see, as soon as you want slightly more structured stuff (deeper than
> one level) you need the dentry tree, yodda, yodda. IOW, you need a
> filesystem anyway and it's easy to implement.

I want to ease people into this notion. I'm personally perfectly happy to
make it a real filesystem, if you are willing to write the code. But I've
become convinced that the transition has to be really simple, with no
administrative work.

It should be a case of "Just plug in a new kernel, and suddenly your
existing filesystem just allows you to do more! 20% more for the same
price! AND we'll throw in this useful ginzu knife for just 4.95 for
shipping and handling. Absolutely free!"

		Linus

