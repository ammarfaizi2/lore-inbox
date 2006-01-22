Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWAVDuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWAVDuw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 22:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWAVDuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 22:50:51 -0500
Received: from kanga.kvack.org ([66.96.29.28]:57298 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932241AbWAVDuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 22:50:51 -0500
Date: Sat, 21 Jan 2006 22:46:38 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile() with 100 simultaneous 100MB files
Message-ID: <20060122034638.GA1008@kvack.org>
References: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com> <20060121022237.GW3927@mea-ext.zmailer.org> <9e4733910601201943y77fb9a1fgf2a5f0d48eca1344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910601201943y77fb9a1fgf2a5f0d48eca1344@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 10:43:44PM -0500, Jon Smirl wrote:
> 100 users at 500K each is 50MB of read ahead, that's not a huge amount of 
> memory

The system might be overrunning the number of requests the disk elevator 
has, which would result in the sort of disk seek storm you're seeing.  
Also, what filesystem is being used?  XFS would likely do substantially 
better than ext3 because of its use of extents vs indirect blocks.

> Does using sendfile() set MADV_SEQUENTIAL and MADV_DONTNEED implicitly?
> If not would setting these help?

No.  Readahead should be doing the right thing.  Rik van Riel did some 
work on drop behind for exactly this sort of case.

> I was following with you until this part. I thought sendfile() worked
> using mmap'd files and that readahead was done into the global page
> cache.

sendfile() uses the page cache directly, so it's like an mmap(), but it 
does not carry the overhead associated with tlb manipulation.

> But this makes me think that read ahead is instead going into another
> pool. How large is this pool? The user space scheme is using 50MB of
> readahead cache, will the kernel do that much readahead if needed?

The kernel performs readahead using the system memory pool, which means 
the VM gets involved and performs page reclaim to free up previously 
cached pages.

> Does this scenario illustrate a problem with the current sendfile()
> implementation? I thought the goal of sendfile() was to always be the
> best way to send complete files. This is a case where user space is
> clearly beating sendfile().

Yes, this would be called a bug. =-)

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
