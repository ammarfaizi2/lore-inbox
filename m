Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVDZPtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVDZPtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVDZPtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:49:33 -0400
Received: from mail.shareable.org ([81.29.64.88]:14249 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261622AbVDZPrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:47:19 -0400
Date: Tue, 26 Apr 2005 16:47:08 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: John Stoffel <john@stoffel.org>,
       "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>, Ville Herva <v@iki.fi>,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050426154708.GC14297@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net> <1114528782.13568.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114528782.13568.8.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> > Jamie> No.  A transaction means that _all_ processes will see the
> > Jamie> whole transaction or not.
> > 
> > This is really hard.  How do you handle the case where process X
> > starts a transaction modifies files a, b & c, but process Y has file b
> > open for writing, and never lets it go?  Or the file gets unlinked?  
> 
> That is why implementing it as a form of lock makes sense.

The problem with making them exclusive locks is that you halt the
system for the duration of the transaction.  If it's a big transaction
such as updating 1000 files for a package update, that blocks a lot of
programs for a long time, and it's not necessary.

And, because that's a potential denial of service, you have to limit
the size of transactions and their duration, especially for ordinary
users.  That makes transactions a lot less useful than they can be.

I would implement them as a combination of time-limited lock, and
abortable transaction with file & directory reads establishing
prerequisites.

While the transaction lock is held, everything read (i.e. read byte
ranges, lock byte ranges, directory lookups, and stat results) cause
the corresponding range or inode to be exclusively locked for this
transaction, and also cause them to be recorded in the prerequisite
set for this transaction.  Everything written (i.e. byte ranges or any
other filesystem modifying operation) is queued.

If the transaction lock timeout is reached before the transaction is
closed, all the exlusive locks for this transaction are released, and
the transaction lock itself is released, and the prerequisite set
continues to be recorded.

If at any time, another process tries to modify any of the information
in the transaction's prerequisite set, then firstly: if the
transaction lock is held, the other process is blocked until that lock
is released.  Secondly: if the other process successfully modifies
information in the transaction's prerequisite set, the transaction is
aborted.  All further operations in this transaction will fail,
including reads, writes, and the final close which commits writes.

Finally, when the transaction is closed, either it fails because
prerequisites were modified, or it commits all the pending filesystem
modifications of this transaction.

Why two phases?

The second phase, with no exclusive locking, is to allow ordinary
users to use transactions without blocking other processes or hogging
excessive system resources.  It allows other processes to progress
while a big transaction is in progress.  In other words, it prevents
some kinds of denial-of-service, allows arbitrarily large transactions
as long as there's enough space in the filesystem, and is generally
better.

The first phase, with exlusive locking, uses a randomised timeout for
the lock.  This is to prevent starvation of transacting processes by
other processes.  It's analogous to the problem of readers starving
writers in some kinds of read-write locks.  The randomised timeout is
to prevent mutual starvation between two or more transacting
processes, which might otherwise get into synchronised livelock.

Enjoy :)
-- Jamie
