Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSIESgb>; Thu, 5 Sep 2002 14:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSIESgb>; Thu, 5 Sep 2002 14:36:31 -0400
Received: from [195.223.140.120] ([195.223.140.120]:61550 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318097AbSIESga>; Thu, 5 Sep 2002 14:36:30 -0400
Date: Thu, 5 Sep 2002 20:41:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905184125.GA1657@dualathlon.random>
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020905180904.A8406@infradead.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 06:09:04PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 05, 2002 at 06:53:07PM +0200, Andrea Arcangeli wrote:
> > btw, even if xfs is applied before the inode_read_write-atomic,  please
> > make sure xfs will learn using the i_size_read when out of the semaphore
> > and i_size_write too. I know the locking is different there but I doubt
> > you're just managing the i_size without races.
> 
> XFS always has the XFS i_lock around accessing it.  Either in read mode
> or in write mode for updates (the lock is a so-called mrlock which
> basically as a rwsem with a few subtile differences).
> 
> Anyway most acceses i_size in the new code are done by the generic
> code now as XFS calls it internally.  Take a look at the update I sent
> you a few seconds ago :)

maybe I'm overlooking something but after a short read it seems you have
no lock in do_truncate->setattr like for all the other fs, so the
vmtruncate can run under reads and the i_size can change under you and
in turn you must always read it with i_size_read using asm, like all the
other fs, if you're not holding the i_sem (and you certainly aren't
holding the i_sem that frequently, you don't even for writes). this
because i_sem  is the only lock/sem hold by truncate.  Infact I'm unsure
how you serialize the i_size writes of truncate against the ones from
writes, that seems problematic too, the i_size could get a value past
the last block allocated (in turn corrupting the fs). Please double
check that I'm wrong, thanks.

Andrea
