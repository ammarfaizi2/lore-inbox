Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266025AbUFIXe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUFIXe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUFIXe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:34:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:31421 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266025AbUFIXeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:34:24 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Thu, 10 Jun 2004 01:38:17 +0200
User-Agent: KMail/1.5.3
Cc: axboe@suse.de, edt@aei.ca, linux-kernel@vger.kernel.org
References: <1085689455.7831.8.camel@localhost> <200406092352.18470.bzolnier@elka.pw.edu.pl> <20040609150658.5e5e6653.akpm@osdl.org>
In-Reply-To: <20040609150658.5e5e6653.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406100138.18028.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 of June 2004 00:06, Andrew Morton wrote:
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > Sure, you don't need my ACK, that's obvious - you need it from
> > Linus/Andrew.
>
> But your nack would almost certainly prevent a merge, pending resolution of
> whatever the issues are.

Thanks.

> > ...
> >
> > BTW are you aware of two (minor?) corner cases of the current
> > implementation?
> >
> > - you can't have journal on a separate device
> >   (pre and post flushes will only flush device storing journal not data)
>
> External journals in ext3 aren't really supported - they just happen to
> work as a plaything.  I haven't tested it in several years, but I believe
> people do use it.
>
> That being said, the bug you identify is an ext3 bug.  The easiest way for

The same is probably true for the current reiserfs barrier patch.

> me to fix it up within ext3 would be to issue some flush command to the
> filesystem's disk, wait for that to complete, then write the buffer_ordered
> commit block to the journal's disk.  That's blkdev_issue_flush(), yes?

Yes and I think that it should work just the way you've just described.

Instead of pre+post flushes in ordered write:

	flush from fs to sync disk + ordered commit (write+flush)

or even:

	flush from fs to sync disk + commit

The latter is a bit less secure but we can also have 'unfortunate' power
failures for ordered write: while writing or between write and actual
flush (although 'race window' is smaller).  Anyway ordering is preserved
(commit won't hit platters before the real data!) and it is a _lot_ simpler
(+ a bit faster).  This solution is 'good enough' for me but the former
one is also okay (unlike 'pre/post flushes private to the IDE driver')
but requires solving 'we need partial completions for IDE' problem first.

Does journal has checksum or some other protection against failure during
writing journal to a disk?  If not than it still can be screwed even with
ordered writes if we are unfortunate enough.  ;-)

> > - if you more than > 1 filesystem on the disk (quite likely scenario) it
> >   can happen that barrier (flush) will fail for sector for file from the
> >   other fs and later barrier for this other fs will succeed
>
> I don't understand this one.

Flush command can fail for sector which came into disk's write cache
from some write request for some other fs on the same disk i.e.

write requests for fs 'a' (sector 'x' stays in write cache)
write requests for fs 'b'
commit log for fs 'b' -> barrier for fs 'b'
barrier fails because of sector 'x'
commit log for fs 'a' -> barrier for fs 'a'
barrier succeeds

Such scenario is highly unlikely (disks do bad sector re-allocation
on write) but not impossible (pool of sectors for remapping is unlimited).
That's why I think it is a minor issue (but still worth to know about it).

This is just to make it clear that write barriers can help for power failures
and hard resets or disks which don't expire their caches (are there any?) but
can't help once things go wrong with a disk (and actually can make it worse).


