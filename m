Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273102AbRIOWHM>; Sat, 15 Sep 2001 18:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273096AbRIOWGx>; Sat, 15 Sep 2001 18:06:53 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:8415 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S273107AbRIOWGk>; Sat, 15 Sep 2001 18:06:40 -0400
Message-ID: <3BA3D10B.FE3C6C79@kegel.com>
Date: Sat, 15 Sep 2001 15:07:07 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-dan i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vitaly Luban <vitaly@luban.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock_bh() usage check, please (was: [PATCH][RFC] Signal-per-fd 
 for RT signals)
In-Reply-To: <3BA2AFFF.C7B8C4DF@kegel.com> <3BA2E144.FB0E5D55@luban.org> <3BA2E99A.1134E382@kegel.com> <3BA350A7.7D39FC23@kegel.com> <3BA3C61A.DED5A27A@luban.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Luban wrote:
> Dan Kegel wrote: ...
> > My variant makes the following changes: ..
> > * it keeps poll data, not pointers, in struct file.  This saves space
> >   and makes the consequence of screwing up less severe.
> > * it overloads an existing struct file field to avoid the space penalty;
> >   it doesn't bloat struct file.
> > * it assumes that it's better to keep the kernel uncluttered, so it
> >   changes the meaning of siginfo.si_code rather than introduces new ioctl's.
> >   (I hear the Austin draft of the Posix single unix spec is deleting all mention
> >    of SIGIO, so it looks like we're free to 'improve' that interface freely
> >    once Austin becomes the law of the land :-)
> 
> I'm reluctant to make such changes, like f_error field overloading because
> a) it may backbite in future if you'll use this mechanism for all I/O and not
> only sockets, since you are interfering with it's legitimate usage, in short, 
> it makes patch more dependent of possible kernel code changes
> b) I want the default kernel behavior to be exactly the same, as if without this
> patch, thus additional fcntl to control this feature. If you do not activate it,
> you don't get it,

You're absolutely right.  My patch is aggressive.  It does things that would
require buy-in by a lot of people.  Your patch is much safer.

But I doubt very much that SIGIO style readiness notification will ever
be used with files.  aio_{read,write} style completion notification is
much more appropriate for file I/O, and my proposal (if I make it) will not
affect that.

> Keeping pointer allows for additional sanity check to make sure I'm not screwed,
That's a good thing, yes.

> and cheap update events information in siginfo.
> Keeping interests strips you of this ability. And also, you have to have
> additional method of gettong events information in user space, because you 
> are not updating siginfo, and cannot rely on it anymore. 

I disagree there.  My patch's updates are just as cheap as yours, and
programs which use si_band instead of si_code are potentially unaffected by my
patch; it's possible to write programs that work identically with or without
my patch.  (My Poller_sigio.cc is such a program.)

> So, to utilize signal per fd feature you have to modify
> event loop and not file descriptor setup, which I'd also try to avoid.

Agreed.  It is messy to have to go out and 'fix' existing programs to 
be compatible with a proposed interface change like this.  You are absolutely
right to avoid the kind of change I made.

On the other hand, my change might in the long run yield both a simpler
kernel and simpler userland programs.  That's the only reason I am playing
with this approch.  I'm not seriously proposing it as yet.  I only posted it
so you could see how I addressed the first two kinds of oops'es; the fixes
should be similar in your patch.

Thanks again for creating and maintaining your patch!  I look forward to
stress-testing the next version.
- Dan
