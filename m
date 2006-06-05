Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750718AbWFEHhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWFEHhn (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWFEHhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:37:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21136 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750718AbWFEHhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:37:42 -0400
Date: Mon, 5 Jun 2006 09:37:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, Hans Reiser <reiser@namesys.com>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Message-ID: <20060605073701.GA28763@elte.hu>
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com> <20060604133326.f1b01cfc.akpm@osdl.org> <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu> <20060604213432.GB5898@elte.hu> <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com> <20060605065444.GA27445@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605065444.GA27445@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> +++ linux/fs/reiser4/txnmgr.h
> @@ -613,7 +613,7 @@ static inline void spin_unlock_txnmgr(tx
>  	LOCK_CNT_DEC(spin_locked_txnmgr);
>  	LOCK_CNT_DEC(spin_locked);
>  
> -	spin_unlock(&(mgr->tmgr_lock));
> +	spin_unlock_non_nested(&(mgr->tmgr_lock));
>  }
>  
>  typedef enum {

Btw., this particular annotation also documents a locking/scalability 
inefficiency. mgr->tmgr_lock is a "global" lock (per superblock it 
seems), while atom->alock is a more "finegrained" lock.

Typical usage: tmgr_lock is used a 'master lock', it's taken, then 
atom->alock is taken, and then ->tmgr_lock is released. Then code runs 
under atom->alock, and atom->alock is released finally.

The scalability problem with such 'master locks' is that they pretty 
much control scalability, so the scalability advantage of the finer 
grained lock is reduced (often eliminated). Since access to the finer 
grained lock goes via the master lock, the master lock cacheline will 
bounce from CPU to CPU.

A much more scalable design is to get to the finer grained lock in some 
read-mostly, lockless way, and then take it. This often necessiates the 
utilization of RCU, but it's well worth it.

There's other kernel code that has been annotated for similar reasons - 
e.g. the netfilter code makes frequent use of master-locks.

All in one, it's a good idea to document such locking constructs via the 
_non_nested() annotation. Often they can be eliminated altogether and 
the code improves. It's not a maintainance problem either, because right 
now there are only 42 such annotations, out of 46,000+ locking API uses 
covered by the lock validator.

	Ingo
