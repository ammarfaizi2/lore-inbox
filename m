Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbUKUHnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbUKUHnT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 02:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUKUHnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 02:43:10 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:57229 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261922AbUKUHnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 02:43:02 -0500
To: pavel@ucw.cz
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20041118144634.GA7922@openzaurus.ucw.cz> (message from Pavel
	Machek on Thu, 18 Nov 2004 15:46:34 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu> <20041118144634.GA7922@openzaurus.ucw.cz>
Message-Id: <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 08:42:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, this one works, I agree... But it will be way slower than coda's
> file-backed approach, right?

No.  In both cases there will be two memory copies:

  - from userspace fs to pagecache
  - from pagecache to read buffer

And vica versa for write.  FUSE will have some overhead of context
switches, but in the optimal case (sequential read), the readahead
code will bundle read requests, and with a 128MByte read, the cost of
a context switch is probably infinitesimal.

> > In the second case there is no deadlock, because the memory subsystem
> > doesn't wait for data to be written.  If the filesystem refuses to
> > write back data in a timely manner, memory will get full and OOM
> > killer will go to work.  Deadlock simply cannot happen.
> 
> Hmmm, so if userspace part is swapped out and data is dirtied
> "too quickly", OOM is practically guaranteed? That is not nice.

Yeah.  I imagined, that the kernel won't assign all it's free pages to
file mappings, but people on the list enlightened me to the contrary.

There seem to be two kinds of solutions:

  1) make the userspace part aware of the memory allocation problems

  2) limit the number of pages that can be dirtied


I don't really like 1) because that really kills the point of
implementing the filesystem in userspace.

So I would go along the lines of 2).  However there is no way to know
when pages are dirtied (ther is no fault), so accounting the dirty
pages exactly is not possible.  However accounting the _writable_
pages should be possible with no overhead, since there is a fault when
the page of a mapping is first touched.

Limiting these pages for FUSE, would mean that the user could do
writable mmap, but with the performance penaly of having a limited
number of pages present in memory.  If the userspace FS refuses to
write back data, the filesystem user will be blocked until the
writeback is completed.  No deadlock (hopefully).

Miklos
