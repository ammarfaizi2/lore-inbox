Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317854AbSFSLs7>; Wed, 19 Jun 2002 07:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317856AbSFSLs6>; Wed, 19 Jun 2002 07:48:58 -0400
Received: from 90dyn220.com21.casema.net ([62.234.21.220]:48833 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S317854AbSFSLs5>; Wed, 19 Jun 2002 07:48:57 -0400
Message-Id: <200206191148.NAA06237@cave.bitwizard.nl>
Subject: Re: [PATCH+discussion] symlink recursion
In-Reply-To: <Pine.LNX.4.33.0206181646220.2562-100000@penguin.transmeta.com>
 from Linus Torvalds at "Jun 18, 2002 04:57:06 pm"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 19 Jun 2002 13:48:17 +0200 (MEST)
CC: Andries.Brouwer@cwi.nl, Alexander Viro <viro@math.psu.edu>,
       linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Could we allow deeper recursion if we did it by hand? Sure. Are
> there any real advantages in 15 levels of recursion over 5 levels of
> recursion? I don't see any.

I'm working on a system that stores part of the "how the hardware is
wired" in symlinks in the filesystem. Funny concept, but it allows us
to view the state of the system with standard filesystem tools.

So we have 

	Exhaust_pump -> DIO2/o/13

This tells us that the Exhaust_pump is connected on pin 13 of the
outputs on the module called "DIO2". Now DIO2 is a (digital IO) module
of type "dio" and it's the third on the bus.....

	DIO2 -> dio/3

Pin 13 on that module is simply a bit belonging to a word in my
"iospace" (the pin numbers are not the same as the bit numbers in from
the software viewpoint):

	dio/3/o/13 -> ../../bits/45/1    (*)

So in this example I seem to be using 3 symlinks in one path. I know
I've run into the "5" limit at sometime in the past. Probably because
this directory was linked somewhere, and that was moved and
compatibility-linked again. And/or there may be one or more extra
levels of indirections in the links in my devices directory.

Linus, people are using symlinks for different stuff than you
are. Thus they have slightly different "boundary conditions". 5
symlinks is just too little. It's "too close for comfort". 

Something like: "symlinks can't nest more than 15 levels deep, but may
never cause the pathname to exceed XX chars" is a reasonable limit.
Now doing that "recursively" may mean that the stack grows too
large. If that's the case, then I'm in favor of going for the
iterative approach.


			Roger. 

(*) Don't pin me on the number of "../" items in this link: It was
difficult enough the first time around, with the shell constantly
trying to outsmart me.....

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
