Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbRETQCX>; Sun, 20 May 2001 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbRETQCO>; Sun, 20 May 2001 12:02:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43206 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262065AbRETQCA>;
	Sun, 20 May 2001 12:02:00 -0400
Date: Sun, 20 May 2001 12:01:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <3B07E569.83639A19@alsa-project.org>
Message-ID: <Pine.GSO.4.21.0105201145380.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Abramo Bagnara wrote:

> > How about reading from them? You are forcing restriction that may make
> > sense in some cases, but doesn't look good for everything.
> 
> exec 3>/dev/ttyS0/ioctl
> exec 4<&3
> echo "speed" >&3
> cat <&4
> exec 3>&-
> exec 4<&-
> 
> Can you make a counter example where this doesn't look good?

If in your opinion it looks good... Again, you are forcing the policy
decision on a lot of interfaces. For no good reason, AFAICS.

> > However, we _do_ allow that. Right now. And yes, I agree that we should
                                                     ^^^^^^^^^^^^^^^^^^^^^^
> > go to separate file for that. And we are right back to finding a related
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > file.
> 
> I'd prefer to make what you often call a crapectomy: no IDE timing
> change using a partition handle. It's something like to permit that on a
> LVM handle, it's stupid...

Sigh... Sure, but so is the magic way to get ioctl descriptor by file
descriptor. They are two separate files. End of story. Yes, they are
related - provided by the same driver.

Look, emulating ioctl(2) via write(2) is _not_ the goal. We will have
to keep that syscall, for binary compatibility reasons if nothing else.
We can start fixing the applications that use Linux-only ioctls (and
that pretty much means that we'll have to leave the networking ones alone
for quite a while).

What _is_ interesting is a sane API that could be used instead of the
current mess with device ioctls. There's only one reason to go for
fs/n/ioctl scheme - mass conversion of applications with little to
no thinking. Not going to happen. Simply because you'll need to switch
arguments in many of these cases.
 
> About tty and vcs split: there the problem is more subtle and it's
> related to a missing separation of keyboard and screen.
> After to have done this choice (i.e. to have the some behaviour of
> serial port) someone has realized that to read from console screen it's
> a sensible action (to fetch current content).

> This is the typical case where to have /dev/tty1/ioctl does not
> substitute to have another device for console screen reading.
> 
> Note that it's a *different* device (different permission, etc.).

And your ioctl is different from that because...? I can certainly see
good reasons to restrict user to some subsets functionality provided by
ioctls - BTW, one more reason why multiple related channels are good.

