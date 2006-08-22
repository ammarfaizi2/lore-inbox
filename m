Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWHVVOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWHVVOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWHVVOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:14:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:10953 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751279AbWHVVOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:14:49 -0400
Message-ID: <44EB7518.5010204@suse.com>
Date: Tue, 22 Aug 2006 17:20:24 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Mike Benoit <ipso@snappymail.ca>
Subject: Re: [PATCH] reiserfs: eliminate minimum window size for bitmap searching
References: <44EB1484.2040502@suse.com> <44EB23D9.9000508@slaphack.com> <44EB28EC.50802@suse.com> <44EB684C.2090206@slaphack.com>
In-Reply-To: <44EB684C.2090206@slaphack.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Masover wrote:
> Jeff Mahoney wrote:
>> The problem is that finding the window isn't really a direct function of
>> free space, it's a function of fragmentation. You could have a 50% full
>> file system that still can't find a 32 block window by having every
>> other block used. I know it's an extremely unlikely case, but it
>> demonstrates the point perfectly.
> 
> Maybe, but it's still not a counterpoint.  No matter how fragmented a
> filesystem is, freeing space can open up contiguous space, whereas if
> space is not freed, you won't open up contiguous space.
> 
> Thus, if your FS is 50% full and 100% fragmented, then you wait till
> space is freed, because if nothing happens, or if more space is filled
> in, you'll have the same problem at 60% than you did at 50%.  If,
> however, you're at 60% full, and 10% of the space is freed, then it's
> fairly unlikely that you still don't have contiguous space, and it's
> worth it to scan once more at 50%, and again if it then drops to 40%.
> 
> So, if your FS is 90% full and space is being freed, I'd think it would
> be worth it to scan again at 80%, 70%, and so on.  I'd also imagine it
> would do little or nothing to constantly monitor an FS that stays mostly
> full -- maybe give it a certain amount of time, but if we're repacking
> anyway, just wait for a repacker run.  It seems very unlikely that
> between repacker runs, activity between 86% and 94% would open up
> contiguous space.
> 
> It's still not a direct function of freed space (as opposed to free
> space), but it starts to look better.
> 
> I'm not endorsing one way or the other without benchmarks, though.

I'd like to see benchmarks too. The goal is obviously to minimize seeks,
but my feeling is that blocks that aren't entirely contiguous but are
located in close enough proximity to each other so that they are all in
the drive's cache anyway will perform better than 128k chunks spread all
over the disk.

Your solution is one possible approach, but I'd rather kill off bigalloc
for reasons described below.

Also, for clarification, the 128k I keep quoting is just what
reiserfs_file_write() breaks larger writes into. It seems MythTV writes
in large chunks (go figure, it's a streaming media application ;), so
they get split up. For smaller writes, they'll go to the allocator with
a request of that many blocks.
reiserfs_{writepage,prepare_write,commit_write} all operate on one page
(and so one block, usually) at a time.

>>>>  In the end, finding a contiguous window for all the blocks in a
>>>> write is
>>>>  an advantageous special case, but one that can be found naturally when
>>>>  such a window exists anyway.
>>> Hmm.  Ok, I don't understand how this works, so I'll shut up.
>>
>> If the space after the end of the file has 32 or more blocks free, even
>> without the bigalloc behavior, those blocks will be used.
> 
> For what behavior -- appending?

For any allocation after the first one. The allocator chooses a starting
position based on the last block it knows about before the position of
the write. This applies for both appends and sparse files.

>> Also, I think the bigalloc behavior just ultimately ends up introducing
>> even more fragmentation on an already fragmented file system. It'll keep
>> contiguous chunks together, but those chunks can end up being spread all
>> over the disk.
> 
> This sounds like the NTFS strategy, which was basically to allow all
> hell to break loose -- above a certain chunk size.  Keep chunks of a
> certain size contiguous, and you limit the number of seeks by quite a lot.

The bigalloc behavior ends up reducing local fragmentation at the
expense of global fragmentation. The free space of the test file system
that prompted this patch was *loaded* with 31 block chunks. All of these
were skipped until we backed off and searched for single block chunks -
or worse, ignored the close chunks in favor of a contiguous chunk
elsewhere. I don't think this is ideal behavior at all. Certainly it's
better to have a contiguous chunk of 63 blocks and one block elsewhere.
That lone block might only be a few blocks away and in the disk's cache
already, but bigalloc doesn't take that into account either. The start
of the allocation could be at the end of a bitmap group, leaving empty
space where we naturally should have just grown the file.

Without bigalloc, we still end up getting as many blocks together as we
can in a particular bitmap before moving on to another one. It will
group as many free blocks together as it can, and then try to find the
next window. Bigalloc just meant that two windows of 16 blocks, a block
apart, wasn't good enough. Once it's time to move on to another bitmap,
the skip_busy behavior (enabled by default), will search for bitmap
groups that are at least 10% free until the file system is 95% full[1].
We're already seeking anyway so this gives us the best chance of finding
a group with room to grow. It also leaves room in bitmaps for existing
files to grow, avoiding fragmentation there as well. It could stand to
be a bit smarter though, perhaps taking into account its proximity to a
neighboring bitmap group in making that determination.

- -Jeff

[1]: Although, the comment says 80%. One or the other is a bug. Mea culpa.

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE63UXLPWxlyuTD7IRAg8yAJ4/sFePRtuV8b2TDA/49pMNSeyp8QCeMymb
n3AnyFC2jyPe28Q16B7WhAQ=
=gNSt
-----END PGP SIGNATURE-----
