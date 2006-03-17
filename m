Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbWCQULz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWCQULz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbWCQULz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:11:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932752AbWCQULv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:11:51 -0500
Date: Fri, 17 Mar 2006 12:11:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Phillip Susi <psusi@cfl.rr.com>
cc: Steven Rostedt <rostedt@goodmis.org>, Nick Warne <nick@linicks.net>,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: chmod 111
In-Reply-To: <441B1025.7000708@cfl.rr.com>
Message-ID: <Pine.LNX.4.64.0603171202240.3618@g5.osdl.org>
References: <200603171746.18894.nick@linicks.net> 
 <6f6293f10603171007vbf752e5n8a3d6f2d65e0a1e7@mail.gmail.com> 
 <200603171811.01963.nick@linicks.net> <1142620004.9478.13.camel@localhost.localdomain>
 <Pine.LNX.4.64.0603171036240.3618@g5.osdl.org> <441B1025.7000708@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Mar 2006, Phillip Susi wrote:
>
> Linus Torvalds wrote:
> > In particular, it's fairly easy to create a shared library that replaces a
> > system library (LD_LIBRARY_PATH) and then just dumps out the binary image.
> > 
> 
> What prevents you from injecting a shared library and manipulating a suid
> executable?

Suid executables do not accept LD_LIBRARY_PATH.

> Does the environment get cleared when you exec a suid program?

No, but the startup environment can tell if it's suid, and refuse to load 
anything but the fixed environment, so it's _effectively_ cleared for a 
subset of the environment strings.

Suid executables also get some special handling by the kernel (it will, 
for example, refuse to dump core for them - another way to get readable 
information from an executable). Similarly, you can't ptrace a suid 
executable (a _third_ way of getting information from a execute-only 
binary in general).

So suid executables are a separate issue: they actually _do_ have security 
protection (regardless of whether they are marked "readable" or not).

And finally don't get me wrong - you _can_ build up security around the 
executable bits, but it has to be a lot more involved than just assuming 
that being unreadable means that nobody can see what a binary does. So for 
example, you _can_ create a system where you only have a certain subset of 
binaries that will be run (no debuggers), and where user-supplied binaries 
simply won't execute (mounting any user-writable area no-exec, and make 
sure that none of the executable loaders like /lib/ld.so will load a 
non-exec image).

But in general, I'd say that is only applicable in some embedded 
environments (you could have a special chroot'ed jail environment where it 
could be very hard to read the binaries that you expose in the jail 
environment, for example). It's not useful in something that gives shell 
access and allows the user to create his own executable program files.

		Linus
