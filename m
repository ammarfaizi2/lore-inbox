Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSFAUFQ>; Sat, 1 Jun 2002 16:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317038AbSFAUFP>; Sat, 1 Jun 2002 16:05:15 -0400
Received: from holomorphy.com ([66.224.33.161]:61855 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317034AbSFAUEj>;
	Sat, 1 Jun 2002 16:04:39 -0400
Date: Sat, 1 Jun 2002 13:04:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
Message-ID: <20020601200414.GD14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF88933.2EC13C8F@zip.com.au> <Pine.LNX.4.44.0206010935290.10978-100000@home.transmeta.com> <3CF91E48.C76B34FA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>> The general VFS layer really shouldn't have assigned that strogn a meaning
>> to "i_nlink" anyway, it's not for the VFS layer to decide (and it only
>> causes problems for any non-UNIX-on-a-disk filesystems).

On Sat, Jun 01, 2002 at 12:19:36PM -0700, Andrew Morton wrote:
> Yes, I suspect all the inode refcounting, locking, I_FREEING, I_LOCK, etc
> could do with a spring clean. Make it a bit more conventional.  I'll 
> discuss with Al when he resurfaces.

I'm somewhat concerned about the protection of ->i_size, since that
appears to be accessed in generic_file_read() without any protection
against writers to the field. From a quick glance at current 2.5 (it
looks like 2.4 has this too) it looks like it's written to by
vmtruncate() through notify_change() with the ->i_sem and BKL held at
the moment, but generic_file_read() doesn't take either before reading
it, and there may be still other writers. I also don't see the anything
like read_barrier_depends() for lockless algorithms or any atomic reads.
Even on machines with extremely strong memory consistency models like
i386, as loff_t is long long, it would seem possible to catch a partial
update and see an entirely bogus ->i_size value. It also appears
->i_size is used to provide some protection against reads of truncated
pages, which may be unreliable without some protection of ->i_size.

If these issues are not what I believe them to be I would be more than
happy to have these impressions corrected.

Cheers,
Bill
