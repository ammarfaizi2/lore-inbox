Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTJQGoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 02:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTJQGoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 02:44:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61623 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263315AbTJQGog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 02:44:36 -0400
Date: Fri, 17 Oct 2003 08:44:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Greg Stark <gsstark@mit.edu>
Cc: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031017064431.GW1128@suse.de>
References: <785F348679A4D5119A0C009027DE33C105CDB2C5@mcoexc04.mlm.maxtor.com> <87ekxcap7a.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ekxcap7a.fsf@stark.dyndns.tv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16 2003, Greg Stark wrote:
> 
> "Mudama, Eric" <eric_mudama@Maxtor.com> writes:
> 
> > It takes us multiple servo wedges to know that we think our write to the
> > media went in the right place, therefore by definition if we didn't already
> > have the next command's data, we've already missed our target location and
> > have to wait a full revolution to put the new data on the media.  Since we
> > can't report good status for the flush until after we're sure the data is
> > down properly, we'll always blow a rev.
> 
> Ok, on further thought. I think a write barrier isn't really what the database
> needs. It seems to be stronger and more resource intensive than what it really
> needs.
> 
> Postgres writes a transaction log. When the client issues a commit postgres
> cannot return until it knows all the writes for the transaction log for that
> transaction have completed.
> 
> Currently it issues an fsync which is already a bit stronger than necessary.
> But a write barrier sounds even stronger. It would block all other disk i/o
> until the fsync completes. This is completely unnecessary, it would prevent
> other transactions from proceeding at all until the commit finished.
> 
> Ideally postgres just needs to call some kind of fsync syscall that guarantees
> it won't return until all buffers from the file that were dirty prior to the
> sync were flushed and the disk was really synced. It's fine for buffers that
> were dirtied later to get synced as well, as long as all the old buffers are
> all synced.

I've been thinking about adding WRITESYNC to do exactly that, and keep
WRITEBARRIER with its current functionality for journalled file
systems. WRITESYNC would be exactly what you describe, it just wont
imply any io scheduler ordering. So a post-flush would be enough to
handle that case.

The problem is that as far as I can see the best way to make fsync
really work is to make the last write a barrier write. That
automagically gets everything right for you - when the last block goes
to disk, you know the previous ones have already. And when the last
block completes, you know the whole lot is on platter. If you were just
using WRITESYNC, you would have to WRITESYNC all blocks in that range
instead of just WRITE WRITE WRITE ... WRITEBARRIER. So the barrier would
still end up being cheaper, unless the fsync just flushes a single page
in which case the WRITESYNC is enough.

-- 
Jens Axboe

