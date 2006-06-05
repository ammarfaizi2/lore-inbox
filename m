Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751408AbWFEUPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWFEUPu (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWFEUPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:15:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14828 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751408AbWFEUPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:15:49 -0400
Date: Mon, 5 Jun 2006 22:15:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Kara <jack@suse.cz>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Valdis.Kletnieks@vt.edu,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
Message-ID: <20060605201510.GA15907@elte.hu>
References: <200606051700.k55H015q004029@turing-police.cc.vt.edu> <1149528339.3111.114.camel@laptopd505.fenrus.org> <200606051920.k55JKQGx003031@turing-police.cc.vt.edu> <20060605193552.GB24342@atrey.karlin.mff.cuni.cz> <1149537156.3111.123.camel@laptopd505.fenrus.org> <20060605200652.GC24342@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605200652.GC24342@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5005]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Kara <jack@suse.cz> wrote:

> > but that doesn't quite match your description...
>   This piece of code is there just because we avoid page cache when
> doing quota writes. That is a different story and should cause problems
> with your lock checker.
>   Standard way of running quota is:
> - get i_mutex for data_inode
> - write some data to data_inode
>   - requires allocation -> calls DQUOT_ALLOC_SPACE
>   - DQUOT_ALLOC_SPACE acquires some quota locks, decides it wants to
>     write out quota structure (e.g. because we are journaling quota and
>     must preserve quota integrity)
>     - acquires dqio_sem, calls filesystem specific quota writing
>       function - e.g. ext3_quota_write()
>     - this function acquires i_mutex for quota file
> 
> I think this is the type of circle your checker has found.

the validator noticed a circular dependency (AB->BA, or AB->BC->CA, 
etc.) - while the nesting above it would report as: "BUG: possible 
deadlock detected!".

	Ingo
