Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUFZXjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUFZXjV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUFZXjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:39:21 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:6054 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267234AbUFZXjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:39:17 -0400
Date: Sat, 26 Jun 2004 16:37:54 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: jiffies_64
Message-ID: <20040626233754.GA12761@taniwha.stupidest.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 03:48:34PM -0700, Linus Torvalds wrote:

> So please tell me where the jiffies64 thing was suddenly correct as
> a "volatile", and I can almost guarantee you that you were WRONG to
> mark it volatile.

In this case it's a platform where moving jiffies around is very
painful so I have a patch to make jiffies per-CPU using the local APIC
timer (jiffies becomes a macro to get_local_jiffies() with all the
horrors that come with that).

Because this drifts we use the PIT as a referrence and resynchronize
every few seconds against jiffies_64.

A few places can't actually use get_local_jiffies() early on like the
bogomips calibration code (because the local APIC timer isn't working
yet) so I've got some hacks in there where they use jiffies_64.

> But you're right, on a 64-bit architecture, jiffies_64 falls back to
> the "jiffies" case, and there it would be acceptable to make it
> volatile.

Actually, I don't like the way we use xtime_lock at all for jiffies_64
now.  Things are unclear and fragile in places.  In my tree I have
jiffies_64 protected by a spinlock instead of the seqlock thing (as it
still needs to be locked even though it's incremented only from one
CPU in irq context) and was looking at using cmpxchg8 on platforms
what can to remove the need to lock jiffies_64 completely.

I've wondered if we can't do the same thing for xtime as well,
however I need to make per-CPU xtime so I'll revisit that when I get a
chance.

> See? The volatile is (again) wrong on the data structure (jiffies_64), and
> you should have added it to the code (get_jiffies_64).

get_jiffies_64() in my case reads the per-CPU value and like I said a
few places don't like that.


  --cw
