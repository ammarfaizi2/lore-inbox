Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSIOEyv>; Sun, 15 Sep 2002 00:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317799AbSIOEyv>; Sun, 15 Sep 2002 00:54:51 -0400
Received: from dsl-213-023-043-058.arcor-ip.net ([213.23.43.58]:50848 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317772AbSIOEyu>;
	Sun, 15 Sep 2002 00:54:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 07:01:44 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>, Greg KH <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209100947481.2842-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0209100947481.2842-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qRXU-0001qs-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 18:51, Linus Torvalds wrote:
> On Tue, 10 Sep 2002, David Brownell wrote:
> > Or in even shorter sound bite format:  "Just say no to BUG()s."
> 
> Well, the thing is, BUG() _is_ sometimes useful. It's a dense and very 
> convenient way to say that something catastrophic happened.

There's an important case you're overlooking that takes us out of the
"sometimes" zone, and that is where you want to load up some piece of
heavily-context-dependent code with assertions, just to have confidence
that the many assumptions actually hold.  And once you have those hooks
in the code, it often makes little sense to take them out, because
they'll just have to go back in again the next time some remote part
of the kernel violates one of the assumptions.

What you *want* to do, is just turn them off, not remove them.  (Sure,
there are lots that shouldn't survive the alpha version of any code,
but still lots of good ones that should be kept, just stubbed out.)

So this is just a name problem: define MYSUBSYSTEM_BUG_ON which is nil
in production, but equivalent to BUG_ON for alpha or beta code.  In the
former case it means the code is going to run a little faster, plus the
system is going to be a little more resilient, as you say.

Otherwise, completely agreed.

> And actually, outside of drivers and filesystems you can often know (or
> control) the number of locks the surrounding code is holding, and then a
> BUG() may not be as lethal. At which point the normal "oops and kill the
> process" action is clearly fine - the machine is still perfectly usable.

Eventually we could try some fancy trick that involves keeping track
of the locks in a systematic way, so that they can be analyzed
automatically by a tool that generates lock-breaking code.  Then a
subsystem could use the generated code in its error path.  Sure, it's a
lot of work just to add another "9" to reliability, but when was anything
ever easy?

-- 
Daniel
