Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTJPUnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTJPUnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:43:31 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:1679 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263170AbTJPUnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:43:23 -0400
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: "'Jens Axboe'" <axboe@suse.de>, Greg Stark <gsstark@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
References: <785F348679A4D5119A0C009027DE33C105CDB2C5@mcoexc04.mlm.maxtor.com>
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB2C5@mcoexc04.mlm.maxtor.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 16 Oct 2003 16:43:21 -0400
Message-ID: <87ekxcap7a.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Mudama, Eric" <eric_mudama@Maxtor.com> writes:

> It takes us multiple servo wedges to know that we think our write to the
> media went in the right place, therefore by definition if we didn't already
> have the next command's data, we've already missed our target location and
> have to wait a full revolution to put the new data on the media.  Since we
> can't report good status for the flush until after we're sure the data is
> down properly, we'll always blow a rev.

Ok, on further thought. I think a write barrier isn't really what the database
needs. It seems to be stronger and more resource intensive than what it really
needs.

Postgres writes a transaction log. When the client issues a commit postgres
cannot return until it knows all the writes for the transaction log for that
transaction have completed.

Currently it issues an fsync which is already a bit stronger than necessary.
But a write barrier sounds even stronger. It would block all other disk i/o
until the fsync completes. This is completely unnecessary, it would prevent
other transactions from proceeding at all until the commit finished.

Ideally postgres just needs to call some kind of fsync syscall that guarantees
it won't return until all buffers from the file that were dirty prior to the
sync were flushed and the disk was really synced. It's fine for buffers that
were dirtied later to get synced as well, as long as all the old buffers are
all synced.

In theory it doesn't even need to force the dirty buffers to be flushed, just
as long as it can keep track of when they are all flushed and then wait until
they're confirmed written by the disk controller. Depending on the application
it may be better for it to force the flush to reduce latency or not to
maximize bandwidth.

There is a related problem when the logs are checkpointed. There postgres has
to be sure that ALL dirty buffers in any file in the database are synced to
disk before it proceeds. This includes files that the process doing the
checkpoint never even had open. Currently the only strategy available is to
call sync(2) and then sleep an arbitrary amount of time.

Ideally it would be able to issue a kind of sync syscall that didn't
necessarily prevent other i/o from happening, but just scheduled all dirty
buffers to be synced and didn't return until they were all guaranteed on disk.
Similarly it's not really necessary to force the buffers to be flushed, and in
the case of a checkpoint probably better that it not. They'll all be flushed
within a reasonable amount of time anyways and forcing them to be flushed
could cause a huge spike in disk i/o as it affects every file in the whole
database.

> If you're issuing 32 MiB writes to a very fast drive , you'll only have
> wasted time every 1/3 of a second (with a ~100MB interface)... which is near
> trivial.  However, if you're doing 1MB or smaller writes, I think you'll see
> a huge performance penalty.

I think the writes to the transaction log are much much smaller than that.
I'm guessing measured in bytes, not megabytes. (I guess small numbers of
blocks in practice of course.)
 
> Then again, if you're only working with datasets of a few megabytes, you'd
> probably never notice.  It is the person flushing a huge stream of data to
> disk who gets penalized the most. 

Note that while the transaction logs are usually pretty small and involve lots
of slow writes, the data itself is often being stored on the same disks and
could be terabytes of data.

-- 
greg

