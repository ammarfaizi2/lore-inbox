Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTJJQ0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTJJQ0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:26:31 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:41178 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S262817AbTJJQ02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:26:28 -0400
Date: Fri, 10 Oct 2003 09:26:07 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010162606.GB28773@ca-server1.us.oracle.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031010152710.GA28773@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100839030.20420-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310100839030.20420-100000@home.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 09:00:23AM -0700, Linus Torvalds wrote:
> I'm hoping in-memory databases will just kill off the current crop 
> totally. That solves all the IO problems - the only thing that goes to 
> disk is the log and the backups, and both go there totally linearly unless 
> the designer was crazy.

	Memory is continuously too small and too expensive.  Even if you
can buy a machine with 10TB of RAM, the price is going to be
prohibitive.  And when 10TB of RAM costs better, the database is going
to be 100TB.
	I'm not saying that in-memory is bad.  Big databases do
everything they can to make the workload look almost like in-memory.
It's the only way to go.

> But why do you think you need O_DIRECT with very bad semantics to handle
> this?

	I don't need O_DIRECT with bad semantics.  I need the semantics
I need, I know that other OSes have O_DIRECT to provide those
capabilities, and everyone loves portability.  That said...

> O_DIRECT throws the cache part away, but it throws out the baby with the
> bathwater, and breaks the other parts. Which is why O_DIRECT breaks things
> like disk scheduling in really subtle ways - think about writing and
> reading to the same area on the disk, and re-ordering at all different 
> levels. 

	Sure, but you don't do that.  The breakage in mixing O_DIRECT
with pagecache I/O to the same areas of the disk isn't even all that
subtle.  But you shouldn't be doing that, at least constantly.

> And the thing is, uncaching is _trivial_. It's not like it is hard to say
> "try to get rid of these pages if they aren't mapped anywhere" and "insert
> this user page directly into the page cache". But people are so fixated
> with "direct to disk" that they don't even think about it.

	I'm not fixated.  "Use this user page for the page cache entry
for this offset into the file", "Change this user page from representing
this offset in this file to representing that offset in that file", and
"whatever you do, always read/write from backing store for this page"
are the semantics needed.  For the latter, you'd have to have a way for
the app to trigger a read or write out of the cache.  You don't want to
do it on every page modification or access, that's too often.  The
application knows the syncronization points, not the kernel.

Joel

-- 

"There is a country in Europe where multiple-choice tests are
 illegal."
        - Sigfried Hulzer

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
