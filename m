Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUIMDDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUIMDDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 23:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUIMDDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 23:03:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24248 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265144AbUIMDDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 23:03:16 -0400
Date: Sun, 12 Sep 2004 20:02:53 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>, Brent Casavant <bcasavan@sgi.com>,
       Andi Kleen <ak@suse.de>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: more numa maxnode confusions
Message-Id: <20040912200253.3d7a6ff5.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that a merge error on my part is contributing further to the
confusions over the meaning of the 'maxnode' parameter to the numa
mbind/set_mempolicy/get_mempolicy calls.  The question is whether
maxnode should be passed in as the number of bits, or one more than the
number of bits (64 or 65 if MAX_NUMNODES is 64, for example).

I will call these two choices the N64 and N65 choices.

As best as I can reconstruct the events, the following has happened over
the last month:

 1) In the beginning, Andi designed this numa interface to be N65.

 2) About Aug 9, Brent Casavant sent in a patch changing the set (not get)
    side calls, sys_mbind and sys_set_mempolicy, to N64.  This patch
    removed the following line from the implementation of get_nodes() in
    mm/mempolicy.c:

	--maxnode;

 3) Due presumably to a merge confusion on my part, my subsequent
    cpuset patch (the original, largest one now dated Sept 2)
    put this line back in, making the interface N65 again.

So currently, a quick reading of the code (could easily be wrong) tells
me that the compat interfaces and the 'get' side (get_mempolicy) are
always N65, but that the native 'set' side is N64 without my cpuset
patch (but with Brent's patch), but N65 with my cpuset patch, which adds
back in the "--maxnode" line to get_nodes().

Currently, by my reading, Linus' bk tree has the mixed N64/N65
interfaces, since it has Brent's patch, but not my cpuset patch.
Andrew's *-mm tree has the pure N65 interface, due to my cpuset patch
reversing Brent's patch.

My guess is that Andi wants this all N65, and that he didn't agree to
Brent's patch.  If Andi understands different, that's fine -- I'm not
trying to reopen that battle.

Andi:

 0) Are my above statements anywhere close to correct?

 1) Should the "--maxnode" be re-inserted in get_nodes()?

 2) Should it be re-inserted by a separate patch from you,
    rather than as a hidden side affect of my cpuset patch?
    I will gladly remove that line from my cpuset patch, in
    favor of a one-liner from you that re-inserts that line.

Brent:

 1) Would you agree to having your partial N64 patch reversed,
    if my efforts to channel Andi's thoughts have succeeded,
    and he wants the "--maxnode" in the code?

Andrew:

 1) Once it's settled on where we (Andi, mostly) wants to go,
    how do you want the patch(es)?  It seems silly for me to
    send in a patch that undoes the re-insertion, just so Andi
    can send in another patch that redoes it.  I will gladly do
    pretty much anything you and Andi agree to here, but you may
    have to spell it out to me in small, simple words ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
