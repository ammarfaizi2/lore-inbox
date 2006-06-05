Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932436AbWFEGzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWFEGzX (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 02:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWFEGzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 02:55:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51864 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932436AbWFEGzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 02:55:22 -0400
Date: Mon, 5 Jun 2006 08:54:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, Hans Reiser <reiser@namesys.com>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Message-ID: <20060605065444.GA27445@elte.hu>
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com> <20060604133326.f1b01cfc.akpm@osdl.org> <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu> <20060604213432.GB5898@elte.hu> <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=AWL,BAYES_60 autolearn=no SpamAssassin version=3.0.3
	1.0 BAYES_60               BODY: Bayesian spam probability is 60 to 80%
	[score: 0.6151]
	-0.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Barry K. Nathan <barryn@pobox.com> wrote:

> Assuming it's a false positive: Since this stops the tracer, it means 
> that if an actual deadlock possibility is detected later [I'm assuming 
> that detection of those doesn't get shut down by the bad-lock-ordering 
> detection either], useful information could be missing from 
> /proc/latency_trace, [...]

reporting the first one only is necessary, because the validator cannot 
trust a system's dependency info that it sees as incorrect. Deadlock 
possibilities are quite rare in a kernel that is "in balance". Right now 
we are not "in balance" yet, because the validator has only been added a 
couple of days ago. The flurry of initial fixes will die down quickly.

you can fix the reiser4 false positive (it's likely a false positive) by 
changing the spin_unlock() to spin_unlock_non_nested(). The patch below 
should do that for this specific instance.

Ob'Reiser4'Cleanup:

	spin_unlock(&(mgr->tmgr_lock));

why isnt that:

	spin_unlock(&mgr->tmgr_lock);

? fs/reiser4/*.c is infested with that, the string '(&(' occurs 199 (!) 
times.

also:

        if (atomic_read(&node->d_count) != 0) {
                return 0;
        }

why the braces, when on the next line it's not done:

        if (blocknr_is_fake(jnode_get_block(node)))
                return 0;

it looks quite inconsistent. Also, just a quick look at just about any 
file in reiser4/*.c shows alot of other coding style inconsistencies.

	Ingo

Index: linux/fs/reiser4/txnmgr.h
===================================================================
--- linux.orig/fs/reiser4/txnmgr.h
+++ linux/fs/reiser4/txnmgr.h
@@ -613,7 +613,7 @@ static inline void spin_unlock_txnmgr(tx
 	LOCK_CNT_DEC(spin_locked_txnmgr);
 	LOCK_CNT_DEC(spin_locked);
 
-	spin_unlock(&(mgr->tmgr_lock));
+	spin_unlock_non_nested(&(mgr->tmgr_lock));
 }
 
 typedef enum {
