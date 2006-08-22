Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWHVPtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWHVPtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWHVPtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:49:52 -0400
Received: from mx1.suse.de ([195.135.220.2]:55693 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751181AbWHVPtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:49:52 -0400
Message-ID: <44EB28EC.50802@suse.com>
Date: Tue, 22 Aug 2006 11:55:24 -0400
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
References: <44EB1484.2040502@suse.com> <44EB23D9.9000508@slaphack.com>
In-Reply-To: <44EB23D9.9000508@slaphack.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Masover wrote:
> Jeff Mahoney wrote:
>>  When a file system becomes fragmented (using MythTV, for example), the
>>  bigalloc window searching ends up causing huge performance problems. In
>>  a file system presented by a user experiencing this bug, the file system
>>  was 90% free, but no 32-block free windows existed on the entire file
>> system.
>>  This causes the allocator to scan the entire file system for each
>> 128k write
>>  before backing down to searching for individual blocks.
> 
> Question:  Would it be better to take that performance hit once, then
> cache the result for awhile?  If we can't find enough consecutive space,
> such space isn't likely to appear until a lot of space is freed or a
> repacker is run.

The problem is that finding the window isn't really a direct function of
free space, it's a function of fragmentation. You could have a 50% full
file system that still can't find a 32 block window by having every
other block used. I know it's an extremely unlikely case, but it
demonstrates the point perfectly.

>>  In the end, finding a contiguous window for all the blocks in a write is
>>  an advantageous special case, but one that can be found naturally when
>>  such a window exists anyway.
> 
> Hmm.  Ok, I don't understand how this works, so I'll shut up.

If the space after the end of the file has 32 or more blocks free, even
without the bigalloc behavior, those blocks will be used.

Also, I think the bigalloc behavior just ultimately ends up introducing
even more fragmentation on an already fragmented file system. It'll keep
contiguous chunks together, but those chunks can end up being spread all
over the disk.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE6yjsLPWxlyuTD7IRAuT0AJ9ssQafYPW+Gy/E/xN+LKCxamjycwCgqL6P
aUbgXdn+0+K3sJhWGBWtrno=
=NDyT
-----END PGP SIGNATURE-----
