Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288399AbSACXuA>; Thu, 3 Jan 2002 18:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288402AbSACXtu>; Thu, 3 Jan 2002 18:49:50 -0500
Received: from fungus.teststation.com ([212.32.186.211]:46599 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S288399AbSACXti>; Thu, 3 Jan 2002 18:49:38 -0500
Date: Fri, 4 Jan 2002 00:48:59 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs fsx'ed
In-Reply-To: <DE185415BB6@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0201040005090.28529-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Petr Vandrovec wrote:

> On  3 Jan 02 at 13:37, Linus Torvalds wrote:
> > 
> > (Not as horrible as the NCPFS thing that doesn't understand about the page
> > cache at all, but still..)
> 
> Unfortunately it is not easy for me to add pagecache support
> to ncpfs, as couple of ncpfs users uses ncpfs in shared environment
> with database record locking, and if I'll now read full 4KB instead of
> 128B record, it can clash with records locked by other clients.

Does the locks prevent you from even looking? You could read only the
parts requested if the file has locks and fill the rest with 0. Only using
the page cache if there are no locks. Not too pretty but ...

I was thinking about writes when you wrote that.

A write of 128 bytes to a file cause a commit_write of 128 bytes, if I am
reading generic_file_write correctly. So that should not cause it to write
the full page and that would be ok for the locking case.

You only read the 128 bytes the user has locked and requested, and then
you only write those bytes. The userspace won't care about the parts of
the page that is 0 and since the file is being shared you will have to
re-read the data on the next syscall anyway.


> I can for sure add `leases' like Novell Client for Windows does for
> possibility of file caching, but I'm not sure whether size of code
> needed for supporting this (and for supporting server driven
> cache flushes) is worth of effort.

smbfs needs these for cooperating clients to work. It can only cache data
if it has a lease. If someone else is also accessing the file then each
smb_file_read must re-read the page.

shared mmaps and SMB oplocks doesn't seem to mix however. Hard to know
when to invalidate a page ... what is caching and what is the "read"?


> P.S.: And as NCP protocol is totally synchronous (even if it uses
> TCP, I explicitly asked in Utah), only local file caching can increase
> ncpfs performance, as there is no such thing like asynchronous file
> read/write...

SMB has no async read/write, but all requests are marked with an ID and it
is allowed to have a certain number of simultaneous requests in transit.

Even without multiple requests you could let ncpfs accept one read
request, send that to the server and return without waiting for the reply.
The readahead code may then queue up the next request for ncpfs, and ncpfs
could process that while the previously read page is returned to the user.

(Warning: I don't know if that is how it actually would work ...
 I am looking at "readpage:" of do_generic_file_read, mm/filemap.c)


I am not saying that it would be worth the effort.

/Urban

