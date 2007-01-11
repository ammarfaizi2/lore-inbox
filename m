Return-Path: <linux-kernel-owner+w=401wt.eu-S1750818AbXAKQU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbXAKQU7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbXAKQU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:20:59 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44131 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbXAKQU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:20:58 -0500
Date: Thu, 11 Jan 2007 08:20:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Viktor <vvp01@inbox.ru>
cc: Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <45A629E9.70502@inbox.ru>
Message-ID: <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2007, Viktor wrote:
> 
> OK, madvise() used with mmap'ed file allows to have reads from a file
> with zero-copy between kernel/user buffers and don't pollute cache
> memory unnecessarily. But how about writes? How is to do zero-copy
> writes to a file and don't pollute cache memory without using O_DIRECT?
> Do I miss the appropriate interface?

mmap()+msync() can do that too.

Also, regular user-space page-aligned data could easily just be moved into 
the page cache. We actually have a lot of the infrastructure for it. See 
the "splice()" system call. It's just not very widely used, and the 
"drop-behind" behaviour (to then release the data) isn't there. And I bet 
that there's lots of work needed to make it work well in practice, but 
from a conceptual standpoint the O_DIRECT method really is just about the 
*worst* way to do things.

O_DIRECT is "simple" in the sense that it basically is a "OS: please just 
get out of the way" method. It's why database people like it, and it's why 
it has gotten implemented in many operating systems: it *looks* like a 
simple interface. 

But deep down, O_DIRECT is anything but simple. Trying to do a direct 
access with an interface that really isn't designed for it (write() 
_fundamentally_ has semantics that do not fit the problem in that you're 
supposed to be able to re-use the buffer immediately afterwards in user 
space, just as an example) is wrong in the first place, but the really 
subtle problems come when you realize that you can't really just "bypass" 
the OS.

As a very concrete example: people *think* that they can just bypass the 
OS IO layers and just do the write directly. It *sounds* like something 
simple and obvious. It sounds like a total no-brainer. Which is exactly 
what it is, if by "no-brainer" you mean "only a person without a brain 
will do it". Because by-passing the OS has all these subtle effects on 
both security and on fundamental correctness.

The whole _point_ of an OS is to be a "resource manager", to make sure 
that people cannot walk all over each other, and to be the central point 
that makes sure that different people doing allocations and deallocations 
don't get confused. In the specific case of a filesystem, it's "trivial" 
things like serializing IO, allocating new blocks on the disk, and making 
sure that nobody will see the half-way state when the dirty blocks haven't 
been written out yet.

O_DIRECT - by bypassing the "real" kernel - very fundamentally breaks the 
whole _point_ of the kernel. There's tons of races where an O_DIRECT user 
(or other users that expect to see the O_DIRECT data) will now see the 
wrong data - including seeign uninitialized portions of the disk etc etc. 

In short, the whole "let's bypass the OS" notion is just fundamentally 
broken. It sounds simple, but it sounds simple only to an idiot who writes 
databases and doesn't even UNDERSTAND what an OS is meant to do. For some 
reasons, db people think that they don't need one, and don't ever seem to 
really understand the concept fo "security" and "correctness". They 
understand it (sometimes) _within_ their own database, but seem to have a 
really hard time seeing past their own sandbox.

Some of the O_DIRECT breakage could probably be fixed:

 - An O_DIRECT operation must never allocate new blocks on the disk. It's 
   fundamentally broken. If you *cannot* write new blocks, and can only 
   read and re-write previous allocations, things are much easier, and a 
   lot of the races go away.

   This is probably _perfectly_ fine for the users (namely databases). 
   People who do O_DIRECT really expect to see a "raw disk image", but 
   they (exactly _because_ they expect a raw disk image) are perfectly 
   happy to "set up" that image beforehand.

 - An O_DIRECT operation must never race with any metadata operation, 
   most notably truncate(), but also any file extension operation like a 
   normal write() that extends the size of the file.

   This should be reasonably easy to do. Any O_DIRECT operation would just 
   take the inode->i_mutex for reading. HOWEVER. Right now it's a mutex, 
   not a read-write semaphore, so that is actually pretty painful. But it 
   would be fairly simple.

With those two rules, a lot of the complexity of the nasty side effects of 
O_DIRECT that the db people obviously never even thought about would go 
away. We'd still have to have some way to synchronize the page cache, but 
it could be as simple as having an O_DIRECT open simply _flush_ the whole 
page cache, and set some flag saying "can't do normal opens, we're 
exclusively open for O_DIRECT".

I dunno. A lot of filesystems don't want to (or can't) actually do a 
"write in place" ANYWAY (writes happen through the log, and hit the "real 
filesystem" part of the disk later), and O_DIRECT really only makes sense 
if you do the write in place, so the above rules would help make that 
obvious too - O_DIRECT really is a totally different thing from a normal 
IO, and an O_DIRECT write() or read() really has *nothing* to do with a 
regular write() or read() system call. 

Overloading a totally different operation with a flag is a bad idea, which 
is one reason I really hate O_DIRECT. It's just doing things badly on so 
many levels.

			Linus
