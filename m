Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750976AbWFEL1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWFEL1p (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWFEL1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:27:45 -0400
Received: from relay2.beelinegprs.ru ([217.118.71.5]:7556 "EHLO
	relay2.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S1750975AbWFEL1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:27:45 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Date: Mon, 5 Jun 2006 15:22:13 +0400
User-Agent: KMail/1.8.2
Cc: "Barry K. Nathan" <barryn@pobox.com>, Valdis.Kletnieks@vt.edu,
        Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        Hans Reiser <reiser@namesys.com>
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com> <20060605065444.GA27445@elte.hu> <20060605073701.GA28763@elte.hu>
In-Reply-To: <20060605073701.GA28763@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606051522.13698.zam@namesys.com>
X-Spamtest-Info: License expired
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Monday 05 June 2006 11:37, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > +++ linux/fs/reiser4/txnmgr.h
> > @@ -613,7 +613,7 @@ static inline void spin_unlock_txnmgr(tx
> >  	LOCK_CNT_DEC(spin_locked_txnmgr);
> >  	LOCK_CNT_DEC(spin_locked);
> >
> > -	spin_unlock(&(mgr->tmgr_lock));
> > +	spin_unlock_non_nested(&(mgr->tmgr_lock));
> >  }
> >
> >  typedef enum {
>
> Btw., this particular annotation also documents a locking/scalability
> inefficiency. mgr->tmgr_lock is a "global" lock (per superblock it
> seems), while atom->alock is a more "finegrained" lock.
>
> Typical usage: tmgr_lock is used a 'master lock', it's taken, then
> atom->alock is taken, and then ->tmgr_lock is released. Then code
> runs under atom->alock, and atom->alock is released finally.

> The scalability problem with such 'master locks' is that they pretty
> much control scalability, so the scalability advantage of the finer
> grained lock is reduced (often eliminated). Since access to the finer
> grained lock goes via the master lock, the master lock cacheline will
> bounce from CPU to CPU.

please note that the master lock is taken by try_caputure only if new 
atom is created.  It is likely than current thread has an atom already 
or the block already captured.

> A much more scalable design is to get to the finer grained lock in
> some read-mostly, lockless way, and then take it. This often
> necessiates the utilization of RCU, but it's well worth it.

There was a code to measure lock contention for reiser4 locks which 
showed that the tmgr lock was contented less than atom and jnode spin 
locks were. 

> There's other kernel code that has been annotated for similar reasons
> - e.g. the netfilter code makes frequent use of master-locks.

> All in one, it's a good idea to document such locking constructs via
> the _non_nested() annotation. Often they can be eliminated altogether
> and the code improves. It's not a maintainance problem either,
> because right now there are only 42 such annotations, out of 46,000+
> locking API uses covered by the lock validator.

I think the txnh lock and the tmgr lock are _non_nested.  And, there is  
a place where two atom locks are taken in deadlock-free order w/o 
always keeping correct order of unlocking.  The latest thing can be 
made lock-validator-friendly.

> 	Ingo

Best,
Alex.

