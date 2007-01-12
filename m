Return-Path: <linux-kernel-owner+w=401wt.eu-S1030195AbXALU17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbXALU17 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 15:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbXALU17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 15:27:59 -0500
Received: from rgminet02.oracle.com ([148.87.113.119]:15942 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030195AbXALU16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 15:27:58 -0500
Date: Fri, 12 Jan 2007 15:23:16 -0500
From: Chris Mason <chris.mason@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dean gaudet <dean@arctic.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
Message-ID: <20070112202316.GA28400@think.oraclecorp.com>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 10:06:22AM -0800, Linus Torvalds wrote:

> > looking at the splice(2) api it seems like it'll be difficult to implement 
> > O_DIRECT pread/pwrite from userland using splice... so there'd need to be 
> > some help there.
> 
> You'd use vmsplice() to put the write buffers into kernel space (user 
> space sees it's a pipe file descriptor, but you should just ignore that: 
> it's really just a kernel buffer). And then splice the resulting kernel 
> buffers to the destination.

I recently spent some time trying to integrate O_DIRECT locking with
page cache locking.  The basic theory is that instead of using
semaphores for solving O_DIRECT vs buffered races, you put something
into the radix tree (I call it a placeholder) to keep the page cache
users out, and lock any existing pages that are present.

O_DIRECT does save cpu from avoiding copies, but it also saves cpu from
fewer radix tree operations during massive IOs.  The cost of radix tree
insertion/deletion on 1MB O_DIRECT ios added ~10% system time on
my tiny little dual core box.  I'm sure it would be much worse if there
was lock contention on a big numa machine, and it grows as the io grows
(SGI does massive O_DIRECT ios).

To help reduce radix churn, I made it possible for a single placeholder
entry to lock down a range in the radix:

http://thread.gmane.org/gmane.linux.file-systems/12263

It looks to me as though vmsplice is going to have the same issues as my
early patches.  The current splice code can avoid the copy but is still
working in page sized chunks.  Also, splice doesn't support zero copy on
things smaller than page sized chunks.

The compromise my patch makes is to hide placeholders from almost
everything except the DIO code.  It may be worthwhile to turn the
placeholders into an IO marker that can be useful to filemap_fdatawrite
and friends.

It should be able to:

record the userland/kernel pages involved in a given io
map blocks from the FS for making a bio
start the io
wake people up when the io is done

This would allow splice to operate without stealing the userland page
(stealing would still be an option of course), and could get rid of big
chunks of fs/direct-io.c.

-chris
