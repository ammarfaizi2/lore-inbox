Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRARIXq>; Thu, 18 Jan 2001 03:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbRARIXg>; Thu, 18 Jan 2001 03:23:36 -0500
Received: from 13dyn155.delft.casema.net ([212.64.76.155]:28678 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129764AbRARIXU>; Thu, 18 Jan 2001 03:23:20 -0500
Message-Id: <200101180823.JAA18205@cave.bitwizard.nl>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <944s0j$9lt$1@penguin.transmeta.com> from Linus Torvalds at "Jan
 17, 2001 11:32:35 am"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 18 Jan 2001 09:23:15 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In article <Pine.LNX.4.30.0101171454340.29536-100000@baphomet.bogo.bogus>,
> Ben Mansell  <linux-kernel@slimyhorror.com> wrote:
> >On 14 Jan 2001, Linus Torvalds wrote:
> >
> >> And no, I don't actually hink that sendfile() is all that hot. It was
> >> _very_ easy to implement, and can be considered a 5-minute hack to give
> >> a feature that fit very well in the MM architecture, and that the Apache
> >> folks had already been using on other architectures.
> >
> >The current sendfile() has the limitation that it can't read data from
> >a socket. Would it be another 5-minute hack to remove this limitation, so
> >you could sendfile between sockets? Now _that_ would be sexy :)
> 
> I don't think that would be all that sexy at all.
> 
> You have to realize, that sendfile() is meant as an optimization, by
> being able to re-use the same buffers that act as the in-kernel page
> cache as buffers for sending data. So you avoid one copy.
> 
> However, for socket->socket, we would not have such an advantage.  A
> socket->socket sendfile() would not avoid any copies the way the
> networking is done today.  That _may_ change, of course.  But it might
> not.  And I'd rather tell people using sendfile() that you get EINVAL if
> it isn't able to optimize the transfer.. 

Linus, 

I admire your good taste in designing interface, but here is one where
we disagree.

I'd prefer an interface that says "copy this fd to that one, and
optimize that if you can".

All cases that can't be optimized would end up doing an in-kernel read
/ write loop. Sure, there is no advantage above doing that same loop
in userspace, but this way the kernel can "grow" and optimize more
stuff later on.

For example, copying a file from one disk to another. I'm pretty sure
that some efficiency can be gained if you don't need to handle the
possibility of the userspace program accessing the data in between the
read and the write. Sure this may not qualify as a "trivial
optimization, that can be done with the existing infrastructure" right
now, but programs that want to indicate "kernel, please optimize this
if you can" can say so.

Currently, once the optimization happens to become possible (*), we'll
have to upgrade all apps that happen to be able to use it. If now we
start advertizing the interface (at a cost of a read/write loop in the
kernel: five lines of code) we will be able to upgrade the kernel, and
automatically improve the performance of every app that happens to use
the interface.

			Roger. 

(*) Either because the infrastructure makes it "trivial", or because
someone convinces you that it is a valid optimization that makes a
huge difference in an important case.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
