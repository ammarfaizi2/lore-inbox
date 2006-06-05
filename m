Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751078AbWFEMvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWFEMvM (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWFEMvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:51:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6338 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751078AbWFEMvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:51:10 -0400
Date: Mon, 5 Jun 2006 14:50:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alexander Zarochentsev <zam@namesys.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Valdis.Kletnieks@vt.edu,
        Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        Hans Reiser <reiser@namesys.com>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Message-ID: <20060605125029.GA5868@elte.hu>
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com> <20060605065444.GA27445@elte.hu> <20060605073701.GA28763@elte.hu> <200606051522.13698.zam@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606051522.13698.zam@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexander Zarochentsev <zam@namesys.com> wrote:

> I think the txnh lock and the tmgr lock are _non_nested. [...]

ok - that's what the two changes i did do.

> [...]  And, there is a place where two atom locks are taken in 
> deadlock-free order w/o always keeping correct order of unlocking.  
> The latest thing can be made lock-validator-friendly.

could you send a patch for that? When there is single-depth nesting of 
two atom-locks then the annotation is easy, instead of:

	spin_lock(&atom->alock);

you should do:

	spin_lock_nested(&atom->alock, SINGLE_DEPTH_NESTING)

for the unordered unlocks, just change the one that is non-nested to 
spin_unlock_non_nested(). (the second lock can stay spin_unlock() - that 
will be in order again)

	Ingo
