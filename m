Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSFAWWV>; Sat, 1 Jun 2002 18:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317080AbSFAWWU>; Sat, 1 Jun 2002 18:22:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12296 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317078AbSFAWWT>;
	Sat, 1 Jun 2002 18:22:19 -0400
Message-ID: <3CF949F4.62F13F11@zip.com.au>
Date: Sat, 01 Jun 2002 15:25:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <3CF88933.2EC13C8F@zip.com.au> <Pine.LNX.4.44.0206010935290.10978-100000@home.transmeta.com> <3CF91E48.C76B34FA@zip.com.au> <20020601200414.GD14918@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Linus Torvalds wrote:
> >> The general VFS layer really shouldn't have assigned that strogn a meaning
> >> to "i_nlink" anyway, it's not for the VFS layer to decide (and it only
> >> causes problems for any non-UNIX-on-a-disk filesystems).
> 
> On Sat, Jun 01, 2002 at 12:19:36PM -0700, Andrew Morton wrote:
> > Yes, I suspect all the inode refcounting, locking, I_FREEING, I_LOCK, etc
> > could do with a spring clean. Make it a bit more conventional.  I'll
> > discuss with Al when he resurfaces.
> 
> I'm somewhat concerned about the protection of ->i_size, since that
> appears to be accessed in generic_file_read() without any protection
> against writers to the field. From a quick glance at current 2.5 (it
> looks like 2.4 has this too) it looks like it's written to by
> vmtruncate() through notify_change() with the ->i_sem and BKL held at
> the moment, but generic_file_read() doesn't take either before reading
> it, and there may be still other writers.

truncate and write change i_size, under i_sem.   The i_size test on
the read path doesn't really need to be there, I suspect.  It handles
the window where i_size has been decreased by truncate but the filesystem
hasn't finished truncating the blocks yet.  It also optimises reads
outside the end of file - no point in calling into the filesystem
to try to map blocks which aren't there.

> I also don't see the anything
> like read_barrier_depends() for lockless algorithms or any atomic reads.
> Even on machines with extremely strong memory consistency models like
> i386, as loff_t is long long, it would seem possible to catch a partial
> update and see an entirely bogus ->i_size value.

That's true.  sys_stat() also could see a confusing intermediate value.
A while back Ingo and Linus were tossing around possible solutions to
this based on x86 compare-and-exchange operations, but nothing conclusive
came out of it.   It's a "known bug".

-
