Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbUKRSvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbUKRSvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbUKRStN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:49:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:56515 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262862AbUKRSsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:48:02 -0500
Date: Thu, 18 Nov 2004 10:47:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Miklos Szeredi <miklos@szeredi.hu>, hbryan@us.ibm.com, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <20041118182814.GB29736@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0411181035140.2222@ppc970.osdl.org>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <20041118182814.GB29736@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Jamie Lokier wrote:
>
> Linus Torvalds wrote:
> > Why do you think it would kill the FUSE process? And why do you think 
> > killing _any_ process would make the system come back to life? After all, 
> > memory wasn't filled by process usage, it was filled by dirty FS pages.
> > 
> > I really do believe that user-space filesystems have problems. There's a 
> > reason we tend to do them in kernel space. 
> 
> Are kernel space filesystems immune from this problem?  What happens
> when they need to kmalloc() in order to write some data?

That's why we have GFP_NOFS and other flags (PF_MEMALLOC etc). So yes,
they are "immune" in the sense that they have been inocculated, but not in
the sense that they can't have the bug conceptually.

So the kernel not only keeps a set of reserved pages for atomic 
allocations, but also the VM knows not to recurse into a filesystem 
operation when the reason for the memory allocation was a low-memory 
circumstance. When a filesystem asks for memory in the page-out path, the 
VM may still throw out cached pages for that FS, but it won't try to write 
them back.

Guys, there is a _reason_ why microkernels suck. This is an example of how 
things are _not_ "independent". The filesystems depend on the VM, and the 
VM depends on the filesystem. You can't just split them up as if they were 
two separate things (or rather: you _can_ split them up, but they still 
very much need to know about each other in very intimate ways).

So what do you do? You limit shared dirty pages (inefficient memory use),
or you disallow certain behaviours, or you add tons of new interfaces to
expose essentially the same "every thing that can allocate and is on the
write-out path takes a GFP flag".

User-space filesystems are hard to get right. I'd claim that they are 
almost impossible, unless you limit them somehow (shared writable mappings 
are the nastiest part - if you don't have those, you can reasonably limit 
your problems by limiting the number of dirty pages you accept through 
normal "write()" calls). 

			Linus
