Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292223AbSBBE3L>; Fri, 1 Feb 2002 23:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292222AbSBBE3B>; Fri, 1 Feb 2002 23:29:01 -0500
Received: from turing.cs.hmc.edu ([134.173.42.99]:44987 "EHLO
	turing.cs.hmc.edu") by vger.kernel.org with ESMTP
	id <S292221AbSBBE2l>; Fri, 1 Feb 2002 23:28:41 -0500
Date: Fri, 1 Feb 2002 20:32:21 -0800 (PST)
From: Nathan Field <nathan@cs.hmc.edu>
To: Daniel Jacobowitz <dan@debian.org>
cc: <linux-kernel@vger.kernel.org>
Subject: PATCH: Re: BUG: PTRACE_POKETEXT modifies memory in related processes
In-Reply-To: <20020131110659.A6197@nevyn.them.org>
Message-ID: <Pine.GSO.4.32.0201311500290.10242-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I believe I have found a bug in recent 2.4 linux kernels (at least 2.4.17)
> > running on x86 related to using ptrace to modify a processes memory. From
[snip incorrect guess at cause of problem]
>
> I don't think you're correctly understanding the circumstances.  Are
> you setting the breakpoint after they fork (seems unlikely, given this
> test case - not much time to do so)?  Otherwise, the breakpoint is
> simply being carried over by your forking.  Why you see it now and did
> not before I don't know.
	Actually I do understand the circumstances. I am setting the
breakpoint _AFTER_ the fork, when the parent and the child should exist in
different memory spaces.

> Basically, GDB on Linux does not support fork very well.  It doesn't
> show up terribly often, because exec() clears breakpoints.
	You are right on that, GDB sucks when debugging forks, which is
why I have written my own debugger that can correctly handle forks. This
is why I've come across this problem. Basically I detect a fork, do some
magic, catch the child process before it continues to run and attach to
it. Then I remove all the breakpoints from the child that were in the
parent. The problem is that in 2.4.17 when I remove the breakpoints from
the child they are also removed from the parent. I do know what I'm
talking about here, I'm not trying to remove the breakpoints before the
fork system call, it is after the fork system call (I actually remove the
breakpoints after the fork library call has returned), and the bug is
related to COW because I figured out exactly what's wrong and here's a
patch that fixes it:

--- ptrace.c.orig	Fri Feb  1 20:17:18 2002
+++ ptrace.c	Fri Feb  1 19:54:58 2002
@@ -148,16 +148,16 @@
 		int bytes, ret, offset;
 		void *maddr;

-		ret = get_user_pages(current, mm, addr, 1,
-				write, 1, &page, &vma);
-		if (ret <= 0)
-			break;
-
 		bytes = len;
 		offset = addr & (PAGE_SIZE-1);
 		if (bytes > PAGE_SIZE-offset)
 			bytes = PAGE_SIZE-offset;

+		ret = get_user_pages(current, mm, addr, 1,
+				write, 1, &page, &vma);
+		if (ret <= 0)
+			break;
+
 		flush_cache_page(vma, addr);

 		maddr = kmap(page);
@@ -173,6 +173,7 @@
 		put_page(page);
 		len -= bytes;
 		buf += bytes;
+		addr += bytes;
 	}
 	up_read(&mm->mmap_sem);
 	mmput(mm);


Basically the kernel was calling get_user_pages on the same address, even
as it moved through different addresses in memory. I have tested this
change on my own 2.4.17 kernel and it now works correctly.

	nathan

------------
Nathan Field  Root is not something to be shared with strangers.

"The nice thing about standards is that there's so many to choose from."
        -- Andrew S. Tanenbaum

