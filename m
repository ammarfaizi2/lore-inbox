Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932261AbWFDVfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWFDVfP (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWFDVfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:35:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44694 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932261AbWFDVfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:35:12 -0400
Date: Sun, 4 Jun 2006 23:34:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, "Barry K. Nathan" <barryn@pobox.com>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Message-ID: <20060604213432.GB5898@elte.hu>
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com> <20060604133326.f1b01cfc.akpm@osdl.org> <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5015]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> On Sun, 04 Jun 2006 13:33:26 PDT, Andrew Morton said:
> 
> > Why does the locking validator complain about unlocking ordering?
> 
> Presumably, if the lock nesting *should* be "take A, take B, release 
> B, release A", if it sees "Take A, Take B, release A" it means there's 
> potentially a missing 'release B' that got forgotten (most likely an 
> error case that does a 'return;' instead of a 'goto 
> end_of_function_cleanup' like we usually code.
> 
> Having said that, I'm not sure it qualifies as a "BUG".  Certainly 
> would qualify for a "SMELLS_FISHY" though.  But we don't have one of 
> those handy, so maybe BUG is as good as it gets (given that the person 
> who built the kernel *asked* to be nagged about locking funkyness)....

yes. This warning caught a couple of bugs, and documented a couple of 
'fishy' places. Sometimes it's code that is totally correct. I think 
it's worth the extra iteration, there arent that many non-nested 
unlocking places.

straight nested unlocking is also best for performance and scalability: 
the outmost lock should be released last, because that's what the 
waiters are most likely to be blocking/spinning upon.

nevertheless i'll turn that warning into a less scary message.

	Ingo
