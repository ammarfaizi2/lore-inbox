Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbUKWKmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbUKWKmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUKWKmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:42:35 -0500
Received: from mail.shareable.org ([81.29.64.88]:59015 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262442AbUKWKma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:42:30 -0500
Date: Tue, 23 Nov 2004 10:42:15 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in fs/fcntl.c
Message-ID: <20041123104215.GE27064@mail.shareable.org>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost> <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A30612.2040700@dif.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> >>	case F_SETSIG:
> >>		/* arg == 0 restores default behaviour. */
> >>-		if (arg < 0 || arg > _NSIG) {
> >>+		if (arg > _NSIG) {
> >>			break;
> >
> Let's find out.

The unusual thing about this function is that "arg" is really
polymorphic, but given type "unsigned long" in the kernel.  It is
really a way to hold arbitrary values of any type.

Just look at the way it becomes "unsigned int" (dupfd) or "struct
flock" (lock) or "long" (leases) or "int" (setown).

F_SETOWN is interesting because you really can pass a negative int
argument and get a meaningful result, even though it's passed around
as unsigned long for a little while.

Signal numbers are usually "int".  The intended behaviour of fcntl(fd,
F_SETSIG, sig) from userspace is that a negative sig returns EINVAL.

I.e. writing fcntl(fd, F_SETSIG, -1) in userspace will compile without
any warnings.  The intended behaviour is that a negative sig returns
EINVAL.  The kernel code illustrates that intention.

It isn't obvious that arg is unsigned long in this function, when
reading the code.  I had to scroll to the top of the function to check
that this patch doesn't change its behaviour.  For that reason I think
the "< 0" test is useful, as it illustrates the intended behaviour and
causes no harm.

-- Jamie
