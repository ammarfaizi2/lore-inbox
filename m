Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUEPFWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUEPFWY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 01:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUEPFWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 01:22:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11170
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263147AbUEPFWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 01:22:22 -0400
Date: Sun, 16 May 2004 07:22:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040516052220.GU3044@dualathlon.random>
References: <200405132232.01484.elenstev@mesatop.com> <Pine.LNX.4.58.0405151914280.10718@ppc970.osdl.org> <Pine.LNX.4.58.0405152029110.10718@ppc970.osdl.org> <200405152231.15099.elenstev@mesatop.com> <Pine.LNX.4.58.0405152147220.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405152147220.25502@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 09:52:50PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 15 May 2004, Steven Cole wrote:
> > 
> > OK, will do.  I ran the bk exerciser script for over an hour with 2.6.6-current
> > and no CONFIG_PREEMPT and no errors.  The script only reported one
> > iteration finished, while I got it to do 36 iterations over several hours earlier
> > today (with a 2.6.3-4mdk vendor kernel)
> 
> Hmm.. Th ecurrent BK tree contains much of the anonvma stuff, so this 
> might actually be a serious VM performance regression. That could 
> effectively be hiding whatever problem you saw.
> 
> Andrea: have you tested under low memory and high fs load? Steven has 384M
> or RAM, which _will_ cause a lot of VM activity when doing a full kernel
> BK clone + undo + pull, which is what his test script ends up doing...

An easy way to verify for Steven is to give a quick spin to 2.6.5-aa5
and see if it's slow too, that will rule out the anon-vma changes
(for completeness: there's a minor race in 2.6.5-aa5 fixed in my current
internal tree, I posted the fix to l-k separately, but you can ignore
the fix for a simple test, it takes weeks to trigger anyways and you
need threads to trigger it and I've never seen threaded version control
systems so I doubt BK is threaded).

In general a "slowdown" cannot be related to anon-vma (unless it's a
minor merging error), that's a black and white thing, it doesn't touch
the vm heuristics and it will only speed the fast paths up plus it will
save some tons of ram in the big systems. Pratically no change should be
measurable on a small system (unless it uses an heavy amount of cows, in
which case it will improve things, it should never hurt).  As for being
tested, it is very well tested on the small desktops too. Probably the
only thing to double check is that there was no minor merging error that
could have caused this.

> It would be good to test going back to the kernel that saw the "immediate 
> problem", and try that version without CONFIG_PREEMPT. 

Agreed.

Thanks.
