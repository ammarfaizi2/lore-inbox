Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282988AbRLCIvy>; Mon, 3 Dec 2001 03:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282998AbRLCItE>; Mon, 3 Dec 2001 03:49:04 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:60178 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284410AbRLBXfb>; Sun, 2 Dec 2001 18:35:31 -0500
Message-ID: <3C0ABA9E.5E652392@zip.com.au>
Date: Sun, 02 Dec 2001 15:34:54 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zaitsev <pz@spylog.ru>
CC: theowl@freemail.c3.hu, theowl@freemail.hu, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: your mail on mmap() to the kernel list
In-Reply-To: <3C08A4BD.1F737E36@zip.com.au>,
		<3C082244.8587.80EF082@localhost>,
	 <3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru>
	 <3C08A4BD.1F737E36@zip.com.au> <142576153324.20011203020702@spylog.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:
> 
> ...

It's very simple.  The kernel has a linked list of vma's for your
process.  It is kept in address order.  Each time you request a
new mapping, the kernel walks down that list looking for an address
at which to place the new mapping.  This data structure is set up
for efficient find-by-address, not for efficient find-a-gap.

Question is: do we need to optimise for this case?

If it's just a single file, then you'd be better off just mapping the
whole thing.   If you need to map lots and lots of files then
you'll hit the maximum file limit fairly early and the mmap()
performance will be not great, but maybe acceptable.

One scenario where this could be a problem is for a file
which is too large to be mapped in its entirety, but the
application needs access to lots of bits of it at the same
time.  There doesn't seem to be much alternative to setting
up a distinct mapping for each access window in this case.

> Also As you see other patterns also show fast performance degradation
> over increasing number of pages. I can also test random allocation and
> freeing but something tells me the result will be the same.

Is this proving to be a problem in a real-world application?
What are you trying to do here?

-
