Return-Path: <linux-kernel-owner+w=401wt.eu-S932295AbXALQ71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbXALQ71 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 11:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbXALQ71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 11:59:27 -0500
Received: from mx33.mail.ru ([194.67.23.194]:8530 "EHLO mx33.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295AbXALQ70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 11:59:26 -0500
X-Greylist: delayed 103543 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 11:59:26 EST
Message-ID: <45A7BE54.7010609@inbox.ru>
Date: Fri, 12 Jan 2007 19:59:00 +0300
From: Viktor <vvp01@inbox.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060212 Fedora/1.7.12-5
X-Accept-Language: en-us, ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>>OK, madvise() used with mmap'ed file allows to have reads from a file
>>with zero-copy between kernel/user buffers and don't pollute cache
>>memory unnecessarily. But how about writes? How is to do zero-copy
>>writes to a file and don't pollute cache memory without using O_DIRECT?
>>Do I miss the appropriate interface?
> 
> 
> mmap()+msync() can do that too.

Sorry, I wasn't sufficiently clear. Mmap()+msync() can't be used for
that if data to be written come from some external source, like video
capturing hardware, which DMA'ing data directly into the user space
buffers. Using mmap'ed area for those DMA buffers doesn't look as a good
idea, because, e.g., it will involve unneeded disk reads on the first
page faults.

So, some O_DIRECT-like interface should exist in the system. Also, as
Michael Tokarev noted, operations over mmap'ed areas don't provide good
ways for error handling, which effectively makes them unusable for
something serious.

> Also, regular user-space page-aligned data could easily just be moved into 
> the page cache. We actually have a lot of the infrastructure for it. See 
> the "splice()" system call. It's just not very widely used, and the 
> "drop-behind" behaviour (to then release the data) isn't there. And I bet 
> that there's lots of work needed to make it work well in practice, but 
> from a conceptual standpoint the O_DIRECT method really is just about the 
> *worst* way to do things.

splice() needs 2 file descriptors, but looking at it I've found
vmsplice() syscall, which, seems, can do the needed actions, although
I'm not sure it can work with files and zero-copy. Thanks for pointing
on those interfaces.

