Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318719AbSHWJz2>; Fri, 23 Aug 2002 05:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSHWJz2>; Fri, 23 Aug 2002 05:55:28 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:59665 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318719AbSHWJz0>; Fri, 23 Aug 2002 05:55:26 -0400
Date: Fri, 23 Aug 2002 10:59:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Tweedie <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/2] 2.4.20-pre4/ext3: Handle dirty buffers encountered unexpectedly.
Message-ID: <20020823105933.A12435@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Tweedie <sct@redhat.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <200208222319.g7MNJaG09082@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208222319.g7MNJaG09082@sisko.scot.redhat.com>; from sct@redhat.com on Fri, Aug 23, 2002 at 12:19:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 12:19:36AM +0100, Stephen Tweedie wrote:
> Ext3's internal debugging has always assumed that it was illegal for there to
> be parallel IO on a buffer-head which it is trying to modify.  That's
> reasonable --- if there is an IO collision, we end up with IOs hitting disk
> out-of-order wrt the journal, so we lose recovery guarantees.
> 
> However, there are two cases where the test is a little over-zealous.  If
> user space is performing inherently non-transactional writes (eg. tune2fs
> adding a label to a live filesystem and writing to the buffered device
> superblock location) then we can hit the ext3 assertion.
> 
> More seriously, since 2.4.11 the page cache can lock a buffer_head for read
> even if the bh is already under journal control.  The tune2fs bug is very
> rare: there have been no reports of it in Bugzilla or ext3-users lists, and
> only one on 2.5 on linux-kernel.  But now, a dump(8) on a live filesystem
> can also give rise to the same condition, and in testing, dump + fs activity
> reproduces the assertion-failure VERY rapidly.

Btw, is the following patch still aimed for inclusion?

Date: Sat, 13 Apr 2002 23:59:48 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrea Arcangeli <andrea@suse.de>
Cc: Stephen Tweedie <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: [RFC] Patch: aliasing bug in blockdev-in-pagecache?
Message-ID: <20020413235948.E4937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Spam-Status: No, hits=-5.0 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK,UNIFIED_PATCH version=2.11

Hi all,

I think there's a data-corruption possible in both ext2 and ext3 (and
in fact any filesystem which uses bread) if user space is reading from
the filesystem's buffered block device during live fs activity.

I've recently been seeing an ext3 assert failure where the filesystem
comes across a buffer which is unexpectedly locked, while running a
dump(8) on the live filesystem.  Now, I do _not_ want to start another
debate about whether it's sane to do that or not!  But the mounted
kernel filesystem should still survive if the user is only reading
from the buffered device.

The problem turns out to be in block_read_full_page().  The page cache
IO code assumes that IO is synchronised at the page level, but any
kernel code using getblk() (or sb_read() or related functions) to
access the buffers at the same time will bypass the page locking.

So if block_read_full_page() encounters a page which bread() is
already reading into cache, it will see the page unlocked but the
buffer_head locked and !uptodate.  However, it ignores the bh lock,
seeing only that the buffer is !uptodate, and so it then locks the bh
itself and submits a read IO.

Unfortunately, if the bread() wins the race for the wait_on_buffer
after the initial IO, we can already have started to modify the buffer
contents by the time that block_read_full_page() starts the new IO.
So we read stale contents from disk on top of the modified contents in
cache.

To solve this, we really do need to have block_read_full_page() test
the uptodate state under protection of the buffer_head lock.  We
already go through 3 stages in block_read_full_page(): gather the
buffers needing IO, then lock them, then submit the IO.  To be safe,
we need a final test for buffer_uptodate() *after* we have locked the
required buffers.

I've verified that the scenario above is definitely happening, and I'm
currently testing the patch below.  I'm using 2.4 for the testing
right now, but 2.5 seems to have the same problem at first glance.

Comments?

--Stephen


--- linux/fs/buffer.c.~1~	Fri Apr 12 17:59:09 2002
+++ linux/fs/buffer.c	Sat Apr 13 21:09:36 2002
@@ -1902,9 +1902,14 @@
 	}
 
 	/* Stage 3: start the IO */
-	for (i = 0; i < nr; i++)
-		submit_bh(READ, arr[i]);
-
+	for (i = 0; i < nr; i++) {
+		struct buffer_head * bh = arr[i];
+		if (buffer_uptodate(bh))
+			end_buffer_io_async(bh, 1);
+		else
+			submit_bh(READ, bh);
+	}
+	
 	return 0;
 }
 


