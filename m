Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWHVUZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWHVUZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWHVUZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:25:49 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:37770 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S932074AbWHVUZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:25:48 -0400
Message-ID: <44EB684C.2090206@slaphack.com>
Date: Tue, 22 Aug 2006 15:25:48 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Mike Benoit <ipso@snappymail.ca>
Subject: Re: [PATCH] reiserfs: eliminate minimum window size for bitmap searching
References: <44EB1484.2040502@suse.com> <44EB23D9.9000508@slaphack.com> <44EB28EC.50802@suse.com>
In-Reply-To: <44EB28EC.50802@suse.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> David Masover wrote:
>> Jeff Mahoney wrote:
>>>  When a file system becomes fragmented (using MythTV, for example), the
>>>  bigalloc window searching ends up causing huge performance problems. In
>>>  a file system presented by a user experiencing this bug, the file system
>>>  was 90% free, but no 32-block free windows existed on the entire file
>>> system.
>>>  This causes the allocator to scan the entire file system for each
>>> 128k write
>>>  before backing down to searching for individual blocks.
>> Question:  Would it be better to take that performance hit once, then
>> cache the result for awhile?  If we can't find enough consecutive space,
>> such space isn't likely to appear until a lot of space is freed or a
>> repacker is run.
> 
> The problem is that finding the window isn't really a direct function of
> free space, it's a function of fragmentation. You could have a 50% full
> file system that still can't find a 32 block window by having every
> other block used. I know it's an extremely unlikely case, but it
> demonstrates the point perfectly.

Maybe, but it's still not a counterpoint.  No matter how fragmented a 
filesystem is, freeing space can open up contiguous space, whereas if 
space is not freed, you won't open up contiguous space.

Thus, if your FS is 50% full and 100% fragmented, then you wait till 
space is freed, because if nothing happens, or if more space is filled 
in, you'll have the same problem at 60% than you did at 50%.  If, 
however, you're at 60% full, and 10% of the space is freed, then it's 
fairly unlikely that you still don't have contiguous space, and it's 
worth it to scan once more at 50%, and again if it then drops to 40%.

So, if your FS is 90% full and space is being freed, I'd think it would 
be worth it to scan again at 80%, 70%, and so on.  I'd also imagine it 
would do little or nothing to constantly monitor an FS that stays mostly 
full -- maybe give it a certain amount of time, but if we're repacking 
anyway, just wait for a repacker run.  It seems very unlikely that 
between repacker runs, activity between 86% and 94% would open up 
contiguous space.

It's still not a direct function of freed space (as opposed to free 
space), but it starts to look better.

I'm not endorsing one way or the other without benchmarks, though.

>>>  In the end, finding a contiguous window for all the blocks in a write is
>>>  an advantageous special case, but one that can be found naturally when
>>>  such a window exists anyway.
>> Hmm.  Ok, I don't understand how this works, so I'll shut up.
> 
> If the space after the end of the file has 32 or more blocks free, even
> without the bigalloc behavior, those blocks will be used.

For what behavior -- appending?

> Also, I think the bigalloc behavior just ultimately ends up introducing
> even more fragmentation on an already fragmented file system. It'll keep
> contiguous chunks together, but those chunks can end up being spread all
> over the disk.

This sounds like the NTFS strategy, which was basically to allow all 
hell to break loose -- above a certain chunk size.  Keep chunks of a 
certain size contiguous, and you limit the number of seeks by quite a lot.
