Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264073AbUFFTtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUFFTtb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 15:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUFFTtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 15:49:31 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:32643 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264073AbUFFTtY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 15:49:24 -0400
Subject: Re: Killing POSIX deadlock detection
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Matthew Wilcox <willy@debian.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040606132751.GZ5850@parcelfarce.linux.theplanet.co.uk>
References: <200406050725.i557P3hQ004052@supreme.pcug.org.au>
	 <20040606130422.0c8946b3.sfr@canb.auug.org.au>
	 <20040606132751.GZ5850@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086551360.5472.48.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 15:49:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 06/06/2004 klokka 09:27, skreiv Matthew Wilcox:
\
> > T1 locks file F1 -> lock (P1, F1)
> > P2 locks file F2 -> lock (P2, F2)
> > P2 locks file F1 -> blocks against (P1, F1)
> > T1 locks file F2 -> blocks against (P2, F2)
> 
> Less contrived example -- T2 locks file F2.  We report deadlock here too,
> even though T1 is about to unlock file F1.

So what is better: report an error and give the user a chance to
recover, or allowing the potential deadlock?
Only the user can resolve problems such as the above threaded problem,
given the SuS definitions.

> So, final call.  Any objections to never returning -EDEADLCK?

Yes: As Chuck points out, that is a fairly nasty change of the userland
API.

Worse: it is a change that fixes only one problem for only a minority of
users (those that combine locking over multiple NPTL threads - a
situation which after the "fix" remains just as poorly defined) at the
expense of reintroducing a series of deadlocking problems for those
single threaded users that rely on the EDEADLK (and have done so
throughout the entire 2.4.x series).

Finally, EDEADLK does actually appear to be mandatory to implement in
SUSv3, given that it states:

        A potential for deadlock occurs if a process controlling a
        locked region is put to sleep by attempting to lock another
        process' locked region. If the system detects that sleeping
        until a locked region is unlocked would cause a deadlock,
        fcntl() shall fail with an [EDEADLK] error.
        
(again see
http://www.opengroup.org/onlinepubs/009695399/functions/fcntl.html)

Trond
