Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUBSXhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUBSXhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:37:48 -0500
Received: from dp.samba.org ([66.70.73.150]:23249 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267421AbUBSXhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:37:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16437.18605.71269.750607@samba.org>
Date: Fri, 20 Feb 2004 10:37:17 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
	<Pine.LNX.4.58.0402181427230.2686@home.osdl.org>
	<16435.60448.70856.791580@samba.org>
	<Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
	<16435.61622.732939.135127@samba.org>
	<Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
	<20040219081027.GB4113@mail.shareable.org>
	<Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
	<20040219163838.GC2308@mail.shareable.org>
	<Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
	<20040219182948.GA3414@mail.shareable.org>
	<Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I'm probably just thicker than a complete set of superman comics, and
probably haven't had enough coffee this morning, but I'm still trying
to understand exactly how much this is going to gain us.

If I understand it, your suggestion gives us:

 - a way of telling if a directory is fully cached in the dcache
 - a way of scanning that full cache with whatever braindead
   comparison algorithm we want

At first I didn't understand the scanning part at all, because I
didn't realise that you could scan just the dentries associated with a
single directory. Al was kind enough to correct me on that.

What your proposal doesn't give us is case-insensitive indexing into
the dcache. The reason the dcache is such a great thing in Linux is
that it is indexed by name, so you rarely do any scanning at all, and
even the case where you have never seen the name before we avoid
scanning because fast filesystems also use a "indexed by name"
scheme. Now maybe I'm just over-obsessed about this scanning stuff and
I'd need some profiles to see how much it would cost (although the
cost as the directory size gets really large seems obvious).

The really interesting part of your proposal is that it opens up the
possibility of a coherence mechanism between a cache that is indexed
by some windows like scheme and the real dcache. If those two bits
could be used by the windows_braindead module to determine if its own
separately indexed cache was current then we'd really be getting
somewhere. 

If we didn't do the separate cache at all, then your proposal still
should hugely reduce the number of times we ask the filesystem for a
list of files in the directory, although as those calls are already
cached at the block device level what I suppose it does is move the
cache up a level. I don't have a clear idea of how much faster it is
to do this scanning in the dcache versus in the filesystem in the
hot-cache case, so I am not clear on how much this wins us. I'm
prepared to believe it could be quite significant though.

I really need more coffee-and-think time on this, plus maybe some
quick and dirty profiling tests to see what the various costs are
like. 

While I'm here I should point out that I'm thinking of the 2.7/2.8
kernel (or even 3.0) for any change, not 2.6. Maybe thats obvious
anyway, but the corresponding userspace changes in Samba definately
won't be happening in Samba 3.0, so this is a Samba 4.0 thing, which
is a fair way off. This means we've got plenty of time to try some
experiments and see what schemes really help.

Cheers, Tridge
