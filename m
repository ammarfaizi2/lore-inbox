Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266514AbUF0BzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUF0BzW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 21:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUF0BzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 21:55:22 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:2214 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266514AbUF0BzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 21:55:11 -0400
Date: Sat, 26 Jun 2004 18:55:01 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: more (insane) jiffies ranting
Message-ID: <20040627015501.GA14647@taniwha.stupidest.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Continuing my rant...

On Sat, Jun 26, 2004 at 03:48:34PM -0700, Linus Torvalds wrote:

> But for most data structures, the way to control access is either
> with proper locking (at which point they aren't volatile any more)
> or through proper accessor functions (ie "jiffies_64" should
> generally only be accessed with something that understands about
> low/high word and update ordering and re-testing).

I don't entirely buy this.  Right now x86 code just assumes 32-bit
loads are atomic and does them blindly in lots of places (ie. every
user of jiffies just about).

Without the volatile it seems entirely reasonable gcc will produce
correct, but wrong code here so I would argue 'volatile' is a property
of the data in this case.

> I repeat: it is the _code_ that knows about volatile rules, not the
> data structure.

Except as I mentioned we have exceptions to this right now.

As far as I can tell jiffies is a mess (I'm talking mostly ia32 here):

  jiffies_64 is protected by xtime_lock, this is a seqlock_t which
  is IMO overly complicated and unnecessary, and this lock is shared
  for xtime as well

  jiffies_64 could be done locklessly as far as I can tell anyhow.

  jiffies is linker-magic to jiffies_64 and works because a
  little-endian load at the same address gives you the 32 lower bits.
  I'm not opposed to this, but a comment wouldn't kill anyone.

  we also have wall_jiffies which is 32-bit (unsigned long, ia32) and
  is used get the gettimeofday code to detect lost ticks, having
  this as well as jiffies_64 seems overkill

  we do xtime updates w/o a lock on most platforms

Perhaps I misunderstand the code right now, the need for the
complexity and what-not --- but I don't like it.

It's either because it's too complicated or it's not-clear what is
going on, I don't know which one matches reality most closely,
probably the latter.

I know there are NTP implications of this this code but it feels more
like "it happens to work, please don't touch it" rather than anything
clean and well designed.  I'm pretty sure there are some tricky corner
cases and subtle interactions to worry about, especially when we look
at leap-seconds.

Maybe having all this code moved into a single place would help, I'm
not sure, with platform-provided abstraction as required so older
platforms which can't do atomic 64-bit updates will still behave
sanely.

To be quite honest I'd like to see jiffies die and xtime become a
per-cpu thing (if that can be made to work reliably, I have some
concerns), or at least have this option on a platform by platform
basis.



  --cw
