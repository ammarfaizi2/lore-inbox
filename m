Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbRACEZT>; Tue, 2 Jan 2001 23:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132072AbRACEZK>; Tue, 2 Jan 2001 23:25:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27145 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130993AbRACEYy>; Tue, 2 Jan 2001 23:24:54 -0500
Date: Tue, 2 Jan 2001 19:54:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in prune_dcache (2.4.0-prerelease)
In-Reply-To: <3A529F06.5BFA4229@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.LNX.4.10.10101021946310.1024-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Udo A. Steinberg wrote:
> 
> While under massive disk and cpu load, 2.4.0-prerelease produced
> the following oops (decode see below)

Hmm.. If I'm not mistaken, this is in dentry_iput() (inline function
called by prune_one_dentry(), which is _also_ an inline function, which
is why it gets reported as being in prune_dcache):

	if (dentry->d_op && dentry->d_op->d_iput)
		dentry->d_op->d_iput(dentry, inode);

and it looks like your dentry->d_op has a value of 0x01000000, so when we
load the d_op->d_iput pointer, we get a page fault.

The strange thing is that 0x01000000 value, which almost certainly should
just be NULL. A one-bit error.

Now, I assume this machine has been historically stable, with no history
of memory corruption problems.. It's entirely possible (and likely) that
the one-bit error is due to some wild kernel pointer. Which makes this
_really_ hard to debug.

I'll try to think about it some more, but I'd love to have more reports to
go on to try to find a pattern..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
