Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVDKOqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVDKOqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 10:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDKOqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 10:46:42 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:7087 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261769AbVDKOq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 10:46:26 -0400
Date: Mon, 11 Apr 2005 07:45:52 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
Message-Id: <20050411074552.4e2e656b.pj@engr.sgi.com>
In-Reply-To: <20050411113523.GA19256@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	<20050411113523.GA19256@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm ... I have this strong sense that I am about 2 hours away from
smacking my forehead and groaning "Duh - so that's what Ingo meant!"

However, one must play out one's destiny.

Could you provide an example scenario, which results in the creation of
a combo-blob?

The best I can come up with is the following.

Let's say Nick changes one line in the middle of kernel/sched.c
(yeah - I know - unlikely scenario - he usually changes more
than that - nevermind that detail.)

In the days Before Combo Blobs (BCB), git would have been told that
kernel/sched.c was to be picked up, and would have wrapped it up in a
zlib'd blob, sha1summed it, seen it was a new sum, and added that blob
to its objects (or something like this -- I'm still a little fuzzy on
these git details.)

But Nick just downloaded the latest git 1.5.11.1 which has added support
for combo blobs, so now, guessing here, instead of wrapping up the new
sched.c, git instead unwraps the old one, diff's with the new, notices a
couple of long sequences that are unchanged, wraps up both of those
sequences as a couple of relatively large blobs, and wraps up the new
lines that Nick just coded in the middle as a small blob, and puts all
three in the object store, along with another small combo-blob, tying
them all together.

So far, not too bad.  Haven't gained anything, and required the
unpacking of a zlib blog we didn't require before, and the running and
analyzing of a diff we didn't require before, but the end result is only
moderately worse - four object blobs instead of one, but of total size
not much larger (well, total size typically 3 disk blocks worse, due to
a slight increase in fragmentation from using 4 blocks to store what
used to be in one.)

But now I get stuck.  Unless I throw in something like the interleaved
delta compression that's at the heart of Marc Rochind's old SCCS code
(and Larry's rewrite thereof), I don't see how we ever come to the
practical realization that any of these four new blobs can ever be
reused.

So explain to me again how we ever gain anything with these combo blobs,
while I take a prophylactic aspirin, so the forehead whack won't hurt as
much.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
