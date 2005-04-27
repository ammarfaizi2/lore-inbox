Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVD0PSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVD0PSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVD0PSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:18:32 -0400
Received: from mail.shareable.org ([81.29.64.88]:59305 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261714AbVD0PSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:18:13 -0400
Date: Wed, 27 Apr 2005 16:17:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ville Herva <vherva@vianova.fi>
Cc: Jan Hudec <bulb@ucw.cz>, John Stoffel <john@stoffel.org>,
       "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050427151758.GE1957@mail.shareable.org>
References: <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net> <20050426152434.GB14297@mail.shareable.org> <20050427093412.GB1904@vagabond> <20050427134331.GT5470@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427134331.GT5470@viasys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> > How do we specify which calls belong to a transaction? By some kind of
> > extra file handle?
> > 
> > I'd think having global per-process transaction is not the best way.
> > So I think we should have some kind of transaction handle (probably in
> > the file handle space) and a way to say that a syscall is done within
> > a transaction. To avoid duplicating all syscalls, we could have
> > set_active_transaction() operation.
> 
> That's more or less what NTFS does. See the example at
> http://blogs.msdn.com/because_we_can/

That's the obvious choice but it limits the usefulness quite a lot.

If we have transactions, then I'd like to be able to do this from a shell:

    transaction_open t

    tar xvpSfz blahblah.tar.gz
    cd blahblah
    patch -p1 -E < foo.patch
    # etc.

    transaction_close $t

I'd also like to write inside a single C program:

    transaction * t = transaction_open ();

    /* Ordinary complicated filesystem operations here... */
    link (a, b);
    rename (c, d);
    read, write, stat etc.
    conf = open ("/etc/blahblah.conf", O_RDONLY);
    read (conf, ...)
    close (conf);
    /* If /etc/blahblah.conf is changed by another program during
       the transaction, the transaction is invalidated, because the
       dbm update below is dependent on what was read... */
    dbm_open (...);
    do_dbm_stuff (...);
    dbm_close (...);
    /* Whatever this command does, I'd like to include in the transaction. */
    system ("perl -pi -e 's/old_value/new_value/g' /etc/another.conf");

    transaction_close (t);

Fundamentally, if transactions are supported in the kernel then these
two usages are easy to offer:

    1. Ordinary file system calls as part of a transaction.

       This allows libraries which are not transaction-aware to be
       used, such as the dbm example above, and other things like XML
       parsers/writers.

    2. Subprocesses inherit a transaction, so a program can execute
       complex transactions by using other programs.

It's useful, and there is no good reason to disallow that.

Nonetheless, there's a need for some kind of transaction handles.  A
file descriptor representing a transaction seems like a natural fit.

Complex programs will want to have multiple transactions at the same
time: For example, any program structured using event-driven logic or
async I/O may have multiple independent state machines per thread,
each wanting to be able to have their own transactions.

This suggests a few things:

  - Transactions have a file descriptor to represent them.

  - Each thread has a "current transaction" that applies to all filesystem
    operations.

  - Concurrent threads will need their own current transactions, even
    while keeping "current directory" global to the whole process for
    POSIX reasons.  A process wide "current transaction" is too coarse.

  - Transactions should be automatically nestable: a program or
    library which uses transactions should itself be callable from a
    program or library which is using a transaction.

  - Transactions should record whether they cannot provide
    transactions for some operation that is attempted (e.g. writing to
    a file on a remote filesystem), aborting the transaction.

  - When a transaction aborts due to the actions of _another_ process
    (or thread) which is outside the transaction, that abort is an
    event which should be detectable synchronously (by polling the
    transaction fd) or asynchronously (by a signal - the SIGIO
    mechanism is fine for this).

  - An exclusive locking period should be optional, requested by a
    flag when opening the transaction.  Most usages will want the
    locking period with its default parameters.

  - Ideally, programs or mechanisms which provide alternative views of
    part of a filesystem, such as search results (Beagle), tarfs, or
    mailfs, should be able to update synchronously with transactions
    that affect whatever the view is watching, so that the view
    changes are effectively part of the transaction.  This does _not_
    mean that a transaction must wait for watchers to calculate
    anything.  It does mean a transaction must synchronously and
    simultaneously invalidate caches held by watchers during the
    atomic commit.

-- Jamie
