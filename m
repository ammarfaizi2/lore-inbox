Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSILWCz>; Thu, 12 Sep 2002 18:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSILWCz>; Thu, 12 Sep 2002 18:02:55 -0400
Received: from fungus.teststation.com ([212.32.186.211]:13836 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S315758AbSILWCy>; Thu, 12 Sep 2002 18:02:54 -0400
Date: Fri, 13 Sep 2002 00:05:38 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Chuck Lever <cel@citi.umich.edu>
cc: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>, <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <Pine.BSO.4.33.0209101036040.5887-100000@citi.umich.edu>
Message-ID: <Pine.LNX.4.44.0209111044120.6219-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Chuck Lever wrote:

> client.  also, i'd really like to hear from maintainers of other network
> file systems about how they manage cache coherency.

I have a feeling that smbfs was built around an assumption that if it has
a file open, no one else can change it. I don't think that is valid
even with older smb protocols.

>From reading (selected parts of) this thread I believe the requirements
from smbfs is much like the nfs ones. An incomplete summary of what is
currently done:

1. If attributes of a file changes (size, mtime) the cached data is
   purged.

2. Directory changes does not modify the mtime of the dir on windows
   servers so a timeout is used.

3. Cached file data is currently not dropped when a file is closed. But
   any dirty pages are written. I guess the idea is that (1) would still
   catch any changes even if the file isn't open.


smbfs in 2.5 will support oplocks, where the server can tell the client
that someone else wants to open the same file, called an "oplock break".
The client should then purge any cached file data and respond when it is 
done.

This needs to be a nonblocking purge for similar reasons as mentioned for
rpciod. The suggested best-effort-try-again-later invalidate sounds ok for
that.

There exists smb documentation stating that caching is not allowed without
a held oplock. But how to deal with mmap wasn't really in that authors 
mind.

If I understood Andrew right with the inode flag that won't purge anything 
until the next userspace access. I don't think that is what smbfs wants 
since the response to the oplock break should happen fairly soon ...

/Urban

