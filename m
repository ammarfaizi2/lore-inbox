Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750725AbWFEINA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWFEINA (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWFEINA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:13:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51635 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750725AbWFEINA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:13:00 -0400
Date: Mon, 5 Jun 2006 10:12:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, Hans Reiser <reiser@namesys.com>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Message-ID: <20060605081220.GA30123@elte.hu>
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com> <20060604133326.f1b01cfc.akpm@osdl.org> <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu> <20060604213432.GB5898@elte.hu> <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com> <20060605065444.GA27445@elte.hu> <986ed62e0606050058v21b457a7tb4da4da62cb7e4e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606050058v21b457a7tb4da4da62cb7e4e3@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5971]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Barry K. Nathan <barryn@pobox.com> wrote:

> On 6/4/06, Ingo Molnar <mingo@elte.hu> wrote:
> >reporting the first one only is necessary, because the validator cannot
> >trust a system's dependency info that it sees as incorrect. Deadlock
> >possibilities are quite rare in a kernel that is "in balance". Right now
> >we are not "in balance" yet, because the validator has only been added a
> >couple of days ago. The flurry of initial fixes will die down quickly.
> 
> So, does that mean the plan is to annotate/tweak things in order to 
> shut up *each and every* false positive in the kernel?

yes. Note that for the many reasons i outlined before they are only 
"half false positives" - i.e. they are potentially dangerous constructs 
and they are potentially inefficient - hence we _want to_ document them 
in the code, to increase the cleanliness of the kernel. A pure "false 
positive" would be a totally valid and perfect locking construct being 
flagged by the lock validator.

nor do these warnings really hurt anyone. Lockdep prints info and then 
shuts up - the system continues to work.

> Anyway, I tried your patch and I got this:

please try the addon patch below.

	Ingo

Index: linux/fs/reiser4/txnmgr.h
===================================================================
--- linux.orig/fs/reiser4/txnmgr.h
+++ linux/fs/reiser4/txnmgr.h
@@ -567,7 +567,7 @@ static inline void spin_unlock_txnh(txn_
 	LOCK_CNT_DEC(spin_locked_txnh);
 	LOCK_CNT_DEC(spin_locked);
 
-	spin_unlock(&(txnh->hlock));
+	spin_unlock_non_nested(&(txnh->hlock));
 }
 
 #define spin_ordering_pred_txnmgr(tmgr)		\
