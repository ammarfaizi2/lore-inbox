Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTJJVJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 17:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTJJVJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 17:09:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:32722 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262739AbTJJVJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 17:09:33 -0400
Date: Fri, 10 Oct 2003 14:09:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Jamie Lokier <jamie@shareable.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <16263.6450.819475.453165@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0310101402370.25501-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Oct 2003, Trond Myklebust wrote:
> 
> In fact, I recently noticed that we still have this race in the NFS
> file locking code: readahead may have been scheduled before we
> actually set the file lock on the server, and may thus fill the page
> cache with stale data.

The current "invalidate_inode_pages()" is _not_ equivalent to a specific
user saying "these pages are bad and have to be updated".

The main difference is that invalidate_inode_pages() really cannot assume
that the pages are bad: the pages may be mapped into another process that 
is actively writing to them, so the regular "invalidate_inode_pages()" 
literally must not force a re-read - that would throw out real 
information.

So "invalidate_inode_pages()" really is a hint, not a forced eviction.

A forced eviction can be done only by a user that says "I have write
permission to this file, and I will now say that these pages _have_ to be
thrown away, whether dirty or not".

And that's totally different, and will require a totally different 
approach.

(As to the read-ahead issue: there's nothing saying that you can't wait
for the pages if they aren't up-to-date, and really synchronize with
read-ahead. But that will require filesystem help, if only to be able to
recognize that there is active IO going on. So NFS would have to keep 
track of a "read list" the same way it does for writeback pages).

		Linus

