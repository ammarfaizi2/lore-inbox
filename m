Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263394AbUECBQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbUECBQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 21:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbUECBQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 21:16:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48565 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263394AbUECBQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 21:16:30 -0400
Date: Mon, 3 May 2004 02:16:29 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] removal of legacy cdrom drivers (Re: [PATCH] mcdx.c insanity removal)
Message-ID: <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk>
References: <20040502024637.GV17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aiiee...

You know, mcdx.c is like a roadkill - just can't stop looking at the thing.

a) it doesn't initialize when non-modular.  Since 2.5.0.  Fixed, can send.
b) it leaks on failure exits; since forever.  Fixed, can send.
c) it has several lovely bugs (e.g. foo = bar | SINGLE ? ... : ..., where
SINGLE is defined as 1; from the context it's obvious that it should've
been bar & SINGLE; there since 1.3.71).  Fixed, can send.
d) it has tons of crimes against decency - e.g.
	foo = bar > (foo += baz) ? bar : foo;
where foo, bar and baz and fairly long expressions.  Partially fixed, can send.
Oh, and let's not forget the lovely variable names - e.g. "stuffp" through
the entire thing.  That's "pointer to all stuff we have about that device".

e) it does *entire* *damn* *IO* without dropping queue lock.  And yes, it
*does* block in there.  A lot.  Always had.

I can fix the last one, however at that point I'm really starting to wonder
if we want to keep the FPOS in the tree.  I don't have the hardware and while
I'm reasonably sure that I can split the transition into provably correct
small steps, I doubt that there's any point in doing that.  Driver is obviously
not used by anyone and hadn't been used for years.

The same goes for the rest of drivers/cdrom - cdrom.c is used, all right
(ide-cd, sr, pcd), but everything else is
	* abandoned by maintainers 5-6 years ago
	* broken
	* obviously not used by anybody
	* impossible to debug due to lack of hardware
	* fucking ugly

How about removing all that stuff instead of keeping the known broken shit
in the tree?  If somebody wants it back, they can always pick the versions
circa 2.6.0 from archives.

If you are OK with that (and nobody on l-k stands up and claims that they want
it alive and *claims* *that* *right* *fucking* *NOW*) I'll send you a patch
putting these buggers out of their misery.
