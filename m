Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUBTB14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267665AbUBTB14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:27:56 -0500
Received: from dp.samba.org ([66.70.73.150]:21639 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267602AbUBTB0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:26:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16437.25160.121741.397124@samba.org>
Date: Fri, 20 Feb 2004 12:26:32 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <Pine.LNX.4.58.0402191625060.2244@ppc970.osdl.org>
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
	<16437.18605.71269.750607@samba.org>
	<Pine.LNX.4.58.0402191549500.2244@ppc970.osdl.org>
	<16437.20949.701574.932001@samba.org>
	<Pine.LNX.4.58.0402191625060.2244@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > I an try to see if I can write something - I'd not do the actual
 > comparison function, but I have the rough framework in my mind. I won't
 > get to it for another day or two, at _least_, though.

ok, that would be excellent. Please don't think there is a huge rush
on this though, whatever we come up with won't be in wide use for a
year at least, and probably longer. The sort of changes in Samba we
need really are most suited for the NTVFS layer in Samba4, and we may
even end up with a ntvfs_linux backend completely separate from the
ntvfs_posix backend that we would use on other unixes. That won't
happen overnight (heck, ntvfs_posix doesn't even exist yet for
Samba4). 

 > With that set up, getting numbers and doing a kernel profile to see where
 > the time goes is probably not hard - again, if you have a samba setup with
 > benchmarks already set up. I just don't know anybody who knows both pieces
 > of the puzzle..

I'm happy to provide the load and profiling tools, probably using
something like dbench but with a different load and a proportion of
case-insensitive lookups (dbench is currently case-sensitive).

One minor thing about your design. You talked about making the new
call actually do the open(). It would be better to just return the
stat information and the real (case sensitive) name. Windows clients
do stat() like calls (Trans2_qpathinfo) roughly 10x as much as they
actually do open() like calls.

We also like to avoid doing open() whenever possible because of the
silly "lose all your locks on close" problem. I know that we've
discussed before fixing that locking stupidity, but even so I think
just returning the stat() info and real name is easiest. Samba needs
to know the name anyway, as there are calls in SMB that ask "what is
the name of the file for this file descriptor I've got open", and we
really should return the case-preserving name.
 
Cheers, Tridge
