Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318101AbSGWPra>; Tue, 23 Jul 2002 11:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318102AbSGWPr3>; Tue, 23 Jul 2002 11:47:29 -0400
Received: from twin.jikos.cz ([217.11.236.59]:21181 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id <S318101AbSGWPr3>;
	Tue, 23 Jul 2002 11:47:29 -0400
Date: Tue, 23 Jul 2002 17:50:17 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Covici <covici@ccs.covici.com>, <linux-kernel@vger.kernel.org>
Subject: Re: is flock broken in 2.4 or 2.5 kernels or what does this mean?
In-Reply-To: <1027441872.31787.139.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207231748150.9333-100000@twin.jikos.cz>
References: <m37kjmik0g.fsf@ccs.covici.com> <1027441872.31787.139.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2002, Alan Cox wrote:

> > Can anyone tell me what this is all about -- is there any basis in
> > reality for what they are saying?
> First I've heard of it, so it would be useful if someone has access to
> the sendmail problem report/test in question that shows it and I'll go
> find out.

Quoting Stephen Tweedie's earlier post to the list:

==
It really is broken, and sendmail triggers it (at least their
commercial binaries do).  I've already been talking to willy about the
problem. The trouble is the accounting: if one process opens a fd and then
fork()s, it is possible for the lock to be taken in the parent and
released in the child (or vice versa) --- unless there's an explicit
flock(LOCK_UN), then the lock will be released implicitly when the
last reference to the fd is closed. When this happens, we get the lock 
count incremented in one task and
decremented in another.  That can wrap the lock count backwards to -1
(or rather ~0UL), which causes the locks rlimit check to think we've
exceeded the lock quota and new lock requests will fail.  It's easy to
reproduce this: try the attached prog.  It produces an erroneous
ENOLCK due to the bug.
==

-- 
JiKos.


