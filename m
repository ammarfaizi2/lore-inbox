Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWJVIk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWJVIk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWJVIk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:40:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:47530 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932229AbWJVIk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:40:28 -0400
Date: Sun, 22 Oct 2006 10:40:20 +0200
From: Nick Piggin <npiggin@suse.de>
To: linux-fsdevel@vger.kernel.org, Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com, bjornw@axis.com,
       reiserfs-dev@namesys.com, chris.mason@oracle.com
Subject: [RFC] commit_write less than prepared by prepare_write
Message-ID: <20061022084020.GA23506@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a request for comments and review by filesystem maintainers.
Especially if you own GFS2, OCFS2, Reiserfs, JFFS! Those using fs/buffer.c
routines directly should be reasonably safe.

We have several long standing deadlocks in the core MM when doing
buffered writes. The full explanation is in 2.6.19-rc2-mm2 in the
patch mm-fix-pagecache-write-deadlocks.patch and there are some followup
fixes.

Basically: when copying the pages from user supplied address to pagecache,
between prepare_write and commit_write, we can take a fault on the
copy_from_user and enter the pagefault handler holding the page lock.

There is no way that this can work safely, so we must do atomic copies
here, which will just return a short write in the case of a fault.

The protocol for handling short writes is as follows:

- If page uptodate, commit_write with the shorter length (potentially 0).
  Move the counters forward and retry.

- If the page is not uptodate, we commit a zero length commit_write, at the
  start offset given by the prepare_write being closed.

* Note that if we hit some other error condition, we may never run another
  prepare_write or commit_write, so we can't rely on that.

For the case of an uptodate page, it may be somewhat safer to commit the
full length that was prepared (we can always pretend that the uncopied
part got dirtied; the retry can happily overwrite it). Comments? I figure
that if we have to audit everything anyway, then keeping this wart would
be silly.

For the non-uptodate page:
We can't run a full length commit_write, because the data in the page is
uninitialised. Can't zero out the uninitialised data, because that would
lead to zeros temporarily appearing in the pagecache. Any other ways to
fix it?

The problem with doing a short commit, as noted by Mark Fasheh, is that
prepare_write might have allocated a disk mapping (eg. if we write over a
hole), and if the commit fails and we unlock the page, then a read from
the filesystem might think that is valid data.

Mark's idea is to loop through the page buffers and zero out the
buffer_new ones when the caller detects a fault here. This should work
because a hole is zeroes anyway, so we could mark the page uptodate and it
would eventually get written back to initialise those blocks. But, is
there any other filesystem specific state that would need to be fixed
up? Do we need another filesystem call?

I would prefer that disk block allocation be performed at commit_write
time. I realise that is probably a lot more rework, and there may be
reasons why it can't be done?

Another alternative is to pre-read the page in prepare_write, which
should always get us out of trouble. Could be a good option for
simple filesystems. People who care about performance probably want to
avoid this.

Any other ideas?

The regular buffered filesystems seem to be working OK. The bulk of the
filesystems are in fs-prepare_write-fixes.patch, but it is a bit
scattered at the moment. Applying the full -mm patch would be a good
idea.

The conversion involves:
* ensure we don't mark the page uptodate in prepare_write if it is not
  (which is a bug anyway... I found a few of those).
* ensure we don't mark a non uptodate page as uptodate if the commit
  was short.

Filesystems that are non trivial are GFS2, OCFS2, Reiserfs, JFFS so
I need maintainers to look at those.

For the "moronic filesystems that do not allow holes", the cont_ routines
have already been using zero length prepare/commit for something else.
OGAWA Hirofumi is thinking about this. Any comments?

Thanks,
Nick
