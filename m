Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288362AbSACWuC>; Thu, 3 Jan 2002 17:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288367AbSACWty>; Thu, 3 Jan 2002 17:49:54 -0500
Received: from fungus.teststation.com ([212.32.186.211]:34311 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S288362AbSACWts>; Thu, 3 Jan 2002 17:49:48 -0500
Date: Thu, 3 Jan 2002 23:49:34 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs fsx'ed
In-Reply-To: <Pine.LNX.4.33.0201031335150.2216-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201032257300.28529-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Linus Torvalds wrote:

> Btw, Urban, is anybody working on trying to do "{read|write}page()"
> asynchronously? I assume that IO performance on smbfs must be quite
> horrible with totally synchronous IO..

Yes. My current list of work:
 ! Large File Support
 ! Unicode Support
 + Async requests
 + Fcntl locking + smb "oplock" support
 - Async readpage/writepage (and readahead)
 - Merge read or write requests for one file into a larger request.
   I am guessing that is how NFS does it.
 + smbconnect instead of smbmount. smbfs calls to a userspace program to
   set up the connection (a la modprobe) and is mounted by mount directly
   like any other fs.
 - Review of smbfs BKL use. I believe a lot of it is unnecessary and just
   an effect of the VFS-level changes.

! = ready, waiting for the previous patch to be accepted & released
+ = code is almost working (90% done, if that joke is familiar :)
- = not actual patches yet ... more like ideas and that I know where to
    find some code to borrow from :)


The current code synchronizes all threads on the same mount since all
threads use "server->packet" as a buffer for send and receive. I have some
code where I have tried to copy how I believe nfs does things with a
"struct request" for each caller.

The requests are filled in and put on a per-server transmit queue and the
caller goes to sleep or returns. There is a smbiod kernel thread that does
the actual send and receive and wakes up the callers. Currently just one
smbiod as that is a little bit easier than having, say, one per processor.

I'm currently looking at a race where it hangs if I run 4 fsx-linux
processes at once. But otherwise it seems to work.

This should be a big win for having more than one process at a time doing
something on a smbfs mount. But I haven't benchmarked it yet.


Oplocks are interesting, they can cause the server to send a request
(a break) to the client and the current smbfs sock.c code doesn't really
expect that. This is the original reason for smbiod and the async request
handling.

With an async request handling making readpage/writepage async shouldn't
be too horrible. NFS has some kind of callbacks ... how hard can it be :)

/Urban

