Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262144AbRETTDS>; Sun, 20 May 2001 15:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262142AbRETTDJ>; Sun, 20 May 2001 15:03:09 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32269 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262140AbRETTDF>; Sun, 20 May 2001 15:03:05 -0400
Date: Sun, 20 May 2001 12:02:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Matthew Wilcox <matthew@wil.cx>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
In-Reply-To: <17695.990377825@redhat.com>
Message-ID: <Pine.LNX.4.21.0105201150110.7553-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, David Woodhouse wrote:
> 
> If that had been done right the first time, you wouldn't have had to either.
> For that matter, it's often the case that if the ioctl had been done right
> the first time, nobody would have had to fix it up for any architecture.

The problem with ioctl's is, let me repeat, not technology.

It's people.

ioctl's are a way to do ugly things. That's what they have ALWAYS been.
And because of that, people don't care about following the rules - if
ioctl's followed the rules, they wouldn't _be_ ioctls in the first place,
but instead have a good interface (say, read()/write()).

Basically, ioctl's will _never_ be done right, because of the way people
think about them. They are a back door. They are by design typeless and
without rules. They are, in fact, the Microsoft of UNIX.

The only way to fix ioctl's is to force people to think about them in
another way. Because if you don't, there is always going to be another
driver writer who adds his own ioctl because it's the easy way to do
whatever he wants without giving it a second of _design_ thought.

Now, a good way to force the issue may be to just remove the "ioctl"
function pointer from the file operations structure altogether. We don't
have to force peopel to use "read/write" - we can just make it clear that
ioctl's _have_ to be wrapped, and that the only ioctl's that are
acceptable are the ones that are well-designed enough to be wrappable. So
we'd have a "linux/fs/ioctl.c" that would do all the wrapping, and would
also be able to do all the stuff that is currently done by pretty much
every single architecture out there (ie emulation of ioctl's for different
native modes).

It would probably not be that horrible. Many ioctl's are probably not all
that much used by any real programs any more. The most common ones by far
are the tty ones - and the truly generic ones like "FIONREAD" that it
actually would make sense to generalize more.

Catching stuff like EJECT at a higher layer and turning THOSE kinds of
things into real block device operations would clean up drivers and make
them more uniform.

Would fs/ioctl.c be an ugly mess of some special cases? Yes. But would
that make the ugliness explicit and possibly easier to try to manage and
fix? Very probably. And it would mean that driver writers could not just
say "fuck design, I'm going to do this my own really ugly way". 

			Linus

