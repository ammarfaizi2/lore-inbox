Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbTJJRlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbTJJRlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:41:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:33996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263085AbTJJRlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:41:03 -0400
Date: Fri, 10 Oct 2003 10:40:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031010172001.GA29301@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0310101024200.20420-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Oct 2003, Joel Becker wrote:
> 
> 	msync() forces write(), like fsync().  It doesn't force read().

Actually, the kernel has a "readahead(fd, offset, size)" system call that
will start asynchronous read-ahead on any mapping. After that, just
touching the page will obviously map in and synchronize the result.

I don't think anybody uses it, and the interface may be broken, but it was
literally 20 lines of code, and I had a trivial test program that
populated the cache for a directory structure really quickly using it.

In general, it would be really nice to have more oracle people discussing
what their particular pet horror is, and what they'd really like to do.

I know you're more used to just doing your own thing and working with
vendors, but even just people getting used to do the unofficial "this is
what we do, and it sucks because xxx" would make people more aware of what 
you wan tto do, and maybe it would suggest novel ways of doing things.

I suspect most of the things would get shot down as being impractical, but
there have always been a lot of discussion about more direct control of
the page cache for programs that really want it, and I'm more than willing
to discuss things (obviously 2.7.x material, but still.. A lot of it is
trivial and could be back-ported to 2.6.x if people start using it).

For example, things we can do, but don't, partly because of interface 
issues and because there is no point in doing it if people wouldn't use 
it:

 - moving a page back and forth between user space. It's _trivial_ to do, 
   with a fallback on copying if the page happens to be busy (ie we can 
   often just replace the existing page cache page, but if somebody else
   has it mapped, we'd have to copy the contents instead)

   We can't do this for "regular" read and write, because the resulting 
   copy-on-write sitution makes it less than desireable in most cases, but 
   if the user space specifically says "you can throw these pages away
   after moving them to the page cache", that avoids a lot of horror.

   The "remap_file_pages()" thing kind of does this on the read side (ie 
   it says "map in this page cache entry into my virtual address space"), 
   but we don't have the reverse aka "take this page in the virtual 
   address space and map it into the page cache".

   Interfaces like these would also allow things like zero-copy file
   copies with smaller page cache footprints - at the expense of 
   invalidating the cache for the source file as a result of the copy. 
   Which is why it can't be a _regular_ read - but it's one of those 
   things where if the user knows what he wants..

 - dirty mapping control (ie controlling partial page dirty state, and 
   also _delaying_ writeout if it needs to be ordered). Possibly by having 
   a separate backing store (ie a mmap that says "read from this file, but
   write back to that other file") to avoid the nasty memory management 
   problems.

A lot of these are really easy to do, but the usage and the interfaces are 
non-obvious.

		Linus

