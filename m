Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVFQBam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVFQBam (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVFQBam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:30:42 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:62136 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261868AbVFQBae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:30:34 -0400
Message-ID: <42B227B5.3090509@yahoo.com.au>
Date: Fri, 17 Jun 2005 11:30:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify.
References: <1118855899.3949.21.camel@betsy>  <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy>
In-Reply-To: <1118946334.3949.63.camel@betsy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Thu, 2005-06-16 at 10:52 -0700, Zach Brown wrote:

>>>+       if (likely(!atomic_read(&inode->inotify_watch_count)))
>>>+               return;
>>
>>Are there still platforms that implement atomic_read() with locks?  I
>>wonder if there isn't a cheaper way for inodes to find out that they're
>>not involved in inotify.. maybe an inode function pointer that is only
>>set to queue_event when watchers are around?
> 
> 
> I don't know what esoteric architectures are doing, but the solution
> needs to be atomic (or we need to say "we don't care about races"--but
> its hard not to care about a pointer race).  On x86, at least, an
> atomic_read() is trivial.
> 
> I actually would not mind being racey (in a safe way) or finding a
> cheaper solution, especially if we could remove
> inode->inotify_watch_count altogether (and not replace it with
> anything).
> 
> But the overhead here is not biting us (we just went through some
> off-list benchmarking that led to the inclusion of this check, in fact).
> 

What we could do is just check list_empty(&inode->inotify_watchers)
and remove the atomic count completely.

We don't actually care about getting an exact count at all, just
whether or not it is empty, and in that case using list_empty is
no more racy than checking an atomic count, both are done outside
any locks.

It is basically just a lock avoidance heuristic. But I think count
is superfluous - off with its head!

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
