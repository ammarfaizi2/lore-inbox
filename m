Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbRETKJg>; Sun, 20 May 2001 06:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbRETKJ1>; Sun, 20 May 2001 06:09:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41198 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261513AbRETKJG>;
	Sun, 20 May 2001 06:09:06 -0400
Date: Sun, 20 May 2001 06:09:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@suse.cz>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending 
 DeviceNumberRegistrants]
In-Reply-To: <3B0780B8.36FDA681@alsa-project.org>
Message-ID: <Pine.GSO.4.21.0105200545170.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Abramo Bagnara wrote:

> Suppose now to have a convention that control stream are in the form:
> "ACTION ARGUMENTS"
> 
> Then we have
> echo "speed 19200" > /proc/self/fd/0/ioctl
> instead of
> stty 19200
> 
> It seems to me something different from a pile of shit ;-)

But it isn't.

	a) You are still trying to think of it as an OOB data associated with
normal channel. That is _wrong_. There is no 1-to-1 relation between these
OOB channels and normal ones. Wrong model. Commands are not associated with
data streams. Sometimes you can tie them together, but in many cases you just
can't. Building the infrastructure on that is a Bad Thing(tm).

	b) Way too many ioctls do not have that form. So aside of converting
code to handling the form above you will need to change the bleedin' APIs.
Sorry. No way around that.

	c) Aside of implementing something dumb a-la XDR and putting encoding
part into libc and decoding one into the procfs (which doesn't fix any of
the problems and only adds to ugliness) any method means that you will need
to go through drivers one-by-one. There is no magic way to deal with that
mess at once - the whole problem is that this pile of dung was festering
for too long and became a complete mess. The fact that anyone who felt an
urge to toss into it did so without a second thought also doesn't help.

	I went through that crap about a week ago when I was doing audit of
copy_from_user() callers. And I ask everyone who seriously wants to discuss
the situation: go and read through that code. Write the APIs down. Stare at
them. When you will get the feeling of the things out there (_not_ a vague
"well, they are for passing some commands; how bad can it be?") join the
show.

> > So there is no easy way to solve that stuff - we'll need to rethink tons
> > of badly designed interfaces.
> 
> This is orthogonal wrt ioctl problems pointed by Linus.

No, it isn't. That's the same problem. We have tons of garbage that will have
to be converted to sane form _before_ we can do anything with it. Result of
the braindead attitude of those who were dumping into that pile.

It should be fixed, but it won't be easy and it won't be fast. If you want
to help - wonderful. But keep in mind that it will take months of wading
through the ugliest code we have in the tree. If you've got a weak stomach -
stay out. I've been there and it's not a nice place.

Getting a list of all ioctls in the tree, along with types of their arguments
would be a great start. Anyone willing to help with that?
 
> I've simply proposed an *infrastructure* for better interfaces.

	We already have that infrastructure. It's called ramfs. Building
infrastructure on the model that doesn't fit the problem domain is a Bad
Thing(tm). We already have enough ESRitis around.

