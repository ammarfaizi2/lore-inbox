Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315610AbSEIEbd>; Thu, 9 May 2002 00:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSEIEbc>; Thu, 9 May 2002 00:31:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18440 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315610AbSEIEba>;
	Thu, 9 May 2002 00:31:30 -0400
Message-ID: <3CD9FC4C.CDF47565@zip.com.au>
Date: Wed, 08 May 2002 21:34:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Pittman <daniel@rimspace.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.14..
In-Reply-To: <Pine.LNX.4.44.0205060811360.2540-100000@home.transmeta.com> <87n0va0yf0.fsf@enki.rimspace.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Pittman wrote:
> 
> On Mon, 6 May 2002, Linus Torvalds wrote:
> > On Mon, 6 May 2002, Daniel Pittman wrote:
> >>
> >> From the look of the changelog at least a few of the file corruption
> >> bugs with ext3, 2k block file systems and 2.5 have been fixed. Should
> >> I expect this release to address the problems I was seeing?
> >
> > "Expect" is too strong a word. I'd say "hope" - a number of truncate
> > bugs were fixed, but whether that was what bit you, nobody knows.
> >
> > I suspect the real answer is that we'd love for you to test things
> > out, but that if it ends up being too painful to recover if the
> > problems happen again, you probably shouldn't..
> 
> Right. I got brave enough to test it on a real, live system after
> extensive fake testing. It seems to work well, at least so far as
> running the same workload that cause massive file corruption correctly.

hmm.

> So, I believe that 2.5.14 is working correctly with 2k ext3 filesystems,
> at least for minimal use. I didn't do any sort of extreme load testing
> or anything like that, being cautious about it.

I've been testing 2.5.14 pretty hard for a couple of days.

ext2, ext3-ordered, ext3-writeback (all with small blocks) are solid.

reiserfs and vfat are solid.

JFS deadlocks (see the BUGBUG comment in jfs_txnmgr.c - it happens).  I've
asked the JFS guys for help on this; possibly the code can just be removed:
the buffer-based writeout which I replaced wouldn't have written the
pages anyway...

ext3-journalled is not happy.

There's a locking bug between try_to_free_buffers and buffer_insert_inode_queue
which never seems to trigger.  I've got that fixed.

There's a known race between unmount and writeback which is probably
impossible to trigger.  (see the FIXME at __sync_list).  Testing the
fix for that at present.

The "sync" functions aren't right.  Pages which are both dirty and
under writeback are not correctly waited upon.  This is a minor
correctness thing which nobody would notice.  Still thinking
about the best way to close this.

So unless you're a JFS or ext3-journalled user, 2.5.14 is OK.

> On reboot, I got an assertion in ext3, though, and the following BUG
> trace. So, something still isn't well, but it seems to be getting it
> much more right. :)
> 
> ...
> 
> >>EIP; c015cf45 <journal_dirty_metadata+13d/174>   <=====
> 
> ...
> Code;  c015cf45 <journal_dirty_metadata+13d/174>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c015cf47 <journal_dirty_metadata+13f/174>
>    2:   60                        pusha
> Code;  c015cf48 <journal_dirty_metadata+140/174>
>    3:   04 40                     add    $0x40,%al

04 60 -> line 1120.  Yup, I get that one too.  I assume you were
testing with data=journal.

Thanks again...

-
