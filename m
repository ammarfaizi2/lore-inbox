Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTJJQCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTJJQCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:02:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:17552 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262366AbTJJQAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:00:41 -0400
Date: Fri, 10 Oct 2003 09:00:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031010152710.GA28773@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0310100839030.20420-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Oct 2003, Joel Becker wrote:
> > I hope disk-based databases die off quickly.
> 
> 	As opposed to what?  Not a challenge, just interested in what
> you think they should be.

I'm hoping in-memory databases will just kill off the current crop 
totally. That solves all the IO problems - the only thing that goes to 
disk is the log and the backups, and both go there totally linearly unless 
the designer was crazy.

Yeah, I don't follow the db market, but it's just insane to try to keep 
the on-disk data in any other format if you've got enough memory. Recovery 
may take a long time (reading that whole backup into memory and redoing 
the log will be pretty expensive), but replication should handle that 
trivially.

> 	Where I work doesn't change the need for O_DIRECT.  If your Big
> App has it's own cache, why copy the cache in the kernel?

Why indeed? 

But why do you think you need O_DIRECT with very bad semantics to handle
this?

The kernel page cache does multiple things:
 - staging area for letting the filesystem do blocking (ie this is why a 
   regular "write()" or "read()" doesn't need to care about alignment etc)
 - a synchronization entity - making sure that a write and a read cannot 
   pass each other, and that mmap contents are always _coherent_.
 - a cache

O_DIRECT throws the cache part away, but it throws out the baby with the
bathwater, and breaks the other parts. Which is why O_DIRECT breaks things
like disk scheduling in really subtle ways - think about writing and
reading to the same area on the disk, and re-ordering at all different 
levels. 

And the thing is, uncaching is _trivial_. It's not like it is hard to say
"try to get rid of these pages if they aren't mapped anywhere" and "insert
this user page directly into the page cache". But people are so fixated
with "direct to disk" that they don't even think about it.

			Linus

