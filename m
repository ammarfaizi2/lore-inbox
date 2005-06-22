Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVFVUvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVFVUvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVFVUto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:49:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262185AbVFVUlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:41:53 -0400
Date: Wed, 22 Jun 2005 22:43:13 +0200
From: Jens Axboe <axboe@suse.de>
To: spaminos-ker@yahoo.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
Message-ID: <20050622204308.GC26925@suse.de>
References: <1119432285.3257.5.camel@linux> <20050622175457.18548.qmail@web30712.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622175457.18548.qmail@web30712.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22 2005, spaminos-ker@yahoo.com wrote:
> --- Jens Axboe <axboe@suse.de> wrote:
> > THe problem here is that cfq  (and the other io schedulers) still
> > consider the io async even if fsync() ends up waiting for it to
> > complete. So there's no real QOS being applied to these pending writes,
> > and I don't immediately see how we can improve that situation right now.
> <I might sound stupid>
> I still don't understand why async requests are in a different queue than the
> sync ones?
> Wouldn't it be simpler to consider all the IO the same, and like you pointed
> out, consider synced IO to be equivalent to async + some sync (as in wait for
> completion) call (fsync goes a little too far).
> </I might sound stupid>

First, lets cover a little terminology. All io is really async in Linux,
the block io model is inherently async in nature. So sync io is really
just async io that is being waited on immediately. When I talk about
sync and async io in the context of the io scheduler, the sync io refers
to io that is wanted right away. That would be reads or direct writes.
The async io is something that we can complete at will, where latency
typically doesn't matter. That would be normal dirtying of data that
needs to be flushed to disk.

Another property of sync io in the io scheduler is that it usually
implies that another sync io request will follow immediately (well,
almost) after one has completed. So there's a depedency relation between
sync requests, that async requests don't share.

So there are different requirements for sync and async io. The io
scheduler tries to minimize latencies for async requests somewhat,
mainly just by making sure that it isn't starved for too long. However,
when you do an fsync, you want to complete lots of writes, but the io
scheduler doesn't get this info passed down. If you keep flooding the
queue with new writes, this could take quite a while to finish. We could
improve this situation by only flushing out the needed data, or just a
simple hack to onlu flush out already queued io (provided the fsync()
already made sure that the correct data is already queued).

I will try and play a little with this, it's definitely something that
would be interesting and worthwhile to improve.

> > What file system are you using? I ran your test on ext2, and it didn't
> > give me more than ~2 seconds latency for the fsync. Tried reiserfs now,
> > and it's in the 23-24 range.
> > 
> I am using ext3 on Fedora Core 3.

Journalled file systems will behave worse for this, because it has to
tend to the journal as well. Can you try mounting that partition as ext2
and see what numbers that gives you?

-- 
Jens Axboe

