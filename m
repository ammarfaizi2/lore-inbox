Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319015AbSIJCyo>; Mon, 9 Sep 2002 22:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319018AbSIJCyo>; Mon, 9 Sep 2002 22:54:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29451 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319015AbSIJCyn>; Mon, 9 Sep 2002 22:54:43 -0400
Date: Mon, 9 Sep 2002 19:59:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <Pine.LNX.4.44.0209091926320.1911-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209091951550.1911-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Linus Torvalds wrote:
> 
> Which basically means that a driver that uses BUG() for something that
> isn't certain to be fatal anyway is a BUGGY driver.

There are probably good exceptions to this rule, like any rule.

For example, if the request queue (or some other fundamental internal data
structure) is found to be corrupted, I couldn't really fault a driver for
BUG()'ing out on it. It's not as if the driver could sanely even do an 
end_request() in that case.

But even broken hardware is not a reason for a BUG(). For example, if the
driver notices that some part of the controller is hung hard (ie provable
hardware problem), the last thing it should do is to bring the system
down. It should fail the IO, and maybe turn itself off, but let the system 
continue otherwise.

One of the best things I ever did from a debuggability standpoint was to 
almost never use panic() in the base kernel, and make various kernel page 
faults etc just try to kill the offender and go on.

Sometimes that "try to continue" approach ends up being nasty too (the
problem repeats and you end up with a dead machine that scrolls infinite
bug reports off the screen, making them really hard to catch), but on the
whole it tends to make things much easier to debug ("oops, I just lost my
floppy drive, let's save the messages on the harddisk and reboot").

			Linus

